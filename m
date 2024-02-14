Return-Path: <linux-kernel+bounces-65116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60039854822
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1278E1F25082
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96F19474;
	Wed, 14 Feb 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MG50v+hr"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2418E29;
	Wed, 14 Feb 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909682; cv=none; b=H7Tj7K4ZLo3+Xd57bu3SUkO65h2G4RSkl0Bmba/l7hgxi5e9NELPc2Q2KQJb44tyPsEr0Zg/qi7pZYYREb4x2XBG5+aoBrLxoHl1aOGz46mzkNhjeQ5noo1pCGkJ+tTmEQDW6gp3oR+KGFdu0VzsMfo0w1b81squRNfV+ufjx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909682; c=relaxed/simple;
	bh=bVEDMbNRQNdgU7rU7pyy3NFJovIvbsuZ3+4W7HWhw1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y99y0hAROtIHT+OQkAfKp1l0BR8ieIU9n494/Pdug8PlbdtL/KXPt1icIC27fULRAcA8gFCI6UdFjIbdyHGrdS5a2ehBHZZnbK7KIrNk1gVeKCJNVnyK/NcGWjcuVnzAzAfv6KezIWjZmIbk7CrweICUWjcNFQoyOUusDokoXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MG50v+hr; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 40D12C3C73;
	Wed, 14 Feb 2024 11:15:01 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D3341C0008;
	Wed, 14 Feb 2024 11:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707909293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbCd7AZVKzULogAVyD2ctlD8U9qaBuXdnxYtEHWg6Bs=;
	b=MG50v+hrg+y7Sg5emV0Q18hc73S4l6SuVbSRMoOxiZZBMANq1M+y6VRkBFK4vpDQ3KUF47
	3FCLA/2bvWoZ00xAnOsQvvulgAZlVVWUYZHxY5JuIH5zVV2Cit7f8L4iRyPpepzCuTiGgK
	K9dvysh0wmA9opy9aJRcIHC8s54VV880sbMcQF34Faqw7Th2DyifiHQJYqwvk0QHwvXVnb
	Jst/ZTtDH3mWZbe6mRbre1Bh+Hjmw4rHB6+ThnGlvMVRhHhGl15ZjosN5OWrU8xF9pfg2W
	13VL4yRUELvVZ8etF64wkowQ61DjwUu9htb2XYIWh2JX555GVMMKY+sSWXoTQg==
Date: Wed, 14 Feb 2024 12:14:48 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
 aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, Richard
 Leitner <richard.leitner@skidata.com>, Marco Felsch
 <m.felsch@pengutronix.de>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/6] phy: freescale: add Samsung HDMI PHY
Message-ID: <20240214121448.451e2e1c@booty>
In-Reply-To: <20240210204606.11944-3-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
	<20240210204606.11944-3-aford173@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

On Sat, 10 Feb 2024 14:45:58 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the driver for the Samsung HDMI PHY found on the
> i.MX8MP SoC. Based on downstream implementation from
> Sandor Yu <Sandor.yu@nxp.com>.  According to the TRM, the PHY
> receives parallel data from the link and serializes it.  It
> also sets the PLL clock needed for the TX serializer.
> 
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v2)
> Tested-by: Richard Leitner <richard.leitner@skidata.com> (v2)
> Co-developed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

[...]

> +static int phy_clk_register(struct fsl_samsung_hdmi_phy *phy)
> +{
> +	struct device *dev = phy->dev;
> +	struct device_node *np = dev->of_node;
> +	struct clk_init_data init;
> +	const char *parent_name;
> +	struct clk *phyclk;
> +	int ret;
> +
> +	parent_name = __clk_get_name(phy->refclk);
> +
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +	init.flags = 0;
> +	init.name = "hdmi_pclk";
> +	init.ops = &phy_clk_ops;
> +
> +	phy->hw.init = &init;
> +
> +	phyclk = devm_clk_register(dev, &phy->hw);
> +	if (IS_ERR(phyclk))
> +		return dev_err_probe(dev, PTR_ERR(phyclk),
> +				     "failed to register clock\n");
> +
> +	ret = of_clk_add_provider(np, of_clk_src_simple_get, phyclk);

As per my v8 review, this function is deprecated:
https://elixir.bootlin.com/linux/v6.8-rc4/source/drivers/clk/clk.c#L4881

However:

[Tested using Avnet MSC SM2S-IMX8PLUS SoM on Avnet MSC SM2-MB-EP1]
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

