Return-Path: <linux-kernel+bounces-94559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B254E874158
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB951C22FC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073014262B;
	Wed,  6 Mar 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B10e6mjG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02313BAC8;
	Wed,  6 Mar 2024 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756740; cv=none; b=iyXNnZZPo25izkj7UMfGdPPAk6UxLwezI8KjqLdCEMu1Vs9iqezt0wEN/z6tVBPqvVZzWthgIrPUnGYNEZf8vtNpPjJ71We+uBBconc3s1VN3PbaamoKdACDVZoya5XhwvtyVG2DXVR5a7h3BhnICANOJJoT1KGCDlyrbSeHSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756740; c=relaxed/simple;
	bh=3G3c4eXPS9WuTGpWw0GK2uRbPmxPUtPwC+akL1YrzdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPUumfUlGc30fZ6+rlyK0jrZU/bYTX24amLYo3UwAHQhWI5zu3eRwH9n1h+6qLP3FmIfC1YX806vBpPxRTbdxcB4HWWzSQXQCLDDAqBAGFG5arT7KRN7KZmYpnORjk/qSXMoi5CeWEe1VYiHYRbTjf1H52WpAvCU49/8GmxvPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B10e6mjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6238AC433F1;
	Wed,  6 Mar 2024 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709756739;
	bh=3G3c4eXPS9WuTGpWw0GK2uRbPmxPUtPwC+akL1YrzdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B10e6mjGQOs0efdBGCCO45+ftivoe096/l9+RgnPaVSs19tfRFuM4Mx+vrMOtjYC/
	 a0e2u6JaXj5WPc0K4XpeJMjbDnzmVKXSGX1t1UisEg33lXxespSre1EQ1aVulYWApX
	 b0Ppcl+0kc21h4mePud+g8dTNrI0DEAzPSmNvBGeHZcXYXxIUE/c1mg0ILv/a19y0I
	 KET6P7xBsTFzEZMPU+Gef22JKbEavG/FXb5uP3N/S+IHKcl/zU3hE/ZqcS0k/IVgT8
	 M++2I3T1x3F//Jft+dCPh6l+GMa8lzGyIPQ1Q00B+27uQne1cVnNwrLktO4YIUXqa5
	 pi2mF3+WpGcRw==
Date: Wed, 6 Mar 2024 14:25:37 -0600
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <20240306202537.GA587561-robh@kernel.org>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-2-c61b98046591@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-asrc_8qxp-v4-2-c61b98046591@nxp.com>

On Tue, Mar 05, 2024 at 12:33:03PM -0500, Frank Li wrote:
> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> have 1 interrupt.
> 
> Increase max interrupt number to 2 and add restriction for platforms except
> i.MX8QXP and i.MX8QM.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> index 56f8c0c8afdea..7f6590708e1ec 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> @@ -31,7 +31,8 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    dmas:
>      items:
> @@ -101,6 +102,21 @@ required:
>  additionalProperties: false
>  
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx8qm-spdif
> +            - fsl,imx8qxp-spdif
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 2

Nowhere is it explained what the 2 interrupts are or what the order of 
them is. Is the first interrupt the same as before, and there is a new 
interrupt for something else? Or it's the same interrupts, but they've 
just split up into 2?

Rob

