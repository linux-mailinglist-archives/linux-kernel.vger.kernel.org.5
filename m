Return-Path: <linux-kernel+bounces-59006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6DB84EFC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6791C215F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CED57893;
	Fri,  9 Feb 2024 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6XQlgLu"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EA57880;
	Fri,  9 Feb 2024 05:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455073; cv=none; b=qUxJRgD1cgKC8UfnMXlBvvyOcQu+kJou1FciCvWt87DDJcyHzRzTLe1SXSFwTVRJHwJH5z3Xq2LT0n2d1w1UV+MMyu44ACyyzwij9h61NDTP8VTzJ9sbyVCOXm4qMFT+ATct68BYGqhfNN8HVSjrqGis6U4YCqCVkGp+g92WMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455073; c=relaxed/simple;
	bh=x4wAU7R5xjM4+lxKEHM12l7yL064SMJqGv7TPMgDom8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8nmu8GZ7bSUKtYOITLMZFf5S2bmM+QO0/qlPjMbtgTl53JE5CxzZA6EIdAOAjaFm2799mtcSrPS09m8I+fRU9xwlZ2N35HLA5QoUCoC6WuTNTTatt7Yx6af31INI36+dBg4R9AAuZUwftqS0iYR2k93HW1wTW2cJoJSpKAExQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6XQlgLu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e05f6c7f50so375304b3a.3;
        Thu, 08 Feb 2024 21:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455070; x=1708059870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcnVvSvxpwClpAlB8qpRfcCVPoPOGOK+ZxWD1m2YSYM=;
        b=T6XQlgLuW33DprQC0gAzydaMsbe0zfJ5w4nSjIjorphxZyn7EFV/1Bn4OvdLYrBObx
         fkFAURKYtllBxh8WMZMLa5d2f8/ErgP5aT4jBq0yOOq+2CHkHHrMPxUm6GMLw0zShPeh
         fxPIocLdoVACM7TPrIWt+2U8hHDG2AGGq7OIrge4OsGz8VXZSSyc9e3wDj2yH+y7ezqI
         waTYYcklc3NSqaJl1ejkvsNpSDg2/1ctPEZs3akPQePFpaWNlZfInRoFW6ciDI76ljBb
         Emy1h1FUPcw7kMjPVYStvl/EMiWybSGjSJkWn0OIo2mPKaewEKbQpHPQ/32MqusNfUQa
         c91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455070; x=1708059870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcnVvSvxpwClpAlB8qpRfcCVPoPOGOK+ZxWD1m2YSYM=;
        b=DASIemEDPpCmFoiTHsDolcvyMltZ5gC+4j5WtpjhMOGnMNUYzVbt3cTfwxD9zs2Tma
         FftLvBts/sqO3Den6rSfV3TVPvZd7jF0tHC6ykgGom2zVawuO1pfoFYFUuqZV0WiSoqU
         n9gax4/PRQPrkdcSVGSO+GJ+dGZHXVcjc/TW/17Rzsfg2Svm/2AWrlcRHFXROWHZIr9a
         AsAGuzP7gveKh6wScR2YH2Jz4Xnr1v0Bdy+JVHeh84vOQL/r8umtBoeE576xXzRdh0FC
         ZLt79+mYWTQw+9jkYEnbnbIllQ1o0xVQyp0gXcX9WfRvwTqbGJkWe5wsYrw7FNBeTI16
         3pew==
X-Gm-Message-State: AOJu0Yw45dxDiyjwdla10+IJnCgHq0U2hWNMUgQ1dciy1p6en3T8I76/
	75syO77KnvQYlX03kgD0XQ4YLRnD8bf6alAKlFsoNN+oJTwDmKvs
