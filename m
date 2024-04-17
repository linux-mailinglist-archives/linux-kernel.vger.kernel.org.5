Return-Path: <linux-kernel+bounces-148231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FEE8A7FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596871F218E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10FA130A77;
	Wed, 17 Apr 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mhwQPRAl"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C04E572;
	Wed, 17 Apr 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346178; cv=none; b=EI6liq/zmddVUafUZSN7/4Ro/BkGKw1Sfotnshkx03Ozvpa+HkNiIaVGC4E5X84Ay7FxSMoY37M9pE82HPKW+moQceFUbID1NtkCX7V/I20xO50KsxphiXkz0nGwz+1Tk571nCHJxiyrrFrd81mNnSuZJTRiveYRymUbyBt0sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346178; c=relaxed/simple;
	bh=dAfMsMXvSUEMSWs22Y7XybMcFB2joyu4CM9IB29HTNY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ecSsszWEBfngpLzp0pZ3A2Br2nGK4ojo76/MvIiaKnQ/4LiRoF2abKzqtB16LgDBCCoHPdWiKapo19qVJNP0H5p+J2hIDHXkj9jDGEilDe7S9dxaQX21ltuqWW0zNMBiXWBJrj1YH4C/HLv8Vzub7/6q5ChFFioodnKaF1omGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mhwQPRAl; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1E9040003;
	Wed, 17 Apr 2024 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713346173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3i344ERuSxhSsjZp4G790f+W4T/PKZQWnrVfudLzaQ=;
	b=mhwQPRAl2eAxgm367WvffpWd2HLo4U9HRWSem6zyjyJ4qTy+wDutGvj550D/e+ToldascP
	mD6PDSlmlwsqRAAIdY2F5HL1J0VuFuLEQXBXpASBgc773GYY2DIeruPSNIfeZQgLz38wtZ
	HPlxt9dfu/J813/WWZTz3dXqSN2KlTIhVzpOAxRCdML9ylMtidCRvcduhqxpZ3eFivDi1j
	jY2w1UyhmXOEXZ9i9CXjnOYwblYD1bhYgHrJtqKMyBjjZv543catHdGXquiH5xY9anoTkQ
	U2pWEoVvcXWgV56po0F7Nm0O6rq3tBf7xnpDjIY2GUT2bDaIdLIcnqWxRzixyg==
Date: Wed, 17 Apr 2024 11:30:09 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Magnus Damm <magnus.damm@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, 
    =?ISO-8859-15?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-renesas-soc@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, 
    "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 2/5] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
In-Reply-To: <42chuecdt7dpgm6fcrtt2crifvv5hflmtnmdrw5fvk3r7pwjgu@hlcv56dbeosf>
Message-ID: <77722ced-4956-0e70-9492-c7b2e8557253@bootlin.com>
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com> <20240415-rzn1-gmac1-v3-2-ab12f2c4401d@bootlin.com> <42chuecdt7dpgm6fcrtt2crifvv5hflmtnmdrw5fvk3r7pwjgu@hlcv56dbeosf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hi Serge,

On Tue, 16 Apr 2024, Serge Semin wrote:

> I am currently working on my Memory-mapped DW XPCS patchset cooking:
> https://lore.kernel.org/netdev/20231205103559.9605-1-fancer.lancer@gmail.com/
> The changes in this series seems to intersect to what is/will be
> introduced in my patchset. In particular as before I am going to
> use the "pcs-handle" property for getting the XPCS node. If so what
> about collecting PCS-related things in a single place. Like this:
> 
> int stmmac_xpcs_setup(struct net_device *ndev)
> {
> 	...
> 
> 	if (priv->plat->pcs_init) {
> 		return priv->plat->pcs_init(priv); /* Romain' part */
>	} else if (fwnode_property_present(priv->plat->port_node, "pcs-handle")) {
> 		/* My DW XPCS part */
> 	} else if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
> 		/* Currently implemented procedure */
> 	}
> 
> 	...
> }

That seems like a good idea to me, although those setup functions would have to 
be renamed to stmmac_pcs_setup/exit.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

