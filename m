Return-Path: <linux-kernel+bounces-48616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4C845EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C1B1C2650B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA307C6ED;
	Thu,  1 Feb 2024 17:49:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D67C6FC;
	Thu,  1 Feb 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809740; cv=none; b=OsbMYMOdlv+Yz75OzfJlZP5RhS8BDW4owja9GCEPatXo0p//o+cs4803shqZBSk7B8nQtSU4ytUUI+kvb07u9xFroMhHycxJKALE0CZUkBv6QRFNZ5gxddNqb34oGn61wEWfVGieCDzbNoWChFeLni2v99G2Pgn1rUd2gS4Qw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809740; c=relaxed/simple;
	bh=4ypK0ycF6rpwPAsSpCWw19pKyyPCXDhJ+L3/dezzUbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFzT3Xw/DzKPW5EOSxDXJlAUXZY7km/IfMFrvtLIAEigACGlxEbn12yheD0oIixChS4iN1BQrpvItGD8lQh+R0uk/jZZRgvjF16XqogTwFw9X/8NgPfsxe5SzIpKQ6wtDOvbzfeufrB/XGNHDSG8XummLctXrdqrJ8nhOk9dfKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F246DA7;
	Thu,  1 Feb 2024 09:49:40 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66D4F3F738;
	Thu,  1 Feb 2024 09:48:54 -0800 (PST)
Date: Thu, 1 Feb 2024 17:48:51 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Conor Dooley <conor@kernel.org>
Cc: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@pengutronix.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, John Watts
 <contact@jookia.org>, Cheo Fusi <fusibrandon13@gmail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20240201174851.62e74089@donnerap.manchester.arm.com>
In-Reply-To: <20240131-renewably-glimpse-a80339e8ff81@spud>
References: <20240131125920.2879433-1-privatesub2@gmail.com>
 <20240131125920.2879433-2-privatesub2@gmail.com>
 <20240131145244.4f534bac@donnerap.manchester.arm.com>
 <20240131-renewably-glimpse-a80339e8ff81@spud>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 21:22:06 +0000
Conor Dooley <conor@kernel.org> wrote:

Hi,

> On Wed, Jan 31, 2024 at 02:52:44PM +0000, Andre Przywara wrote:
> > On Wed, 31 Jan 2024 15:59:14 +0300
> > Aleksandr Shubin <privatesub2@gmail.com> wrote:
> > 
> > Hi,
> >   
> > > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > > controller witch is different from the previous pwm-sun4i.
> > > 
> > > The D1 and T113 are identical in terms of peripherals,
> > > they differ only in the architecture of the CPU core, and
> > > even share the majority of their DT. Because of that,
> > > using the same compatible makes sense.
> > > The R329 is a different SoC though, and should have
> > > a different compatible string added, especially as there
> > > is a difference in the number of channels.
> > > 
> > > D1 and T113s SoCs have one PWM controller with 8 channels.
> > > R329 SoC has two PWM controllers in both power domains, one of
> > > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> > > 
> > > Add a device tree binding for them.
> > > 
> > > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 88 +++++++++++++++++++
> > >  1 file changed, 88 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > > new file mode 100644
> > > index 000000000000..716f75776006
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > > @@ -0,0 +1,88 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Allwinner D1, T113-S3 and R329 PWM
> > > +
> > > +maintainers:
> > > +  - Aleksandr Shubin <privatesub2@gmail.com>
> > > +  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: allwinner,sun20i-d1-pwm
> > > +      - items:
> > > +          - const: allwinner,sun20i-r329-pwm
> > > +          - const: allwinner,sun20i-d1-pwm
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#pwm-cells":
> > > +    const: 3
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Bus clock
> > > +      - description: 24 MHz oscillator
> > > +      - description: APB0 clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: bus
> > > +      - const: hosc
> > > +      - const: apb0
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  allwinner,pwm-channels:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: The number of PWM channels configured for this instance
> > > +    enum: [6, 9]
> > > +
> > > +allOf:
> > > +  - $ref: pwm.yaml#
> > > +
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: allwinner,sun20i-r329-pwm
> > > +
> > > +    then:
> > > +      required:
> > > +        - allwinner,pwm-channels
> > > +
> > > +    else:
> > > +      properties:
> > > +        allwinner,pwm-channels: false  
> > 
> > Do we really need to be that strict?
> > If something compatible to D1 pops up in the future, just with a different
> > number of channels, we would need a new compatible string.  
> 
> Well, you would want to have a soc specific compatible anyway then,
> right?

So the idea would be to add any new (specific) compatible string to that
list then, when we add them?
I guess this would work, but strictly speaking any current driver would
then only need to check this property for the R329 type? The Linux
driver proposed in the next patch *always* honours the
allwinner,pwm-channels property, which is IMHO the right way to implement
this. And that's why I think the binding should reflect that, and not
explicitly *forbid* the property for every one other than R329 (atm).

With the current Linux driver, a potential new SoC using:
	"allwinner,sun20i-d2-pwm", "allwinner,sun20i-d1-pwm";
	allwinner,pwm-channels = <6>;
would work without driver changes. A driver strictly written to this
binding here might not, though, as it would be free to ignore the
pwm-channels property.

Does that make sense? So to encourage future compatibility, can we drop
the "else" branch?

> > If we would leave this else branch out, we could just specify some
> > number differing from the default, and be good.  
> 
> If it were compatible with the d1, then the "then:" branch would apply,
> provided you used the fallback correctly.
>
> Although if the number of
> channels were different, we'd likely end up with modifications here to
> limit it to the correct values for each soc.

That's fine, because this just affects the bindings (and the DT), but
doesn't require any driver changes, which take months to trickle into
distributions, not to speak of LTS distros. A DT can be updated
independently.

Cheers,
Andre.

> > The number of channels really looks like a parameter to the IP, it's
> > modelled like this in the manual (PCR: 0x0100 + 0x0000 + N * 0x0020).  


