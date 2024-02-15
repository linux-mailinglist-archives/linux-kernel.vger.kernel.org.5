Return-Path: <linux-kernel+bounces-66576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECC855E88
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049181F22547
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B8634FD;
	Thu, 15 Feb 2024 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QaEsskPh"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542256340F;
	Thu, 15 Feb 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990777; cv=none; b=qMUFWQaj+HUIKTdFl4p/aQS1R276LSK8JrUOORdoA+A7QY/ym1fw2SBdCJmFr35YM6JbSwOOBdQupoM2056EFprcy3xKowebM0p2LhqO0ZZ5u3Jt6wd+Axt5GEbRdqWsqdfdd4i4v9vtzL0KcTI6m6NnrTuCgX16eUDbqf0Hd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990777; c=relaxed/simple;
	bh=NpT4MujOWA1QAn/s06YLRsKfLQx4zRuyUaPcyLqGa/0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FgdVHbMGuUaF7AMlDGNWCjjccljNFM0FstI8Y1LjFjh/j+CWbqYBrLYD1J0AUJfrY1yA1l14w8YmvvC9ePS1K3wBsl5BFllyQjHZ+RClgHoOr12UqXpm4phbjSHCUhXk/Qzs5G2Xw1t+TbG/oeXMbYsAd8/UNT45HG/ddLt51gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QaEsskPh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF44C24000F;
	Thu, 15 Feb 2024 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707990766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0R7cedwXz8r4syjj8vVk7jrDrE/C0nhuEPgHT7CMLE=;
	b=QaEsskPhSgsZB/TB+dXWgSCBO9KxJbwVruQNhObt7j1OrUXjORU/qfqNIXzMAMj8AnnTlK
	9d5+4RthCg2tpHT3ZQnf+c1snCdi9Ed0gGNUTOhQkpGngf3JqzZsIquzsKiUUvDljL3mnL
	NHaTW1TCUBjkJW8r3X08dgVaH1WKrAvyBOqNIeqIAyEDZmZvoccQNkv34r+79VfaYtwCoX
	cg2V7he5PLcGWhYouj0A9lEMNCevjORUX/3k4lKgvy81bfqG69Hzv8fsr9dPdq7a7zn/Ea
	nmKOpCJZ3YzdQRCxEj8k5LIMPwBMN6U7dX1gFzW6Sfaln7YW6Ocu/bevQQsesQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Feb 2024 10:52:44 +0100
Message-Id: <CZ5K713P9WDB.FN0HZ3ANLTNC@bootlin.com>
Subject: Re: [PATCH 03/23] dt-bindings: gpio: nomadik: add
 mobileye,eyeq5-gpio compatible
Cc: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mips@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob
 Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-3-f88c0ccf372b@bootlin.com>
 <9e19c820-c9aa-4eef-a594-f7305b03eea4@linaro.org>
In-Reply-To: <9e19c820-c9aa-4eef-a594-f7305b03eea4@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 15, 2024 at 10:13 AM CET, Krzysztof Kozlowski wrote:
> On 14/02/2024 17:23, Th=C3=A9o Lebrun wrote:
> > This GPIO controller is used on the Mobileye EyeQ5 SoC. Add its
> > compatible to the dt-bindings. One difference is that the block as
> > integrated on EyeQ5 does not support sleep-mode.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../devicetree/bindings/gpio/st,nomadik-gpio.yaml        | 16 ++++++++=
+++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yam=
l b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
> > index bbd23daed229..e44cf292bc6d 100644
> > --- a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
> > @@ -19,7 +19,9 @@ properties:
> >      pattern: "^gpio@[0-9a-f]+$"
> > =20
> >    compatible:
> > -    const: st,nomadik-gpio
> > +    enum:
> > +      - st,nomadik-gpio
> > +      - mobileye,eyeq5-gpio
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -65,6 +67,18 @@ required:
> > =20
> >  unevaluatedProperties: false
> > =20
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: st,nomadik-gpio
> > +    then:
> > +      properties:
> > +        st,supports-sleepmode:
> > +          description: Whether the controller can sleep or not.
> > +          $ref: /schemas/types.yaml#/definitions/flag
>
> You already have such property, so you are defining it second time. You
> want instead if: for eyeq5-gpio making it:
> then:
>   properties:
>     st,supports-sleepmode: false

Good catch. I hesitated between declaring the property inside an
if-statement or disabling it inside an if-statement as you show here. I
ended-up mixing those two approaches.

Wil pick the if-eyeq5-then-disable-prop solution.

Thanks for the review Krzysztof!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

