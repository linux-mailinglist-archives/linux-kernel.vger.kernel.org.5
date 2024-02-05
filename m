Return-Path: <linux-kernel+bounces-53040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF382849FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857E128596A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721844C82;
	Mon,  5 Feb 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd1VHMQs"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B73D99E;
	Mon,  5 Feb 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151749; cv=none; b=m4mnjPnI8kP5j15G+BgnA6kDCFKXCI+oDkjU4k1OIYYKoKKw2hjkshrxG7+KRbAN/obv4977vFzvSVrI44weIATsndTaUaCf5GIwuI+FdbreZnKCYqhvzX35WCUejiAZmbatn4eHETMWVQnLDqAWPKcXU4NN+tIexo7MEm4xGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151749; c=relaxed/simple;
	bh=QUMd/pymTNWROMEPvOP0tST5nIvBnoIZpBFhJ64dhxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In3vxFC9KZLPw50dEHTHcy288lSJebBPCu9pJqxzhPrzOk8/KoDV/gTEkmijnet8Qf/OOnOAzL8A24PjOgOr+XjTdPpt92FXk9s7etHaw0rcSxutv/avRHPyG6O3T/ot922BoRm0z5XlL2kBQd6JibFllwMUqxkdnGNQlxlDhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd1VHMQs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511538be947so954846e87.3;
        Mon, 05 Feb 2024 08:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151745; x=1707756545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozVMLwHgKVfJzWQo5tW7oNNWQr0MV/j4f/0n469yn4M=;
        b=Vd1VHMQs9c3r3r+ysu2zpPPGpmm5Hd7eqG19wc3Ea2hrbZEYtW6nk44T9NSeQBZMiS
         CnceKXI7pIC91hw4BrYfkqRyIgPrx9Z8zPWv6//qtuUWKOo6QCdCChdrGpuQFHccmwnK
         NRCCfUbiurE+Dkh0EQV2yzIBSC2pYk+dW/oGD445FfZ/p26el3R0JPhN306uU4XEjFul
         XMDUKi4croPMqjPNGIdhAUXS2nRfHYHR3D6YjyYXPE4CpAiKcGTODVDcjhcZcVOeYNEP
         aZAFordVImTlDcAJBj4UuRhfj5HT+i0G601ybOYf9E4fzOUrXjPFmCVpHh54PL/ireC4
         QLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151745; x=1707756545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozVMLwHgKVfJzWQo5tW7oNNWQr0MV/j4f/0n469yn4M=;
        b=Of0KqOC0xpwAUc6JvVNKxrHc7ECc39CQZ1qBd+7bnP/d+Kf6uFL25iRlcl41bdaGqm
         8yVhFlwchG19XoEHuLna5z4uSqcwhMOVwlPfxRGNF5PIPIPbwt/JB9lr+g12Cuw1ozFI
         TW7JvP01bfq3+zgE4dKTgbiOw6woIrZ2CXJC1aKzo4AvLXZzYsGOea54SUYgHqSl5ELh
         84wusPHT4paGlaLWeuP9W+lDO2f4sqZwqPxV36iquCqrmFRV9xvwMQGsTF76KHJWs5Kd
         hhkPxXKj1Hvaz7BgurbRG7M7hNclnVOlDAIgiP+AzNMc7jkBLPqV3RgibGLzAJ2hTJVN
         txfw==
X-Gm-Message-State: AOJu0Yxt+FYSyx935zu0zd4kTnsHf0klJB/8ag/EipDUoYEBRkztsqeh
	3nGADBU1bhY4rPmB0dGcAL/opiMbCa7mioWJv/Y5QQdbiiMlRZIamyev9ROu
