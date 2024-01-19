Return-Path: <linux-kernel+bounces-30892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D0683259D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A381F2173F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2D208DF;
	Fri, 19 Jan 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEMVNWWc"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B61F5E6;
	Fri, 19 Jan 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652406; cv=none; b=IYJS8Lo4GEIIr8X63kHtGiV1+Zl3bSX6PRTSHAYRPV1kCl+sB6wUH5G3RDVSoWDCdkLygMnz9eInsMB+4gYBILeT8AxCUfJgm0sJ2euKHsTTcOQHehetbm90vKPVFjeZcDY7VNqZiSGNCRqh0eJmKD7GdFMptl06q2Bez8h8lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652406; c=relaxed/simple;
	bh=hFt0zTpCZQ0fcZH0knVkNJSLARQZkEOuOozfO1PQzvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8tVGf7VF3V8l1RXd5bRwsDgRdKvJerZ51Kuq3K9EaHXqB21u8TMSR8xg2XYu2UAJHRFE79y4sJevLNafzoYJhC4b/s18ceNh6xLQ0836Q7nbGIbObfg0Eg5HzEjY9aHGs4tytdKs7Vwg61mRqiIzE9FGI2yhfOqyq/12kRAQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEMVNWWc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a293f2280c7so50580066b.1;
        Fri, 19 Jan 2024 00:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705652403; x=1706257203; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lsR+tvff2CxAiZo34B7B8Rp+iXMZjWM108KbbjhVJjU=;
        b=iEMVNWWc5MMRGokrIDeFaTnIVyY+mfgvrE/Ln/BVoYrMdw/e/vV1k/V9fyIGj1btHJ
         kXWcgbVZLry1owsMlehN33XBJ9aHIwqib4xg8c685PGWlbgfTeTOrNWqQSERAPFv1PKo
         an1B4MRmuQ4ie4T3YFvI0VUcPJjvVVdc+jCD9a5qcCpQ8PF/gOsDQQtE6NbQ4F6OUuBI
         zP3U+qx1JjT9QLRhvAwA2xk98oiVsFLTX7obmlOyNK0MPD8BfkZrir8psJs1oit7RdVE
         8AIf+U/vdtCltwpUiPIm+EodQqINknyqAKfLEc+rwEA53v9wukPb7WNhl77ZnR9AzgU/
         OqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652403; x=1706257203;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsR+tvff2CxAiZo34B7B8Rp+iXMZjWM108KbbjhVJjU=;
        b=anrE4Q3suReInIvThDJxGf+6UCSIGs0hqMeO8NgR1NbCUFypjdOb2UBAnwv3B8fBR0
         BzbFsnVKngDhXrKtR2X6+AbKkNvbO0wH0Gpg9UIm84ZjCYze89ScRVCQkaRvR99TR2zw
         k0mFyn2svfgGANDMuQH0siTlR6pzdzD91qcriEppsGRNpfL1B0MxprZC5EkwJZG4fQip
         Dr/+RxUQ77UuzPmNRvN93gLoK5L7pNHsim6LSmX6eZLPCRILShtfQicZnLxOr8XXgTv8
         L/RlIl4Npt+LrVZHzaEIWDCiBQA3XmlIm9SJrgiv2p+5tKjMwTB2k4aGnDwnxalfbINL
         P2hg==
X-Gm-Message-State: AOJu0YymQe+tnr0bqEBk5pwlXtBXpY6+OhuiBP6vfUyjdGSOdUqHH93k
	Wo23iE3Si3iaY+V+Vp4HvzyoeBrxQ1KOll7P0f1uqQyZJxSfYKZw
X-Google-Smtp-Source: AGHT+IFUQIABA97/qbaltUDYCF8bxq90AhedbqLqcAOZYYjG89W9tASZQCsvcezLrSwzM1fVauZ0gA==
X-Received: by 2002:a17:907:d386:b0:a2f:76b8:6956 with SMTP id vh6-20020a170907d38600b00a2f76b86956mr120109ejc.25.1705652402674;
        Fri, 19 Jan 2024 00:20:02 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id wb3-20020a170907d50300b00a2cc6398083sm8981998ejc.10.2024.01.19.00.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:20:02 -0800 (PST)
Message-ID: <0f32caa9a11305333f1f18b97c97d775f4a5bb9a.camel@gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>, Conor Dooley
	 <conor@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan
 Cameron <jic23@kernel.org>,  Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Crt Mori <cmo@melexis.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 19 Jan 2024 09:20:01 +0100
