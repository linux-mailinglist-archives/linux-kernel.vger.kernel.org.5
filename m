Return-Path: <linux-kernel+bounces-30944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832FF832676
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DCF1F23AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92B288CE;
	Fri, 19 Jan 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGUA64cr"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003325776;
	Fri, 19 Jan 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656083; cv=none; b=WAZ3jaZ9k1wwQKkiaxMzdh5IFdkLPUxwgaNykvNDhqjbafiRSMEvHMYRI1wXd9yIlIVy7HH2xOX2BKFGPlXa0BWYZuzz5QpOul7TXC3Wtz3icy3ZWVvURU+WnBeX7dk/du5X4zzSySq3/Ap0+RQDrrkuE7LhnsEhGCxoy+uG1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656083; c=relaxed/simple;
	bh=i2VqeG3gmGYPajLQMYJLxm8XaxAlr7ZJEGSi82iLtgY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNdz/Y5s0pbOwqVu0mk4CO0nXsEpuUdnbZsytojjyrzMCH0YicJKvUDutccv94mv7sI3SPT0Axo0hHHIYA7pziDELdaXEdLCGSlsJ1BjNEHr+5+a5iReEJOeaMLf0RAq73h4jGEX61S8jkcW0mDhzGwejikgf6uN4gxyN2o6now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGUA64cr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2dc7827a97so52103166b.2;
        Fri, 19 Jan 2024 01:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705656080; x=1706260880; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i2VqeG3gmGYPajLQMYJLxm8XaxAlr7ZJEGSi82iLtgY=;
        b=dGUA64cr6l4Kh6GhL7hLUK4CswxfVFNnY/OSECKJm3nUbGd5+BJPuI21qaYGJbGzDy
         vyX6zpsKsbLCoRnoziEr8UWAj/030jJ29aOqMcFyr6OwJgh4c9b+1za+cg1Qbdv1TkS5
         /y163RzHfmor+2IyiT8SsmLAMwBGp2u2kN8ZFBvU6CPUKlgrzboCcXNEiRnQFs8T2PYW
         hwpS0is3M+y/AHXaKDgvLykEErZjr3RwOc83bBoWUfU2a86HjE2BZSa0mz1vDyI1nahx
         qC6UayuYQMViVmDoM6DOSG37Ho7EZCnFSLHSGNFhyeqwdiFUnJ8GhdDZGyUgKY4yndzT
         d1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705656080; x=1706260880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2VqeG3gmGYPajLQMYJLxm8XaxAlr7ZJEGSi82iLtgY=;
        b=U0nXwNXWwvwHdepfUwFKVa4fK7rscAN20rk+b9ATOpj5q+6YHdl78eqcnuCOvBtM6l
         8gZNsZi16eUiNv4NX+U+eS0oDw8ZiGYs7M8nIetexk8FZyf32mG3QZpSASrwd2D64mBj
         24wQrIrp+4iFkX84SSQ/6+wtJU0LCrEt7nwgYuY+BE2V6eAIXE2DHNwwx2847GqNKbI9
         xxn4urHEX4xyWg232qXtlv5prLeVzoI8hpPWCdN7I1XolE0qN1aA5US6BknI6JBtjDsN
         /3B9XPVBEHSXTm/XDSk7orVEuGsa/vtaWm8oTUN1SiPotBQY1xbGpxkcakXyelcjKKKG
         3/7Q==
X-Gm-Message-State: AOJu0YxJqGQUp2ArhthkZA+olncMH7TkKkJyCeVzljy1/DVL3wDsS6IW
	bmuYs9SloTW366keZM+9Ib6rkraJPAlV81CnImN8RBmm4E9+LqpT
X-Google-Smtp-Source: AGHT+IGD0HoXy5/ZvGbgpAcyjjdTFcSV557VS8QaspzayXqlKgR/s1NSdEXXuDWYmxRrGn6QopugYA==
X-Received: by 2002:a17:907:cca1:b0:a26:6e89:d94c with SMTP id up33-20020a170907cca100b00a266e89d94cmr1044663ejc.152.1705656079828;
        Fri, 19 Jan 2024 01:21:19 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id tk4-20020a170907c28400b00a2ce236ed71sm8627050ejc.43.2024.01.19.01.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 01:21:19 -0800 (PST)
Message-ID: <dd3051170bc9724ca7e2884344dee3bc7b8f0a85.camel@gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: "Paller, Kim Seer" <KimSeer.Paller@analog.com>, Conor Dooley
 <conor@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>, Linus Walleij
 <linus.walleij@linaro.org>,  Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 19 Jan 2024 10:21:18 +0100
In-Reply-To: <20240119-squad-unflawed-934627f0e394@wendy>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
	 <20240118085856.70758-2-kimseer.paller@analog.com>
	 <20240118-steadily-coauthor-de8275118901@spud>
	 <PH0PR03MB71410860593D3C7253B200FCF9702@PH0PR03MB7141.namprd03.prod.outlook.com>
	 <0f32caa9a11305333f1f18b97c97d775f4a5bb9a.camel@gmail.com>
	 <20240119-squad-unflawed-934627f0e394@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-19 at 08:31 +0000, Conor Dooley wrote:
