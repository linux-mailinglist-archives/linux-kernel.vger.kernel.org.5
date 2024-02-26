Return-Path: <linux-kernel+bounces-82458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D68684D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806341F233DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F62136640;
	Mon, 26 Feb 2024 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="WXO1PBxy"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC4135419;
	Mon, 26 Feb 2024 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991840; cv=none; b=gfPF03G1MYeF4p1jd5urz3OaNQwEnqeRRlZrF287Kct95g4A1jYWXFTZnabWCK9Sppvb4qDEROIV4QgDA6Q2OO9JxDZKn9yo9j7v04iUFLzdwXtuvgunMKTEhuuqM9ZNnvrNihOdnMIJKUEnjGrox8VjI6eS87XVhjk3K2+Av1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991840; c=relaxed/simple;
	bh=rZaLoAoJVtC2cJB1SpNOGGPxOC1/pGjN9BizSRFZma0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYm6oEsyn3Oxwc3RqHtFd6nvl2LO2LKcHDTXBfEuIP5UXXt6WUIHQqsP9E5ZgIq+5irmKj2McnNXdzlD5lDNHyDBonHr1rO2nv80/Ysubkz9nWYdqIViS0E/2E1KhLvs8F2NM4xTediyXs29Q9MeqQIXDA/XQQGAaj1ecq75bAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=WXO1PBxy; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708991828; bh=rZaLoAoJVtC2cJB1SpNOGGPxOC1/pGjN9BizSRFZma0=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=WXO1PBxyQno+RvrzTOKSG5iaPFGaFoBMY4jYlysNZb6djRltmh6ERSyY70L86T+a1
	 Ilb+f7g+ayjXlBNH3QzL7+QNJZpTmkThUABO8S/1mSAf6Xnk95uInS3xNMmZiJu328
	 vfO6JYvwF1GJyAPEhYPvBb5OFrVsnpo0a1Oj1UL8=
Date: Tue, 27 Feb 2024 00:57:08 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [RESEND PATCH v2 1/5] dt-bindings: sound: Add jack-type property
 to sun8i-a33-codec
Message-ID: <w75crq6ofqq6gisxdda6zeyem5gmsrexe7zarrza46awpstlvk@lc7bttbt63el>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240224135501.3822390-1-megi@xff.cz>
 <20240224135501.3822390-2-megi@xff.cz>
 <20240226194727.GA1320480-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226194727.GA1320480-robh@kernel.org>

On Mon, Feb 26, 2024 at 01:47:27PM -0600, Rob Herring wrote:
> On Sat, Feb 24, 2024 at 02:54:54PM +0100, Ondřej Jirman wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > The codec driver needs to know what jack connector it is connected to
> > on the board. Add proprty to describe the type of connector.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > ---
> >  .../bindings/sound/allwinner,sun8i-a33-codec.yaml        | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> > index 63eadc4200ac..399fc00ad3f4 100644
> > --- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> > +++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> > @@ -44,6 +44,15 @@ properties:
> >        - const: bus
> >        - const: mod
> >  
> > +  jack-type:
> 
> I'm all for a generic property name, but it needs to be documented 
> somewhere common. Perhaps dai-common.yaml.
> 
> I'm sure there is some prior art here to consider as well.

There's only a mention in the code. But there's no use of similar property
on the codec nodes.

https://elixir.bootlin.com/linux/latest/source/sound/soc/soc-component.c#L288

/**
 * snd_soc_component_get_jack_type
 * @component: COMPONENTs
 *
 * Returns the jack type of the component
 * This can either be the supported type or one read from
 * devicetree with the property: jack-type.
 */

This is part of a component, so maybe in sound/component-common.yaml ?

Kind regards,
	o.

> Rob

