Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831E47A0260
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbjINLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbjINLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B61FDA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50078eba7afso1405392e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690355; x=1695295155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kiVpD+HqGq1+e/c8vvIDGsaa2qWD6QDzovb4cVyxMw=;
        b=cUZMz+CTOEsrdBDAsEjVLxnSVZkBODraJGmOXdSUtIRrTY4zr7ivH6Nf8bJmAA2h5b
         rJwmjLTWMKcDYfEQ5w1ln2LVZUxDnTVgRFjy0zp7HoPrY+1j3CssxZ1ViLPOVv6H7Wuj
         psQmZQphOFtnwkR0K+107pjUMGg1S1qwFU/8ykkkNFY2CWdtEH0Re1Jkj5TEI7H+UCNz
         el63Ow86/TxiY3lHyikrO9L7RoTfFZ19SIOy/Or2DQfbkYsV0Euoj9kX8WZhx4eYLSV+
         q5vDU+jqrTdqiNpU+EXiXIs1ZNkaxuPkxXOizi+buABFiSFiT2b2KDlHbkGkm3MnVWfm
         0S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690355; x=1695295155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kiVpD+HqGq1+e/c8vvIDGsaa2qWD6QDzovb4cVyxMw=;
        b=iBzbLmBn6BFTr83RMW4YcPPKKaG47lMruEwb/KxCviFtkdZiRdAEGeSQmVOfDQwrDl
         2gN+pLUwGR87FHJogqYXtm7poYlFA5015n2cG/3n8+C1QKryzzfBzmg4BEmM5La7vsXV
         DIhIlR3CBUmVP92HotVZOqR2lKcbV3HNyc+sZ1yg40uvDcCyH7Y9jgvsBndhmSRG2Xi3
         /Ww5i/Wz/OK0nOcr1ht+DiJHDp1x9t95O9qhbW/4dmS14sq7NLYFQtWHsZ1Rk7/kOyFs
         r6VSzXKduFSgbRmurQsAY1ZGD4IXYGSum4RN5DjS6EApKh/dIW1d/cm+hWrjvNvVt3yf
         788A==
X-Gm-Message-State: AOJu0YwU3253Lvv2SJBAEjkFz6v0BApF6R5d4cUEHdUlLgkNc6ZcAskG
        Kw8PczrpSMDday/JQB9UCDgMng==
X-Google-Smtp-Source: AGHT+IFqkXKsu67+BKk6H70B+cKDioBZ+IuAUNUhmOS/mLfep1SUOlJkgAmyyCuS8EBH4ZwvZ6equA==
X-Received: by 2002:a05:6512:3c93:b0:500:c3d1:4d60 with SMTP id h19-20020a0565123c9300b00500c3d14d60mr5381224lfv.24.1694690355165;
        Thu, 14 Sep 2023 04:19:15 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id c5-20020a197605000000b004edc72be17csm236671lff.2.2023.09.14.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:19:14 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 14/17] pmdomain: sunxi: Move Kconfig option to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:19:12 +0200
Message-Id: <20230914111912.586764-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: <linux-sunxi@lists.linux.dev>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig       |  1 +
 drivers/pmdomain/sunxi/Kconfig | 10 ++++++++++
 drivers/soc/sunxi/Kconfig      |  9 ---------
 3 files changed, 11 insertions(+), 9 deletions(-)
 create mode 100644 drivers/pmdomain/sunxi/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 67049ebf7265..39f358f27f2e 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -13,5 +13,6 @@ source "drivers/pmdomain/rockchip/Kconfig"
 source "drivers/pmdomain/samsung/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
+source "drivers/pmdomain/sunxi/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kconfig
new file mode 100644
index 000000000000..17781bf8d86d
--- /dev/null
+++ b/drivers/pmdomain/sunxi/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SUN20I_PPU
+	bool "Allwinner D1 PPU power domain driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y to enable the PPU power domain driver. This saves power
+	  when certain peripherals, such as the video engine, are idle.
diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
index c5070914fc6a..8aecbc9b1976 100644
--- a/drivers/soc/sunxi/Kconfig
+++ b/drivers/soc/sunxi/Kconfig
@@ -19,12 +19,3 @@ config SUNXI_SRAM
 	  Say y here to enable the SRAM controller support. This
 	  device is responsible on mapping the SRAM in the sunXi SoCs
 	  whether to the CPU/DMA, or to the devices.
-
-config SUN20I_PPU
-	bool "Allwinner D1 PPU power domain driver"
-	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on PM
-	select PM_GENERIC_DOMAINS
-	help
-	  Say y to enable the PPU power domain driver. This saves power
-	  when certain peripherals, such as the video engine, are idle.
-- 
2.34.1

