Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CDB7D0AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376523AbjJTIvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376487AbjJTIvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:51:15 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A5BB991;
        Fri, 20 Oct 2023 01:51:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id AC639604889BB;
        Fri, 20 Oct 2023 16:51:09 +0800 (CST)
X-MD-Sfrom: chaodong@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Wang chaodong <chaodong@nfschina.com>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wang chaodong <chaodong@nfschina.com>
Subject: [PATCH] =?UTF-8?q?power:=20snapshot:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20error?=
Date:   Fri, 20 Oct 2023 16:51:06 +0800
Message-Id: <20231020085106.12026-1-chaodong@nfschina.com>
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

error is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Wang chaodong <chaodong@nfschina.com>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 87e9f7e2bdc05..9acdc4458a36d 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1119,7 +1119,7 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
 int create_basic_memory_bitmaps(void)
 {
 	struct memory_bitmap *bm1, *bm2;
-	int error = 0;
+	int error;
 
 	if (forbidden_pages_map && free_pages_map)
 		return 0;
-- 
2.18.2

