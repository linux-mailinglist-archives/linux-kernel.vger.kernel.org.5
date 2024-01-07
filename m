Return-Path: <linux-kernel+bounces-18967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C78265CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8136B1F2158E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA72111AA;
	Sun,  7 Jan 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1QkFxda"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5F11183;
	Sun,  7 Jan 2024 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28bf46ea11so208622366b.1;
        Sun, 07 Jan 2024 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704656499; x=1705261299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObkI4/hpAc5XCYcrKwgY+Xsx/yEYLmlwpmTk1Flaajo=;
        b=N1QkFxdaonlWqAhAvqnEQPJMfOpSqkHtd69NmCsRM/D/RHRnQFvFPsbOBeXbkXGLnO
         AEuo7iedKlNb3hQGoabTZASKtFJFbz+WyIUJy2a8mBa4RdhAOmmqZHBu5XpCKn0JH5wK
         4jrGX0ow7NTnsPRXhmRp7FT/MiVolHaBislPYn76HqvmxtUFbJYbFLiobtMuX82xsXtU
         XJXzNZ/SuL6C9ag4d5LMDEG21WOip15gXLdu43RHfOKcmKcd+PyDVW6foOcRbSAsuOsI
         2GQpRSGrDmMiymkZrblBryg9pe1MxTN/kKLWO3EQuC6qO0vT1iRNaFDpWo5j19cr04qh
         QhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704656499; x=1705261299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObkI4/hpAc5XCYcrKwgY+Xsx/yEYLmlwpmTk1Flaajo=;
        b=HNmzACho7kd9W4+7yWzNMAdnGU9ogGoJN/SSfezJIEowLHQrmGZO5S+pl9sMYYhrhQ
         IgCHibw3lO5bjuxnrYvrM5PoGyi+C44RdIlWkqA3SIIaMmnUN260IHHtpTKZC7JhaFps
         92BKLosuVF5hu1nlJR4uIJuVENXnePhX/t/9vTLLuagTskN3ntBnClwflx98LICs7bQR
         DoosLM2/UOAjBvCxEFEot+SAOb47PyI3YXBfKocZlRmrVFcvBvcs6pUTqAiR+Yr8S7uj
         kIoqVKqi069Ptptm6nAeySDhmGBNqQL/sAfu/yfwGxEfFnFWKjuNfUETuteoS0Pk1cyy
         qn7Q==
X-Gm-Message-State: AOJu0YxoRdc8yDd9fcnEtXeC0Jp5QitR8NP32HVeRTtHQbUrI/wSBC8y
	KQmdDHYUf2GPOXrkTQesMH8=
X-Google-Smtp-Source: AGHT+IH31Fk17x8DYiIrH3Q0+tye342WuIdmMYNFJs+1QZp0qAs/AH1bgXtFv1zwhGMSkiK+UDQklA==
X-Received: by 2002:a17:906:27c2:b0:a2a:b797:bde7 with SMTP id k2-20020a17090627c200b00a2ab797bde7mr168993ejc.13.1704656498643;
        Sun, 07 Jan 2024 11:41:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id et9-20020a056402378900b00557884a55efsm1140264edb.9.2024.01.07.11.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 11:41:38 -0800 (PST)
Message-ID: <2c13d157-c8da-4cf4-b8a1-668ab34b803f@gmail.com>
Date: Sun, 7 Jan 2024 20:41:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: phylink: add quirk for disabling
 in-band-status for mediatek pcs at 2500base-x
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240102074326.1049179-1-ericwouds@gmail.com>
 <ZZQDWzYlxAKl0JxI@shell.armlinux.org.uk>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <ZZQDWzYlxAKl0JxI@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/2/24 13:36, Russell King (Oracle) wrote:

> As 6.6 was declared LTS, I think we can now move phylink_pcs_neg_mode()
> into phylink.c, and thus think about what we should do with:

In the other rfc patch Russell King (Oracle) wrote:

> Since Autoneg is clear, phylink_mii_c22_pcs_decode_state() won't
> change state->speed and state->duplex, which should already be
> correctly set.

So the rfc patch now I have changed it to the following. Sure still
not ready for the real patch, but a few steps closer. The rtl8221b
can now be used as optical sfp (even without disabling autoneg in the 
sfp-quirk). Also it can be used with marek's rtl8221b rollball patch,
that changes interface between 2500base-x and sgmii. This is tested
on the BananaPi R3. The speed and duplex get are set from phylink. I'm
not sure what to do with pl->link_config.pause. For now I set it to
MLO_PAUSE_NONE.

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 298dfd6982a5..3f03af290fa3 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1074,6 +1055,108 @@ static void phylink_pcs_an_restart(struct phylink *pl)
 		pl->pcs->ops->pcs_an_restart(pl->pcs);
 }
 
