Return-Path: <linux-kernel+bounces-55398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DFB84BC3C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40181C23CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4E16431;
	Tue,  6 Feb 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IuaVpEBe"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E214AA7;
	Tue,  6 Feb 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240945; cv=none; b=OTwCishh7lGNGrNGUlVEvEYuvKfMb+Es+GkDiQVfukiVvrKNHBMi0V7kUR45b7M1AjKNxzXpaPeJDRAssNSNPAH+WwD7b4TJPgSVK+AL9IEvd0WaN06kH/wYyXFSE9jJYv34fv832gThp5ItchB/31WA22bYQlOzQr7kV0jJ4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240945; c=relaxed/simple;
	bh=vYW5a3b6r0uvuy7rt/CUuyzW9UQ+MTqSktC5C0cnbaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npVSVeNBDfCH+LSYMBeirFfMFFwcgIrT+aWU1w5VDSm4vVOwXf8oy6cLHlNLVSvXOnZHZJgEyyFZtxLaYoIaFAbgCSKOAWjkfepr6H+NPMNBcaV5Ahl5nDT1lU2jFkg4OJhLr3jIOMhHoZDKy3AmvILtYM6vSTakcrDVEMorRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IuaVpEBe; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89DCE240005;
	Tue,  6 Feb 2024 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707240941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLuicXUcmwZr7iVXdo2HwN/TuKjC2kwohE0VI92lxDs=;
	b=IuaVpEBeEe5/ma32gG5MmgZMvOrq2t5+fbEpAHp73fD+RHZAyHtZFODysyGWeWitS4VPmj
	glHDM/ex8iFFVU5cmpwLh/ok/34y1XrCbiLG2u2dvkDYpKhG7Ovjto5L7u5QOHfSOn8YPK
	z2+SmLsHLThVAomwzIJXC6dLKAZHUfU0iACC4NbxWCKPPf3q2Wc2E+2dhMZWg4yPDp4Kz6
	ALQbMYDH/wc+LKvZtj78iAmu8sp3HwhJ8J9mlEepYr/YKI8/BO2jKsYmFX0L3uN1dA9BHU
	SczZ5hFDtD5M2Ea0LiCv3NPEdYcAOpmmyTP/Kj872voG3PIET650U+XAO6R25w==
Date: Tue, 6 Feb 2024 18:35:37 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
 alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de, Lucas Stach
 <l.stach@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 09/12] dt-bindings: display: imx: add binding for
 i.MX8MP HDMI TX
Message-ID: <20240206183537.38360f1d@booty>
In-Reply-To: <20240203165307.7806-10-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-10-aford173@gmail.com>
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

On Sat,  3 Feb 2024 10:52:49 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The HDMI TX controller on the i.MX8MP SoC is a Synopsys designware IP
> core with a little bit of SoC integration around it.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>

[...]

> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mp-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/imx8mp-power.h>
> +
> +    hdmi@32fd8000 {
> +        compatible = "fsl,imx8mp-hdmi-tx";
> +        reg = <0x32fd8000 0x7eff>;
> +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk IMX8MP_CLK_HDMI_APB>,
> +                 <&clk IMX8MP_CLK_HDMI_REF_266M>,
> +                 <&clk IMX8MP_CLK_32K>,
> +                 <&hdmi_tx_phy>;
> +        clock-names = "iahb", "isfr", "cec", "pix";
> +        power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
> +        reg-io-width = <1>;
> +        ports {
> +           #address-cells = <1>;
> +           #size-cells = <0>;
> +           port@0 {
> +             reg = <0>;
> +
> +             hdmi_tx_from_pvi: endpoint {
> +               remote-endpoint = <&pvi_to_hdmi_tx>;
> +             };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +              hdmi_tx_out: endpoint {

Two excess indenting spaces on this line (port@0 is correct).
Also, I think there should an empty line between properties and nodes.

With these fixed:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

