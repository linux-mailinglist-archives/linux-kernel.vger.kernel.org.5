Return-Path: <linux-kernel+bounces-62106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37639851B90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C26287EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F26F3F9FC;
	Mon, 12 Feb 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wul86u3F"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C13D994;
	Mon, 12 Feb 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759196; cv=none; b=LUnBv5ue2tbHdtuxqmugcOw2rdUIBom7NGeH0MsMa7WxWZU0dm2JwqiWnasGlONZPyxHaAyGIQvFX6dadyCNaEuBOpJFAFAayEUoMiksiqgRbeK+T9ZwnMYlgoQNg73MJCz2aQtjhW6jHILdNmHgyexcxG1HRZ1nEmqvZ27TMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759196; c=relaxed/simple;
	bh=iPEASSYlDcjrlPwsGBPKNYL9SBV46Dl15cGG7NcwLpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaMsIF08fObnCjkhnYf1CBennYxi0OhRUuLIlgijCJT1SjR67ke18MED9GnelqlOmeDbJR9jXI2OUW7Godze3kA8HsOAkwECN1orlrAz+DsoDPH4k3rEYPESXhl5OtUeu6dK/uweHPMG7XzOGH0eR/U97mssvbQ+BWzQXnIRips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wul86u3F; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 372FF240003;
	Mon, 12 Feb 2024 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707759191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yw66TIimhTJfNownIQ4rCrh/cxjyJxNv0GJT7l+wY1s=;
	b=Wul86u3F3IIpXicG6XPUT6nASTZle8eza9PgFc6ovn0K2mM6fnq0u6BMQ5LII4CCKJ93Kc
	l+PXm9YYK+/g6WFdCHVxeMhjOgygV9/tVYilxRaNjtu9aQS+rs3gpDOcbxXX2Tq5F5kp1A
	O6iqe4+My8ILDA3Y16ceXMV+/QDJMM3VOnzGYhK0H2uP266ODxwbxoq53NXcJEQkqLGEZ9
	Q6XEjImE2Yfe7sVtIFivot1xayxeGJDGWyNu0Unm7vaAlh7H2L3i33e+ojGwYO3Ae2vVAI
	pXpotR5qF+1Jee2+wqq9NktuE+Xdo90abtl8HoCR8xY8b6nQx878u6c+YHcXSg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Subject: [PATCH net-next 1/3] net: phy: Add support for inband extensions
Date: Mon, 12 Feb 2024 18:33:04 +0100
Message-ID: <20240212173307.1124120-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The USGMII Standard by Cisco introduces the notion of extensions used
in the preamble. The standard proposes a "PCH" extension, which allows
passing timestamps in the preamble. However, other alternatives are
possible, like Microchip's "MCH" mode, that allows passing indication to
a PHY telling whether or not the PHY should timestamp an outgoing packet,
therefore removing the need for the PHY to have an internal classifier.

This commit allows reporting the various extensions a PHY supports,
without tying them to the actual PHY mode. This is done 1) because there
are multiple variants of the USGMII mode, like QUSGMII and OUSGMII, and
2) because other non-cisco standards might one day propose a similar
mechanism.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/phy.rst | 70 ++++++++++++++++++++++++++
 drivers/net/phy/phy.c            | 86 ++++++++++++++++++++++++++++++++
 include/linux/phy.h              | 28 +++++++++++
 3 files changed, 184 insertions(+)

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index 1283240d7620..f10a45ac7053 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -538,6 +538,76 @@ Call one of following function before unloading module::
  int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
  int phy_register_fixup_for_id(const char *phy_id);
 
