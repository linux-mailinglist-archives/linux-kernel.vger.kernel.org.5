Return-Path: <linux-kernel+bounces-73618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ACA85C52F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E70B24A11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1348014AD33;
	Tue, 20 Feb 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkoOGaSI"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2476914;
	Tue, 20 Feb 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458695; cv=none; b=f0wk0iVxpPEL6crPr14Gp5qy39LBZ6uk0dbis7STd2q9BGN+zX+RvH44nfPV1UWqf//4iUekGbTcp4zy5ljbb2PVhzdiCyYhp5GwCBG9JNvW0JlmFrsaZSZOh7q/Yg2Ht5kQvISgHmyTSZdHiTN2vfo1EtRl1wmJcuaF9NcDtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458695; c=relaxed/simple;
	bh=YwAEprxX0yVAdpG5CpfTah0Pbx+hkBdLRt0EuDBsMEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPApeCIWsxxXLx0Nbs58KgaFwtZLdNN67bMoRJShZkAgMt1rryL2DWoH4UbolI9e3qXRtxkGPxYKmqA2TIwHgQkZRsfzB6UNAeaE5xnyfMyyHlohxdoNRY37zkxWFva8ctYFImqDuiVDeAQxXV36BjHOArQjhi5rT4exOqIMObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkoOGaSI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so24848681fa.3;
        Tue, 20 Feb 2024 11:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708458692; x=1709063492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUr0wyu/jz5j+F30VmSGdk68hVqH2/LrI5G9Ml1dToY=;
        b=TkoOGaSIwLTzR1zibJL52kNphUvjDsFDvM6uKLeMVK6J4cZzEAiGv/a2vBZ560rUOK
         YgYDNkkob/0Be0h8GDr0eVZdEyjHUvZpP+XG9FZTXiTdBF2SD8DnJj2lCRhjUrqAsVDv
         je+V8wxiTZ8QgN9VEYnqp8l05aF714i4BqFuzPWkYIFbCrNjQ9jZIrktzPKHaIRF/2Jg
         kcFty7XnOxe29xgCHON1nWLqxFZReLFxnbJCeEO5Jmg4sFBJyW2UW1KqaNtARx719P2a
         UgFIfVdpFVuFxTq1ndI9j45+0FjV1ncXfiS1oo3J8B7sVGWzPMowE+jrCOwMpDFh4MGR
         rvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458692; x=1709063492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUr0wyu/jz5j+F30VmSGdk68hVqH2/LrI5G9Ml1dToY=;
        b=Yaj9afl0l+IPW0aWLliuFLzZOqCubFzPq9AgLAOsGfzLVUsdZR3SX7hEj7IAeICfOa
         P0t6OSTAlwKQ5pdlpQ2RIYEAR3wUGXFyzhMturgqUSCkLqoEMWHwFi2vD9c026i84CVr
         mBNMdZElzZEgunAzULW5T7o9NAlyai6EzyUVCxWweEn35xigAqQjCGXC/i+2NvhxCRY9
         5NqiWVBjp1Hv/hNFyFFcAiTFJdA0Gsy3SE2UZgSmL1uUml18RbkB6zvNI7q+WHvPyceO
         zovZaHSTVNAF9rbDV+CKmleZo3OVadTyfspTZ/fGNAfdECMPIIwPZbWsf3B/hVlO/OX+
         /qxA==
X-Forwarded-Encrypted: i=1; AJvYcCWRPbZGk/7ZbfV2YVIi6n0tssHP4FiVNVoSZWjtBJEwAgYqrej70ojE+k//h2lEVKSesOeC+vJQVWQkMAlIzOUVEB1GqtVSNTca+pgUTQMg+yVH0gmu1yAAloBV2Xg3RW9XFhfI
X-Gm-Message-State: AOJu0YyeEVZB5GgWNXGUNXyzciejL99aMGg9npqMEtU0aAmuIHpFEV6h
	8xa9Fdn6cisb15AB0r++Faj1LTHtPk+2e/RFGIJggZHUKAHfzrAn
X-Google-Smtp-Source: AGHT+IH8XmbnjjLrqM2qNGyY6IrGAEhMVRS1fEYKTWML6/eZh09Mn6ciIvO9ybOc7OWHcbRo1DFpUw==
X-Received: by 2002:a2e:a71e:0:b0:2d2:3d31:2200 with SMTP id s30-20020a2ea71e000000b002d23d312200mr3160066lje.24.1708458691752;
        Tue, 20 Feb 2024 11:51:31 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fs14-20020a05600c3f8e00b00411a595d56bsm15494853wmb.14.2024.02.20.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:51:31 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 1/3] net: phy: add support for defining multiple PHY IDs in PHY driver
