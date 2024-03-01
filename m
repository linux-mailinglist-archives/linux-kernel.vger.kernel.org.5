Return-Path: <linux-kernel+bounces-89155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7372386EB4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F2D2874E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0E58AAB;
	Fri,  1 Mar 2024 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYLz/Zns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2958ACC;
	Fri,  1 Mar 2024 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328975; cv=none; b=DUhuXVSbIkInrZIJHd8i1yZf8OyKF85uxGhjL7acscqdfIcaNXyd0iu9HuZVst6gjbA89XegWUfgq6EpEkGcNTZV1uTXWodd0i3tYvm6AGzJeKsxa4LOebpzUmNSb7l1f2shVmX1+GWtY5atwkp/bhv0+4IvosaZrR68E7SEjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328975; c=relaxed/simple;
	bh=nNI1GFWV3VF+KBWjXYmR+1rViSk5YziUkARe0UzaTHE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+r6yp4fHvHLlJL9/ItVyMBOIVY5JkiDalmmrWREyDr1RFKqEVuZhV3M6yQ1ak4ETX29pbv7zXgpwI+nW8LtgjE+HVY3g1FZVOcVfIg0JKZ4Odm6AZvXF2ZbIoDNH/Oe0ax5XgtS80BllFMV9cIBmRkNWymbSIUKcF6hmubqADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYLz/Zns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B04C43390;
	Fri,  1 Mar 2024 21:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328975;
	bh=nNI1GFWV3VF+KBWjXYmR+1rViSk5YziUkARe0UzaTHE=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=LYLz/ZnsEinauRuxr4yV1WGVUfRs0tq+0Tot9DU/uKbQeZEb5lw4RA2Iq7/yIdUiP
	 HjrK8XFtaLipJS4P/sVNBh66ZbrHvC28PgCrPyYNECKUsXSLfi5Qx9R6gPD0+4WrEm
	 wKl9ye33lOMRO+aG0nBrEhWD/w0W5Id3KMsrQaLHWfdlBkl9ZlGqCsOc8sva+/IAgP
	 3s87FI+Omy163728oQT2rlDJp922OEJjzBzAeR6h52xiWMuOd8QtlKwoCqg6arKNul
	 kfy4rLGXQ+QAB3qKDZNsV41rWFgr7QK4b2Q5Ercvxnlp4z6FWR7Dz9nK3iIl6nruJx
	 UpBwUdRQtLyGg==
Date: Fri, 1 Mar 2024 15:36:12 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [RESEND PATCH v2 1/5] dt-bindings: sound: Add jack-type property
 to sun8i-a33-codec
Message-ID: <20240301213612.GA3071318-robh@kernel.org>
References: <20240224135501.3822390-1-megi@xff.cz>
 <20240224135501.3822390-2-megi@xff.cz>
 <20240226194727.GA1320480-robh@kernel.org>
 <w75crq6ofqq6gisxdda6zeyem5gmsrexe7zarrza46awpstlvk@lc7bttbt63el>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w75crq6ofqq6gisxdda6zeyem5gmsrexe7zarrza46awpstlvk@lc7bttbt63el>

On Tue, Feb 27, 2024 at 12:57:08AM +0100, Ondřej Jirman wrote:
> On Mon, Feb 26, 2024 at 01:47:27PM -0600, Rob Herring wrote:
> > On Sat, Feb 24, 2024 at 02:54:54PM +0100, Ondřej Jirman wrote:
> > > From: Ondrej Jirman <megi@xff.cz>
> > > 
> > > The codec driver needs to know what jack connector it is connected to
> > > on the board. Add proprty to describe the type of connector.
> > > 
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > ---
> > >  .../bindings/sound/allwinner,sun8i-a33-codec.yaml        | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> > > index 63eadc4200ac..399fc00ad3f4 100644
> > > --- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> > > @@ -44,6 +44,15 @@ properties:
> > >        - const: bus
> > >        - const: mod
> > >  
> > > +  jack-type:
> > 
> > I'm all for a generic property name, but it needs to be documented 
> > somewhere common. Perhaps dai-common.yaml.
> > 
> > I'm sure there is some prior art here to consider as well.
> 
> There's only a mention in the code. But there's no use of similar property
> on the codec nodes.
> 
> https://elixir.bootlin.com/linux/latest/source/sound/soc/soc-component.c#L288

git grep 'jack' Documentation/devicetree/bindings/sound

There's lots of things related to jack. I don't see type, but I didn't 
go looking for 'mic' or 'headphone' or 'headset' or ...

> 
> /**
>  * snd_soc_component_get_jack_type
>  * @component: COMPONENTs
>  *
>  * Returns the jack type of the component
>  * This can either be the supported type or one read from
>  * devicetree with the property: jack-type.
>  */
> 
> This is part of a component, so maybe in sound/component-common.yaml ?

A comment with no other usage I can find doesn't make it documented.

Rob

