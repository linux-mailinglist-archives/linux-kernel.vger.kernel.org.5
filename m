Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345107D0AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376498AbjJTIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376486AbjJTIh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:37:58 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 13F0BD53;
        Fri, 20 Oct 2023 01:37:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 9B143604652C0;
        Fri, 20 Oct 2023 16:37:50 +0800 (CST)
X-MD-Sfrom: zhoujie@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   ZhouJie <zhoujie@nfschina.com>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ZhouJie <zhoujie@nfschina.com>
Subject: [PATCH] =?UTF-8?q?power:=20main:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20initialization=20from=20last=5Ffailed?= =?UTF-8?q?=5Fstep=5Fshow()?=
Date:   Fri, 20 Oct 2023 16:37:43 +0800
Message-Id: <20231020083743.11412-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring char *last_failed_step; is reasonable because you can later
assign the function's return value to last_failed_step without
explicitly assigning an initial value.

Signed-off-by: ZhouJie <zhoujie@nfschina.com>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index f6425ae3e8b05..24c675f6ab862 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -410,7 +410,7 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 {
 	int index;
 	enum suspend_stat_step step;
-	char *last_failed_step = NULL;
+	char *last_failed_step;
 
 	index = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
 	index %= REC_FAILED_NUM;
-- 
2.18.2

