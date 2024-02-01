Return-Path: <linux-kernel+bounces-47985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8878455B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDEB2811AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1932315B97E;
	Thu,  1 Feb 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TeYaN4Zz"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3AE5684;
	Thu,  1 Feb 2024 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784342; cv=none; b=LcW3KTxRFsvE0Fl9RkPWoFXWSBSJ2f6nRPDEBSk20oe3J1eCdBtvssaPSk+uWoIwvMIc83XM7MMMtToICmZ6f5ksqfEbDNqhEFxuxubuQAg/OVfr2aUA6+lN87OEbhS7Dd7xy4otvMgCy1USmPk08CeHIFDtOkcmiwTX36B57lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784342; c=relaxed/simple;
	bh=y5p7YWxCixLSRC8L9+RtySskgo4VXq55VYvzVOHQv4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MsoK8BwkwEuxdXk9MfutXdjbBbat33peOHdTOFMlN/nX4af2xU4ghXtotc/A/AHo35DSMYQXSZuITx+86IyXr4AtnNjP7uV5TyKVtKlxIa/xndmo4XscqCIcz1tYrIP4nGCuN3FWiNDkSWiIpD/nhkmT83Sg5BGFJUxFMR0rSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TeYaN4Zz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CED0C0003;
	Thu,  1 Feb 2024 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706784337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mT1oLGRWsLYnRlkvBBGQg6iP7R72Zz+RmHUhiF//kno=;
	b=TeYaN4Zzv++6cefywcds2sJiBvMlGpIpwmNVn2e+XGroZq2dhIzPTCZ4gA0ksIQlhmw9AC
	SeWCItj6viug5VQWEHJWUn6f2q/OvTrky+O1KrzAFGIHG0biwm3Bmod68kKyFXxu54mlVe
	y1LsTPVUbSx+XUJ6+n/DIkM8F30T2zTJQyuRyGbq7F0ljNDNsvbFW1IqSAM3f0DymHiM0k
	5RO81KKE5ACZH54/l8GFUQ8t7vMD1PQGQ9lP4uFJGWcgER+uYKT0zKngEW75DnwVaz5hJY
	qVmDrF5fSnTw9ZSi/kqS8HCKwNpX1ElEf+yR8Qe1czAGWoY7DK8dfd25EbvlJQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 11:45:36 +0100
Message-Id: <CYTOJVMATYTW.2G1JB1CVPECYA@bootlin.com>
Subject: Re: [PATCH v4 07/18] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-7-bcd00510d6a0@bootlin.com>
 <ca618c6e-ef29-4ee5-860f-68b48ebbeb9e@linaro.org>
In-Reply-To: <ca618c6e-ef29-4ee5-860f-68b48ebbeb9e@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 1, 2024 at 10:36 AM CET, Krzysztof Kozlowski wrote:
> On 31/01/2024 17:26, Th=C3=A9o Lebrun wrote:
> > Add documentation to describe the "Other Logic Block" syscon.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 89 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 90 insertions(+)
> >=20
>
> ...
>
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +      #address-cells =3D <2>;
> > +      #size-cells =3D <2>;
> > +
> > +      system-controller@e00000 {
> > +        compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> > +        reg =3D <0x0 0xe00000 0x0 0x400>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x0 0x0 0xe00000 0x400>;
>
> If there is going to be any resend:
> 1. ranges follows reg
> 2. Use lower-case hex
>
> See DTS coding style.

I'm re-reading Documentation/devicetree/bindings/dts-coding-style.rst
right now. Thanks.

>
> > +
> > +        clocks: clock-controller@2c {
> > +          compatible =3D "mobileye,eyeq5-clk";
> > +          reg =3D <0x02C 0x50>, <0x11C 0x04>;
> > +          reg-names =3D "plls", "ospi";
> > +          #clock-cells =3D <1>;
> > +          clocks =3D <&xtal>;
> > +          clock-names =3D "ref";
> > +        };
> > +
> > +        reset: reset-controller@0 {
>
> 0 is before 2c, keep nodes properly ordered.

Indeed.

> > +          compatible =3D "mobileye,eyeq5-reset";
> > +          reg =3D <0x000 0x0C>, <0x200 0x34>, <0x120 0x04>;
> > +          reg-names =3D "d0", "d1", "d2";
> > +          #reset-cells =3D <2>;
> > +        };
> > +
> > +        pinctrl: pinctrl@b0 {
> > +          compatible =3D "mobileye,eyeq5-pinctrl";
> > +          reg =3D <0x0B0 0x30>;
>
> This looks incomplete. Your binding mentions children, so provide at
> least one child.

Will do. Didn't think about adding a child example to the dt-bindings
example.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

