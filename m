Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E337C41EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbjJJU5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjJJU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:57:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3990791
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:57:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31465C433C7;
        Tue, 10 Oct 2023 20:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696971419;
        bh=suuDB+tTBn5ITRqlAhlU4jlW36SzhBMty2iyCgJJw2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=gERlxxet+vSuTV0nBpq1b95B3MXWdMN5p3S2iGJH+MZIRov5R9XRwjB7y9B/IHzUd
         L1WBf/8vjv+v0Lv0ssNKOfI2lJm/auJXwOXG2BbZeBQ3U+pOdSFRV5oZaB3J4RvLzs
         fMRr/ttbXyl1FIAZ2Iv+lcGYIVrOBKP2MwiXaLmlzoC42qoJE1o6EH9QGEUb4rDPcm
         rQi73Phyy4CRSsrdT2mS3jrMVJ6YL04tdJ6g+DrYRtukYvuqo0bdy24g6q2PDWoKQ/
         V5SQV+y1mFRscNG8K7o1+99gVUkTJT18nbzJBBRpWkYPwA3ZxwGIp7/rhdz7mMXoiu
         5FEeINj4a6+EQ==
Received: (nullmailer pid 1584974 invoked by uid 1000);
        Tue, 10 Oct 2023 20:56:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: apple: mailbox: Add explicit include of platform_device.h
Date:   Tue, 10 Oct 2023 15:56:49 -0500
Message-ID: <20231010205649.1584790-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other and pull in various other headers. In
preparation to fix this, adjust the includes for what is actually needed.

platform_device.h is implicitly included by of_platform.h, but that's going
to be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note this was added in the merge window and missed the last round.
---
 drivers/soc/apple/mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 0cbd172f435e..780199bf351e 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-- 
2.42.0