Date: Tue, 20 Feb 2024 20:50:48 +0100
Message-ID: <20240220195103.15809-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220195103.15809-1-ansuelsmth@gmail.com>
References: <20240220195103.15809-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PHY driver might implement the same OPs for different PHY ID and
using a mask is not enough to match similar PHYs.

To reduce code duplication, add support for defining multiple PHY IDs in
PHY driver struct.

Introduce a new variable in phy_driver struct, .ids, where a table array of
phy_driver_id can be defined to reference multiple PHY IDs (with their
own masks) supporting the same group of OPs and flags. PHY driver also
require to declare .ids_count to signal the amount of multiple PHYs the
phy_driver supports.

Introduce a new variable in phy_device, .drv_id, where the matching
phy_driver_id is stored.

To make this transparent and don't cause regression in ABI, mdiodrv
registration logic is changed. Each element in .ids is registreted as a
separate driver (mimicking them defined as an entire phy_driver), each
element then points to the common phy_driver struct to reduce code
duplication, permitting the correct driver name applied. Name of each
driver is taken by the .name in phy_driver_id.

If defined .name defined in phy_driver will be used for early PHY driver
registration.

Both implementation are mutually exclusive, phy_driver with .phy_id or
phy_id_mask and .ids are not supported and are rejected by the kernel
with a WARN as this is a bugged/wrong PHY driver.

to_phy_driver macro is updated to this new structure.

Single PHY ID implementation is still supported and ID is internally
converted to the .ids table with a single element.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 127 ++++++++++++++++++++++++++---------
 include/linux/phy.h          |  38 +++++++++--
 2 files changed, 129 insertions(+), 36 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d63dca535746..7125e16f4c70 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -524,12 +524,13 @@ static int phy_scan_fixups(struct phy_device *phydev)
 
 static int phy_bus_match(struct device *dev, struct device_driver *drv)
 {
+	struct phy_driver_id *phydrv_id = to_phy_driver_id(drv);
 	struct phy_device *phydev = to_phy_device(dev);
-	struct phy_driver *phydrv = to_phy_driver(drv);
+	struct phy_driver *phydrv = phydrv_id->driver;
 	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
 	int i;
 
-	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
+	if (!(phydrv_id->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
 		return 0;
 
 	if (phydrv->match_phy_device)
@@ -541,13 +542,14 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
 				continue;
 
 			if (phy_id_compare(phydev->c45_ids.device_ids[i],
-					   phydrv->phy_id, phydrv->phy_id_mask))
+					   phydrv_id->phy_id, phydrv_id->phy_id_mask))
 				return 1;
 		}
+
 		return 0;
 	} else {
-		return phy_id_compare(phydev->phy_id, phydrv->phy_id,
-				      phydrv->phy_id_mask);
+		return phy_id_compare(phydev->phy_id, phydrv_id->phy_id,
+				      phydrv_id->phy_id_mask);
 	}
 }
 
@@ -1465,9 +1467,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 */
 	if (!d->driver) {
 		if (phydev->is_c45)
-			d->driver = &genphy_c45_driver.mdiodrv.driver;
+			d->driver = &genphy_c45_driver.ids->mdiodrv.driver;
 		else
-			d->driver = &genphy_driver.mdiodrv.driver;
+			d->driver = &genphy_driver.ids->mdiodrv.driver;
 
 		using_genphy = true;
 	}
@@ -1649,14 +1651,14 @@ static bool phy_driver_is_genphy_kind(struct phy_device *phydev,
 bool phy_driver_is_genphy(struct phy_device *phydev)
 {
 	return phy_driver_is_genphy_kind(phydev,
-					 &genphy_driver.mdiodrv.driver);
+					 &genphy_driver.ids->mdiodrv.driver);
 }
 EXPORT_SYMBOL_GPL(phy_driver_is_genphy);
 
 bool phy_driver_is_genphy_10g(struct phy_device *phydev)
 {
 	return phy_driver_is_genphy_kind(phydev,
-					 &genphy_c45_driver.mdiodrv.driver);
+					 &genphy_c45_driver.ids->mdiodrv.driver);
 }
 EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
 
