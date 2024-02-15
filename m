Return-Path: <linux-kernel+bounces-67109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595DB85669C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C29C1C22FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EC13248C;
	Thu, 15 Feb 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvpubKcC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5201132461;
	Thu, 15 Feb 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008924; cv=none; b=ltpuyi3uI3hFsJdw9yBfPeH/OkNoQOGEsWMXnpSoWbtEwiIHYg/vjfX5JAb3qNLjJ714Ar0lp1tRzxu4SGqLSJmJm5a4MUDTMhzfD9V/Ds3L0XuUx3UpRq0goo+xAOw7lVY4h4phlOZbAT4GcXe6/qJi5aVnjK+K+02UPfywRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008924; c=relaxed/simple;
	bh=Xo56YjEkb3PoIIHlm3YyDfE/vrdIxz8HkhajQhUNEps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raA/ZjlrUYDqP45nyhgNxBsiBmnw5qd4xi9IEtWmr3/BOQeq77nr7jZWh+JwYB/1LTY2mQXhGEQyD5eBAAmbC5DJPyPOa1bUKyG08AeMGAGnS7ARtBsI5wdol4Lkt6JBSM9y+6sBaHW3aigu1LneYelipE2l2YzWr5hLoIgabQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvpubKcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC676C433F1;
	Thu, 15 Feb 2024 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708008924;
	bh=Xo56YjEkb3PoIIHlm3YyDfE/vrdIxz8HkhajQhUNEps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvpubKcC9wLxsXopx09TTB0HcsFo68c6NY/8G04efmt87QDcXjYURbeQT70FaEC5N
	 Cl0FQ+XQP0egMm2vT93LbSZ2XipbsUQuFg5od7vJAw8rvJjvuvXswL3AgNdKBzQaWm
	 6RFSPcl97dwXY+ohE18jYTt8aSdjd2l32CAamHdKgYsq6GZTFVN63xIhakw52tw/N6
	 5eYW6tKp7FFZuNcVz1bhNme9jtwMAWLTt5T5SriSeyqSQS88wktpUyj90pCdee6sZV
	 Sjvq0G58c/KBS/Be0My4tfU3aGvjmmmsjv+f5gfFl10L6AQEQvV9QK1///I7Mzlw2m
	 t8FHEQEM41ifA==
Date: Thu, 15 Feb 2024 08:55:20 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/17] dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add
 imx6
Message-ID: <20240215145520.GA20171-robh@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-7-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213010347.1075251-7-sre@kernel.org>

On Tue, Feb 13, 2024 at 02:00:55AM +0100, Sebastian Reichel wrote:
> Add compatibles used by different i.MX6 variants to the i.MX IOMUX
> Controller GPR binding.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml   | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> index 1da1b758b4ae..8451cb4dd87c 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> @@ -17,7 +17,23 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: fsl,imx8mq-iomuxc-gpr
> +          - enum:
> +              - fsl,imx6q-iomuxc-gpr
> +              - fsl,imx8mq-iomuxc-gpr
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - enum:
> +              - fsl,imx6sl-iomuxc-gpr
> +              - fsl,imx6sll-iomuxc-gpr
> +              - fsl,imx6ul-iomuxc-gpr
> +          - const: fsl,imx6q-iomuxc-gpr
> +          - const: syscon

A bit odd that imx6q is a simple-mfd above, but not here. I suppose 
that could be valid if the variants here don't have sub-devices or they 
do, but have a dependency on the parent.

Acked-by: Rob Herring <robh@kernel.org>

> +      - items:
> +          - enum:
> +              - fsl,imx6sx-iomuxc-gpr
> +              - fsl,imx7d-iomuxc-gpr
> +          - const: fsl,imx6q-iomuxc-gpr
>            - const: syscon
>            - const: simple-mfd
>        - items:
> -- 
> 2.43.0
> 

