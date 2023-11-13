Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FDA7E9447
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjKMBwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMBwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:52:39 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F06AA1727
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:52:35 -0800 (PST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A813860327F34;
        Mon, 13 Nov 2023 09:52:32 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?misc:=20ocxl:=20main:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20rc?=
Date:   Mon, 13 Nov 2023 09:52:29 +0800
Message-Id: <20231113015229.12074-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rc is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 drivers/misc/ocxl/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/main.c b/drivers/misc/ocxl/main.c
index ef73cf35dda2b..658974143c3cc 100644
--- a/drivers/misc/ocxl/main.c
+++ b/drivers/misc/ocxl/main.c
@@ -7,7 +7,7 @@
 
 static int __init init_ocxl(void)
 {
-	int rc = 0;
+	int rc;
 
 	if (!tlbie_capable)
 		return -EINVAL;
-- 
2.18.2

