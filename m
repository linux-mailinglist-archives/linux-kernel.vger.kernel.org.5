Return-Path: <linux-kernel+bounces-117962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D288B666
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58DBB61817
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32DF5B5B3;
	Mon, 25 Mar 2024 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UArTmgyY"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F266B56;
	Mon, 25 Mar 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399483; cv=none; b=iaPOAxwZcXjPfs4GwKh75pahlk1PqyXLIIqmGym21WI9dfa7NGOz+l/yjDgevYh7AtcMjUgD8VXOzV0jy/vedpnMXf3fqItM8e4oG7ZCN/AT1Th4BDvK5dTgqr4oAccc8V8PlGKCNjaeXQY+ki2YOCiwCwyfvWis0JM3/P88nZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399483; c=relaxed/simple;
	bh=NN3Q6fEUpQFPJwyI/sF2V4GUMiIqPWv8LHfRQaeaVwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIktXxTa/SN8TKh/amNAAIWuBLahrwgsmCr7RqxjM8wCgacCqdkVHFeLJ4cdSiINo3mzs7V3dZCmHPg8Fgh4WMKSOLQuXxAqOu/YJnpV2M32CPi3Yw2qUjeTzeDVm2O07RSD+4ACcmJZ/7FDXWH/6rT8cSGEnSLMjvOO5t55poE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UArTmgyY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c1a520659so1204533a12.1;
        Mon, 25 Mar 2024 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399480; x=1712004280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3F3o0xYdA9ZOv6apMVbgo/NjnscMLmWpdUFxEQ0wug=;
        b=UArTmgyYYx77BXNHvgCDHYOFKmKv15J6D2YPsMmGkcGw/L4r+5GyA/I8Gfwio2qThk
         M3/yuTqWraaj3/ssjISlNzT8HY/bWbE7sIoljpR78Dx1j47Cj99zkgfu03kTT5fjm2NF
         g3j7ipfkVyBgTGWucXd65S0+e9lssEwxlQkGvp6p1Xr6aXEazHjaBYc1/5b3Nu5VQvPf
         JhOKAWcGRt5Tc8WUPmF52nwYxLx168+2rpJMjatjiV4Dttj+pOxiDMKCrF3SK94cLLtK
         S21eSalrDuzLyDV23/uFiDwamGNgDwc2QE0nWO3b+DzgPV1RjS13tKxs5WvxwA1+da3I
         xEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399480; x=1712004280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3F3o0xYdA9ZOv6apMVbgo/NjnscMLmWpdUFxEQ0wug=;
        b=vorI8DoLK/pJiUCe9691IyLbvpivObzQJjOKJ9VGpnjbLOvxvk3Te3RwDrazjkeXnd
         aPCjCb1Y7FrYNeeZxxb6As5isALrU/LWpHV23IkKfR7L6BldyCbHq79QFa0FWiKt9GAe
         c2cldPRwqHEMoMgBs6BxRm21I0jWhE/Jq68HJ5CXBJHNdfss5A/W+An5k8qXoGvRQ+RM
         qTTESpPDQQYWSL2bo83kawRqWQaCTrHPwVwMV8FIlvDu1f9hfGGNRKxJ+yADkDS47Agl
         RVrWvtresE/sArkrqyQt3lmTan9u35NFdkUbkEwYUljVql480hv4w1+1nR+0njuglV1c
         6YXg==
X-Forwarded-Encrypted: i=1; AJvYcCXt32wBwWSOrp09bkdRumKbJhtNqi5uAbCPHHHk8mXJYbsxLz81sA82BMJWwHljZipyynoMAf7lrvdEDUrbV0TU6HKChccaPWgFqJpd
X-Gm-Message-State: AOJu0Yzv9a51S1V/6ZLPLV98U0GDMqLutwQU4lScxJ3Oo7WRtp/9fscr
	unqNwhbqioHj8IxR8DG7UqhHFalzxL4OWIPwcepWq/jVe2f2h/jaS59MDiQMyqM=
X-Google-Smtp-Source: AGHT+IHqVJnpocOEDgV7jAIbVWN1L28cHyk2FlXMCpKmLd1ERX4vUxh7TjhW8IhPvOaBczs7RNvfYg==
X-Received: by 2002:a50:cd4c:0:b0:568:b851:f718 with SMTP id d12-20020a50cd4c000000b00568b851f718mr542540edj.40.1711399479801;
        Mon, 25 Mar 2024 13:44:39 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:44:39 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
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
Subject: [PATCH net-next v7 02/16] net: dsa: vsc73xx: convert to PHYLINK
Date: Mon, 25 Mar 2024 21:43:27 +0100
Message-Id: <20240325204344.2298241-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
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

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v7:
  - added 'Reviewed-by' to commit message only
v6:
  - resend only
v5:
  - introduce MAC reset function with procedure described in datasheet
  - reorganise routines
  - move 'Accept packets again' routine to 'phylink_mac_link_up'
  - fix one FIXME
v4:
  - update commit descripion
  - remove phylink_get_caps after rebase to current net-next/main
v3:
  - remove legacy_pre_march2020 after rebase