+Inband Extensions
+=================
+
+The USGMII Standard allows the possibility to re-use the full-length 7-bytes
+frame preamble to convey meaningful data. This is already partly used by modes
+like QSGMII, which passes the port number in the preamble.
+
+In USGMII, we have a standardized approach to allow the MAC and PHY to pass
+such data in the preamble, which looks like this :
+
+|  0   |  1   |  2  |  3  |  4  |  5  |  6  |  7  |  Frame data
+| SoP  |      |      Extension              | CRC |
+|     /        \_______________             |     |
+|    /                         \            |     |
+|   | type | subport | ext type |           |     |
+
+The preamble in that case uses the Packet Control Header (PCH) format, where
+the byte 1 is used as a control field with :
+
+type - 2 bits :
+        - 00 : Packet with PCH
+        - 01 : Packet without PCH
+        - 10 : Idle Packet, without data
+        - 11 : Reserved
+
+subport - 4 bits : The subport identifier. For QUSGMII, this field ranges from
+                   0 to 3, and for OUSGMII, it ranges from 0 to 7.
+
+ext type - 2 bits : Indicated the type of data conveyed in the extension
+        - 00 : Ignore extension
+        - 01 : 8 bits reserved + 32 timestamp
+        - 10 : Reserved
+        - 11 : Reserved
+
+It is possible for vendors to use the extensions mechanism without relying on
+the PCH formatting.
+
+In order to leverage such extensions, both the MAC and the PHY have to agree on
+which extension to use. The current model has the PHY expose the possible
+available extensions with ::
+
+  bool phy_inband_ext_available(struct phy_device *phydev, enum phy_inband_ext ext);
+
+The PHY driver decides which extensions are available to use at any given time,
+as they can only be used if ::
+  - A compatible PHY mode is used, such as USXGMII or QUSGMII
+  - The PHY can use the required mode at that moment
+
+A PHY driver can register available modes with::
+
+  int phy_inband_ext_set_available(struct phy_device *phydev, enum phy_inband_ext ext);
+  int phy_inband_ext_set_unavailable(struct phy_device *phydev, enum phy_inband_ext ext);
+
+It's then up to the MAC driver to enable/disable the extension in the PHY as
+needed. This was designed to fit the timestamping configuration model, as it
+is the only mode supported so far.
+
+Enabling/Disabling an extension is done from the MAC driver through::
+
+  int phy_inband_ext_enable(struct phy_device *phydev, enum phy_inband_ext ext);
+  int phy_inband_ext_disable(struct phy_device *phydev, enum phy_inband_ext ext);
+
+These functions will cause the relevant callback to be called in the PHY driver::
+
+  int (*set_inband_ext)(struct phy_device *dev, enum phy_inband_ext ext, bool enable);
+
+The state of currently enabled extensions can be queried with::
+
+  bool phy_inband_ext_enabled(struct phy_device *phydev, enum phy_inband_ext ext);
+
 Standards
 =========
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 3b9531143be1..4b6cf94f51d5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1760,3 +1760,89 @@ int phy_ethtool_nway_reset(struct net_device *ndev)
 	return ret;
 }
 EXPORT_SYMBOL(phy_ethtool_nway_reset);
