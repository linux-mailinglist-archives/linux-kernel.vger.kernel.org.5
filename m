Return-Path: <linux-kernel+bounces-14122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D73821811
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AC71C21538
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8302108;
	Tue,  2 Jan 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mol/eurh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70D53A5;
	Tue,  2 Jan 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e9a42582aso1279419e87.2;
        Mon, 01 Jan 2024 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704181423; x=1704786223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mM3PDqFdCZw+zdDJaYo5Q6NaL9KNCZtFGDckEZSKOng=;
        b=Mol/eurhtbBpBsBEORadegz73+mEs7dwn3x4ZRDn7ShsTpmy4vkU43K+Huv4eAwTCH
         if57tcTZUh5hPYoraZ9UOh0ucDoHvA/QO2juz/ZTjytlpBBxf9OGCSi1Y8vf4rmarU2n
         rhoMUaU1Ns7y3dRyNzpWxlNyvgbEbSKa00jMBja34bG372GC0q6/3NzCWfCtjJNncrfq
         tbfvn421EYjHUIGko1jTNke5cG9LxfXe3Bh+dRQwxcctia+Q6sYljaIPwnwtwguhlbGh
         0XuKkMWDudelqll4AkXuCDCsHEp/hj03rSBHCCYTh/74Qct9/TyfNgmtwCM9GRGT8Yl6
         x2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704181423; x=1704786223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM3PDqFdCZw+zdDJaYo5Q6NaL9KNCZtFGDckEZSKOng=;
        b=j1Of+7HZSFh3CedVyScwKpTwKsWpVdxbhlDVcQ6G8F5q7sRPlh7bKZJCk4dsU49Nzo
         j9Yq3GK2fpJG6UBymmvj8CivweQar03nEaHo11zyUi4//UFFuAf50+cHNcee6FE7rSiO
         7h/KQPUGJ1vgv04xX8vzFYxbmMAb1RUbYCNFJPIUzGFXvi20dlaQU2BO6Uefml1BcfiN
         PKTTRoe7QA+w2gz2Mguyfbb212+ekw/pEVAKqvFX18Vr3lWJiEgLM5vLKp1awzIaAZ24
         ozSAs1Y0dAxSt5C7MCom9DxhtQCObBBEg+Li15P95B1x3m3cLQuIJnX7U9XZWvFYTpQR
         04wA==
X-Gm-Message-State: AOJu0YwMsPoBED9T/pXSOuKFrb0LOLJ6zcf9ML/+xvJby2dB+GMD9Pry
	AOgfySBuqmWKKgsit+oxp6Q=
X-Google-Smtp-Source: AGHT+IFPtfc//kD/XoMFYOLGF/DLaFInPnIJKxvQEy0hvSCHjbtHIQ8SDlaKUR5cxnPPR9uEALzwig==
X-Received: by 2002:a05:6512:3d9e:b0:50e:7042:468d with SMTP id k30-20020a0565123d9e00b0050e7042468dmr7464991lfv.36.1704181422779;
        Mon, 01 Jan 2024 23:43:42 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d0d7000000b005533a9934b6sm15574325edo.54.2024.01.01.23.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 23:43:42 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frank-w@public-files.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC net-next] net: phylink: add quirk for disabling in-band-status for mediatek pcs at 2500base-x
Date: Tue,  2 Jan 2024 08:43:26 +0100
Message-ID: <20240102074326.1049179-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In follow up to: net: pcs: pcs-mtk-lynxi: use 2500Base-X without AN

MediaTek LynxI PCS, 2500Base-X will only work without inband status due to
hardware limitation.

I understand this patch probably will not get approved as it is now, but
perhaps with some pointers in the correct direction to follow, I can change
it so it could be. It does however get the result that the rtl8221b on a
sfp module functions correctly, with and without (as optical sfp) the phy
attached and without using a quirk/ethtool to disable auto-negotiation.

Introduce bool phylink_major_no_inband(pl,interface), a function similar to
bool phylink_phy_no_inband(phy). An option could be to use a function like
bool pcs->ops->supports_inband(interface), where if the function-pointer is
null, it means it is supported for all. This instead of using
of_device_is_compatible() inside the phylink_major_no_inband() function.

Code added to phylink_major_config():

When there is no PHY attached, pl->pcs_neg_mode is set to
PHYLINK_PCS_NEG_INBAND_DISABLED.

When there is a PHY attached, pl->cur_link_an_mode is set to MLO_AN_PHY.
To have the pcs function correctly with the rtl8221b, we need to do the
following to the in-band-status:

We need to disable it when interface of the pcs is set to 2500base-x,
but need it enable it when switched to sgmii.

So we get:

[...] mtk_soc_eth ... eth1: phy link up sgmii/1Gbps/Full/none/rx/tx
[...] mtk_soc_eth ... eth1: phylink_mac_config: mode=inband/sgmii/none
                                adv=00,00000000,00000000,00000000 pause=03

[...] mtk_soc_eth ... eth1: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx
[...] mtk_soc_eth ... eth1: phylink_mac_config: mode=phy/2500base-x/none
                                adv=00,00000000,00008000,0000606f pause=03

Changes to be committed:
	modified:   drivers/net/phy/phylink.c

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/phylink.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 298dfd6982a5..6e443eb8ee46 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1074,6 +1074,22 @@ static void phylink_pcs_an_restart(struct phylink *pl)
 		pl->pcs->ops->pcs_an_restart(pl->pcs);
 }
 
+static bool phylink_major_no_inband(struct phylink *pl, phy_interface_t interface)
+{
+	struct device_node *node = pl->config->dev->of_node;
+
+	if (!node)
+		return false;
+
+	if (!of_device_is_compatible(node, "mediatek,eth-mac"))
+		return false;
+
+	if (interface != PHY_INTERFACE_MODE_2500BASEX)
+		return false;
+
+	return true;
+}
+
 static void phylink_major_config(struct phylink *pl, bool restart,
 				  const struct phylink_link_state *state)
 {
@@ -1085,10 +1101,22 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 
 	phylink_dbg(pl, "major config %s\n", phy_modes(state->interface));
 
+	if (phylink_major_no_inband(pl, state->interface) && (!!pl->phydev)) {
+		if (pl->cur_link_an_mode == MLO_AN_INBAND)
+			pl->cur_link_an_mode = MLO_AN_PHY;
+		else
+			/* restore mode if it was changed before */
+			pl->cur_link_an_mode = pl->cfg_link_an_mode;
+	}
+
 	pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
 						state->interface,
 						state->advertising);
 
+	if (phylink_major_no_inband(pl, state->interface) && !pl->phydev &&
+	    pl->pcs_neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		pl->pcs_neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
+
 	if (pl->using_mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs)) {
@@ -1218,6 +1246,9 @@ static void phylink_mac_pcs_get_state(struct phylink *pl,
 				      struct phylink_link_state *state)
 {
 	linkmode_copy(state->advertising, pl->link_config.advertising);
+	if (pl->pcs_neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				   state->advertising);
 	linkmode_zero(state->lp_advertising);
 	state->interface = pl->link_config.interface;
 	state->rate_matching = pl->link_config.rate_matching;
-- 
2.42.1


