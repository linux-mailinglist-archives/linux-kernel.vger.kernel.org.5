Return-Path: <linux-kernel+bounces-97442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21931876A92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B592F1F21EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B857878;
	Fri,  8 Mar 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edRqX6nh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2452C853;
	Fri,  8 Mar 2024 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921465; cv=none; b=A5/m2cxlCaouXnkjfKC16CaOE0/2cicfTweRtHWn5u9/Q1jpHONW1pwFYpXL4p71ABX6hS9IhbOI65TgGOC/vaQ1hzmihcozistdc+QQQ7rDiC3BnErlN1IcMH4l3add8mBkOZzYqLli8q0IUmfw+gKJRQf4b0iV71p/JsLcmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921465; c=relaxed/simple;
	bh=utxrg0pNh6ZbcAIwRjF9wFUYQwIU/V2MSk12njbmDog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5MXvDrbnM44S86BzPlk6SO6EETPNZ8M4C3SwyQMkMPwiwiMmmsQX76wGoEDfozEMQpW8TG9CzIpoPaj3MrTKZENf3ktTcemrRiWz1evzhUjidvHm1bXRn38cPej6MO8N7FY9S8PXtUe7qh1G+NFdnRGIyY2OvziKL0gxK/Pvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edRqX6nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283CBC433C7;
	Fri,  8 Mar 2024 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709921465;
	bh=utxrg0pNh6ZbcAIwRjF9wFUYQwIU/V2MSk12njbmDog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edRqX6nhErDnO5DqqLDyUiWB+Xa1bPYu1fOyMldzCNGRkJM7j5uj6Xj0oy7wcEUMl
	 Pxv1nTFk6Kpd4s0UtQI1Nbex/DZSNKXfmiZq4Tyisy0uqInj4RgfQUwbaRYWS07kQB
	 BpWEopMIjtLDJw+YJwkCDodi0wyVlGMRBJEXa5YKiabyGtFtluEWgbnJK/81oOAmuV
	 xfkir0wIkOn7A82imICL0d5w9Qb8ixhaj8wzYtGl0IW4phdRR02J5xD6QlUVQWFble
	 2DAhglL2rJdMsgNloew200fTRKzzMZEJMggMkJ/qjEt9VdqvQyd1tD3VsO1XnRqYeu
	 gqWebCNA6Z1Tw==
Date: Fri, 8 Mar 2024 12:11:03 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <20240308181103.GA855753-robh@kernel.org>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
 <20240308-asrc_8qxp-v6-2-e08f6d030e09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308-asrc_8qxp-v6-2-e08f6d030e09@nxp.com>

On Fri, Mar 08, 2024 at 10:30:51AM -0500, Frank Li wrote:
> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> have 1 interrupt.
> 
> Increase max interrupt number to 2 and add restriction for platforms except
> i.MX8QXP and i.MX8QM.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,spdif.yaml        | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> index 56f8c0c8afdea..a242f68f99f18 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> @@ -31,7 +31,11 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Combined or receive interrupt
> +      - description: Transmit interrupt

Test your patches please because this will have warnings. Or, you can 
put in *exactly* what I provided because this is not it.

If you continue to just toss crap at us at the rate you are, the DT 
maintainers will either just start ignoring your patches or require some 
trusted review by another NXP colleague first (offhand, not sure who 
that would be which is part of the problem).

Rob

