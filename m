Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95745757022
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGQXAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjGQXAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:00:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D2419AF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88023612FC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C8DC433C7;
        Mon, 17 Jul 2023 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634782;
        bh=dTo5XNATzzM/tfQRUvE1uGXA7s6gfipA/USyd9LnlKU=;
        h=From:To:Cc:Subject:Date:From;
        b=Pj2Nqs6gs1cnoiUXf5HhUD6GMmRBbIPuUF0WRBAOsS+hoxLCY3R4AQmQHoE8bdU9L
         hVRq3+GNkHAPAZ6TrC7fnVke+VZw03371U/UM4NVEoFgGCEIyY96RzKeu2FVl/vq9/
         +mSozoyUQaR0pM1YCT3uKBXKZZStcs0j2TJ492GpUWKqT8uIQlUFuqsN+LaWHhvKWU
         CTvFz6EabTfhGmf965y2DgKjQwSSYlrQDvjemGU4CuSuRnT1EA7+FbHLb3E0SUp1t8
         UOS322okJje3VACKNaAHoJ4koXZgmnSCAt2MEYAF2V1/LxbTCSD5amIA4DCUhVTXJB
         ASIVMoJ0KuFpg==
Received: (nullmailer pid 3212409 invoked by uid 1000);
        Mon, 17 Jul 2023 22:55:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: Drop unused includes
Date:   Mon, 17 Jul 2023 16:55:04 -0600
Message-Id: <20230717225505.3212231-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several includes are not needed, so drop them.

of_platform.h (for now) implicitly includes platform_device.h and of.h, so
add explicit includes of those as needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-imx/mach-imx1.c   | 4 ----
 arch/arm/mach-imx/mach-imx25.c  | 5 -----
 arch/arm/mach-imx/mach-imx27.c  | 6 ------
 arch/arm/mach-imx/mach-imx35.c  | 8 --------
 arch/arm/mach-imx/mach-imx50.c  | 1 -
 arch/arm/mach-imx/mach-imx51.c  | 5 +----
 arch/arm/mach-imx/mach-imx53.c  | 8 --------
 arch/arm/mach-imx/mach-imx6sx.c | 2 --
 arch/arm/mach-imx/mach-imx6ul.c | 4 ----
 arch/arm/mach-imx/mach-imx7d.c  | 2 +-
 arch/arm/mach-imx/pm-imx5.c     | 1 +
 arch/arm/mach-imx/pm-imx6.c     | 1 +
 12 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx1.c b/arch/arm/mach-imx/mach-imx1.c
index 8eca92d66a2e..a4688f575ffe 100644
--- a/arch/arm/mach-imx/mach-imx1.c
+++ b/arch/arm/mach-imx/mach-imx1.c
@@ -3,15 +3,11 @@
  *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
  */
 
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 
 #include "common.h"
 #include "hardware.h"
 
-#define MX1_AVIC_ADDR	0x00223000
-
 static void __init imx1_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX1);
diff --git a/arch/arm/mach-imx/mach-imx25.c b/arch/arm/mach-imx/mach-imx25.c
index 51927bd08aef..114df312a99a 100644
--- a/arch/arm/mach-imx/mach-imx25.c
+++ b/arch/arm/mach-imx/mach-imx25.c
@@ -3,12 +3,7 @@
  * Copyright 2012 Sascha Hauer, Pengutronix
  */
 
-#include <linux/irq.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include "common.h"
 #include "hardware.h"
 
diff --git a/arch/arm/mach-imx/mach-imx27.c b/arch/arm/mach-imx/mach-imx27.c
index e325c9468105..ada84fe8a1fd 100644
--- a/arch/arm/mach-imx/mach-imx27.c
+++ b/arch/arm/mach-imx/mach-imx27.c
@@ -4,14 +4,8 @@
  */
 
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/mm.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 
 #include "common.h"
 #include "hardware.h"
diff --git a/arch/arm/mach-imx/mach-imx35.c b/arch/arm/mach-imx/mach-imx35.c
index 0fc08218b77d..35dbc719fb6d 100644
--- a/arch/arm/mach-imx/mach-imx35.c
+++ b/arch/arm/mach-imx/mach-imx35.c
@@ -5,15 +5,7 @@
  * based on imx27-dt.c
  */
 
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/clk-provider.h>
-#include <linux/clocksource.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <asm/hardware/cache-l2x0.h>
 #include "common.h"
 #include "mx35.h"
 
diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
index a2d35f9ba474..9dc9d0ae9342 100644
--- a/arch/arm/mach-imx/mach-imx50.c
+++ b/arch/arm/mach-imx/mach-imx50.c
@@ -5,7 +5,6 @@
  * Copyright 2011 Linaro Ltd.
  */
 
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 8b748a1854d7..510801f6f71c 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -5,12 +5,9 @@
  */
 
 #include <linux/io.h>
-#include <linux/irq.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 
 #include "common.h"
 #include "hardware.h"
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 8223c5aee45d..6622406e0081 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -4,15 +4,7 @@
  * Copyright 2011 Linaro Ltd.
  */
 
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 
 #include "common.h"
 #include "hardware.h"
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index e65ed5218f53..9ababf4ac210 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -5,12 +5,10 @@
 
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
-#include <linux/phy.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 
 #include "common.h"
 #include "cpuidle.h"
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 7a0299de1db6..cb6d29c2bb5f 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -3,12 +3,8 @@
  * Copyright (C) 2015 Freescale Semiconductor, Inc.
  */
 #include <linux/irqchip.h>
-#include <linux/mfd/syscon.h>
 #include <linux/of_platform.h>
-#include <linux/phy.h>
-#include <linux/regmap.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 
 #include "common.h"
 #include "cpuidle.h"
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 6fdd06bcf988..9587885fb1ac 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -5,7 +5,7 @@
 #include <linux/irqchip.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/regmap.h>
 
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 2e3af2bc7758..6f0de45b71e9 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/cacheflush.h>
 #include <asm/fncpy.h>
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 045b9fdd342d..b36f05b54cc7 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/suspend.h>
 #include <asm/cacheflush.h>
-- 
2.40.1

