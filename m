Return-Path: <linux-kernel+bounces-64422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519FA853E23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CF51C217F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33B64CD0;
	Tue, 13 Feb 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxdjuzuT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433163CAE;
	Tue, 13 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861913; cv=none; b=A+JD9rRxdmsl6y7Hmq4QnuMGKfFUalPSTDiDLjK/K5bF4u29xDUXyQMbhEjGcl+IbtNQxbA9Htid3f1dKaZ3LZ0u3pA9mDedhrM0EvFkMPJgPUkIYdk52B03kUDfU2CC5y0KlkXFFFtXQ6nAiYWOODzk9VRC6H4/OIBbX6gZnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861913; c=relaxed/simple;
	bh=yEjRlTeHU1w+2Rf1F1hrkdWRrgjpz55T4ZpfkZoGlaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbMtCzeizoNoojH5KcKm7QNCH+oYWWwW5mTV9G8iUpGV5cUkbfAweaHVKPYgMKJv3GLG6JwX+iH3bCi4Sgz9PRVvlojhXVeCSyaIJkA+oeiCtZyBFLeF+oQL6jsuB7zNtz9vPpo3Z+2DVT1G0IXTkaonlCsqhcUAvgL5lHpZ1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxdjuzuT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a38271c0bd5so614416566b.0;
        Tue, 13 Feb 2024 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861909; x=1708466709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+zX7GM3eAspifd077YFCj/xmWH5BRFUvp0tC1IJz9E=;
        b=gxdjuzuTEGGixzOeeP4oM05vDcISJb2G73eBoChC5ZmR+KT9KtKW4itpjTLKdkQvzX
         Cr+sgX1WMOKHhxWSS8IvqRsV0VffGSeBQBId9rgZj39ucKn8SZmpKAsE/aJTZe3PFKnP
         9G/TfLUDahWPbP/x6SBGF6Gei82Epx4zCUcxJaNq/YHbHD8bk9U5AXRu627Lzvw1blvo
         hbhr6wFLK4QAPYmqE4PtDcOU5vI5zHxIaRjm1EEzuyyOeVDAfBP1G/+0XxpLuQQlerJ1
         qdEwGW/mhsPXnZaLJ9txaBWoy1YTI45q1pt3hbAdQN8lu9FB43P0BgMoDWkfwlZ7lYFs
         YKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861909; x=1708466709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+zX7GM3eAspifd077YFCj/xmWH5BRFUvp0tC1IJz9E=;
        b=iA4qcc4/iktyPOlyJZFE/XpSFD9Sk5YbTQ/Mml8u5f6HvSmwB7JprVZEHzLEYQakHV
         nXGMGU7EbdbFCslvenXW/ntX9t+xvUP4EZ6UFYeijuVwR6K37z8c1ER53+J0irigh9Cs
         FljV9MbRxEW/Tzo6k4HNiBtEISl355XtmHhjKetUUTManK6uNBq7Nm2pRp3fcpPV5QzH
         2atAmb6ySL+zSs4HaPVfTf2OOgfqS29ydguHa338eRalMwvwqmjibhns5DpTKokHH+k4
         3N25ggFS44VBFxhBtB6FbN+T7DSeoSg3mLybxXw/FV5fpK8h2TT7VwtJwXojpU+K3x9y
         0wIg==
X-Forwarded-Encrypted: i=1; AJvYcCUUCkceUVTWiRJEg/EFIVbNEB+fWMPmDg/iYIIycYwKTXfEZe0fPPSyEml0JfvNoEZMDjH78hqb9VILxrELu/xuzjyVsvJHHZgM1458
X-Gm-Message-State: AOJu0YwCneYLFqlXhrCih29Er8uHoC7nD/WIXZ1Kp7wmeAAm8f9mOJxP
	HuLsIcN7FLUzzw07GZ18pioKfONPDjTkaDOGco68tDPF9J3Oa1dbBPXM1ohe5vo=