X-Google-Smtp-Source: AGHT+IEiBJAxu5f7/MXQ00yym5c3Q53XmYm2ChwEJlzsaXM9KEbeAV2yLQLeo6FAUsJpu/VdTryeTA==
X-Received: by 2002:a19:8c19:0:b0:511:297f:2732 with SMTP id o25-20020a198c19000000b00511297f2732mr122812lfd.31.1707151745386;
        Mon, 05 Feb 2024 08:49:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUS+2aX1gUn1eBXcvBG1RDeE6hlA+QE0aGi3kidpjPYVsE2gAh1X/9dM7bboBH19pbuZ45ndzo9BVB8uX87ueeQXzAEzoObEItsmaUqhA71e+aY3BOvItwLtXf4GOHMfRbUswwZBiQHgkiA4v2TCh8SbU6s9G9LeZYXHa/1Wvnanugxc8AIZL0KXheyOMj8buAm42wdUCgKeAIv6A+97bDFWjyM6sB/73pG0X+01Ywr1i69RN57Xm+J1StqjWor2ylI4qq1DSZL4R6sA+ov6UCcC1scIugU/10qTnXguJ3HKF3jDPIcOFx2UZfwt52SSP3gJXJjYQ/lQQjxJ0CNTxFShg5zE5qx3lzLkhZHGU3mrU7teoF0YFXv9PTJQZhQ4g/AV70BhgVC8al9HFT8SvS/oJBXcVXCjrUSLkSD4MNF7vjhp1NDt2yt/3buETBJRpB2BVIImnqDQiismudmCUEVUh22yW7IQhLDFmMoslt01uxnlZ5rcs63bICdypZ5MgK0bUxsfd28ADTNAde427DDYz6XIfyXgVdPkzXzUDLmRMxyt7Y1+g1f1w0aULQfnPpcu556F5qX7Ll6MpwtJFt4qgntBit4lB9I7o2ChAeqk8/Oxi3rI+CpAco2BBQS9MMNnghrkEazD+CdhS0zpzQetLCfMSjawp5juvemgasNJQkD5C+fmQ==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:04 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v6 02/10] net: phy: add support for scanning PHY in PHY packages nodes
Date: Mon,  5 Feb 2024 17:48:34 +0100
Message-ID: <20240205164851.1351-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for scanning PHY in PHY package nodes. PHY packages nodes
are just container for actual PHY on the MDIO bus.

Their PHY address defined in the PHY package node are absolute and
reflect the address on the MDIO bus.

mdio_bus.c and of_mdio.c is updated to now support and parse also
PHY package subnode by checking if the node name match
"ethernet-phy-package".

As PHY package reg is mandatory and each PHY in the PHY package must
have a reg, every invalid PHY Package node is ignored and will be
skipped by the autoscan fallback.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 79 +++++++++++++++++++++++++++-----------
 drivers/net/phy/mdio_bus.c | 44 +++++++++++++++++----
 2 files changed, 92 insertions(+), 31 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 64ebcb6d235c..08e607f62e10 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -139,6 +139,53 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 }
 EXPORT_SYMBOL(of_mdiobus_child_is_phy);
 
+static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
+				   bool *scanphys)
+{
+	struct device_node *child;
+	int addr, rc = 0;
+
+	/* Loop over the child nodes and register a phy_device for each phy */
+	for_each_available_child_of_node(np, child) {
+		if (of_node_name_eq(child, "ethernet-phy-package")) {
+			/* Ignore invalid ethernet-phy-package node */
+			if (!of_property_present(child, "reg"))
+				continue;
+
+			rc = __of_mdiobus_parse_phys(mdio, child, NULL);
+			if (rc && rc != -ENODEV)
+				goto exit;
+
+			continue;
+		}
+
+		addr = of_mdio_parse_addr(&mdio->dev, child);
+		if (addr < 0) {
+			/* Skip scanning for invalid ethernet-phy-package node */
+			if (scanphys)
+				*scanphys = true;
+			continue;
+		}
+
+		if (of_mdiobus_child_is_phy(child))
+			rc = of_mdiobus_register_phy(mdio, child, addr);
+		else
+			rc = of_mdiobus_register_device(mdio, child, addr);
+
+		if (rc == -ENODEV)
+			dev_err(&mdio->dev,
+				"MDIO device at address %d is missing.\n",
+				addr);
+		else if (rc)
+			goto exit;
+	}
+
+	return 0;
+exit:
+	of_node_put(child);
+	return rc;
+}
+
 /**
  * __of_mdiobus_register - Register mii_bus and create PHYs from the device tree
  * @mdio: pointer to mii_bus structure
@@ -180,33 +227,18 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		return rc;
 
 	/* Loop over the child nodes and register a phy_device for each phy */
