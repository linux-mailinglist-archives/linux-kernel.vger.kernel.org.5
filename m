Return-Path: <linux-kernel+bounces-55396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9284BC35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA7F1F23441
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAAD13FE0;
	Tue,  6 Feb 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L2xZfaVh"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9ADDAE;
	Tue,  6 Feb 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240933; cv=none; b=kXVzJnjPpVYeLMuKj3Wu47Jp0txxjbR5lqiVJeqNIMLuSCDaMrA3TQjAXv7j0LzyYrSy3VrZUgTdeBwKxfT5md8/hWANuUg6ZNKmPQ8TgNHSpmjwBTeJfEpalFLfPcbsUStALOoP7mzwxMAxx7qt+2gbYDdXoTdIHJNW+DCmK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240933; c=relaxed/simple;
	bh=mKEg8NSA+MWEsWOtYemeNPanDj5YdywtPZx/Cs37/D0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7RctNFXCf3pJzAmX+3cGufqBoLyY3lZQkLOxm147873Zb5u4nWd+/2RDm48V7mnr3z+xsvZzJiUXRuK1Zr0RnY1l1B8VCBJYJnCkUZ54c9ynJkH2HzzDrvwdL/bc2jsjMu4zJ5l3ZPqgE4PsXrIBNEHxas+sixqrFBdC2OHwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L2xZfaVh; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22DE240008;
	Tue,  6 Feb 2024 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707240923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaoA+WDat1FJlr5cBeBddcywk0i1Oklt1CF1ajVk3kM=;
	b=L2xZfaVhIHa26kVoZAs1UG/T1TeVIT5oX04AE6DGkHNL1za2UbistMzqLYaIIxVNm0CJ/n
	emHEOFg1uXnVr6famrQDH1v0K3ggxD28JjNSWSwb96rVRvNd3M/WKOzcE1UchoBl+Zb5sE
	wIl9l5fkr2RdOLgPs4+9HCWrlkQydC4pv+vUvTT5YGxGAMUnRfu6bOZLrdsu2MZ7o70fzQ
	KLphmSosUipkmfglqar4JYTOAT476ic+DoKCc5Cw7plSJd63GKv66gtOQO8krLixVGpnt5
	u/QbJA/otO9hh+ODyrC5glCdsSgqkn1VJPWpqX/RjLEDqYH+nN5sLRMa/kFx7Q==
Date: Tue, 6 Feb 2024 18:35:17 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
 alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de, Lucas Stach
 <l.stach@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying
 <victor.liu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 02/12] phy: freescale: add Samsung HDMI PHY
Message-ID: <20240206183517.2b9dfb07@booty>
In-Reply-To: <20240203165307.7806-3-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-3-aford173@gmail.com>
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

On Sat,  3 Feb 2024 10:52:42 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the driver for the Samsung HDMI PHY found on the
> i.MX8MP SoC.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

[...]

> +#define PHY_REG_33		0x84
> +#define  REG33_MODE_SET_DONE	BIT(7)
> +#define  REG33_FIX_DA		BIT(1)
> +
> +#define PHY_REG_34		0x88
> +#define  REG34_PHY_READY	BIT(7)
> +#define  REG34_PLL_LOCK		BIT(6)
> +#define  REG34_PHY_CLK_READY	BIT(5)
> +
> +

Nitpick: only one empty line here.

> +#define PHY_PLL_REGS_NUM 48

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

Ouch:

> This function is *deprecated*. Use of_clk_add_hw_provider() instead.

Appears as an easy replacement though.

Otherwise looks good.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

