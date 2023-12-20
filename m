Return-Path: <linux-kernel+bounces-6635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D09819B49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F778289DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19391DA27;
	Wed, 20 Dec 2023 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LLeXhgCM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6B1DA2F;
	Wed, 20 Dec 2023 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FB05C0007;
	Wed, 20 Dec 2023 09:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703064083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPNq32k7RUHJWtzhDpgh7IIKSJ8ogPbwfwNx+ef6OUg=;
	b=LLeXhgCMzxmdPigMGBwI7Ub9N0z7RdJcsDBUtr69LjNhfiS3LXYK5ETvaOg3UtVbFzgyVC
	g03zGiN5kdU1Anklqqp9yqJqIT3Nsae4ybpdbWrauHBR6HITc10cvL59p41BRd3wTbvXqR
	WXeE/kceft0lhW1dXFvrr1VqJ7ENxibmeBbvX3MRAKOJfdsGPw+6fmw9QncQF3c6BhYhcN
	2cmwmgSVXgG0yDEgdAHDK1GNNpYTTylaoJe93Zgk3sDapzAKW9C0US/LeM8evi9xxYyEaM
	oo6RV+sXibTZ5NsBsvoC8dsq2hEV62oruhpwlbGgp6F73rKNsqPKDmEVRUS9xA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Dec 2023 10:21:22 +0100
Message-Id: <CXT1TYH16JPB.2RY1IKI8NAUNE@bootlin.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add
 bindings
Cc: <linux-mips@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.15.2
References: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
 <20231218-mbly-pinctrl-v1-1-2f7d366c2051@bootlin.com>
 <0f0c0d16-f736-419e-9ffc-c3dc507b815c@linaro.org>
In-Reply-To: <0f0c0d16-f736-419e-9ffc-c3dc507b815c@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

I've seen all your comments, thanks for that. I'll answer to some.

On Tue Dec 19, 2023 at 8:34 AM CET, Krzysztof Kozlowski wrote:
> On 18/12/2023 18:19, Th=C3=A9o Lebrun wrote:
> > Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 125 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 126 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-p=
inctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinc=
trl.yaml
> > new file mode 100644
> > index 000000000000..5faddebe2413
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.=
yaml
> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mobileye EyeQ5 pinctrl (pinmux & pinconf) controller
>
> pinctrl means pin controller, so you basically wrote:
> pin controller pinmux and pin configuration controller
>
> Just "pin controller"
>
>
> > +
> > +description:
> > +  The EyeQ5 pin controller handles a pin bank. It is custom to this pl=
atform,
>
> Can part of SoC be not custom to given platform? I mean... describe the
> hardware, not write essay.
>
> > +  its registers live in a shared region called OLB.
> > +  There are two pin banks on the platform, each having a specific comp=
atible.
>
> Instead of repeating something obvious - visible from the binding -
> explain why. Say something different than the binding is saying.
>
>
> > +  Pins and groups are bijective.
> > +
> > +maintainers:
> > +  - Gr=C3=A9gory Clement <gregory.clement@bootlin.com>
> > +  - Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^pinctrl([0-9]+)?$"
> > +    description:
> > +      We have no unique address, we rely on OLB; we therefore can't ke=
ep the
> > +      standard pattern and cannot inherit from pinctrl.yaml.
>
> No, instead fix pinctrl.yaml

I've tried some things, but I'm unsure how to proceed. Options I see:

 - Modify pinctrl.yaml so that if reg/ranges is required, $nodename must
   be the current value ("^(pinctrl|pinmux)(@[0-9a-f]+)?$"). Else,
   $nodename should be "^(pinctrl|pinmux)(-[0-9a-f]+)?$".

   I've tried some things but nothing conclusive for the moment.

 - Leave pinctrl.yaml alone and override $nodename from our binding.
   I've not found a way to do that though.

 - Use the current $nodename, ie with a unit address. With that approach
   I get the "node has a unit name, but no reg or ranges property"
   warning which, reading the code, I don't see a way of avoiding.

Were you thinking about option 1? Any advice on how to proceed would be
helpful, I've not been able to get a working patch to use option 1.

>
> > +
> > +  compatible:
> > +    enum:
> > +      - mobileye,eyeq5-a-pinctrl
> > +      - mobileye,eyeq5-b-pinctrl
>
> Why two compatibles? Description provided no rationale for this.

I'll add that info. The gist of it is to have one node per bank. Each
pin has two function: GPIO or pin-dependent. So we must know which bank
we are to know what each pin function can be.

Both nodes are child to the same OLB. The compatible also tells us which
registers to use.

>
> > +
> > +  "#pinctrl-cells":
> > +    const: 1
> > +
> > +  mobileye,olb:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      A phandle to the OLB syscon. This is a fallback to using the par=
ent as
> > +      syscon node.
>
> So here is the explanation for missing unit address. If all registers,
> as you claim in description, belong to OLB, then this should be part of
> OLB. Drop the phandle.

The reason I provided both options was that I see four drivers that do
this kind of fallback. I guess it was for legacy reasons. I'm dropping
the phandle and keeping only the child option.

	drivers/gpio/gpio-syscon.c
	drivers/phy/rockchip/phy-rockchip-usb.c
	drivers/phy/samsung/phy-exynos-dp-video.c
	drivers/soc/rockchip/io-domain.c

>
> > +
> > +required:
> > +  - compatible
> > +  - "#pinctrl-cells"
>
> So now please test your code without olb phandle...

That is the main way I am running my code.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

