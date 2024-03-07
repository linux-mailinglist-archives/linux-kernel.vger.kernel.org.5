Return-Path: <linux-kernel+bounces-96301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D638759E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E833828297A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9D13EFE0;
	Thu,  7 Mar 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW8L14UC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA0131E3C;
	Thu,  7 Mar 2024 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849028; cv=none; b=tvUiO60CqimaQw1hVkf7wCd9bAerbvCIC8o3qshqNsyTh5MKfkny95YowQwFYXGHWTQxJwG/mDgYS0BmitBEOCm590eX/cBu+V/kbD/pgu3UBkKvzWsWATjlteOXjOIQpQ3ue2MeFmGZpcWZ2YfpmVYoYR+gZs5O0rRbPtS8aD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849028; c=relaxed/simple;
	bh=uXXY5fFvxOrrTcB+iOTkNq6WmKRJCgv3X2iBCtsruYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaWUqAqbDNN9iqmLuku2ug98DqZQmR8BOgyRcQUBwLZSGaG9l8ah1svS4Iqn5L1558HPuqacQ4d5EIRgd7eydbrEZWGyUhcHLdAuqh+VlPnmgG73/gaF4+jszZ6RF50eHa1LScjuZ+qHCZ8qOpaBQp8pt0u14kdxgD9EzSZRLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW8L14UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF545C433F1;
	Thu,  7 Mar 2024 22:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849028;
	bh=uXXY5fFvxOrrTcB+iOTkNq6WmKRJCgv3X2iBCtsruYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nW8L14UCIz1KhLfGfg1HRdnMqy207TaeZAkS0kmZkbcS65xYqBCSPjouX14eZqdxo
	 LQcvxpT+SWMBn0kbfbkQetayioo4O1WsMJUuDZCz1r4Kx+wLQXhg484FU/LMVtN4Ey
	 FJdjpXCYzuJocWjzyBvd8iOhZ+xAFYxoQx4xHZ9zhO394dXvWi2pNvu3muug/06E7p
	 OiY7ZxsacHNzswLLl44n1xjmPN20YFr1XafsLnbziJ2JWRLY+izdp5fxveufB8EAQb
	 DOgaN7o/xn+YeDd2A80x5FjQ2tGE+YiVhfLcAQ/kS3kESPXE+6LXo5w3pH0GG9/HNb
	 CTAhLkDThhtQA==
Date: Thu, 7 Mar 2024 16:03:44 -0600
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
Subject: Re: [PATCH v5 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <20240307220344.GA3133548-robh@kernel.org>
References: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
 <20240307-asrc_8qxp-v5-2-db363740368d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307-asrc_8qxp-v5-2-db363740368d@nxp.com>

On Thu, Mar 07, 2024 at 02:19:09PM -0500, Frank Li wrote:
> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> have 1 interrupt.
> 
> Increase max interrupt number to 2 and add restriction for platforms except
> i.MX8QXP and i.MX8QM.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

I still don't know what the 2 interrupts are (reading this patch). You 
need something like this:

interrupts:
  minItems: 1
  items:
    - description: Combined or receive interrupt
    - description: Transmit interrupt

Correct whatever I got wrong in the descriptions...

