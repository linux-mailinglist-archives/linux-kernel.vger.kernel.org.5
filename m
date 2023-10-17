Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375617CBA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjJQGCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjJQGCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:02:14 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 663A0B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:02:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 7ECEB6027B148;
        Tue, 17 Oct 2023 14:01:59 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     bsingharora@gmail.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?taskstats:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20rc?=
Date:   Tue, 17 Oct 2023 14:01:57 +0800
Message-Id: <20231017060157.10117-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rc is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/taskstats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 8ce3fa0c19e2d..5685dead54228 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -406,7 +406,7 @@ static struct taskstats *mk_reply(struct sk_buff *skb, int type, u32 pid)
 
 static int cgroupstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 {
-	int rc = 0;
+	int rc;
 	struct sk_buff *rep_skb;
 	struct cgroupstats *stats;
 	struct nlattr *na;
-- 
2.18.2

