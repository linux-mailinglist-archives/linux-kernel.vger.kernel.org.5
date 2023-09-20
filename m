Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B967A7919
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjITKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjITKXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:23:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A42AF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:23:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so8404173a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695205394; x=1695810194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBlFPN4rTkvNkIwWrvWpLVOcnwv+R23CbwzJnrGYB5Q=;
        b=vl7v/rHUnxVgRjBExA2/rBghzGOU38LmkRZ4TENkUu1g+eUHFyL0qHMzFLf2EJtmQW
         zSYvkAw7uG2DH/8waB8Ha3s3ob2bGiw+B+08VLoLSRfI39BmKOakZ9mSp7m2Nuhd3TjX
         cHo9xNu75S3sokRMALw1IfcYNnvTGdcEZTP6wz17vk7ZBH+mwVYKBcA3FwhH3qzgrmvK
         OjqtiqijTajMZ11UJRri2ELeVlcQTZCX7QZQQmEIirqFOSwP7Fl0XdXtdcuKUnc10Wlp
         zFiufk91rGHDrWmeGBkZRXGlZQmV9Iz+LdX/+RJ1RRYeFHq58ZndaZByTSa8I27VcRCX
         TIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695205394; x=1695810194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBlFPN4rTkvNkIwWrvWpLVOcnwv+R23CbwzJnrGYB5Q=;
        b=uQgdhQGZgPj/Zw1M64wGGbsPmsdI2QGSpoeCNJ8A1zsLG6FdvomlikIa/7Fu3i/e0i
         jYa6QyuRO01PFa9jQc0jcAh/qUQEY8BNvdRzWBhNEvXjw9lUzhK3qWLHgkrq3pAiHTZl
         g6zci9iNOv2+pAfsSEf7sgmRyHFaxfQ5FcMY/2BawmOGuVsHeEo9jbE0iQ4TdpoosNtS
         2m5tzVpnVFB7loFLK8qJqlBNVrezxYMbienYjENhxes0MeQohh/9h+M3w4aVThk3U2iB
         2J57u3MpN0XI0Gi9BFukGn56JSE7vMZ71s3v2GUIjL2+rZZCPnQrpeRa6YdLpBN5iNJR
         rYwQ==
X-Gm-Message-State: AOJu0YxG/3BIFAjKm+J/ojGbN7yTEn3QCq1IQk8QwSCv0EcpV/M5TNsy
        3gzFshHm6BTqBJLAaSSWYBilXQ==
X-Google-Smtp-Source: AGHT+IFQ9N7cmG2hrJt3k0vQuqNuVRpWI/r0U6RCPWb3X6phrFE4fTmuSKXBdG5HqOkgH191zMBCWg==
X-Received: by 2002:a17:906:1015:b0:9a9:d651:68f5 with SMTP id 21-20020a170906101500b009a9d65168f5mr1642291ejm.3.1695205394405;
        Wed, 20 Sep 2023 03:23:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id cf21-20020a170906b2d500b009ad8d444be4sm9061397ejb.43.2023.09.20.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 03:23:13 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-mips@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/17] pmdomain: bcm: Move Kconfig options to the pmdomain subsystem
Date:   Wed, 20 Sep 2023 12:22:22 +0200
Message-Id: <20230920102222.39831-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Dropped the SOC_BCM63XX config altogether.

---
 drivers/pmdomain/Kconfig     |  1 +
 drivers/pmdomain/bcm/Kconfig | 42 +++++++++++++++++++++++++++++
 drivers/soc/bcm/Kconfig      | 51 ------------------------------------
 3 files changed, 43 insertions(+), 51 deletions(-)
 create mode 100644 drivers/pmdomain/bcm/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 482d9e970e14..ddc05d6af100 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -4,5 +4,6 @@ menu "PM Domains"
 source "drivers/pmdomain/actions/Kconfig"
 source "drivers/pmdomain/amlogic/Kconfig"
 source "drivers/pmdomain/apple/Kconfig"
+source "drivers/pmdomain/bcm/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/bcm/Kconfig b/drivers/pmdomain/bcm/Kconfig
new file mode 100644
index 000000000000..b28c9f6d256b
--- /dev/null
+++ b/drivers/pmdomain/bcm/Kconfig
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Broadcom PM Domains"
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
+config BCM63XX_POWER
+	bool "BCM63xx power domain driver"
+	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the BCM63xx power domains controller on
+	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
+
+endmenu
diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index f96906795fa6..1f5577cfd68c 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -1,36 +1,6 @@
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
-config SOC_BCM63XX
-	bool "Broadcom 63xx SoC drivers"
-	depends on BMIPS_GENERIC || COMPILE_TEST
-	help
-	  Enables drivers for the Broadcom 63xx series of chips.
-	  Drivers can be enabled individually within this menu.
-
-	  If unsure, say N.
-
 config SOC_BRCMSTB
 	bool "Broadcom STB SoC drivers"
 	depends on ARM || ARM64 || BMIPS_GENERIC || COMPILE_TEST
@@ -42,27 +12,6 @@ config SOC_BRCMSTB
 
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