In-Reply-To: <PH0PR03MB71410860593D3C7253B200FCF9702@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
	 <20240118085856.70758-2-kimseer.paller@analog.com>
	 <20240118-steadily-coauthor-de8275118901@spud>
	 <PH0PR03MB71410860593D3C7253B200FCF9702@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kim,

On Fri, 2024-01-19 at 00:30 +0000, Paller, Kim Seer wrote:
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Friday, January 19, 2024 12:10 AM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Lars-Peter
> > Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Rob Herring <robh+dt@kernel.org>;
> > Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Crt Mori <cmo@melexis.com>; Linus Walleij
> > <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>
> > Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
> >=20
> > [External]
> >=20
> > Hey,
> >=20
> > On Thu, Jan 18, 2024 at 04:58:55PM +0800, Kim Seer Paller wrote:
> > > Dual microwave down converter module with input RF and LO frequency
> > > ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 t=
o
> > > 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> > > for each down conversion path.
> > >=20
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > ---
> > > V5 -> V6: Moved array of switch and attenuation GPIOs to the channel =
node.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Changed pin co=
ords with friendly names. Removed Reviewed-by tag.
> > > V4 -> V5: Added Reviewed-by tag.
> > > V3 -> V4: Updated the description of the properties with multiple ent=
ries and
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defined the or=
der.
> > > V2 -> V3: Adjusted indentation to resolve wrong indentation warning.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Changed node n=
ame to converter. Updated the descriptions to clarify
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the properties=
.
> > > V1 -> V2: Removed '|' after description. Specified the pins connected=
 to
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the GPIOs. Add=
ed additionalProperties: false. Changed node name to
> > gpio.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Aligned < synt=
ax with the previous syntax in the examples.
> > >=20
> > > =C2=A0.../bindings/iio/frequency/adi,admfm2000.yaml | 129 +++++++++++=
+++++++
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 7 +
> > > =C2=A02 files changed, 136 insertions(+)
> > > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > >=20
> > > diff --git
> > a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > > new file mode 100644
> > > index 000000000000..6f2c91c38666
> > > --- /dev/null
> > > +++
> > b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > > @@ -0,0 +1,129 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2023 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ADMFM2000 Dual Microwave Down Converter
> > > +
> > > +maintainers:
> > > +=C2=A0 - Kim Seer Paller <kimseer.paller@analog.com>
> > > +
> > > +description:
> > > +=C2=A0 Dual microwave down converter module with input RF and LO fre=
quency
> > ranges
> > > +=C2=A0 from 0.5 to 32 GHz and an output IF frequency range from 0.1 =
to 8 GHz.
> > > +=C2=A0 It consists of a LNA, mixer, IF filter, DSA, and IF amplifier=
 for each down
> > > +=C2=A0 conversion path.
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 enum:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,admfm2000
> > > +
> > > +=C2=A0 '#address-cells':
> > > +=C2=A0=C2=A0=C2=A0 const: 1
> > > +
> > > +=C2=A0 '#size-cells':
> > > +=C2=A0=C2=A0=C2=A0 const: 0
> > > +
> > > +patternProperties:
> > > +=C2=A0 "^channel@[0-1]$":
> > > +=C2=A0=C2=A0=C2=A0 type: object
> > > +=C2=A0=C2=A0=C2=A0 description: Represents a channel of the device.
> > > +
> > > +=C2=A0=C2=A0=C2=A0 additionalProperties: false
> > > +
> > > +=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The channel n=
umber.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minimum: 0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 1
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,mode:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RF path selec=
ted for the channel.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
 - Direct IF mode
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
 - Mixer mode
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml=
#/definitions/uint32
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1]
> >=20
> > How come this is an enum, rather than a boolean property such as
> > "adi,mixer-mode"?
>=20
> I used an enum, perhaps because it was easier to implement. However, this
> could be changed if a boolean property might be more suitable in this cas=
e.
> Is that the preferred option?
>=20

Hmmm, How is the enum easier than a boolean property :)? I guess the device=
 has a
default mode. So, if it is Direct IF mode you have 'adi,mixer-mode' to enab=
le that
mode and that's it. So the code is pretty much just:

if (device_property_read_bool()) {
	/* enable mixer mode */
}

Also remember that from a bindings point of view being easier to implement =
or not in
the driver does not matter much. Take for an example, properties with well =
know units
like 'microamp'. It would be much easier to just have an enum with the devi=
ce
register values but that's not how we should do it since it wouldn't be int=
uitive at
all for people reading devicetrees.

- Nuno S=C3=A1