+/* This function needs to be changed, not using compatible */
+static bool phylink_basex_no_inband(struct phylink *pl)
+{
+	struct device_node *node = pl->config->dev->of_node;
+
+	if (!node)
+		return false;
+
+	if (!of_device_is_compatible(node, "mediatek,eth-mac"))
+		return false;
+
+	return true;
+}
+
+static void phylink_pcs_neg_mode(struct phylink *pl,
+				 phy_interface_t interface,
+				 const unsigned long *advertising){
+	if ((!!pl->phydev) && phylink_basex_no_inband(pl)) {
+		switch (interface) {
+		case PHY_INTERFACE_MODE_1000BASEX:
+		case PHY_INTERFACE_MODE_2500BASEX:
+			if (pl->cur_link_an_mode == MLO_AN_INBAND)
+				pl->cur_link_an_mode = MLO_AN_PHY;
+			break;
+		default:
+			/* restore mode if it was changed before */
+			if ((pl->cur_link_an_mode == MLO_AN_PHY) &&
+			    (pl->cfg_link_an_mode == MLO_AN_INBAND))
+				pl->cur_link_an_mode = pl->cfg_link_an_mode;
+		}
+	}
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		/* These protocols are designed for use with a PHY which
+		 * communicates its negotiation result back to the MAC via
+		 * inband communication. Note: there exist PHYs that run
+		 * with SGMII but do not send the inband data.
+		 */
+		if (!phylink_autoneg_inband(pl->cur_link_an_mode))
+			pl->pcs_neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+		else
+			pl->pcs_neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		break;
+
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		/* 1000base-X is designed for use media-side for Fibre
+		 * connections, and thus the Autoneg bit needs to be
+		 * taken into account. We also do this for 2500base-X
+		 * as well, but drivers may not support this, so may
+		 * need to override this.
+		 */
+		if (!phylink_autoneg_inband(pl->cur_link_an_mode))
+			pl->pcs_neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					   advertising) &&
+					   !phylink_basex_no_inband(pl))
+				pl->pcs_neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		else {
+			pl->pcs_neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
+			linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					   pl->link_config.advertising);
+			pl->link_config.speed = (interface ==
+			                         PHY_INTERFACE_MODE_1000BASEX) ?
+			                         SPEED_1000 : SPEED_2500;
+			pl->link_config.duplex = DUPLEX_FULL;
+			pl->link_config.pause = MLO_PAUSE_NONE; /* ????? */
+
+		}
+		break;
+
+	default:
+		pl->pcs_neg_mode = PHYLINK_PCS_NEG_NONE;
+		break;
+	}
+
+	return;
+}
+
 static void phylink_major_config(struct phylink *pl, bool restart,
 				  const struct phylink_link_state *state)
 {
@@ -1085,9 +1187,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 
 	phylink_dbg(pl, "major config %s\n", phy_modes(state->interface));
 
-	pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
-						state->interface,
-						state->advertising);
+	phylink_pcs_neg_mode(pl, state->interface, state->advertising);
 
 	if (pl->using_mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
@@ -1191,9 +1291,9 @@ static int phylink_change_inband_advert(struct phylink *pl)
 		    pl->link_config.pause);
 
 	/* Recompute the PCS neg mode */
-	pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
-					pl->link_config.interface,
-					pl->link_config.advertising);
+	phylink_pcs_neg_mode(pl, pl->link_config.interface,
+			    pl->link_config.advertising);
+
 
 	neg_mode = pl->cur_link_an_mode;
 	if (pl->pcs->neg_mode)
@@ -1222,7 +1322,8 @@ static void phylink_mac_pcs_get_state(struct phylink *pl,
 	state->interface = pl->link_config.interface;
 	state->rate_matching = pl->link_config.rate_matching;
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-			      state->advertising)) {
+			      state->advertising) &&
+			      (pl->pcs_neg_mode != PHYLINK_PCS_NEG_INBAND_DISABLED)) {
 		state->speed = SPEED_UNKNOWN;
 		state->duplex = DUPLEX_UNKNOWN;
 		state->pause = MLO_PAUSE_NONE;

