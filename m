Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9677D1CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjJULGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJULGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:06:00 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 43FB5D65;
        Sat, 21 Oct 2023 04:05:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4B149604DAB88;
        Sat, 21 Oct 2023 19:05:52 +0800 (CST)
X-MD-Sfrom: fenghui@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   fenghui <fenghui@nfschina.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        fenghui <fenghui@nfschina.com>
Subject: [PATCH] =?UTF-8?q?watchdog=5Fdev:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20err?=
Date:   Sat, 21 Oct 2023 19:05:38 +0800
Message-Id: <20231021110538.441-1-fenghui@nfschina.com>
X-Mailer: git-send-email 2.11.0
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

err is assigned first, so it does not need to initialize the assignment.

Signed-off-by: fenghui <fenghui@nfschina.com>
---
 drivers/watchdog/watchdog_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 15df74e11a59..0868ccbcf92b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -291,7 +291,7 @@ static int watchdog_start(struct watchdog_device *wdd)
  */
 static int watchdog_stop(struct watchdog_device *wdd)
 {
-	int err = 0;
+	int err;
 
 	if (!watchdog_active(wdd))
 		return 0;
-- 
2.11.0

