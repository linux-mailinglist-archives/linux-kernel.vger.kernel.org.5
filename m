Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADB47E6AEE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjKING4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:06:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D454E2D55;
        Thu,  9 Nov 2023 05:06:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4094301d505so5573175e9.2;
        Thu, 09 Nov 2023 05:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699535211; x=1700140011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOIjNHwDhIrchH75GqKOcAkPO2xPGvmXahK1witYqLQ=;
        b=QLeVLtaQuk8DJJnBxRK9IYnH0O/Crti1ZYzgtw6WlttU3Cx1ivh4JnDaL/BZQfm27V
         T5Ecq5ClBbVRJt67kdm9V4aVwP/beTqH23f3ICyJF8Sx3HgHm7Z+SQj04gmHAYjmIB7V
         dvN9Ki6NZwyuaLqEHbPu6hDvOjn/jxdLeLBCLg2dnF87kTvMDRVuU/wvWNgoPMGQMYKT
         fBSU8vsWLqgntvlEMJ7nmbyQHkkCx6wMvg0/xTjoJlqkIBQ+uSj7TB5b+51rJvJSPs6Q
         MqSZE4l8psm/dvoe4gdNq4CKQ3NB7LOvZ2vJCeUs61XLMTS16ca/N0yx6a7qnAz9HGoV
         Xebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535211; x=1700140011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOIjNHwDhIrchH75GqKOcAkPO2xPGvmXahK1witYqLQ=;
        b=EuR2nqK8buSyT1oNH6BwkIophlDj2AGk/61tiBIcZ214/0v7WnpYKJAsZVASn7KI2Q
         3XlJrkKBKvqnWhg2KzI5YMXJkmc0pOGSyrNs3mHmthwPG1f57zwOah/bUMGbpwn00V84
         ILsbkUlF3B+ChTdK+UUuWwvVla1Ju9KilVihiMSl6fo+lOu1aeR3+xM6wKdoGHIJDvn1
         jT0dyWFUxn90O2T2ISQq2wHhes491Ly9cFbe+i89sPJfx8/OVSLtnpMQyH7dVrvgjG8m
         XCO7Rm4wxO6N+8lL8NDQRHKa/MYTHtTS60MxXTVXWX3nLayqPCXTmJHWUFPVhOZbbahE
         rLVw==
X-Gm-Message-State: AOJu0YzXhQHUlXaCfAuBNEtmUnXYh6Fn3+DzSnXdE1YJ51klET41e5I+
        6KFZ/6d7HtmCwNnhhbPWo94=
X-Google-Smtp-Source: AGHT+IFbDCbIXiVpY6Mn2uAlQLGSxn3Bb9kx81nXr/A7KXXIfQ9AEnOdXFXwP6clKgGh5QhGOQV7lw==
X-Received: by 2002:a05:600c:2046:b0:405:75f0:fd31 with SMTP id p6-20020a05600c204600b0040575f0fd31mr4456945wmg.31.1699535210756;
        Thu, 09 Nov 2023 05:06:50 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v19-20020a05600c445300b0040813e14b49sm2095267wmn.30.2023.11.09.05.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:06:50 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v6 1/4] net: phy: aquantia: move to separate directory
Date:   Thu,  9 Nov 2023 13:32:50 +0100
Message-Id: <20231109123253.3933-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move aquantia PHY driver to separate driectory in preparation for
firmware loading support to keep things tidy.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v4:
- Keep order for kconfig config
Changes v3:
- Add this patch

 drivers/net/phy/Kconfig                         | 5 +----
 drivers/net/phy/Makefile                        | 6 +-----
 drivers/net/phy/aquantia/Kconfig                | 5 +++++
 drivers/net/phy/aquantia/Makefile               | 6 ++++++
 drivers/net/phy/{ => aquantia}/aquantia.h       | 0
 drivers/net/phy/{ => aquantia}/aquantia_hwmon.c | 0
 drivers/net/phy/{ => aquantia}/aquantia_main.c  | 0
 7 files changed, 13 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/phy/aquantia/Kconfig
 create mode 100644 drivers/net/phy/aquantia/Makefile
 rename drivers/net/phy/{ => aquantia}/aquantia.h (100%)
 rename drivers/net/phy/{ => aquantia}/aquantia_hwmon.c (100%)
 rename drivers/net/phy/{ => aquantia}/aquantia_main.c (100%)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 421d2b62918f..25cfc5ded1da 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -96,10 +96,7 @@ config ADIN1100_PHY
 	  Currently supports the:
 	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
 
-config AQUANTIA_PHY
-	tristate "Aquantia PHYs"
-	help
-	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
+source "drivers/net/phy/aquantia/Kconfig"
 
 config AX88796B_PHY
 	tristate "Asix PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..f65e85c91fc1 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -35,11 +35,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
-aquantia-objs			+= aquantia_main.o
-ifdef CONFIG_HWMON
-aquantia-objs			+= aquantia_hwmon.o
-endif
-obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
+obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o
 obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
 obj-$(CONFIG_BCM54140_PHY)	+= bcm54140.o
diff --git a/drivers/net/phy/aquantia/Kconfig b/drivers/net/phy/aquantia/Kconfig
new file mode 100644
index 000000000000..226146417a6a
--- /dev/null
+++ b/drivers/net/phy/aquantia/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AQUANTIA_PHY
+	tristate "Aquantia PHYs"
+	help
+	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
diff --git a/drivers/net/phy/aquantia/Makefile b/drivers/net/phy/aquantia/Makefile
new file mode 100644
index 000000000000..346f350bc084
--- /dev/null
+++ b/drivers/net/phy/aquantia/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+aquantia-objs			+= aquantia_main.o
+ifdef CONFIG_HWMON
+aquantia-objs			+= aquantia_hwmon.o
+endif
+obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
diff --git a/drivers/net/phy/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
similarity index 100%
rename from drivers/net/phy/aquantia.h
rename to drivers/net/phy/aquantia/aquantia.h
diff --git a/drivers/net/phy/aquantia_hwmon.c b/drivers/net/phy/aquantia/aquantia_hwmon.c
similarity index 100%
rename from drivers/net/phy/aquantia_hwmon.c
rename to drivers/net/phy/aquantia/aquantia_hwmon.c
diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
similarity index 100%
rename from drivers/net/phy/aquantia_main.c
rename to drivers/net/phy/aquantia/aquantia_main.c
-- 
2.40.1

