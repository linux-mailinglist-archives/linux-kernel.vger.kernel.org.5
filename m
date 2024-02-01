Return-Path: <linux-kernel+bounces-48376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCD5845B2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5091C26E32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B5779F2;
	Thu,  1 Feb 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lesuJMSu"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851F626A3;
	Thu,  1 Feb 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800699; cv=none; b=eZ1z8If1zUJQA5ccE5Ei9zqEHJopahOdqTjesVh2uO+S9BaIdco0AHeC5AgCqUI27QnvD/4LC1zb/AqorojNdHiokepzYBUU7OQSBZKOVASoIhoQBRh7L8JShxYZ+s39mBj3g8D7eRPJ5LNJpf1EK6UAyQ6qRoNT6+0EGWX9XiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800699; c=relaxed/simple;
	bh=Bl00NQENXqEm4pXlmgt1Yiiwk8vIc6KVi7lXc/n1j6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drKaKbS92BdabZUll5g/1WKzG1a7eCQ68ZDhAQv4uILgk3l8eukJ+Y/kGHlzOSiKCZru+2dwom98mMd7SfoT08bh42pUuEekEdzkz2VFw1adYGONFmGdhu1x6unAKKIgKZm9kvfeh1QEjdxJvLhtZokN+7hKpngGU6EngExCOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lesuJMSu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so13536041fa.3;
        Thu, 01 Feb 2024 07:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800696; x=1707405496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lodvHw/FwxJ4HaaqD63vKwSgnThs64bJ3+PDTf7WPII=;
        b=lesuJMSuxm3a/aHhZ8GnwNbjPLeJh1SU6h887L3Z5uF/8bG+iMx5utWhMYwSFrBI5E
         E5KI15gNXWMDz0TAFm1QTKaA+DMZxi9tzp+qMNiWKF6xmtFSIBh0snioZJS502vCJYDa
         lu2ySZ4BECO5oZXediESr3mIfORUrH8BUvogR1ccBWy0NScW18qXLvOWcJLxfWH2q+u1
         CgyZDWQYpkx1iIRG32PhqaFiAWzs7XmfaC2iMlaaUu2Iki0oxtyIVWJNsg5wZwhNXL4Q
         6bAQJuCG8x2iEo6XfXm7GdnCWXMLgIIwyqtij2VGoDXTdiKUJTCylATLSjgoqDfP82fD
         HZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800696; x=1707405496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lodvHw/FwxJ4HaaqD63vKwSgnThs64bJ3+PDTf7WPII=;
        b=DAZWvUB7KztlreSvCID40amHaBDCtfoY4R+UtLgEsvRnMilOFKPlz3QBiZLJqlwjNx
         hfUTSmEqEUBQPcafZouUg5JAxfzsWADQ5es+JmSGhg1bKrDqbvcT8K2xcvWTX8sndvul
         23wcQfkkj8Bt16k4hkXKljFp5oLwVbS3cu3MzjLczs6yuedxDb2mf3PCdDwLGDAS7mnQ
         82BDaT+K7wp4vXQPbS+ogSrGLyAgUrJGHb0A9F+H2DSOFaNfYeHVmX04WgQU6LLauaES
         oR3ACs9bfD6xZkZ81md/YiGiRtXHZDRESrkW255fFspfrcYVVUTWkrztxnYvhVlvzHzd
         csxw==
X-Gm-Message-State: AOJu0YyR+GUzYxiMqyBDRWlveLIl/XfMp+0whunBZXEb0BNzM0SayeIn
	C/ryQftlTvHWYilBmrA6RWtT+MOpgS8z0HTxiM45vjmamJ7QLVJt
X-Google-Smtp-Source: AGHT+IGJWnzH/ut4VtYSd/gVIprYVbIRd/tYyZa7pPdPcxhl5kRAFX3qELo0+LC1UazYJF9G7NOYHg==
X-Received: by 2002:a2e:a40f:0:b0:2cf:1033:c745 with SMTP id p15-20020a2ea40f000000b002cf1033c745mr1471029ljn.51.1706800695761;
        Thu, 01 Feb 2024 07:18:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFBK2nkDT2oq9LHPJu15t1S+WfoYHhZouoO0/Y9nxWoOmG60znQ5EbW2W31KZ31lBRFPlyLshe/WDbPj/fI6uuyBs5zAh6up1iOdRF7VBBvxLPO7vmvLexk4GpfpwV55ZBMDmneLat5vrR/DrOKa3Z1bujhQk57ellOGQpFbXcGykIuj6P0rB4RaaIhQmYxkfqYllKKvXg5tVjLDg2jL8+pC7uVLF3GPyifbM+tvgXflYeQpC3bjzcitYzla/tpRrsmmmKWlOhz7ZqQZWj3nWp+f5IIcfHaMdhlp5E539SA6IIALijJxSOvlneBYsjjSaFTl/pNR8TKJUD3kf1RcNFtg5NcAlATFUHSpmw8fOSwa/U/lajjfoyxb6fDQbhwv/UCkamgnKBIyTGmk/AGo2mitYQu3yRcdrpW6HL/m0StUi85pRx9A/GTB4+pHSXA3esMFkKU2Tc+SJOEt7zFAbIYYZ9nQECiEfXZEX6puuUsHPpcBO/WwjgaYV8pbz3mxjHgx8LzxREVKfqKMYs8OcOvcNhXCHMvQDh3Jo9i5fmS9jwKPoY/aPbN2h2RZkqJeWj2p+OCoCNRBBvBRXVNrIakdVEdH8iW/gMda25pxbBm/Su9IZ1pbCu
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:15 -0800 (PST)
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
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v5 2/9] net: phy: add support for scanning PHY in PHY packages nodes
Date: Thu,  1 Feb 2024 16:17:28 +0100
Message-ID: <20240201151747.7524-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201151747.7524-1-ansuelsmth@gmail.com>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for scanning PHY in PHY packages nodes. PHY packages nodes
are just container for actual PHY on the MDIO bus.