X-Google-Smtp-Source: AGHT+IG/aK9QkeEsPYB+Z5SoDh222Zl7QD/xWASoKzbYGarzH0F3ra3q6Q7FC97QMt3fyTG1yblegQ==
X-Received: by 2002:a05:6a00:1c9b:b0:6e0:7249:3712 with SMTP id y27-20020a056a001c9b00b006e072493712mr697729pfw.30.1707455069917;
        Thu, 08 Feb 2024 21:04:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9CQxf3/OG1NJqNLFgjhtp8SL8QWqX5OQoQftbdqEQa4jgWr3yaAeEVpwa7zcRHUTXY0pBFqG1PwPN9IHC5xms4HKH2PqmFRh9EtCF7az3zMiXJVIkxJ3686uwPHljXLV3jG+bfgQgro0RDMR2L7y254fXFgc5ionfWRvW7ndsXzUm+RM9gRcK87N0eOr+l8uztoHlwPERIMkQUITa9kP3/K4V349ROetoB21/rLBxR2iBF5ZSH72cv0lrw6yBq5CG8xAHSfDsVmcGGkHIoIrduLC09L0D+HyjfaS/LIbZypeeZz4ZTY6dqz07Bt91y+YJAzJr6pJBpQxTBORgBe/4pNER/B3Nxr4Oxtp3qhiPREnPe5w=
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:29 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:39 -0300
Subject: [PATCH net-next v6 03/11] net: dsa: realtek: convert variants into
 real drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-realtek_reverse-v6-3-0662f8cbc7b5@gmail.com>
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=17785; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=x4wAU7R5xjM4+lxKEHM12l7yL064SMJqGv7TPMgDom8=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJLUN1cNWKlicFHnPIM5InJNhwVmktsd8GaI
 0Rix365DlKJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWySwAKCRC7Edu60Qc7
 VkY2B/0ROtE/i7xKMelDNxIGTdKPdgFNyxa/JoJVnx2zkgCI4NOE6eKMU0MkPwhjBxauF5/dFd4
 0rrqFw0VpJzB2/ISjvzNcvvqZGvFCrJWCg9Hvyj8kgIlIY+EKq4qRHv5x9W1+4X19e4zeWFre2S
 93rhHjTZ3R8acBJHtDvu4PDjXqy1PIaKKnyMJ2OBn5+sJ7pE6Bi3ZCTzLaVwYqOPxfwPTwhxXwU
 LFFGGHJHSc9v20ATiMiuQw1oY3w1NBgca65o12bWZfSByH4O7HenwL8Gx3OGeciMGWltBYz7nPt
 H37NIUqctFYxaXREwWGa4jWqVqdd/Pk3qJC3oESllHUEH8PD
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Previously, the interface modules realtek-smi and realtek-mdio served as
a platform and an MDIO driver, respectively. Each interface module
redundantly specified the same compatible strings for both variants and
referenced symbols from the variants.

Now, each variant module has been transformed into a unified driver
serving both as a platform and an MDIO driver. This modification
reverses the relationship between the interface and variant modules,
with the variant module now utilizing symbols from the interface
modules.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/realtek/Kconfig        | 20 +++-------
 drivers/net/dsa/realtek/realtek-mdio.c | 68 +++++++++++++++++++------------
 drivers/net/dsa/realtek/realtek-mdio.h | 48 ++++++++++++++++++++++
 drivers/net/dsa/realtek/realtek-smi.c  | 73 +++++++++++++++++++---------------
 drivers/net/dsa/realtek/realtek-smi.h  | 48 ++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb.c    | 54 ++++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8366rb.c    | 54 ++++++++++++++++++++++++-
 7 files changed, 292 insertions(+), 73 deletions(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 060165a85fb7..9d182fde11b4 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -16,37 +16,29 @@ menuconfig NET_DSA_REALTEK
 if NET_DSA_REALTEK
 
 config NET_DSA_REALTEK_MDIO
-	tristate "Realtek MDIO interface driver"
+	tristate "Realtek MDIO interface support"
 	depends on OF
-	depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
-	depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
-	depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
 	help
 	  Select to enable support for registering switches configured
 	  through MDIO.
 
 config NET_DSA_REALTEK_SMI
-	tristate "Realtek SMI interface driver"
+	tristate "Realtek SMI interface support"
 	depends on OF
-	depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
-	depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
-	depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
 	help
 	  Select to enable support for registering switches connected
 	  through SMI.
 
 config NET_DSA_REALTEK_RTL8365MB
-	tristate "Realtek RTL8365MB switch subdriver"
-	imply NET_DSA_REALTEK_SMI
-	imply NET_DSA_REALTEK_MDIO
+	tristate "Realtek RTL8365MB switch driver"
+	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
 	select NET_DSA_TAG_RTL8_4
 	help
 	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
 
 config NET_DSA_REALTEK_RTL8366RB
-	tristate "Realtek RTL8366RB switch subdriver"
-	imply NET_DSA_REALTEK_SMI
-	imply NET_DSA_REALTEK_MDIO
+	tristate "Realtek RTL8366RB switch driver"
+	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
 	select NET_DSA_TAG_RTL4_A
 	help
 	  Select to enable support for Realtek RTL8366RB.
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index c2572463679f..7c5372561587 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-mdio.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -140,7 +141,19 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
 	.disable_locking = true,
 };
 
