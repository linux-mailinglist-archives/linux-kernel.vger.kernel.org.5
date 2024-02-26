Return-Path: <linux-kernel+bounces-81671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74C98678E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879872976FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D256134CE7;
	Mon, 26 Feb 2024 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iKTqD1KN"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C6134727;
	Mon, 26 Feb 2024 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958166; cv=none; b=LGCeAEUgHGHdLfxO8zk7fCqey//n4DP7OM9VOQqo3lrtiIpL6ajrSHUUbFdklB9PH8zl3x6Gki6fQbJ/E8UrlfBaGlpHJ6TUWLz6QG84vxAH4lsBO03+Cz6jsqzZ2qoRwrakNiWiH49vHmmlkXiwSA8qcytL/C2n5l2kIWH7aGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958166; c=relaxed/simple;
	bh=9ywEGY5Eo3x6FAI3cUqz0fj17fVyroyFNHMiCN6mL/0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=AL3yII8vq0mTujTbnvC0jhlf86YzXSYe9nmhJB7H7mLfiJ7XD14Q1XRx1qqy8vRZJG5wwdBX1UDQLpuFfQU2U71yd1IYvSHpCflQ9XyIJCTs/NY+57Nat6XgensQqeNUTvtCz2xRt6C6Gbosb5QGuzay2XDJ4gohBXKMzgibQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iKTqD1KN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 751121BF209;
	Mon, 26 Feb 2024 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708958161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzRRKGTCf49DCuAE0sJucov1JPKZw/oB6zFjk/bAKO0=;
	b=iKTqD1KNUEKWwhSN9AhG2JhtpDWL87tAJ9I4T86LLIn0QkDMqI+Oq/4+t5fhJHfsecTixf
	s+/UCitLkC/j7Yzf2luIY9kN/WVrqMOEEhpie7a1JCoV8PxKfF7ZsBq1MSbynBrgmJ/0G8
	ZxSoSjSk+MX665A3cbZFKu1gKOPna55GAkVF91br9adMhh4PNkUAXQV2JhQDci4qKmmejm
	JL2SGM4FZHA5FflxtIvKquzoswqNZ3772Bw7PYJFrEI13XKigy9mEFjpYofCBWCbm8cCGy
	ekDso4pH4pexQ/dQvsW+ccS6C8ALdQM9DHAkXv9hA7YZiY3GXIkRlLIWyj4lqg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 15:35:59 +0100
Message-Id: <CZF33W51MC4M.3GUBZFQXT39DB@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: usb: ti,j721e-usb: drop useless
 compatible list
Cc: "Conor Dooley" <conor@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Roger Quadros" <rogerq@kernel.org>, "Peter Chen"
 <peter.chen@kernel.org>, "Pawel Laszczak" <pawell@cadence.com>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Kevin
 Hilman" <khilman@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>,
 <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
To: "Conor Dooley" <conor.dooley@microchip.com>
X-Mailer: aerc 0.15.2
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com>
 <20240223-clarity-variably-206b01b7276a@spud>
 <CZEXXXQDZZWB.1M5CTZAFVO4YP@bootlin.com>
 <20240226-portable-rockslide-e501667a0d9a@wendy>
In-Reply-To: <20240226-portable-rockslide-e501667a0d9a@wendy>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Feb 26, 2024 at 12:56 PM CET, Conor Dooley wrote:
> On Mon, Feb 26, 2024 at 11:33:06AM +0100, Th=C3=A9o Lebrun wrote:
> > Hello Conor,
> >=20
> > On Fri Feb 23, 2024 at 7:12 PM CET, Conor Dooley wrote:
> > > On Fri, Feb 23, 2024 at 05:05:25PM +0100, Th=C3=A9o Lebrun wrote:
> > > > Compatible can be A or B, not A or B or A+B. Remove last option.
> > > > A=3Dti,j721e-usb and B=3Dti,am64-usb.
> > > >=20
> > > > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 9 +++---=
---
> > > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yam=
l b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > > > index 95ff9791baea..949f45eb45c2 100644
> > > > --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > > > @@ -11,12 +11,9 @@ maintainers:
> > > > =20
> > > >  properties:
> > > >    compatible:
> > > > -    oneOf:
> > > > -      - const: ti,j721e-usb
> > > > -      - const: ti,am64-usb
> > > > -      - items:
> > > > -          - const: ti,j721e-usb
> > > > -          - const: ti,am64-usb
> > >
> > > Correct, this makes no sense. The devices seem to be compatible thoug=
h,
> > > so I would expect this to actually be:
> > > oneOf:
> > >   - const: ti,j721e-usb
> > >   - items:
> > >       - const: ti,am64-usb
> > >       - const: ti,j721e-usb
> >=20
> > I need your help to grasp what that change is supposed to express? Woul=
d
> > you mind turning it into english sentences?
> > A=3Dti,j721e-usb and B=3Dti,am64-usb. My understanding of your proposal=
 is
> > that a device can either be compat with A or B. But B is compatible
> > with A so you express it as a list of items. If B is compat with A then
> > A is compat with B. Does the order of items matter?
>
> The two devices are compatible with each other, based on an inspection of
> the driver and the existing "A+B" setup. If this was a newly submitted
> binding, "B" would not get approved because "A+B" allows support without
> software changes and all that jazz.
>
> Your patch says that allowing "A", "B" and "A+B" makes no sense and you
> suggest removing "A+B". I am agreeing that it makes no sense to allow
> all 3 of these situations.
>
> What I also noticed is other problems with the binding. What should have
> been "A+B" is actually documented as "B+A", but that doesn't make sense
> when the originally supported device is "A".
>
> Therefore my suggestion was to only allow "A" and "A+B", which is what
> we would (hopefully) tell you to do were you submitting the am64 support
> as a new patch today.

Thank you for the in-depth explanation! It makes much more sense now,
especially the handling of historic stuff that ideally wouldn't have
been done this way but that won't be changed from now on.

> > I've not applied your proposal to check for dtbs_check but I'd guess it
> > would throw warnings for the single existing upstream DTSI (as of
> > v6.8-rc6) that uses "ti,am64-usb"? See:
> > arch/arm64/boot/dts/ti/k3-am64-main.dtsi.
>
> Yeah, it would but it's not as if that cannot be changed. There's no
> concerns here about backwards compatibility here, right?

I'm not involved in the maintenance of this platform so I do not believe
I should be answering this question. I asked the question because I
taught there always were concerns of backwards-compat when it comes to
DT and dt-bindings (in the best of all possible worlds).

K3 maintainers are already in cc.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