+
+/**
+ * PHY modes in the USXGMII family can have extensions, with data transmitted
+ * in the frame preamble.
+ * For now, only QUSGMII is supported, but other variants like USGMII and
+ * OUSGMII can be added in the future.
+ */
+static inline bool phy_interface_has_inband_ext(phy_interface_t interface)
+{
+	return interface == PHY_INTERFACE_MODE_QUSGMII;
+}
+
+bool phy_inband_ext_available(struct phy_device *phydev, enum phy_inband_ext ext)
+{
+	return !!(phydev->inband_ext.available & ext);
+}
+EXPORT_SYMBOL(phy_inband_ext_available);
+
+bool phy_inband_ext_enabled(struct phy_device *phydev, enum phy_inband_ext ext)
+{
+	return !!(phydev->inband_ext.enabled & ext);
+}
+EXPORT_SYMBOL(phy_inband_ext_enabled);
+
+static int phy_set_inband_ext(struct phy_device *phydev,
+			      enum phy_inband_ext ext,
+			      bool enable)
+{
+	int ret;
+
+	if (!phy_interface_has_inband_ext(phydev->interface))
+		return -EOPNOTSUPP;
+
+	if (!phydev->drv->set_inband_ext)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&phydev->lock);
+	ret = phydev->drv->set_inband_ext(phydev, ext, enable);
+	mutex_unlock(&phydev->lock);
+	if (ret)
+		return ret;
+
+	if (enable)
+		phydev->inband_ext.enabled |= BIT(ext);
+	else
+		phydev->inband_ext.enabled &= ~BIT(ext);
+
+	return 0;
+}
+
+int phy_inband_ext_enable(struct phy_device *phydev, enum phy_inband_ext ext)
+{
+	if (!phy_inband_ext_available(phydev, ext))
+		return -EOPNOTSUPP;
+
+	return phy_set_inband_ext(phydev, ext, true);
+}
+EXPORT_SYMBOL(phy_inband_ext_enable);
+
+int phy_inband_ext_disable(struct phy_device *phydev, enum phy_inband_ext ext)
+{
+	return phy_set_inband_ext(phydev, ext, false);
+}
+EXPORT_SYMBOL(phy_inband_ext_disable);
+
+int phy_inband_ext_set_available(struct phy_device *phydev, enum phy_inband_ext ext)
+{
+	if (!(BIT(ext) & phydev->drv->inband_ext))
+		return -EOPNOTSUPP;
+
+	phydev->inband_ext.available |= BIT(ext);
+
+	return 0;
+}
+EXPORT_SYMBOL(phy_inband_ext_set_available);
+
+int phy_inband_ext_set_unavailable(struct phy_device *phydev, enum phy_inband_ext ext)
+{
+	if (!(BIT(ext) & phydev->drv->inband_ext))
+		return -EOPNOTSUPP;
+
+	phydev->inband_ext.available &= ~BIT(ext);
+
+	return 0;
+}
+EXPORT_SYMBOL(phy_inband_ext_set_unavailable);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a66f07d3f5f4..b358a96f71e7 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -202,6 +202,25 @@ static inline void phy_interface_set_rgmii(unsigned long *intf)
 	__set_bit(PHY_INTERFACE_MODE_RGMII_TXID, intf);
 }
 
+/**
+ * enum phy_inband_ext - Inband extensions
+ *
+ * @PHY_INBAND_EXT_PCH_TIMESTAMP: Transmit the nanoseconds part of a timestamp,
+ *				  Using the PCH format.
+ *
+ * Describes the inband extensions that can be conveyed in the ethernet preamble
+ */
+enum phy_inband_ext {
+	PHY_INBAND_EXT_PCH_TIMESTAMP = 0,
+};
+
+int phy_inband_ext_enable(struct phy_device *phydev, enum phy_inband_ext ext);
+int phy_inband_ext_disable(struct phy_device *phydev, enum phy_inband_ext ext);
+int phy_inband_ext_set_available(struct phy_device *phydev, enum phy_inband_ext ext);
+int phy_inband_ext_set_unavailable(struct phy_device *phydev, enum phy_inband_ext ext);
+bool phy_inband_ext_available(struct phy_device *phydev, enum phy_inband_ext ext);
+bool phy_inband_ext_enabled(struct phy_device *phydev, enum phy_inband_ext ext);
+
 /*
  * phy_supported_speeds - return all speeds currently supported by a PHY device
  */
@@ -678,6 +697,11 @@ struct phy_device {
 	phy_interface_t interface;
 	DECLARE_PHY_INTERFACE_MASK(possible_interfaces);
 
+	struct {
+		u32 available;
+		u32 enabled;
+	} inband_ext;
+
 	/*
 	 * forced speed & duplex (no autoneg)
 	 * partner speed & duplex & pause (autoneg)
@@ -908,6 +932,7 @@ struct phy_driver {
 	u32 phy_id_mask;
 	const unsigned long * const features;
 	u32 flags;
+	u32 inband_ext;
 	const void *driver_data;
 
 	/**
@@ -1167,6 +1192,9 @@ struct phy_driver {
 	 */
 	int (*led_polarity_set)(struct phy_device *dev, int index,
 				unsigned long modes);
+	/** @set_inband_ext: Enable or disable a given extension*/
+	int (*set_inband_ext)(struct phy_device *dev, enum phy_inband_ext ext,
+			      bool enable);
 };
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
-- 
2.43.0


