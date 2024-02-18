Return-Path: <linux-kernel+bounces-70385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD28596E7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8839F1F216BB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E36BB5D;
	Sun, 18 Feb 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mBR2OF66"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB541E898;
	Sun, 18 Feb 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708260031; cv=none; b=V/NICi/9tptWhDGzDMCJrv3a+IjnYSGtB/tzby/D/l0uj4a/JqDnZs0vrsqOcZ2XU5rdoRuES03moP7Gy+Ib3exceKMqbdAtPA0qiETzCJMxR6KL/ds6g7zNiNLiiOAHu9qpZg2vPpk0GnybSMmrPx8HUWDOY9LuSTsenoySY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708260031; c=relaxed/simple;
	bh=7hbdV91MrBto8JKPz8p1poHgpVrkh1a7ubJfJ9hhfHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCGAqT9/Es+Dd76Nsuh4VTCZFKtQcNYY9M6PFOzVXOyYd1QqcSfj9+yeKy1u+E2t44P+V9URCblvJWTwQOroCcH4d2yaQWjZ0PoTIqwNy72xUZuo9ef0hVo4b55DKZxa4u5kiicKTgSePm/szjRSRyHvFQ9swlbSIcqrqFjtt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mBR2OF66; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gZmqfmB6fTBR74XgJI+NN8XTEyIaAFoIbaH6cB+nt6s=; b=mBR2OF66UJDI6eSNbTgQXD+wCc
	NesRa+Hql7Df5cVcsDdkuEl5mwXoNrHSgNDgkML6JoR6Mnob4IED2QMayj6A0YoBnGwnw4DaztJFj
	wihuyCiFiT19ddMcFLX9JYFYZxHSsZofJusrW5UKvtXQ8rJ9exHa/tT14EwJchA+iCgu2pha6aLYD
	XeIYSz+WpDwgJyxnSGUoXW7cKOuJN7UobFSwWr6AGiUBzvcR5YoLHQciZF6co0COeZICs/QFSfAMJ
	n9QWMvr8lUZ95gMIJStvpyNQH3m8Slpj1DZQbVil+WiupdVF5jH28K29h13ghcHZGuzRkfvoLnwGs
	TV57ATRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rbgS7-0002It-3D;
	Sun, 18 Feb 2024 12:39:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rbgRu-0007Qi-70; Sun, 18 Feb 2024 12:39:14 +0000
Date: Sun, 18 Feb 2024 12:39:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com, Peter Geis <pgwipeout@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>, Xu Liang <lxu@maxlinear.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, rust-for-linux@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 0/3] net: phy: detach PHY driver OPs from
 phy_driver struct
Message-ID: <ZdH6csVX1ZOPYP84@shell.armlinux.org.uk>
References: <20240217194116.8565-1-ansuelsmth@gmail.com>
 <ZdEOpB1oVDE8+Qhq@shell.armlinux.org.uk>
 <65d13fcd.050a0220.88fe3.665f@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d13fcd.050a0220.88fe3.665f@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 18, 2024 at 12:22:45AM +0100, Christian Marangi wrote:
> On Sat, Feb 17, 2024 at 07:53:08PM +0000, Russell King (Oracle) wrote:
> > Would it make more sense instead of this big churn, to instead
> > introduce into struct phy_driver:
> > 
> > 	struct mdio_device_id	*ids;
> > 
> > which would then allow a phy_driver structure to be matched by
> > several device IDs?
> 
> Yes that was an alternative idea, but is it good to then have 2 way to
> declare PHY ID?
> 
> Also the name should be changed... Maybe an array of a struct PHY_ID,
> name that ends with a sentinel?

We already have arrays of mdio_device_id in every driver, whether they
can be re-used or not is a separate issue. In any case, merely adding
support for this (only build tested patch below) is a much smaller
change.

 drivers/net/phy/phy_device.c | 64 +++++++++++++++++++++++++++++++++-----------
 include/linux/phy.h          | 16 ++++++++++-
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2e7d5bfb338e..7e02bf51a2a5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -522,12 +522,51 @@ static int phy_scan_fixups(struct phy_device *phydev)
 	return 0;
 }
 
