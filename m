Return-Path: <linux-kernel+bounces-90781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BD98704FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095641F228B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEFA4F1F5;
	Mon,  4 Mar 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jOWFc6YT"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325F47772;
	Mon,  4 Mar 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565021; cv=none; b=EvIZklK4N3PJZEKAbViwoCFSlh7nVFmsArkxkt4YF59R+gRYnOtc4ogvxyf+LuuaBqbbtbwnDFPSTyslaHuGyc7dotDLhQNDVbDPf1AhUklRX/QUkjgaKQJp+LJNO+PpDkxleqBU+J9JnuSjNXGD5Tsn2ynlbKpJ/fKFLeENwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565021; c=relaxed/simple;
	bh=pW+1V7YqOhkcLioMl2DX0tOkmXUQtbPF3XcSxdIf7OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZy4abN0/KZIu/LWvWwlE15EqXAMiA/BojWlBqLmFjPO8af/rqv2z+BVmCdhzctygoCt2CdKFSGwK1e1E2rnYOZebvoeg3GkScPZn42plsBwEkxRyM4wAluk3epCEfrzo5GluP2uByi/pv6WmgkiJDdvzgB6g6G0zyK3cUEj/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jOWFc6YT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4405B1BF20B;
	Mon,  4 Mar 2024 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709565017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmCZ8+vUM5DG7x+TAmA4cTrV/kcQNelYUOaYHrZMngk=;
	b=jOWFc6YTA+JqZ8uZMFTD1zxcWx2ZZf7jB1sEU+oTscYmKbqz2oFj3fFqQF4TtGOIrdja5Y
	Ih949WqcLOaLh4y6ZrMU3x2dGW4pfFyOa/tLtYEH7w9PItt++G4sei7qmVDsjunOL7tqFb
	yXrggYyFSHiMbLfGiDK7dPF87MJkqo4Nf16x09XaTC1aZhSpidzepVWkA00KblZMgRp6Ep
	ZUjCwYp9EurDlbd6ZYv9twBz++Jh+g9HIjWf/KKF3L+t0o1SyWPtsyNEgWhjm6ZhLz1poa
	n3AzhjQFrrlTtdbYfpkbl78+gjzsrAgv/LYMl6zKl9T0fVFPdPGG1Vkb6FK1Hg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v10 02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
Date: Mon,  4 Mar 2024 16:09:58 +0100
Message-ID: <20240304151011.1610175-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
References: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Pass the phy_device as a parameter to the sfp upstream .disconnect_phy
operation. This is preparatory work to help track phy devices across
a net_device's link.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V10: No changes
V9: No changes
V8: No changes
V7: No changes
V6: Moved an incorrectly added hunk from the previous series to patch 0003
V5: No changes
V4: No changes
V3: No changes

 drivers/net/phy/phylink.c | 3 ++-
 drivers/net/phy/sfp-bus.c | 4 ++--
 include/linux/sfp.h       | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 503fd7c40523..8a34883eb99b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3385,7 +3385,8 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	return ret;
 }
 
-static void phylink_sfp_disconnect_phy(void *upstream)
+static void phylink_sfp_disconnect_phy(void *upstream,
+				       struct phy_device *phydev)
 {
 	phylink_disconnect_phy(upstream);
 }
diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index db39dec7f247..e05013aeecc3 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -486,7 +486,7 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
 			bus->socket_ops->stop(bus->sfp);
 		bus->socket_ops->detach(bus->sfp);
 		if (bus->phydev && ops && ops->disconnect_phy)
-			ops->disconnect_phy(bus->upstream);
+			ops->disconnect_phy(bus->upstream, bus->phydev);
 	}
 	bus->registered = false;
 }
@@ -742,7 +742,7 @@ void sfp_remove_phy(struct sfp_bus *bus)
 	const struct sfp_upstream_ops *ops = sfp_get_upstream_ops(bus);
 
 	if (ops && ops->disconnect_phy)
-		ops->disconnect_phy(bus->upstream);
+		ops->disconnect_phy(bus->upstream, bus->phydev);
 	bus->phydev = NULL;
 }
 EXPORT_SYMBOL_GPL(sfp_remove_phy);
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 9346cd44814d..0573e53b0c11 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -544,7 +544,7 @@ struct sfp_upstream_ops {
 	void (*link_down)(void *priv);
 	void (*link_up)(void *priv);
 	int (*connect_phy)(void *priv, struct phy_device *);
-	void (*disconnect_phy)(void *priv);
+	void (*disconnect_phy)(void *priv, struct phy_device *);
 };
 
 #if IS_ENABLED(CONFIG_SFP)
-- 
2.44.0