> On Fri, Jan 19, 2024 at 09:20:01AM +0100, Nuno S=C3=A1 wrote:
> > Hi Kim,
> >=20
> > On Fri, 2024-01-19 at 00:30 +0000, Paller, Kim Seer wrote:
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> > > > Sent: Friday, January 19, 2024 12:10 AM
> > > > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > > > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Lars-P=
eter
> > > > Clausen <lars@metafoo.de>; Hennerich, Michael
> > > > <Michael.Hennerich@analog.com>; Rob Herring <robh+dt@kernel.org>;
> > > > Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dool=
ey
> > > > <conor+dt@kernel.org>; Crt Mori <cmo@melexis.com>; Linus Walleij
> > > > <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>
> > > > Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2=
000
> > > >=20
> > > > [External]
> > > >=20
> > > > Hey,
> > > >=20
> > > > On Thu, Jan 18, 2024 at 04:58:55PM +0800, Kim Seer Paller wrote:
> > > > > Dual microwave down converter module with input RF and LO frequen=
cy
> > > > > ranges from 0.5 to 32 GHz and an output IF frequency range from 0=
1 to
> > > > > 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplif=
ier
> > > > > for each down conversion path.
> > > > >=20
> > > > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > > > ---
> > > > > V5 -> V6: Moved array of switch and attenuation GPIOs to the chan=
nel node.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Changed pi=
n coords with friendly names. Removed Reviewed-by tag.
> > > > > V4 -> V5: Added Reviewed-by tag.
> > > > > V3 -> V4: Updated the description of the properties with multiple=
 entries
> > > > > and
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defined th=
e order.
> > > > > V2 -> V3: Adjusted indentation to resolve wrong indentation warni=
ng.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Changed no=
de name to converter. Updated the descriptions to
> > > > > clarify
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the proper=
ties.
> > > > > V1 -> V2: Removed '|' after description. Specified the pins conne=
cted to
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the GPIOs.=
 Added additionalProperties: false. Changed node name
> > > > > to
> > > > gpio.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Aligned < =
syntax with the previous syntax in the examples.
> > > > >=20
> > > > > =C2=A0.../bindings/iio/frequency/adi,admfm2000.yaml | 129 +++++++=
+++++++++++
> > > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 7 +
> > > > > =C2=A02 files changed, 136 insertions(+)
> > > > > =C2=A0create mode 100644
> > > > Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > > > >=20
> > > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yam=
l
> > > > b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yam=
l
> > > > > new file mode 100644
> > > > > index 000000000000..6f2c91c38666
> > > > > --- /dev/null
> > > > > +++
> > > > b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yam=
l
> > > > > @@ -0,0 +1,129 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +# Copyright 2023 Analog Devices Inc.
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.y=
aml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: ADMFM2000 Dual Microwave Down Converter
> > > > > +
> > > > > +maintainers:
> > > > > +=C2=A0 - Kim Seer Paller <kimseer.paller@analog.com>
> > > > > +
> > > > > +description:
> > > > > +=C2=A0 Dual microwave down converter module with input RF and LO=
 frequency
> > > > ranges
> > > > > +=C2=A0 from 0.5 to 32 GHz and an output IF frequency range from =
0.1 to 8 GHz.
> > > > > +=C2=A0 It consists of a LNA, mixer, IF filter, DSA, and IF ampli=
fier for each
> > > > > down
> > > > > +=C2=A0 conversion path.
> > > > > +
> > > > > +properties:
> > > > > +=C2=A0 compatible:
> > > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,admfm2000
> > > > > +
> > > > > +=C2=A0 '#address-cells':
> > > > > +=C2=A0=C2=A0=C2=A0 const: 1
> > > > > +
> > > > > +=C2=A0 '#size-cells':
> > > > > +=C2=A0=C2=A0=C2=A0 const: 0
> > > > > +
> > > > > +patternProperties:
> > > > > +=C2=A0 "^channel@[0-1]$":
> > > > > +=C2=A0=C2=A0=C2=A0 type: object
> > > > > +=C2=A0=C2=A0=C2=A0 description: Represents a channel of the devi=
ce.
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0 additionalProperties: false
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0 properties:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The chann=
el number.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minimum: 0
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 1
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,mode:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RF path s=
elected for the channel.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0 - Direct IF mode
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1 - Mixer mode
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.=
yaml#/definitions/uint32
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1]
> > > >=20
> > > > How come this is an enum, rather than a boolean property such as
> > > > "adi,mixer-mode"?
> > >=20
> > > I used an enum, perhaps because it was easier to implement. However, =
this
> > > could be changed if a boolean property might be more suitable in this=
 case.
> > > Is that the preferred option?
> > >=20
> >=20
> > Hmmm, How is the enum easier than a boolean property :)? I guess the de=
vice has a
> > default mode. So, if it is Direct IF mode you have 'adi,mixer-mode' to =
enable
> > that
> > mode and that's it. So the code is pretty much just:
> >=20
> > if (device_property_read_bool()) {
>=20
> device_property_present() is preferred I think.
>=20

Hmm, don't want to start an argument but I'm not sure either :). I would ar=
gue that
device_property_read_bool() has more users (according to git grep - and if =
I did not
mess the grep) and it pretty much wraps device_property_present(). So, if t=
here was
no value in it's "meaning" we would/should stop using it and eventually dro=
p it...
Anyways, not really a big deal.

- Nuno S=C3=A1
> >=20


