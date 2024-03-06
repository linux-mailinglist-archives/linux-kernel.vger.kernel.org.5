Return-Path: <linux-kernel+bounces-94573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737AB874194
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17901C210E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A01175A7;
	Wed,  6 Mar 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXF5lxxx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F2CA4E;
	Wed,  6 Mar 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758527; cv=none; b=irlIoZrAiADSY1xmm7xOGiW0Q5u2kOgGmdSYXROWQYev7F0yIOqV6YAmRtv9oOUMb1Jw9jxERvJ6jC27mYNflLTJTrkqpPjxVfLtpjSnlJu74Nk70rew8rZkg17Ui+lJjdRqTEdKBjSUzPfgZ4zNCtpsLG919AEppA4PlXIDFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758527; c=relaxed/simple;
	bh=8wpIf1u7ZRpALOfHZ4AX6o9s1PVu3WXuDX1nZ0s4XSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVkjC148brJfJ2RSHsKVr7SalvW2/OjuQFQ7cUsmSd4nHICeK2FM6N4cz8ufufQYLBCgB6BPsIBf2Tqe6vtfhvOg621qifrLNl3DJF058Kp6n+GaJIQJLm++BSOGL6w3zv6YhxR0e/jwJsHYHMoWo7MqRv9iOyNxpGLn5schycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXF5lxxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9114C433F1;
	Wed,  6 Mar 2024 20:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709758526;
	bh=8wpIf1u7ZRpALOfHZ4AX6o9s1PVu3WXuDX1nZ0s4XSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXF5lxxx+5t7+86g9lXRI/nNc8B4ygRS3Pb/kEY2lndTQUNMt4NdY7rUvEMCXmXQl
	 vxmyt4AOGSH2J4BP3G5owS+NwYYzYVNAi7VZYYC94rGw+DYdQFHddWlgmPeVdHI8e5
	 TO7VYXRFl7FeITijsC6W/rxrVtrmpB3/n7h3O0uJGKcoF7CRFZnbC5m2BZD+1zwpuh
	 zt5ZPUwn/ak239yElwk+gNSlGGsBVgGtYpsdxO76K4qrOOJlgOJrZVidGFIn2F+MVm
	 w0zqPA++4MN6nCQbqOK5WuxVp7d/V16f5iYor8Lvr8kR2Chbaj4VvihYTvX3vsDAx6
	 hUYzM5k4d/n0Q==
Date: Wed, 6 Mar 2024 14:55:24 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240306205524.GB587561-robh@kernel.org>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
 <20240306-pebble-grope-88fdaa95a87c@spud>
 <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZejDQddMp17RD6Yk@lizhi-Precision-Tower-5810>

On Wed, Mar 06, 2024 at 02:25:53PM -0500, Frank Li wrote:
> On Wed, Mar 06, 2024 at 06:45:13PM +0000, Conor Dooley wrote:
> > On Tue, Mar 05, 2024 at 12:33:04PM -0500, Frank Li wrote:
> > > Some sai only connect one direction dma (rx/tx) in SOC. For example:
> > > imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> > > for dma-names.
> > > 
> > > Remove description under dmas because no user use index to get dma channel.
> > > All user use 'dma-names' to get correct dma channel. dma-names already in
> > > 'required' list.
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > index 2456d958adeef..6f551c68d33db 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > @@ -81,15 +81,14 @@ properties:
> > >  
> > >    dmas:
> > >      minItems: 1
> > > -    items:
> > > -      - description: DMA controller phandle and request line for RX
> > > -      - description: DMA controller phandle and request line for TX
> > > +    maxItems: 2
> > >  
> > >    dma-names:
> > > -    minItems: 1
> > > -    items:
> > > -      - const: rx
> > > -      - const: tx
> > > +    oneOf:
> > > +      - items:
> > > +          - const: rx
> > > +          - const: tx
> > > +      - enum: [ rx, tx ]
> > 
> > I'm not entirely sure if this was Rob's suggestion, I got the impression
> > he was suggesting that in the two items case we'd not care about the
> > order. But while I think this is different to that suggestion it's also
> > not wrong.
> 
> I log this at cover-letter. b4 can't support write change log at every
> patch yet.

It never will (probably). That's because it doesn't need to. You can 
just do it with git. When you edit the commit message, then after the 
tags, Add '---' and put whatever you want after. That works as long as 
the commit is applied from a patch as 'git am' will drop it. 

> Rob's suggest was not work. dt-binding check complain too long
> if there are two dma-names = "rx", "tx". 

So I'm wrong or you didn't have it correct? No way to tell with your 
explanation. Let me give you the exact schema:

dma-names:
  minItems: 1
  items:
    - enum: [ rx, tx ]
    - const: tx

This says we can have 1 or 2 entries. The first entry can be either rx 
or tx. The 2nd entry must be tx. That's what you want. However, '"tx", 
"tx"' is allowed with the above, but we enforce items to be unique 
elsewhere. Or I thought we did, but we relaxed '.*-names$' at some 
point. I'm going to fix that now.

Rob

