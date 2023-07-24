Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657F175F53F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGXLhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGXLhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:37:02 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE421DB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:37:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A2992000E;
        Mon, 24 Jul 2023 11:36:57 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] nvmem: Kconfig: Fix typo "drive" -> "driver"
Date:   Mon, 24 Jul 2023 13:36:22 +0200
Message-Id: <20230724113622.12838-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: didi.debian@cknow.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo where "driver" was meant instead of "drive".
While at it, also capitalize "OTP".

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 drivers/nvmem/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da9befa3d6c4..e7f504ff15b7 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -247,7 +247,7 @@ config NVMEM_ROCKCHIP_EFUSE
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This is a simple drive to dump specified values of Rockchip SoC
+	  This is a simple driver to dump specified values of Rockchip SoC
 	  from eFuse, such as cpu-leakage.
 
 	  This driver can also be built as a module. If so, the module
@@ -258,8 +258,8 @@ config NVMEM_ROCKCHIP_OTP
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This is a simple drive to dump specified values of Rockchip SoC
-	  from otp, such as cpu-leakage.
+	  This is a simple driver to dump specified values of Rockchip SoC
+	  from OTP, such as cpu-leakage.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_rockchip_otp.
-- 
2.40.1

