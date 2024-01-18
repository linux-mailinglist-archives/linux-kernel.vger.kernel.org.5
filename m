Return-Path: <linux-kernel+bounces-29946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AE78315A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC2A1C229C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265701E885;
	Thu, 18 Jan 2024 09:21:17 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB41BC33;
	Thu, 18 Jan 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569676; cv=none; b=Z2/ZaKK9MAB2w+C9b5/X+fDh0HuuKlwYuKFJ4BvfDLOBR3RkNIuhVxzgq52ygub2KO0jdX4f4cYEHzMJl1/mDag9HvFct+Ll0t8KBusEC2xB7tGok5rcME1ltsqqTZGpsJ6gEBQgYWozcRFsw00To4qkSLbEPH7uEmdDjWHL8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569676; c=relaxed/simple;
	bh=kNuDy3QbrcPdmFFi0m7j/Zge1439ZBqnmZlKGQqeyHE=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=AdFypVv1JhMl9JHi/GyNyfKNnZOWt7WWojKylPomoGXe1YpyYdeCBZahRWr7bCsapWs0i5f15p1qbcKUZau5e65Yq//7CawqYv55rE7Jr1X2PYHF0A6zjjjlQ2bhShP75oZtsvyGfClTYymo4mth+Mu5o8jBSABKgcsMTUnziOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TFxy82Wlbz687NT;
	Thu, 18 Jan 2024 17:18:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F25DA1400CD;
	Thu, 18 Jan 2024 17:21:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Jan
 2024 09:21:10 +0000
Date: Thu, 18 Jan 2024 09:21:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
CC: David Lechner <dlechner@baylibre.com>, <linus.walleij@linaro.org>,
	<brgl@bgdev.pl>, <andy@kernel.org>, <linux-gpio@vger.kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
	<chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
	<mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/2] dt-bindings: adc: add AD7173
Message-ID: <20240118092110.00002c44@Huawei.com>
In-Reply-To: <cf48e196-a569-4287-93b7-b5f06c34d6f6@gmail.com>
References: <20231220104810.3179-1-mitrutzceclan@gmail.com>
	<CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
	<20240116163003.0000039d@Huawei.com>
	<18c239af-71ee-49d8-878e-e1770c3e2d46@gmail.com>
	<20240117163725.00003981@Huawei.com>
	<cf48e196-a569-4287-93b7-b5f06c34d6f6@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Jan 2024 10:10:46 +0200
Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:

> On 1/17/24 18:37, Jonathan Cameron wrote:
> > On Wed, 17 Jan 2024 14:43:21 +0200
> > Ceclan Dumitru <mitrutzceclan@gmail.com> wrote: =20
> >> On 1/16/24 18:30, Jonathan Cameron wrote: =20
> >>> On Mon, 15 Jan 2024 15:53:39 -0600
> >>> David Lechner <dlechner@baylibre.com> wrote: =20
> >>>> On Wed, Dec 20, 2023 at 4:48=E2=80=AFAM Dumitru Ceclan <mitrutzcecla=
n@gmail.com> wrote:   =20
>=20
> ...
>=20
> >>>>> +
> >>>>> +  refin-supply:
> >>>>> +    description: external reference supply, can be used as referen=
ce for conversion.     =20
> >>>> If I'm understanding correctly, this represents both voltage inputs
> >>>> REF+ and REF-, correct? The datasheet says "Reference Input Negative
> >>>> Terminal. REF=E2=88=92 can span from AVSS to AVDD1 =E2=88=92 1 V". I=
t seems like they
> >>>> should be separate supplies in case REF- is non-zero. Otherwise, how
> >>>> can we know what voltage it is? (same comment applies to refin2.)   =
=20
> >>> Agreed, in this case these are directly used as references (we recent=
ly
> >>> had another driver that could take a wide range of negative and posit=
ive
> >>> inputs but in that case an internal reference was generated that didn=
't
> >>> made it not matter exactly what was being supplied.  Not true here th=
ough!
> >>>    =20
> >> Wouldn't it be alright to specify that the voltage specified here shou=
ld
> >> be the actual difference (REF+)-(REF-)? =20
> > How do you establish the offset to apply to single ended channels if yo=
u don't
> > know the value of REF- (relative to local ground)?
> >=20
> > So no - as the device supports single ended channels the difference isn=
't
> > enough information.  It would probably be fine to do as you say if it
> > were a device with only differential channels where all that matters is
> > the scaling. =20
>=20
> 	I suppose that you are referring to the first page presentation: "Cross
> point multiplexer; 8 full differential or 16 single-ended channels". I
> consider this to be a bit misleading as all channels are actually fully
> differential (must select positive and negative source, AVSS is not one
> of them).
>=20
>=20
> 	Even more, the datasheet specifies that when using "single-ended"
> inputs you need to select which of the pins is the common one and
> connect it to the desired GND (be it AVSS, REF-):
>=20
> "Because there is a cross point mux, the user can set any of the analog
> inputs as the common pin. An example of such a scenario is to connect
> the AIN16 pin to AVSS or to the REFOUT voltage (that is, AVSS +
> 2.5 V)" (ad7173-8 page 27)
>=20
> 	For me this is 100% the case that this is a fully differential ADC in
> which the datasheet presents a way to use it single-ended. Let's say
> that we are using EXT_REF, and REF- is non zero. If someone connects
> AVSS to the desired common pin, the ADC will still measure correctly the
> difference of voltage between AIN_POS and AIN_NEG and compare it to the
> EXT_REF.

Thanks for the explanation. I indeed was mislead by the introduction!
Seems that the difference in the reference inputs is sufficient for this
device.

Jonathan