-	for_each_available_child_of_node(np, child) {
-		addr = of_mdio_parse_addr(&mdio->dev, child);
-		if (addr < 0) {
-			scanphys = true;
-			continue;
-		}
-
-		if (of_mdiobus_child_is_phy(child))
-			rc = of_mdiobus_register_phy(mdio, child, addr);
-		else
-			rc = of_mdiobus_register_device(mdio, child, addr);
-
-		if (rc == -ENODEV)
-			dev_err(&mdio->dev,
-				"MDIO device at address %d is missing.\n",
-				addr);
-		else if (rc)
-			goto unregister;
-	}
+	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys);
+	if (rc)
+		goto unregister;
 
 	if (!scanphys)
 		return 0;
 
 	/* auto scan for PHYs with empty reg property */
 	for_each_available_child_of_node(np, child) {
-		/* Skip PHYs with reg property set */
-		if (of_property_present(child, "reg"))
+		/* Skip PHYs with reg property set or ethernet-phy-package node */
+		if (of_property_present(child, "reg") ||
+		    of_node_name_eq(child, "ethernet-phy-package"))
 			continue;
 
 		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
@@ -227,15 +259,16 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 				if (!rc)
 					break;
 				if (rc != -ENODEV)
-					goto unregister;
+					goto put_unregister;
 			}
 		}
 	}
 
 	return 0;
 
-unregister:
+put_unregister:
 	of_node_put(child);
+unregister:
 	mdiobus_unregister(mdio);
 	return rc;
 }
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index afbad1ad8683..08624f073014 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -459,19 +459,34 @@ EXPORT_SYMBOL(of_mdio_find_bus);
  * found, set the of_node pointer for the mdio device. This allows
  * auto-probed phy devices to be supplied with information passed in
  * via DT.
+ * If a PHY package is found, PHY is searched also there.
  */
-static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
-				    struct mdio_device *mdiodev)
+static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
+			       struct device_node *np)
 {
-	struct device *dev = &mdiodev->dev;
 	struct device_node *child;
 
-	if (dev->of_node || !bus->dev.of_node)
-		return;
-
-	for_each_available_child_of_node(bus->dev.of_node, child) {
+	for_each_available_child_of_node(np, child) {
 		int addr;
 
+		if (of_node_name_eq(child, "ethernet-phy-package")) {
+			/* Validate PHY package reg presence */
+			if (!of_property_present(child, "reg")) {
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			if (!of_mdiobus_find_phy(dev, mdiodev, child)) {
+				/* The refcount for the PHY package will be
+				 * incremented later when PHY join the Package.
+				 */
+				of_node_put(child);
+				return 0;
+			}
+
+			continue;
+		}
+
 		addr = of_mdio_parse_addr(dev, child);
 		if (addr < 0)
 			continue;
@@ -481,9 +496,22 @@ static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
 			/* The refcount on "child" is passed to the mdio
 			 * device. Do _not_ use of_node_put(child) here.
 			 */
-			return;
+			return 0;
 		}
 	}
+
+	return -ENODEV;
+}
+
+static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
+				    struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+
+	if (dev->of_node || !bus->dev.of_node)
+		return;
+
+	of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node);
 }
 #else /* !IS_ENABLED(CONFIG_OF_MDIO) */
 static inline void of_mdiobus_link_mdiodev(struct mii_bus *mdio,
-- 
2.43.0


