Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8697EF6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346147AbjKQRUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjKQRUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:20:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86269D79
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:20:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2965FC433C7;
        Fri, 17 Nov 2023 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700241616;
        bh=pT4H+8f476H52UEU9hpQ7SOhDZTw4TDB9JYhp+a1A9g=;
        h=From:To:Cc:Subject:Date:From;
        b=pt6wObhfMTV/kYZU1DOo+p424g21J9U41kwCZ4eeImde232ZgsYOb9j0+iH0xjpuL
         +rXv9GDzaa+SBNQ8w3AAXFOkmktloa16H/d11M3QC2WJvJntWJ69YnHpcIsuUUDdZA
         ehxkQmGcW6Zu6aaBACwac6DzcDdKyNUbvYn0sSDtCBddnAqYVB0aOi64eZICmHgHvL
         r+iAjvijI8vo6oeKL0QB18Cu0dQqcGSU3QwuF8NFSPhTCIdnz2jc+Y5wzCQKEdrYEF
         z23y0y0/9TaUMmVMVX7NcrDqK8SeawO8rNLH9C7szdjrpEN4pyqT8uKZMaxCgKMk7e
         YrWm0qq1NVThQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r42Vv-0005My-2e;
        Fri, 17 Nov 2023 18:20:19 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] of: fix recursion typo in kernel doc
Date:   Fri, 17 Nov 2023 18:16:28 +0100
Message-ID: <20231117171628.20139-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the kernel doc for the of_platform_depopulate() functions,
which remove children "recursively".

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/of/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 126d265aa7d8..2293059758d1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -668,7 +668,7 @@ EXPORT_SYMBOL_GPL(of_platform_device_destroy);
  * @parent: device which children will be removed
  *
  * Complementary to of_platform_populate(), this function removes children
- * of the given device (and, recurrently, their children) that have been
+ * of the given device (and, recursively, their children) that have been
  * created from their respective device tree nodes (and only those,
  * leaving others - eg. manually created - unharmed).
  */
@@ -737,7 +737,7 @@ static int devm_of_platform_match(struct device *dev, void *res, void *data)
  * @dev: device that requested to depopulate from device tree data
  *
  * Complementary to devm_of_platform_populate(), this function removes children
- * of the given device (and, recurrently, their children) that have been
+ * of the given device (and, recursively, their children) that have been
  * created from their respective device tree nodes (and only those,
  * leaving others - eg. manually created - unharmed).
  */
-- 
2.41.0