X-Google-Smtp-Source: AGHT+IF8YZI7u5V7pI003no9Snlwiu4mThhLeZNuC2zokJMUrHCwDJzYnA8U3Ah369MoRte/SX5eLQ==
X-Received: by 2002:a17:906:b48:b0:a3c:2a66:3fdd with SMTP id v8-20020a1709060b4800b00a3c2a663fddmr468714ejg.17.1707861909047;
        Tue, 13 Feb 2024 14:05:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxab9q2Y7PMVWEI1uQzcxkyJ4b96TTuLVgetSUhnge+w5ZEiDsgQoHfSmgLj2EYKWIDOJIAvEMajitC16MMTuQV380mMKdQwx3Bkag3T/awAGelohkmko7dQ6FOVkQMr9RttqFcZceB9ahxnmBYXn4cPd47pGfhqX5kESV4ro1UjFkURP5ichApsexC2qbQHU6LuPViJf9Bpf9jRR4HMopG7PAwp1QrF4CemBWrWSwxOjahKAizXYaFMXZFvhkbHdP0JbRHdbSvQhNW5OB/Dve+NcMAPfUgRcTLHgsC4Hcq82ed0WNHeVcklY7HolPWri8Gl9Y46TgC08tumGuZ35CL86/yoJZxtIuSKuVJAPUC+0fi/wvCz4R3uaLK+XKSIOEcL4e6oKd8tBDHWep1HqAnHyqFFu2pqh5Qjd1wgm4gFgXtJgUMKD7TxVnY98HTRCsYUdELm+RxA==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:05:08 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 02/15] net: dsa: vsc73xx: convert to PHYLINK
Date: Tue, 13 Feb 2024 23:03:15 +0100
Message-Id: <20240213220331.239031-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces the adjust_link api with the phylink apis that provide
equivalent functionality.

The remaining functionality from the adjust_link is now covered in the
phylink_mac_link_* and phylink_mac_config.

Removes:
adjust_link
Adds:
phylink_mac_config
phylink_mac_link_up
phylink_mac_link_down

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - update commit descripion
  - remove phylink_get_caps after rebase to current net-next/main
v3:
  - remove legacy_pre_march2020 after rebase
v2:
  - replace switch to if and get rid of macros in
    vsc73xx_phylink_mac_link_up function

 drivers/net/dsa/vitesse-vsc73xx-core.c | 166 +++++++++++--------------
 1 file changed, 72 insertions(+), 94 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 8b2219404601..70dd3f96dafb 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -714,8 +714,7 @@ static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
 }
 
 static void vsc73xx_adjust_enable_port(struct vsc73xx *vsc,
-				       int port, struct phy_device *phydev,
-				       u32 initval)
+				       int port, u32 initval)
 {
 	u32 val = initval;
 	u8 seed;
@@ -753,12 +752,11 @@ static void vsc73xx_adjust_enable_port(struct vsc73xx *vsc,
 			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN);
 }
 
-static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
-				struct phy_device *phydev)
+static void vsc73xx_phylink_mac_config(struct dsa_switch *ds, int port,
+				       unsigned int mode,
+				       const struct phylink_link_state *state)
 {
 	struct vsc73xx *vsc = ds->priv;
-	u32 val;
-
 	/* Special handling of the CPU-facing port */
 	if (port == CPU_PORT) {
 		/* Other ports are already initialized but not this one */
@@ -774,101 +772,79 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 			      VSC73XX_ADVPORTM_ENA_GTX |
 			      VSC73XX_ADVPORTM_DDR_MODE);
 	}
+}
 
-	/* This is the MAC confiuration that always need to happen
-	 * after a PHY or the CPU port comes up or down.
-	 */
-	if (!phydev->link) {
-		int ret, err;
-
-		dev_dbg(vsc->dev, "port %d: went down\n",
-			port);
-
-		/* Disable RX on this port */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
-				    VSC73XX_MAC_CFG,
-				    VSC73XX_MAC_CFG_RX_EN, 0);
-
-		/* Discard packets */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_ARBDISC, BIT(port), BIT(port));
-
-		/* Wait until queue is empty */
-		ret = read_poll_timeout(vsc73xx_read, err,
-					err < 0 || (val & BIT(port)),
-					1000, 10000, false,
-					vsc, VSC73XX_BLOCK_ARBITER, 0,
-					VSC73XX_ARBEMPTY, &val);
-		if (ret)
-			dev_err(vsc->dev,
-				"timeout waiting for block arbiter\n");
-		else if (err < 0)
-			dev_err(vsc->dev, "error reading arbiter\n");
-
-		/* Put this port into reset */
-		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
-			      VSC73XX_MAC_CFG_RESET);
-
-		/* Accept packets again */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_ARBDISC, BIT(port), 0);
-
-		/* Allow backward dropping of frames from this port */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
-
-		/* Receive mask (disable forwarding) */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-				    VSC73XX_RECVMASK, BIT(port), 0);
+static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int port,
+					  unsigned int mode,
+					  phy_interface_t interface)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int ret, err;
+	u32 val;
 