-static int realtek_mdio_probe(struct mdio_device *mdiodev)
+/**
+ * realtek_mdio_probe() - Probe a platform device for an MDIO-connected switch
+ * @mdiodev: mdio_device to probe on.
+ *
+ * This function should be used as the .probe in an mdio_driver. It
+ * initializes realtek_priv and read data from the device-tree node. The switch
+ * is hard reset if a method is provided. It checks the switch chip ID and,
+ * finally, a DSA switch is registered.
+ *
+ * Context: Can sleep. Takes and releases priv->map_lock.
+ * Return: Returns 0 on success, a negative error on failure.
+ */
+int realtek_mdio_probe(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv;
 	struct device *dev = &mdiodev->dev;
@@ -235,8 +248,20 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(realtek_mdio_probe, REALTEK_DSA);
 
-static void realtek_mdio_remove(struct mdio_device *mdiodev)
+/**
+ * realtek_mdio_remove() - Remove the driver of an MDIO-connected switch
+ * @mdiodev: mdio_device to be removed.
+ *
+ * This function should be used as the .remove_new in an mdio_driver. First
+ * it unregisters the DSA switch and cleans internal data. If a method is
+ * provided, the hard reset is asserted to avoid traffic leakage.
+ *
+ * Context: Can sleep.
+ * Return: Nothing.
+ */
+void realtek_mdio_remove(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
 
@@ -249,8 +274,21 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
 }
+EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
 
-static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
+/**
+ * realtek_mdio_shutdown() - Shutdown the driver of a MDIO-connected switch
+ * @mdiodev: mdio_device shutting down.
+ *
+ * This function should be used as the .shutdown in an mdio_driver. It shuts
+ * down the DSA switch and cleans the platform driver data, to prevent
+ * realtek_mdio_remove() from running afterwards, which is possible if the
+ * parent bus implements its own .shutdown() as .remove().
+ *
+ * Context: Can sleep.
+ * Return: Nothing.
+ */
+void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
 
@@ -261,29 +299,7 @@ static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
-
-static const struct of_device_id realtek_mdio_of_match[] = {
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
-	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
-#endif
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
-	{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
-#endif
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
-
-static struct mdio_driver realtek_mdio_driver = {
-	.mdiodrv.driver = {
-		.name = "realtek-mdio",
-		.of_match_table = realtek_mdio_of_match,
-	},
-	.probe  = realtek_mdio_probe,
-	.remove = realtek_mdio_remove,
-	.shutdown = realtek_mdio_shutdown,
-};
-
-mdio_module_driver(realtek_mdio_driver);
+EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
diff --git a/drivers/net/dsa/realtek/realtek-mdio.h b/drivers/net/dsa/realtek/realtek-mdio.h
new file mode 100644
index 000000000000..ee70f6a5b8ff
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-mdio.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_MDIO_H
+#define _REALTEK_MDIO_H
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_MDIO)
+
+static inline int realtek_mdio_driver_register(struct mdio_driver *drv)
+{
+	return mdio_driver_register(drv);
+}
+
+static inline void realtek_mdio_driver_unregister(struct mdio_driver *drv)
+{
+	mdio_driver_unregister(drv);
+}
+
+int realtek_mdio_probe(struct mdio_device *mdiodev);
+void realtek_mdio_remove(struct mdio_device *mdiodev);
+void realtek_mdio_shutdown(struct mdio_device *mdiodev);
+
+#else /* IS_ENABLED(CONFIG_NET_DSA_REALTEK_MDIO) */
+
+static inline int realtek_mdio_driver_register(struct mdio_driver *drv)
+{
+	return 0;
+}
+
+static inline void realtek_mdio_driver_unregister(struct mdio_driver *drv)
+{
+}
+
+static inline int realtek_mdio_probe(struct mdio_device *mdiodev)
+{
+	return -ENOENT;
+}
+
+static inline void realtek_mdio_remove(struct mdio_device *mdiodev)
+{
+}
+
+static inline void realtek_mdio_shutdown(struct mdio_device *mdiodev)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_NET_DSA_REALTEK_MDIO) */
+
+#endif /* _REALTEK_MDIO_H */
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 668336515119..2a6a884bb45e 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -40,6 +40,7 @@
 #include <linux/if_bridge.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
@@ -408,7 +409,19 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
-static int realtek_smi_probe(struct platform_device *pdev)
+/**
+ * realtek_smi_probe() - Probe a platform device for an SMI-connected switch
+ * @pdev: platform_device to probe on.
+ *
+ * This function should be used as the .probe in a platform_driver. It
+ * initializes realtek_priv and read data from the device-tree node. The switch
+ * is hard reset if a method is provided. It checks the switch chip ID and,
+ * finally, a DSA switch is registered.
+ *
+ * Context: Can sleep. Takes and releases priv->map_lock.
+ * Return: Returns 0 on success, a negative error on failure.
+ */
+int realtek_smi_probe(struct platform_device *pdev)
 {
 	const struct realtek_variant *var;
 	struct device *dev = &pdev->dev;
@@ -505,8 +518,20 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
 
-static void realtek_smi_remove(struct platform_device *pdev)
+/**
+ * realtek_smi_remove() - Remove the driver of a SMI-connected switch
+ * @pdev: platform_device to be removed.
+ *
+ * This function should be used as the .remove_new in a platform_driver. First
+ * it unregisters the DSA switch and cleans internal data. If a method is
+ * provided, the hard reset is asserted to avoid traffic leakage.
+ *
+ * Context: Can sleep.
+ * Return: Nothing.
+ */
+void realtek_smi_remove(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
@@ -521,8 +546,21 @@ static void realtek_smi_remove(struct platform_device *pdev)
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
 }
+EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
 
-static void realtek_smi_shutdown(struct platform_device *pdev)
+/**
+ * realtek_smi_shutdown() - Shutdown the driver of a SMI-connected switch
+ * @pdev: platform_device shutting down.
+ *
+ * This function should be used as the .shutdown in a platform_driver. It shuts
+ * down the DSA switch and cleans the platform driver data, to prevent
+ * realtek_smi_remove() from running afterwards, which is possible if the
+ * parent bus implements its own .shutdown() as .remove().
+ *
+ * Context: Can sleep.
+ * Return: Nothing.
+ */
+void realtek_smi_shutdown(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
@@ -533,34 +571,7 @@ static void realtek_smi_shutdown(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 }
-
-static const struct of_device_id realtek_smi_of_match[] = {
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
-	{
-		.compatible = "realtek,rtl8366rb",
-		.data = &rtl8366rb_variant,
-	},
-#endif
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
-	{
-		.compatible = "realtek,rtl8365mb",
-		.data = &rtl8365mb_variant,
-	},
-#endif
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, realtek_smi_of_match);
-
-static struct platform_driver realtek_smi_driver = {
-	.driver = {
-		.name = "realtek-smi",
-		.of_match_table = realtek_smi_of_match,
-	},
-	.probe  = realtek_smi_probe,
-	.remove_new = realtek_smi_remove,
-	.shutdown = realtek_smi_shutdown,
-};
-module_platform_driver(realtek_smi_driver);
+EXPORT_SYMBOL_NS_GPL(realtek_smi_shutdown, REALTEK_DSA);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
diff --git a/drivers/net/dsa/realtek/realtek-smi.h b/drivers/net/dsa/realtek/realtek-smi.h
new file mode 100644
index 000000000000..ea49a2edd3c8
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-smi.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_SMI_H
+#define _REALTEK_SMI_H
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_SMI)
+
+static inline int realtek_smi_driver_register(struct platform_driver *drv)
+{
+	return platform_driver_register(drv);
+}
+
+static inline void realtek_smi_driver_unregister(struct platform_driver *drv)
+{
+	platform_driver_unregister(drv);
+}
+
+int realtek_smi_probe(struct platform_device *pdev);
+void realtek_smi_remove(struct platform_device *pdev);
+void realtek_smi_shutdown(struct platform_device *pdev);
+
+#else /* IS_ENABLED(CONFIG_NET_DSA_REALTEK_SMI) */
+
+static inline int realtek_smi_driver_register(struct platform_driver *drv)
+{
+	return 0;
+}
+
+static inline void realtek_smi_driver_unregister(struct platform_driver *drv)
+{
+}
+
+static inline int realtek_smi_probe(struct platform_device *pdev)
+{
+	return -ENOENT;
+}
+
+static inline void realtek_smi_remove(struct platform_device *pdev)
+{
+}
+
+static inline void realtek_smi_shutdown(struct platform_device *pdev)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_NET_DSA_REALTEK_SMI) */
+
+#endif  /* _REALTEK_SMI_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index c42ee8241ca2..e67c4562f5db 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -101,6 +101,8 @@
 #include <linux/if_vlan.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
+#include "realtek-mdio.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -2172,7 +2174,57 @@ const struct realtek_variant rtl8365mb_variant = {
 	.cmd_write = 0xb8,
 	.chip_data_sz = sizeof(struct rtl8365mb),
 };