Their PHY address is defined as offset of the PHY package base address
defined in DT. of_mdio_parse_addr_offset helper is introduced to
validate the final address is correct.

mdio_bus.c and of_mdio.c is updated to now support and parse also
PHY package subnote by checking if the node name match
"ethernet-phy-package".

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 75 +++++++++++++++++++++++++++-----------
 drivers/net/phy/mdio_bus.c | 44 +++++++++++++++++-----
 include/linux/of_mdio.h    | 26 +++++++++++++
 3 files changed, 115 insertions(+), 30 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 64ebcb6d235c..58b54c644f11 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -139,6 +139,54 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 }
 EXPORT_SYMBOL(of_mdiobus_child_is_phy);
 
+static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
+				   int base_addr, bool *scanphys)
+{
+	struct device_node *child;
+	int addr, rc = 0;
+
+	/* Loop over the child nodes and register a phy_device for each phy */
+	for_each_available_child_of_node(np, child) {
+		if (of_node_name_eq(child, "ethernet-phy-package")) {
+			rc = of_property_read_u32(child, "reg", &addr);
+			if (rc)
+				goto exit;
+
+			rc = __of_mdiobus_parse_phys(mdio, child, addr, scanphys);
+			if (rc && rc != -ENODEV)
+				goto exit;
+
+			continue;
+		}
+
+		if (base_addr)
+			addr = of_mdio_parse_addr_offset(&mdio->dev, child, base_addr);
+		else
+			addr = of_mdio_parse_addr(&mdio->dev, child);
+		if (addr < 0) {
+			*scanphys = true;
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
@@ -180,25 +228,9 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
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
+	rc = __of_mdiobus_parse_phys(mdio, np, 0, &scanphys);
+	if (rc)
+		goto unregister;
 
 	if (!scanphys)
 		return 0;
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
index afbad1ad8683..7737d0101d7b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -459,20 +459,33 @@ EXPORT_SYMBOL(of_mdio_find_bus);
  * found, set the of_node pointer for the mdio device. This allows
  * auto-probed phy devices to be supplied with information passed in
  * via DT.
+ * If a PHY package is found, PHY is searched also there.
  */
-static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
-				    struct mdio_device *mdiodev)
+static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
+			       struct device_node *np, int base_addr)
 {
-	struct device *dev = &mdiodev->dev;
 	struct device_node *child;
 
-	if (dev->of_node || !bus->dev.of_node)
-		return;
+	for_each_available_child_of_node(np, child) {
+		int addr, ret;
 
-	for_each_available_child_of_node(bus->dev.of_node, child) {
-		int addr;
+		if (of_node_name_eq(child, "ethernet-phy-package")) {
+			ret = of_property_read_u32(child, "reg", &addr);
+			if (ret)
+				return ret;
 
-		addr = of_mdio_parse_addr(dev, child);
+			if (!of_mdiobus_find_phy(dev, mdiodev, child, addr)) {
+				of_node_put(child);
+				return 0;
+			}
+
+			continue;
+		}
+
+		if (base_addr)
+			addr = of_mdio_parse_addr_offset(dev, child, base_addr);
+		else
+			addr = of_mdio_parse_addr(dev, child);
 		if (addr < 0)
 			continue;
 
@@ -481,9 +494,22 @@ static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
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
+	of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node, 0);
 }
 #else /* !IS_ENABLED(CONFIG_OF_MDIO) */
 static inline void of_mdiobus_link_mdiodev(struct mii_bus *mdio,
diff --git a/include/linux/of_mdio.h b/include/linux/of_mdio.h
index 8a52ef2e6fa6..8566df2afbe6 100644
--- a/include/linux/of_mdio.h
+++ b/include/linux/of_mdio.h
@@ -72,6 +72,27 @@ static inline int of_mdio_parse_addr(struct device *dev,
 	return addr;
 }
 
+static inline int of_mdio_parse_addr_offset(struct device *dev,
+					    const struct device_node *np,
+					    u16 offset)
+{
+	int addr;
+
+	addr = of_mdio_parse_addr(dev, np);
+	if (addr < 0)
+		return addr;
+
+	/* Validate final address with offset */
+	addr += offset;
+	if (addr >= PHY_MAX_ADDR) {
+		dev_err(dev, "%s PHY address offset %i is too large\n",
+			np->full_name, addr);
+		return -EINVAL;
+	}
+
+	return addr;
+}
+
 #else /* CONFIG_OF_MDIO */
 static inline bool of_mdiobus_child_is_phy(struct device_node *child)
 {
@@ -130,6 +151,11 @@ static inline int of_mdio_parse_addr(struct device *dev,
 {
 	return -ENOSYS;
 }
+static inline int of_mdio_parse_addr_offset(struct device *dev,
+					    const struct device_node *np)
+{
+	return -ENOSYS;
+}
 static inline int of_phy_register_fixed_link(struct device_node *np)
 {
 	return -ENOSYS;
-- 
2.43.0


