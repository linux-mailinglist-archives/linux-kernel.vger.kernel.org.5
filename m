Return-Path: <linux-kernel+bounces-45272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA46842DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBEC1C2269E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22655E57;
	Tue, 30 Jan 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR4vSkzh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE671401B;
	Tue, 30 Jan 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646857; cv=none; b=NYN2tTaKUAbyRUiekS4xj7ioHsKiPDgnccz3oEQ3l5X2mgBOvy1uuguKOPzNE3KHQPei88OBD81HnGKvA9DHv6MvUxRRqy81mQLfc+BrupEctu909fL1Mv9INYbniNNDxl3IThIQHKIDNjKe6B7cH2otbJCeRS9/wnisE+1XZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646857; c=relaxed/simple;
	bh=/t3GFmRm5hVeR5xzoWsZKKi65PGNECWaoN8DFhDtjuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJa5iPXfMJSlnfwFfVeQWLewxmBccGE9JNk5orBxZ12saVwG8hOqo5O1JFUQyhtytMXyLa7shRmnJdHwVWyetdyruIEl1D5SY7lhbh/OQBhm07v7qBt4ZkFurZkmjNsl9fb3mfGrd+SMmRYLLj+kSqBC8SDQEmCIG7PNXjbR1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR4vSkzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEB0C433F1;
	Tue, 30 Jan 2024 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706646856;
	bh=/t3GFmRm5hVeR5xzoWsZKKi65PGNECWaoN8DFhDtjuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KR4vSkzhXVYDoJgMgUekpqQCkB0fnG56TeJoVnaeQrHDhNs0viEsSZp1NgkHvj6hy
	 K+/DGxoG65pCGKy7cnZIha/D50KPC8xbtVQ6sIokl/3dE28rYz2dK+aWQd37rppXqq
	 SzgWt77k7MdIHZ7h7aDp7XpwOf2bJT9oPn2IPkX5bH5XJNcfotHgGVmpofnhDmODiX
	 xaxrL3RDXJEZHTc3bLIVQQgMqUOnxrHgzh7Aq17lpk4Q+VlaUmDEFj0H2jpJDOO84G
	 a499XEVFN6mwFjKRSIepGcMTFMMZZcuJ34w89OqoWwhIDRlA3vX5ph1YreFdnVsiJp
	 wFvB0O34NMVTw==
Date: Tue, 30 Jan 2024 14:34:13 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: convert PCIESYS to the
 json-schema
Message-ID: <20240130203413.GA2290196-robh@kernel.org>
References: <20240123082100.7334-1-zajec5@gmail.com>
 <20240123082100.7334-3-zajec5@gmail.com>
 <e17b85b1-7f1f-4b60-89b7-43f560466cc2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e17b85b1-7f1f-4b60-89b7-43f560466cc2@collabora.com>

On Tue, Jan 23, 2024 at 12:20:29PM +0100, AngeloGioacchino Del Regno wrote:
> Il 23/01/24 09:20, Rafał Miłecki ha scritto:
> > From: Rafał Miłecki <rafal@milecki.pl>
> > 
> > This helps validating DTS files. Introduced changes:
> > 1. Documented "reg" property
> > 2. Adjusted "reg" in example
> > 
> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > ---
> >   .../arm/mediatek/mediatek,mt7622-pciesys.yaml | 47 +++++++++++++++++++
> >   .../arm/mediatek/mediatek,pciesys.txt         | 25 ----------
> >   2 files changed, 47 insertions(+), 25 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
> >   delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
> > new file mode 100644
> > index 000000000000..7340a2512402
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
> 
> I think that we should really move all those clock controller yaml files to their
> proper directory, which would be
> 
> Documentation/devicetree/bindings/clock/
> 
> ...because those are clock controllers anyway and the fact that they do also
> provide a reset controller doesn't really justify having them in arm/mediatek.
> 
> Besides, I would appreciate if you could also move mt8186/92/95 and eventual
> others that are there to clock/.

Yes, please move it.

> 
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt7622-pciesys.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek PCIESYS controller
> > +
> > +description:
> > +  The MediaTek PCIESYS controller provides various clocks to the system.
> > +
> > +maintainers:
> > +  - Matthias Brugger <matthias.bgg@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mediatek,mt7622-pciesys
> > +          - mediatek,mt7629-pciesys
> > +      - const: syscon
> 
> I know that there's syscon all over the place and, even if I admit I didn't check,
> I am fairly sure that there's absolutely no reason to have syscon there, and that
> the syscon compatible never did anything for (most of, or all of) those clock
> controllers, at all.
> 
> I'm not sure - though - if removing syscon during the txt->yaml conversion is
> acceptable (yeah we'd be cheating a bit), but something makes me say it is, because
> the bindings couldn't validate before that one as well.

As long as you state why you are removing it in the commit msg.

> 
> Of course you'd have to remove the syscon compatible from the affected device trees
> as well as omitting it here.

You could also do 'minItems: 1' and 'deprecated' in the 2nd item.

> However, to be sure that we're doing the right thing here, I have to summon someone
> that can actually give a definitive answer to what I just said.....
> 
> Krzysztof, please? :-)