@@ -3409,9 +3411,11 @@ static int phy_probe(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 	struct device_driver *drv = phydev->mdio.dev.driver;
-	struct phy_driver *phydrv = to_phy_driver(drv);
+	struct phy_driver_id *id = to_phy_driver_id(drv);
+	struct phy_driver *phydrv = id->driver;
 	int err = 0;
 
+	phydev->drv_id = id;
 	phydev->drv = phydrv;
 
 	/* Disable the interrupt if the PHY doesn't support it
@@ -3551,6 +3555,42 @@ static int phy_remove(struct device *dev)
 	return 0;
 }
 
+static int phy_driver_mdiodrv_register(struct mdio_driver_common *mdiodrv, char *name,
+				       struct module *owner)
+{
+	int retval;
+
+	/* PHYLIB device drivers must not match using a DT compatible table
+	 * as this bypasses our checks that the mdiodev that is being matched
+	 * is backed by a struct phy_device. If such a case happens, we will
+	 * make out-of-bounds accesses and lockup in phydev->lock.
+	 */
+	if (WARN(mdiodrv->driver.of_match_table,
+		 "%s: driver must not provide a DT match table\n",
+		 name))
+		return -EINVAL;
+
+	mdiodrv->flags |= MDIO_DEVICE_IS_PHY;
+	mdiodrv->driver.name = name;
+	mdiodrv->driver.bus = &mdio_bus_type;
+	mdiodrv->driver.probe = phy_probe;
+	mdiodrv->driver.remove = phy_remove;
+	mdiodrv->driver.owner = owner;
+	mdiodrv->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
+
+	retval = driver_register(&mdiodrv->driver);
+	if (retval) {
+		pr_err("%s: Error %d in registering driver\n",
+		       name, retval);
+
+		return retval;
+	}
+
+	pr_debug("%s: Registered new driver\n", name);
+
+	return 0;
+}
+
 /**
  * phy_driver_register - register a phy_driver with the PHY layer
  * @new_driver: new phy_driver to register
@@ -3558,7 +3598,7 @@ static int phy_remove(struct device *dev)
  */
 int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 {
-	int retval;
+	int i, retval;
 
 	/* Either the features are hard coded, or dynamically
 	 * determined. It cannot be both.
@@ -3569,33 +3609,47 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 		return -EINVAL;
 	}
 
-	/* PHYLIB device drivers must not match using a DT compatible table
-	 * as this bypasses our checks that the mdiodev that is being matched
-	 * is backed by a struct phy_device. If such a case happens, we will
-	 * make out-of-bounds accesses and lockup in phydev->lock.
+	/* Either PHY driver define multiple PHY IDs, or a single one.
+	 * It cannot be both.
 	 */
-	if (WARN(new_driver->mdiodrv.driver.of_match_table,
-		 "%s: driver must not provide a DT match table\n",
-		 new_driver->name))
+	if (WARN_ON((new_driver->phy_id || new_driver->phy_id_mask) &&
+		    new_driver->ids)) {
+		pr_err("%s: phy_id or phy_id_mask and ids table must not both be set\n",
+		       new_driver->name);
 		return -EINVAL;
+	}
 
-	new_driver->mdiodrv.flags |= MDIO_DEVICE_IS_PHY;
-	new_driver->mdiodrv.driver.name = new_driver->name;
-	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
-	new_driver->mdiodrv.driver.probe = phy_probe;
-	new_driver->mdiodrv.driver.remove = phy_remove;
-	new_driver->mdiodrv.driver.owner = owner;
-	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
+	/* Dynamically allocate ids table for PHY driver that define
+	 * a single PHY ID.
+	 */
+	if (!new_driver->ids) {
+		struct phy_driver_id *id;
 
-	retval = driver_register(&new_driver->mdiodrv.driver);
-	if (retval) {
-		pr_err("%s: Error %d in registering driver\n",
-		       new_driver->name, retval);
+		id = kzalloc(sizeof(*new_driver->ids), GFP_KERNEL);
+		if (!id)
+			return -ENOMEM;
 
-		return retval;
+		id->name = new_driver->name;
+		id->phy_id = new_driver->phy_id;
+		id->phy_id_mask = new_driver->phy_id_mask;
+		new_driver->ids = id;
+		new_driver->ids_count = 1;
 	}
 
-	pr_debug("%s: Registered new driver\n", new_driver->name);
+	for (i = 0; i < new_driver->ids_count; i++) {
+		struct phy_driver_id *ids = new_driver->ids;
+
+		/* Attach the phy_driver to the phy_driver_id */
+		ids[i].driver = new_driver;
+		retval = phy_driver_mdiodrv_register(&ids[i].mdiodrv,
+						     ids[i].name, owner);
+		if (retval) {
+			while (i-- > 0)
+				driver_unregister(&ids[i].mdiodrv.driver);
+
+			return retval;
+		}
+	}
 
 	return 0;
 }
@@ -3620,7 +3674,16 @@ EXPORT_SYMBOL(phy_drivers_register);
 
 void phy_driver_unregister(struct phy_driver *drv)
 {
-	driver_unregister(&drv->mdiodrv.driver);
+	int i;
+
+	for (i = 0; i < drv->ids_count; i++)
+		driver_unregister(&drv->ids[i].mdiodrv.driver);
+
+	/* With phy_id or phy_id_mask set in phy_driver, assume
+	 * dynamically allocated ids table.
+	 */
+	if (drv->phy_id || drv->phy_id_mask)
+		kfree(drv->ids);
 }
 EXPORT_SYMBOL(phy_driver_unregister);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c2dda21b39e1..f341a9867f19 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -537,6 +537,7 @@ struct phy_c45_device_ids {
 	u32 device_ids[MDIO_MMD_NUM];
 };
 
+struct phy_driver_id;
 struct macsec_context;
 struct macsec_ops;
 
@@ -544,6 +545,7 @@ struct macsec_ops;
  * struct phy_device - An instance of a PHY
  *
  * @mdio: MDIO bus this PHY is on
+ * @drv_id: Pointer to the driver ID for this PHY instance
  * @drv: Pointer to the driver for this PHY instance
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
@@ -641,6 +643,7 @@ struct phy_device {
 
 	/* Information about the PHY type */
 	/* And management functions */
+	const struct phy_driver_id *drv_id;
 	const struct phy_driver *drv;
 
 	struct device_link *devlink;
@@ -881,9 +884,32 @@ struct phy_led {
 
 #define to_phy_led(d) container_of(d, struct phy_led, led_cdev)
 
+/**
+ * struct phy_driver_id - Driver structure id for a particular PHY type
+ * @mdiodrv: Data common to all MDIO devices
+ * @phy_id: The result of reading the UID registers of this PHY
+ *   type, and ANDing them with the phy_id_mask.  This driver
+ *   only works for PHYs with IDs which match this field
+ * @name: The friendly name of this PHY type
+ * @phy_id_mask: Defines the important bits of the phy_id
+ *
+ * @driver: Pointer to the associated PHY driver
+ */
+struct phy_driver_id {
+	struct mdio_driver_common mdiodrv;
+	u32 phy_id;
+	char *name;
+	u32 phy_id_mask;
+
+	struct phy_driver *driver;
+};
+
 /**
  * struct phy_driver - Driver structure for a particular PHY type
  *
+ * @ids: array of mdio device IDs to match this driver (terminated with
+ *   zero phy_id_mask)
+ * @ids_count: count of mdio device IDs (not counting the sentinel)
  * @mdiodrv: Data common to all MDIO devices
  * @phy_id: The result of reading the UID registers of this PHY
  *   type, and ANDing them with the phy_id_mask.  This driver
@@ -905,7 +931,8 @@ struct phy_led {
  * though it is not currently supported in the driver).
  */
 struct phy_driver {
-	struct mdio_driver_common mdiodrv;
+	struct phy_driver_id *ids;
+	u32 ids_count;
 	u32 phy_id;
 	char *name;
 	u32 phy_id_mask;
@@ -1171,8 +1198,10 @@ struct phy_driver {
 	int (*led_polarity_set)(struct phy_device *dev, int index,
 				unsigned long modes);
 };
-#define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
-				      struct phy_driver, mdiodrv)
+
+#define to_phy_driver_id(d) container_of(to_mdio_common_driver(d),		\
+					 struct phy_driver_id, mdiodrv)
+#define to_phy_driver(d) to_phy_driver_id(d)->driver
 
 #define PHY_ANY_ID "MATCH ANY PHY"
 #define PHY_ANY_UID 0xffffffff
@@ -1206,7 +1235,8 @@ static inline bool phy_id_compare(u32 id1, u32 id2, u32 mask)
  */
 static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
 {
-	return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
+	return phy_id_compare(id, phydev->phy_id,
+			      phydev->drv_id->phy_id_mask);
 }
 
 /* A Structure for boards to register fixups with the PHY Lib */
-- 
2.43.0