-EXPORT_SYMBOL_GPL(rtl8365mb_variant);
+
+static const struct of_device_id rtl8365mb_of_match[] = {
+	{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rtl8365mb_of_match);
+
+static struct platform_driver rtl8365mb_smi_driver = {
+	.driver = {
+		.name = "rtl8365mb-smi",
+		.of_match_table = rtl8365mb_of_match,
+	},
+	.probe  = realtek_smi_probe,
+	.remove_new = realtek_smi_remove,
+	.shutdown = realtek_smi_shutdown,
+};
+
+static struct mdio_driver rtl8365mb_mdio_driver = {
+	.mdiodrv.driver = {
+		.name = "rtl8365mb-mdio",
+		.of_match_table = rtl8365mb_of_match,
+	},
+	.probe  = realtek_mdio_probe,
+	.remove = realtek_mdio_remove,
+	.shutdown = realtek_mdio_shutdown,
+};
+
+static int rtl8365mb_init(void)
+{
+	int ret;
+
+	ret = realtek_mdio_driver_register(&rtl8365mb_mdio_driver);
+	if (ret)
+		return ret;
+
+	ret = realtek_smi_driver_register(&rtl8365mb_smi_driver);
+	if (ret) {
+		realtek_mdio_driver_unregister(&rtl8365mb_mdio_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(rtl8365mb_init);
+
+static void __exit rtl8365mb_exit(void)
+{
+	realtek_smi_driver_unregister(&rtl8365mb_smi_driver);
+	realtek_mdio_driver_unregister(&rtl8365mb_mdio_driver);
+}
+module_exit(rtl8365mb_exit);
 
 MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
 MODULE_DESCRIPTION("Driver for RTL8365MB-VC ethernet switch");
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 6661d4ba6882..747407ae8225 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -23,6 +23,8 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
+#include "realtek-mdio.h"
 
 #define RTL8366RB_PORT_NUM_CPU		5
 #define RTL8366RB_NUM_PORTS		6
@@ -1933,7 +1935,57 @@ const struct realtek_variant rtl8366rb_variant = {
 	.cmd_write = 0xa8,
 	.chip_data_sz = sizeof(struct rtl8366rb),
 };
-EXPORT_SYMBOL_GPL(rtl8366rb_variant);
+
+static const struct of_device_id rtl8366rb_of_match[] = {
+	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rtl8366rb_of_match);
+
+static struct platform_driver rtl8366rb_smi_driver = {
+	.driver = {
+		.name = "rtl8366rb-smi",
+		.of_match_table = rtl8366rb_of_match,
+	},
+	.probe  = realtek_smi_probe,
+	.remove_new = realtek_smi_remove,
+	.shutdown = realtek_smi_shutdown,
+};
+
+static struct mdio_driver rtl8366rb_mdio_driver = {
+	.mdiodrv.driver = {
+		.name = "rtl8366rb-mdio",
+		.of_match_table = rtl8366rb_of_match,
+	},
+	.probe  = realtek_mdio_probe,
+	.remove = realtek_mdio_remove,
+	.shutdown = realtek_mdio_shutdown,
+};
+
+static int rtl8366rb_init(void)
+{
+	int ret;
+
+	ret = realtek_mdio_driver_register(&rtl8366rb_mdio_driver);
+	if (ret)
+		return ret;
+
+	ret = realtek_smi_driver_register(&rtl8366rb_smi_driver);
+	if (ret) {
+		realtek_mdio_driver_unregister(&rtl8366rb_mdio_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(rtl8366rb_init);
+
+static void __exit rtl8366rb_exit(void)
+{
+	realtek_smi_driver_unregister(&rtl8366rb_smi_driver);
+	realtek_mdio_driver_unregister(&rtl8366rb_mdio_driver);
+}
+module_exit(rtl8366rb_exit);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for RTL8366RB ethernet switch");

-- 
2.43.0


