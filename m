Return-Path: <linux-kernel+bounces-129571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF5896CB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AF02820FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC74B1420A5;
	Wed,  3 Apr 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haLxy8zZ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1221411F2;
	Wed,  3 Apr 2024 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140677; cv=none; b=ZCZvlj6GZkYcH7yj4t+1432bXzBgJ1wIc8Nw+nTr4Q7VDLM0o7xcVwDG9HAv+yKqDtm/Zad5bInvmGp5x4tXsP8rrtgUjT3y2Ha6edYXYESQA8c4/YtSQGkAbH4b7NfTUMFRRCjP2UnQWzbnd64XLOhuIIwaN54ROXeh7D6qcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140677; c=relaxed/simple;
	bh=RNzWaV0YS7Bu2UB99RZuHOoMtzT5XBda5tMY+XPplUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ad+/3KmTD4BWFI9JJ+ptwvN3zRag9A6/Q4AgZNWpq9JDRMaiS7cCMGKSTwU/8rKa33RrB2+1uJAiEwZHULHVSNa9hjMl9164cogMLFEmXKvbP5NQdugFhYrjucC21swt5M62l6ORPZvlg5nBuI9OUpCVkx5qybksvg32k62WfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haLxy8zZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c0a249bacso7638625a12.1;
        Wed, 03 Apr 2024 03:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140674; x=1712745474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ck2CqR/iyiP+BpiyWMgFyaN9K8n1DvbHV7cUnb3niw=;
        b=haLxy8zZ7MXza4LhD5ex+sO6EkTDaJVh62lHHnxBDu8lguGmJuntYKhajVur1brjWE
         Dwx69PsIBUqQ8uvk4xI8ShS+6a8uDu7qKiM7AePo/shrhG8XA8rBlwaNpbhEPRCiZqlK
         YgRRpvNghcdXLYsyXoQTCnCHDfmGI9ywND/cjWA49Dbrlg+uBEGd/K6Ord5OR2oziekW
         h2oG1NbldI56+KBmonoXs5DHBF1FuZfbHY0qkqWhGVKQci92qQ71+vwA8PmivRZfYucR
         tgGAYBAT+RszEZIlSDo+/48Ctp6EhWwazzOg5K68UfpGVdZMVCUvS3k64xArPeheO+iC
         Ysqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140674; x=1712745474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ck2CqR/iyiP+BpiyWMgFyaN9K8n1DvbHV7cUnb3niw=;
        b=qss7owkxIVcR4A8Y9E5ENnfih/wqYAgMR0+jy861bnp3SVU/Me0XNNvHHi/8ougxdL
         To+pJMaN/JCBjocH4OjyE2VQxhUk6KeAYz0vWBzXyjr4RxsUPrG1o289BXmRj/9FNWv7
         +Uj1/CdoFOr9RuNN0jwy2vUMeN3o28A6aEyzTCkdT8mfVA5yGoa+nrCiUUZEYV8Y+LmO
         qxmu6HjFJXyx2Lv+QXtbynyJ2eLIKW1uQqlEIyu89L7gGEPEGToZF/xy/IXGQd5dL9L3
         1nFpKMcu8v5L44Ij9d45zqYLPbGYAbDxREFuzjCBpWS99yInoWupW5nVTLj+VWg6RKq8
         hX0w==
X-Forwarded-Encrypted: i=1; AJvYcCXPPPmpiHksJn39NlzGAGKPmK4byU5istgyUwf/QoHs4/DTlDSSsnaQlFdfgooUuF1scfK7SkBvuSRKzLUz6RtukgiXkDcdMZ6vqUKH
X-Gm-Message-State: AOJu0YxbTapYtxsPsLTzvyHbs1BbX0QBUozXMXrN5JMFOrvBQs539bYM
	MNbdj5rxwnlA5+y2ei2wcpNuzk7+IZeBM5ktBu6ddy6v2g0XnjXFOSg0BmZVB0s=
X-Google-Smtp-Source: AGHT+IFkdedKV06hMFtbNYf9Z0MaCMYO9TzWwMVd3NQppfz1sx6N8yIKDEk1JB5ix62QDPWbQbM8gA==
X-Received: by 2002:a17:906:30c4:b0:a4e:fe3:ceff with SMTP id b4-20020a17090630c400b00a4e0fe3ceffmr7538433ejb.57.1712140673848;
        Wed, 03 Apr 2024 03:37:53 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:37:53 -0700 (PDT)
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
Subject: [PATCH net-next v8 02/16] net: dsa: vsc73xx: convert to PHYLINK
Date: Wed,  3 Apr 2024 12:37:18 +0200
Message-Id: <20240403103734.3033398-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403103734.3033398-1-paweldembicki@gmail.com>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
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
v8:
  - resend only
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


