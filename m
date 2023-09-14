Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C467A024D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbjINLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjINLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:17:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6171FCE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:17:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5029e4bfa22so1398599e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690246; x=1695295046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3mbgmnyoTrMzfffrRfxAP2RkuD6rjug1WQEvOx/n/U=;
        b=wWKnfGgixpdGbd7X4MXR4aRd1/BE+XkIMHECkIOmxY0LaUEJeZA+TEbJ0RchFFATaC
         xna2aBnr2EcZ+f9EXthRf3c0v52ZunDaY6zMaGFfl7RfH/obvvBLUmUFYHBwAKudpwrU
         Ny57VzA3zRQkhuBdNRXG/Y1BN3zeUv7HbR2j2iKYUj36+TrR2/kKECUJsbYDKQco/pPH
         z1c8ZfH1hrLh+CZ6L/OpG0B2iHgWF8B1kqq859qpO70GbZhWxk6xKcMcXXdkME+Ov7Bf
         VDKBbUEnCMD29LOMe5g997FNuvDAryZOuvWHNaRZVqHibUNsKoQ+Z8Uw2bvuBNNbK3Kp
         1nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690246; x=1695295046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3mbgmnyoTrMzfffrRfxAP2RkuD6rjug1WQEvOx/n/U=;
        b=UDKM4/5Ar/+5keLa5BOGtTnkEeV/epR1xG8JGgTS3OMC6AiDVV/QHjTYJJIXGVFlE6
         ugEvJpjaNI8GVQHs7nU6mkO6PYldq/MekA4qKIeWeJ2U2WgeVDVwCa5qLDFxeUWyGh8X
         RMz6fab+a+kVxho20Et3Uz4CqoAk9P8k9tsYLxDMBrlC3KSv2ZHiL2RIo0/gIxKOd5LF
         x6CGGaTZ7viqkZvGgQv3z8gCOyzLEls+0I8GY3SuWVUDQDKjSZK9jI+WV4ruI8ylG68t
         p8Oh0Uahu3/UprdPTXz8NyYNtkdeqRhfgWeATqN+zqEr1tO2nG5Nr9IyOsxXcZVqVMfz
         +lrA==
X-Gm-Message-State: AOJu0YyJflKNdxwv9ZXtvfe3cQRRpcnk/tARtfLzdsCtVGQpX6ZWymhb
        YmsemXzqijhqRVA1ha/Jdydx7w==
X-Google-Smtp-Source: AGHT+IEJ5kh0s85nneZdUyXZTaobo6Y9st5U7pZU2uaiIVoFsmea5woLy3l43yDv/hY8fs+c1T43FA==
X-Received: by 2002:a05:6512:1585:b0:500:bf33:3add with SMTP id bp5-20020a056512158500b00500bf333addmr6038147lfb.47.1694690246319;
        Thu, 14 Sep 2023 04:17:26 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id r9-20020a056512102900b004fe48d0b639sm237143lfr.83.2023.09.14.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:17:25 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-mips@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 05/17] pmdomain: bcm: Move Kconfig options to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:17:21 +0200
Message-Id: <20230914111721.586543-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc subsystem to the pmdomain subsystem.

Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: <linux-mips@vger.kernel.org>
Cc: <linux-rpi-kernel@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig     |  1 +
 drivers/pmdomain/bcm/Kconfig | 46 ++++++++++++++++++++++++++++++++++++
 drivers/soc/bcm/Kconfig      | 42 --------------------------------
 3 files changed, 47 insertions(+), 42 deletions(-)
 create mode 100644 drivers/pmdomain/bcm/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 55a9ca191849..a0569a44ff4b 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -4,5 +4,6 @@ menu "Power Domains Support"
 source "drivers/pmdomain/actions/Kconfig"
 source "drivers/pmdomain/amlogic/Kconfig"
 source "drivers/pmdomain/apple/Kconfig"
+source "drivers/pmdomain/bcm/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/bcm/Kconfig b/drivers/pmdomain/bcm/Kconfig
new file mode 100644
index 000000000000..a4ee960b4749
--- /dev/null
+++ b/drivers/pmdomain/bcm/Kconfig
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Broadcom Power Domains"
+
+config BCM2835_POWER
+	bool "BCM2835 power domain driver"
+	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
+	default y if ARCH_BCM2835
+	select PM_GENERIC_DOMAINS if PM
+	select RESET_CONTROLLER
+	help
+	  This enables support for the BCM2835 power domains and reset
+	  controller.  Any usage of power domains by the Raspberry Pi
+	  firmware means that Linux usage of the same power domain
+	  must be accessed using the RASPBERRYPI_POWER driver
+
+config RASPBERRYPI_POWER
+	bool "Raspberry Pi power domain driver"
+	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
+	depends on RASPBERRYPI_FIRMWARE=y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the RPi power domains which can be enabled
+	  or disabled via the RPi firmware.
+
+config BCM_PMB
+	bool "Broadcom PMB (Power Management Bus) driver"
+	depends on ARCH_BCMBCA || (COMPILE_TEST && OF)
+	default ARCH_BCMBCA
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the Broadcom's PMB (Power Management Bus) that
+	  is used for disabling and enabling SoC devices.
+
+if SOC_BCM63XX
+
+config BCM63XX_POWER
+	bool "BCM63xx power domain driver"
+	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the BCM63xx power domains controller on
+	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
+
+endif # SOC_BCM63XX
+
+endmenu
diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index f96906795fa6..406617aa3056 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -1,27 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Broadcom SoC drivers"
 
-config BCM2835_POWER
-	bool "BCM2835 power domain driver"
-	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
-	default y if ARCH_BCM2835
-	select PM_GENERIC_DOMAINS if PM
-	select RESET_CONTROLLER
-	help
-	  This enables support for the BCM2835 power domains and reset
-	  controller.  Any usage of power domains by the Raspberry Pi
-	  firmware means that Linux usage of the same power domain
-	  must be accessed using the RASPBERRYPI_POWER driver
-
-config RASPBERRYPI_POWER
-	bool "Raspberry Pi power domain driver"
-	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
-	depends on RASPBERRYPI_FIRMWARE=y
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the RPi power domains which can be enabled
-	  or disabled via the RPi firmware.
-
 config SOC_BCM63XX
 	bool "Broadcom 63xx SoC drivers"
 	depends on BMIPS_GENERIC || COMPILE_TEST
@@ -42,27 +21,6 @@ config SOC_BRCMSTB
 
 	  If unsure, say N.
 
-config BCM_PMB
-	bool "Broadcom PMB (Power Management Bus) driver"
-	depends on ARCH_BCMBCA || (COMPILE_TEST && OF)
-	default ARCH_BCMBCA
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the Broadcom's PMB (Power Management Bus) that
-	  is used for disabling and enabling SoC devices.
-
-if SOC_BCM63XX
-
-config BCM63XX_POWER
-	bool "BCM63xx power domain driver"
-	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the BCM63xx power domains controller on
-	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
-
-endif # SOC_BCM63XX
-
 source "drivers/soc/bcm/brcmstb/Kconfig"
 
 endmenu
-- 
2.34.1

