Return-Path: <linux-kernel+bounces-32327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A9835A45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1AFB21486
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA104C9D;
	Mon, 22 Jan 2024 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="SxRkMb14"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB84C6F;
	Mon, 22 Jan 2024 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901663; cv=none; b=eylNRJuY4CwmcQ8A+ZW6qDXpQSkYuuYO8qQYY8/GEecusoIZBNZ4RlExXodaKkTuYD4p7vOFZaybBzszhQrn4la/xIuz+lC7vVPvRaY2/KWygDznkhj0jIcITMIZK16ZEfwdesdENsLQak/A7i9UGx89t3t3kb7TjSyKK/gOfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901663; c=relaxed/simple;
	bh=Gr/lFVSC/sloO0j7uEV1oRzqzdwzIJnxJJunVKAuEhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=s3GgUdfutjhGUnVGDIZFswmQwZuy3Rk2iUMIcQRS1/67YExfCMtbSCRdNTVz8H8+NR7z44MBD58n7E7AqeU91wvemVr+3a4Ca1nBSPjhSP/uaIHtwst5xpb3zf3eAnpeFXFnHgrMyysdpuyUW/CS3d2wYpT4zYUHmp0ZDVmx0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=SxRkMb14; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F455FF803;
	Mon, 22 Jan 2024 05:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705901652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mB9WRD6UXawX/aZviJr/LqXnsIPoDNYg4d4Tt1YlqkY=;
	b=SxRkMb14wn++UxcMrOZme+dR5/cym/kRXGFuenpi3Dm5PvNsbn0oWpyGmrfhQ1oSB/4jJ/
	aW6GihGsMOxaVyJG1a6fqjBioKPbdo44oEJLd/AfKk8TSJyDBZGAvcT4AUG2VUAaeXrPQD
	yy8spbFZCDFIT7tBwoDMMhIoGWEyrHBIgh+tdCMNgLOi3zF1dlmiQu92caulhpVg78iCKA
	JC8tm/gvNbDQaP1KSHi7vuBGC+uOPp5pRrfzC4qzL6d2PhQT9XZp3Zhz0rft8MOCcTR4lr
	lcIpxR4Peo9TIxt+YksTVGuMxr1sOR+vOMgHZkS1SBY8Y1gpQuyTWK4JakNIaQ==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration from DSA core
Date: Mon, 22 Jan 2024 08:33:48 +0300
Message-Id: <20240122053348.6589-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

The code block under the "!ds->user_mii_bus && ds->ops->phy_read" check
under dsa_switch_setup() populates ds->user_mii_bus. The use of
ds->user_mii_bus is inappropriate when the MDIO bus of the switch is
described on the device tree [1].

For this reason, use this code block only for switches [with MDIO bus]
probed on platform_data, and OF which the switch MDIO bus isn't described
on the device tree. Therefore, remove OF-based MDIO bus registration as
it's useless for these cases.

These subdrivers which control switches [with MDIO bus] probed on OF, will
lose the ability to register the MDIO bus OF-based:

drivers/net/dsa/b53/b53_common.c
drivers/net/dsa/lan9303-core.c
drivers/net/dsa/realtek/realtek-mdio.c
drivers/net/dsa/vitesse-vsc73xx-core.c

These subdrivers let the DSA core driver register the bus:
- ds->ops->phy_read() and ds->ops->phy_write() are present.
- ds->user_mii_bus is not populated.

The commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus") which brought
OF-based MDIO bus registration on the DSA core driver is reasonably recent
and, in this time frame, there have been no device trees in the Linux
repository that started describing the MDIO bus, or dt-bindings defining
the MDIO bus for the switches these subdrivers control. So I don't expect
any devices to be affected.

The logic we encourage is that all subdrivers should register the switch
MDIO bus on their own [2]. And, for subdrivers which control switches [with
MDIO bus] probed on OF, this logic must be followed to support all cases
properly:

No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if "interrupt-controller" is defined at
the switch node. This case should only be covered for the switches which
their dt-bindings documentation didn't document the MDIO bus from the
start. This is to keep supporting the device trees that do not describe the
MDIO bus on the device tree but the MDIO bus is being used nonetheless.

Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
the switch node and "interrupts" is defined at the PHY nodes under the
switch MDIO bus node].

Switch MDIO bus defined but explicitly disabled: If the device tree says
status = "disabled" for the MDIO bus, we shouldn't need an MDIO bus at all.
Instead, just exit as early as possible and do not call any MDIO API.

After all subdrivers that control switches with MDIO buses are made to
register the MDIO buses on their own, we will be able to get rid of
dsa_switch_ops :: phy_read() and :: phy_write(), and the code block for
registering the MDIO bus on the DSA core driver.

Link: https://lore.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/ [1]
Link: https://lore.kernel.org/netdev/20240103184459.dcbh57wdnlox6w7d@skbuf/ [2]
Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 net/dsa/dsa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ac7be864e80d..09d2f5d4b3dd 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/of.h>
-#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <net/dsa_stubs.h>
 #include <net/sch_generic.h>
@@ -626,7 +625,6 @@ static void dsa_switch_teardown_tag_protocol(struct dsa_switch *ds)
 
 static int dsa_switch_setup(struct dsa_switch *ds)
 {
-	struct device_node *dn;
 	int err;
 
 	if (ds->setup)
@@ -666,10 +664,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 
 		dsa_user_mii_bus_init(ds);
 
-		dn = of_get_child_by_name(ds->dev->of_node, "mdio");
-
-		err = of_mdiobus_register(ds->user_mii_bus, dn);
-		of_node_put(dn);
+		err = mdiobus_register(ds->user_mii_bus);
 		if (err < 0)
 			goto free_user_mii_bus;
 	}
-- 
2.40.1


