Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFF7A024C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbjINLR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbjINLRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:17:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CCB2111
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:17:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b962c226ceso12347671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690255; x=1695295055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEe0O9FNWF0PRk2EeQvO8Dbf6wLGmNuQMW1XScp3I4I=;
        b=rpAyaVGodUaz2/bGnt6kIKtrWgpC2AGCyh3ku0tzkccjJtLq659+/+B5u91rxbTx6B
         ufjuGzoRpaNLNBZdScqnxeOxbTis3oHh8oRqy+1iOaJslLWTjv2ut4TDVUeUradUEBQw
         IgdubF4ZYEgXQmt1GwVbKQlvE2B7Y8/6OvP1wCH4FHeovCuqqdcoqX2oQeAUjGaZOGvO
         o4GmUDfO9XArDOOIBIvvXAMLGk6XJ0AtZXVoW+uvkOLtBVNldVOfpLWDW/F+x4XtfW93
         PA+4l09bjgZdWABTSPlwmAHlt7HqtjQkP3w9NU0QsBEpRlwCTlJ/BDvrBQPsIMqhjqqF
         dqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690255; x=1695295055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEe0O9FNWF0PRk2EeQvO8Dbf6wLGmNuQMW1XScp3I4I=;
        b=IJBDgsp8bqNTOgJrAOO+sKWMStTWES/emnZpQHM+GMWc6j0YheHqyucuJOtuscb/oo
         0y2RZON8pgnvjKQKA7EvuYInjMrm7XIKOAm4EiiByeIl+IOuqXOJq4eJ1CnKPYftYGbW
         VG86HSEDxUV26p2xFv05JcDXfX10cs5YX8F2bXgbBY54Fn+Z93zF+DhYj+BRHwqjUt7m
         7wOx45jRKVUEDiFtexiJiYJz/PflcqHAlC12Yf3WJ2on61tfC3qewPuW8TvANPH8cvmP
         Q0gaMWJteIiydZhwMtEM6PvwObdsEwG1CrsYTCdz81mgLJfozEokaISHYEJQW+1EdL/r
         hdyw==
X-Gm-Message-State: AOJu0YyTJampVZkMvWmPvL2N5PCHNvS50o4/QuVHFYqoTvzM8cldLMID
        pFyJW1+1X39ojY8IeD1reukdWw==
X-Google-Smtp-Source: AGHT+IGaEOK/RpuGALw8XgYDXCUZMKnfRxZ33kxqHOwpa09VEzdpFcREoV9i67p91oXBarsERZBEbA==
X-Received: by 2002:a2e:b045:0:b0:2b9:3883:a765 with SMTP id d5-20020a2eb045000000b002b93883a765mr4950619ljl.31.1694690254937;
        Thu, 14 Sep 2023 04:17:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id h13-20020a2eb0ed000000b002b9e65912cesm226190ljl.140.2023.09.14.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:17:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH 06/17] pmdomain: imx: Move Kconfig options to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:17:31 +0200
Message-Id: <20230914111731.586564-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc- and firmware subsystem to the pmdomain
subsystem.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: <kernel@pengutronix.de>
Cc: <linux-imx@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/imx/Kconfig |  6 ------
 drivers/pmdomain/Kconfig     |  1 +
 drivers/pmdomain/imx/Kconfig | 29 +++++++++++++++++++++++++++++
 drivers/soc/imx/Kconfig      | 19 -------------------
 4 files changed, 30 insertions(+), 25 deletions(-)
 create mode 100644 drivers/pmdomain/imx/Kconfig

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c027d99f2a59..183613f82a11 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -22,9 +22,3 @@ config IMX_SCU
 
 	  This driver manages the IPC interface between host CPU and the
 	  SCU firmware running on M4.
-
-config IMX_SCU_PD
-	bool "IMX SCU Power Domain driver"
-	depends on IMX_SCU
-	help
-	  The System Controller Firmware (SCFW) based power domain driver.
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index a0569a44ff4b..8a02523b62ce 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -5,5 +5,6 @@ source "drivers/pmdomain/actions/Kconfig"
 source "drivers/pmdomain/amlogic/Kconfig"
 source "drivers/pmdomain/apple/Kconfig"
 source "drivers/pmdomain/bcm/Kconfig"
+source "drivers/pmdomain/imx/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
new file mode 100644
index 000000000000..ef964df0f856
--- /dev/null
+++ b/drivers/pmdomain/imx/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "i.MX Power Domains"
+
+config IMX_GPCV2_PM_DOMAINS
+	bool "i.MX GPCv2 PM domains"
+	depends on ARCH_MXC || (COMPILE_TEST && OF)
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	select REGMAP_MMIO
+	default y if SOC_IMX7D
+
+config IMX8M_BLK_CTRL
+	bool
+	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
+	depends on PM_GENERIC_DOMAINS
+	depends on COMMON_CLK
+
+config IMX9_BLK_CTRL
+	bool
+	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
+	depends on PM_GENERIC_DOMAINS
+
+config IMX_SCU_PD
+	bool "IMX SCU Power Domain driver"
+	depends on IMX_SCU
+	help
+	  The System Controller Firmware (SCFW) based power domain driver.
+
+endmenu
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 76a4593baf0a..2a90ddd20104 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -1,14 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "i.MX SoC drivers"
 
-config IMX_GPCV2_PM_DOMAINS
-	bool "i.MX GPCv2 PM domains"
-	depends on ARCH_MXC || (COMPILE_TEST && OF)
-	depends on PM
-	select PM_GENERIC_DOMAINS
-	select REGMAP_MMIO
-	default y if SOC_IMX7D
-
 config SOC_IMX8M
 	tristate "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
@@ -28,15 +20,4 @@ config SOC_IMX9
 	help
 	  If you say yes here, you get support for the NXP i.MX9 family
 
-config IMX8M_BLK_CTRL
-	bool
-	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
-	depends on PM_GENERIC_DOMAINS
-	depends on COMMON_CLK
-
-config IMX9_BLK_CTRL
-	bool
-	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
-	depends on PM_GENERIC_DOMAINS
-
 endmenu
-- 
2.34.1