+static const struct mdio_device_id *
+phy_driver_match_id(struct phy_driver *phydrv, u32 id)
+{
+	const struct mdio_device_id *ids = phydrv->ids;
+
+	if (ids) {
+		while (ids->phy_id) {
+			if (phy_id_compare(id, ids->phy_id, ids->phy_id_mask))
+				return ids;
+			ids++;
+		}
+	}
+
+	if (phy_id_compare(id, phydrv->id.phy_id, phydrv->id.phy_id_mask))
+		return &phydrv->id;
+
+	return NULL;
+}
+
+static const struct mdio_device_id *
+phy_driver_match(struct phy_driver *phydrv, struct phy_device *phydev)
+{
+	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
+	const struct mdio_device_id *id;
+	int i;
+
+	if (!phydev->is_c45)
+		return phy_driver_match_id(phydrv, phydev->phy_id);
+
+	for (i = 1; i < num_ids; i++) {
+		if (phydev->c45_ids.device_ids[i] == 0xffffffff)
+			continue;
+
+		id = phy_driver_match_id(phydrv, phydev->c45_ids.device_ids[i]);
+		if (id)
+			return id;
+	}
+
+	return NULL;
+}
+
 static int phy_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 	struct phy_driver *phydrv = to_phy_driver(drv);
-	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
-	int i;
 
 	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
 		return 0;
@@ -535,20 +574,7 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
 	if (phydrv->match_phy_device)
 		return phydrv->match_phy_device(phydev);
 
-	if (phydev->is_c45) {
-		for (i = 1; i < num_ids; i++) {
-			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
-				continue;
-
-			if (phy_id_compare(phydev->c45_ids.device_ids[i],
-					   phydrv->phy_id, phydrv->phy_id_mask))
-				return 1;
-		}
-		return 0;
-	} else {
-		return phy_id_compare(phydev->phy_id, phydrv->phy_id,
-				      phydrv->phy_id_mask);
-	}
+	return !!phy_driver_match(phydrv, phydev);
 }
 
 static ssize_t
@@ -3311,6 +3337,7 @@ static int phy_probe(struct device *dev)
 	int err = 0;
 
 	phydev->drv = phydrv;
+	phydev->drv_id = phy_driver_match(phydrv, phydev);
 
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
@@ -3485,6 +3512,11 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.owner = owner;
 	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
+	if (!new_driver->id.phy_id) {
+		new_driver->id.phy_id = new_driver->phy_id;
+		new_driver->id.phy_id_mask = new_driver->phy_id_mask;
+	}
+
 	retval = driver_register(&new_driver->mdiodrv.driver);
 	if (retval) {
 		pr_err("%s: Error %d in registering driver\n",
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fd8dbea9b4d9..2f2ebbd41535 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -542,6 +542,7 @@ struct macsec_ops;
  *
  * @mdio: MDIO bus this PHY is on
  * @drv: Pointer to the driver for this PHY instance
+ * @drv_id: The matched driver ID for this PHY instance
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
  * @phy_id: UID for this device found during discovery
@@ -639,6 +640,7 @@ struct phy_device {
 	/* Information about the PHY type */
 	/* And management functions */
 	const struct phy_driver *drv;
+	const struct mdio_device_id *drv_id;
 
 	struct device_link *devlink;
 
@@ -882,6 +884,9 @@ struct phy_led {
  * struct phy_driver - Driver structure for a particular PHY type
  *
  * @mdiodrv: Data common to all MDIO devices
+ * @ids: array of mdio device IDs to match this driver (terminated with
+ *   zero phy_id)
+ * @id: mdio device ID to match
  * @phy_id: The result of reading the UID registers of this PHY
  *   type, and ANDing them with the phy_id_mask.  This driver
  *   only works for PHYs with IDs which match this field
@@ -903,6 +908,8 @@ struct phy_led {
  */
 struct phy_driver {
 	struct mdio_driver_common mdiodrv;
+	const struct mdio_device_id *ids;
+	struct mdio_device_id id;
 	u32 phy_id;
 	char *name;
 	u32 phy_id_mask;
@@ -1203,7 +1210,14 @@ static inline bool phy_id_compare(u32 id1, u32 id2, u32 mask)
  */
 static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
 {
-	return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
+	u32 mask;
+
+	if (phydev->drv_id)
+		mask = phydev->drv_id->phy_id_mask;
+	else
+		mask = phydev->drv->phy_id_mask;
+
+	return phy_id_compare(id, phydev->phy_id, mask);
 }
 
 /* A Structure for boards to register fixups with the PHY Lib */

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