v2:
  - replace switch to if and get rid of macros in
    vsc73xx_phylink_mac_link_up function

 drivers/net/dsa/vitesse-vsc73xx-core.c | 235 ++++++++++++-------------
 1 file changed, 109 insertions(+), 126 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ab5771d4d828..cb2e7e256279 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -717,52 +717,43 @@ static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
 		      port, VSC73XX_C_RX0, 0);
 }
 
-static void vsc73xx_adjust_enable_port(struct vsc73xx *vsc,
-				       int port, struct phy_device *phydev,
-				       u32 initval)
+static void vsc73xx_reset_port(struct vsc73xx *vsc, int port, u32 initval)
 {
-	u32 val = initval;
-	u8 seed;
-
-	/* Reset this port FIXME: break out subroutine */
-	val |= VSC73XX_MAC_CFG_RESET;
-	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG, val);
-
-	/* Seed the port randomness with randomness */
-	get_random_bytes(&seed, 1);
-	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
-	val |= VSC73XX_MAC_CFG_SEED_LOAD;
-	val |= VSC73XX_MAC_CFG_WEXC_DIS;
-	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG, val);
+	int ret, err;
+	u32 val;
 
-	/* Flow control for the PHY facing ports:
-	 * Use a zero delay pause frame when pause condition is left
-	 * Obey pause control frames
-	 * When generating pause frames, use 0xff as pause value
-	 */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_FCCONF,
-		      VSC73XX_FCCONF_ZERO_PAUSE_EN |
-		      VSC73XX_FCCONF_FLOW_CTRL_OBEY |
-		      0xff);
+	/* Disable RX on this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+			    VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_RX_EN, 0);
 
-	/* Disallow backward dropping of frames from this port */
+	/* Discard packets */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-			    VSC73XX_SBACKWDROP, BIT(port), 0);
+			    VSC73XX_ARBDISC, BIT(port), BIT(port));
+
+	/* Wait until queue is empty */
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 || (val & BIT(port)),
+				VSC73XX_POLL_SLEEP_US,
+				VSC73XX_POLL_TIMEOUT_US, false,
+				vsc, VSC73XX_BLOCK_ARBITER, 0,
+				VSC73XX_ARBEMPTY, &val);
+	if (ret)
+		dev_err(vsc->dev,
+			"timeout waiting for block arbiter\n");
+	else if (err < 0)
+		dev_err(vsc->dev, "error reading arbiter\n");
 
-	/* Enable TX, RX, deassert reset, stop loading seed */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
-			    VSC73XX_MAC_CFG,
-			    VSC73XX_MAC_CFG_RESET | VSC73XX_MAC_CFG_SEED_LOAD |
-			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN,
-			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN);
+	/* Put this port into reset */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
+		      VSC73XX_MAC_CFG_RESET | initval);
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
@@ -778,102 +769,92 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 			      VSC73XX_ADVPORTM_ENA_GTX |
 			      VSC73XX_ADVPORTM_DDR_MODE);
 	}
+}
+
+static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int port,
+					  unsigned int mode,
+					  phy_interface_t interface)
+{
+	struct vsc73xx *vsc = ds->priv;
 
-	/* This is the MAC confiuration that always need to happen
-	 * after a PHY or the CPU port comes up or down.
+	/* This routine is described in the datasheet (below ARBDISC register
+	 * description)
 	 */
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
-					VSC73XX_POLL_SLEEP_US,
-					VSC73XX_POLL_TIMEOUT_US, false,
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
+	vsc73xx_reset_port(vsc, port, 0);
 
-		return;
-	}
+	/* Allow backward dropping of frames from this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
 
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
-		dev_err(vsc->dev,
-			"could not adjust link: unknown speed\n");
-	}
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
+	u8 seed;
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
+
+	/* This routine is described in the datasheet (below ARBDISC register
+	 * description)
+	 */
+	vsc73xx_reset_port(vsc, port, val);
+
+	/* Seed the port randomness with randomness */
+	get_random_bytes(&seed, 1);
+	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
+	val |= VSC73XX_MAC_CFG_SEED_LOAD;
+	val |= VSC73XX_MAC_CFG_WEXC_DIS;
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG, val);
+
+	/* Flow control for the PHY facing ports:
+	 * Use a zero delay pause frame when pause condition is left
+	 * Obey pause control frames
+	 * When generating pause frames, use 0xff as pause value
+	 */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_FCCONF,
+		      VSC73XX_FCCONF_ZERO_PAUSE_EN |
+		      VSC73XX_FCCONF_FLOW_CTRL_OBEY |
+		      0xff);
+
+	/* Accept packets again */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_ARBDISC, BIT(port), 0);
 
 	/* Enable port (forwarding) in the receieve mask */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), BIT(port));
+
+	/* Disallow backward dropping of frames from this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_SBACKWDROP, BIT(port), 0);
+
+	/* Enable TX, RX, deassert reset, stop loading seed */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+			    VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_RESET | VSC73XX_MAC_CFG_SEED_LOAD |
+			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN,
+			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN);
 }
 
 static int vsc73xx_port_enable(struct dsa_switch *ds, int port,
@@ -1060,7 +1041,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
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