-		return;
-	}
+	/* Disable RX on this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+			    VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_RX_EN, 0);
 
-	/* Figure out what speed was negotiated */
-	if (phydev->speed == SPEED_1000) {
-		dev_dbg(vsc->dev, "port %d: 1000 Mbit mode full duplex\n",
-			port);
-
-		/* Set up default for internal port or external RGMII */
-		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
-			val = VSC73XX_MAC_CFG_1000M_F_RGMII;
-		else
-			val = VSC73XX_MAC_CFG_1000M_F_PHY;
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else if (phydev->speed == SPEED_100) {
-		if (phydev->duplex == DUPLEX_FULL) {
-			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 100 Mbit full duplex mode\n",
-				port);
-		} else {
-			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 100 Mbit half duplex mode\n",
-				port);
-		}
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else if (phydev->speed == SPEED_10) {
-		if (phydev->duplex == DUPLEX_FULL) {
-			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 10 Mbit full duplex mode\n",
-				port);
-		} else {
-			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 10 Mbit half duplex mode\n",
-				port);
-		}
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else {
+	/* Discard packets */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_ARBDISC, BIT(port), BIT(port));
+
+	/* Wait until queue is empty */
+	ret = read_poll_timeout(vsc73xx_read, err, err < 0 || (val & BIT(port)),
+				1000, 10000, false, vsc, VSC73XX_BLOCK_ARBITER,
+				0, VSC73XX_ARBEMPTY, &val);
+	if (ret)
 		dev_err(vsc->dev,
-			"could not adjust link: unknown speed\n");
-	}
+			"timeout waiting for block arbiter\n");
+	else if (err < 0)
+		dev_err(vsc->dev, "error reading arbiter\n");
+
+	/* Put this port into reset */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
+		      VSC73XX_MAC_CFG_RESET);
+
+	/* Accept packets again */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_ARBDISC, BIT(port), 0);
+
+	/* Allow backward dropping of frames from this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
+
+	/* Receive mask (disable forwarding) */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_RECVMASK, BIT(port), 0);
+}
+
+static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
+					unsigned int mode,
+					phy_interface_t interface,
+					struct phy_device *phydev,
+					int speed, int duplex,
+					bool tx_pause, bool rx_pause)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
+
+	if (speed == SPEED_1000)
+		val = VSC73XX_MAC_CFG_GIGA_MODE | VSC73XX_MAC_CFG_TX_IPG_1000M;
+	else
+		val = VSC73XX_MAC_CFG_TX_IPG_100_10M;
+
+	if (interface == PHY_INTERFACE_MODE_RGMII)
+		val |= VSC73XX_MAC_CFG_CLK_SEL_1000M;
+	else
+		val |= VSC73XX_MAC_CFG_CLK_SEL_EXT;
+
+	if (duplex == DUPLEX_FULL)
+		val |= VSC73XX_MAC_CFG_FDX;
 
 	/* Enable port (forwarding) in the receieve mask */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), BIT(port));
+	vsc73xx_adjust_enable_port(vsc, port, val);
 }
 
 static int vsc73xx_port_enable(struct dsa_switch *ds, int port,
@@ -1055,7 +1031,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.setup = vsc73xx_setup,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
-	.adjust_link = vsc73xx_adjust_link,
+	.phylink_mac_config = vsc73xx_phylink_mac_config,
+	.phylink_mac_link_down = vsc73xx_phylink_mac_link_down,
+	.phylink_mac_link_up = vsc73xx_phylink_mac_link_up,
 	.get_strings = vsc73xx_get_strings,
 	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
 	.get_sset_count = vsc73xx_get_sset_count,
-- 
2.34.1


