Return-Path: <linux-kernel+bounces-77557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FB4860775
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0467D284EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01C65C;
	Fri, 23 Feb 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1xlwVYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AC19B;
	Fri, 23 Feb 2024 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647202; cv=none; b=r0oZ1QMscjnDSsitKIxADGm0kFHbxQI8+4JflslIytvg302ENxPFsPfYr9NjXP97ioDK18m9ZmGEYCzVI6hEZA97O0VX2PCNSNl3r8Vm4ARhE+/VvZxjD404CvUNKaR/DYXVVNTp1ao+kt6nqrjx0LlzjeN+1QhSczKyUhoizXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647202; c=relaxed/simple;
	bh=WrfhKnkZoUwVt/L7piLpwgqgYhyHxtoagm5LeTByIXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgCota0v9+my+sYUMzssg/YpNegB5X0eRaQhb2cW29jNOffZ49N/z0D/rUpbRvNiGrzxpQJrsPRyBOIa9MEODCujxMwDvCvQ8FHyv5GTtqcKJ5hvg8CjRgORJPefZXY0qxviHq/4wT0QuDbyIbMM5G3UhZEMfrWDy8D7omu9zs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1xlwVYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF12C433F1;
	Fri, 23 Feb 2024 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647201;
	bh=WrfhKnkZoUwVt/L7piLpwgqgYhyHxtoagm5LeTByIXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1xlwVYKGWCxscOdJpuNpQisTFh5QltxjOIlIBuiX/MomkfpnMuO/iv/WhuFGIQYs
	 RsA3igZhKnXBAmDQnOrT4dDcb/J0IrDIZXJ9A2jhBunY4eq8QZWs4nuj8ZXibgnjTi
	 Wfq0BMmHrxYJRAE12FCPd+PpHhEGOQ0yZXueO49UuaW01IV0jGD9FscaCakB2gKnne
	 aM6tgyR9Qcq/VRi8rtIbjW5T5/y8is1ohmcELEMWRFLt44U/NZ40zDT2gtmUMeF50e
	 FuhhqeR9WRGY+7P92vHE092HG7pZQtmEHy7lDumX/xc79iWZ30XXGUGTUpNW9HCKx3
	 0MQdc/tT3m5EA==
Date: Thu, 22 Feb 2024 17:13:17 -0700
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Message-ID: <20240223001317.GA3857129-robh@kernel.org>
References: <20240218-imx95-dts-v1-0-2959f89f2018@nxp.com>
 <20240218-imx95-dts-v1-1-2959f89f2018@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-imx95-dts-v1-1-2959f89f2018@nxp.com>

On Sun, Feb 18, 2024 at 02:38:51PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add DT compatible string for NXP i.MX95 19x19 EVK board.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 39378879777b..3b318c518e35 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1264,6 +1264,12 @@ properties:
>                - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
>            - const: fsl,imx93
>  
> +      - description: i.MX95 based Boards
> +        items:
> +          - enum:
> +              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
> +          - const: fsl,imx93

imx93 or imx95?

> +
>        - description: i.MXRT1050 based Boards
>          items:
>            - enum:
> 
> -- 
> 2.37.1
> 

