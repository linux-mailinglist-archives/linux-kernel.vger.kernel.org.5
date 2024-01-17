Return-Path: <linux-kernel+bounces-29236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66817830B67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08225B23B40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209CD224EE;
	Wed, 17 Jan 2024 16:46:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244D1E875;
	Wed, 17 Jan 2024 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509975; cv=none; b=HSC+ky2qollMJwJdREFA8GwioLdtWlr6zFWPdo3Z0EZ+mWZKuqb6Wgfbo+uQ9jHRcdjPtQ+2x3iEVeFJ+qSRQdhaxtlxvyskGDI7wBw3zHFDBWvg8jhO+pCsmnC2DhqiwdkwfqvA1k+gtrn8QCerpSL8AlHu4h5KQ6cZ8RGeg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509975; c=relaxed/simple;
	bh=MuVgMtEj7P8JEJRpwYW+9iwfv2YqraUTBmEdptScHGw=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=J257Zkl2zvO4mHIB4dLWqtLbgBhkr3nwLJC+tnTZmruI991UZcWsTI5NdmGVl9H22aI+tE7iOyH8gKXQFxMxQpfZrecLz6tDfDcNle7tDzMKZHZwH3cE/Q+5nIonvYT2sMN8ng74ygU5KUtrnCZ41+BRymQhkXlNhLIxd3SMLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TFWsS1HWpz6K8s5;
	Thu, 18 Jan 2024 00:43:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 911101408F9;
	Thu, 18 Jan 2024 00:46:10 +0800 (CST)
Received: from localhost (10.48.153.213) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 16:46:09 +0000
Date: Wed, 17 Jan 2024 16:46:08 +0000
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
Message-ID: <20240117164608.00004dd0@Huawei.com>
In-Reply-To: <38dcb8cc-5d16-41f2-845b-5c97cb691cb7@gmail.com>
References: <20231220104810.3179-1-mitrutzceclan@gmail.com>
	<CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
	<38dcb8cc-5d16-41f2-845b-5c97cb691cb7@gmail.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 17 Jan 2024 14:30:33 +0200
Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:

> On 1/15/24 23:53, David Lechner wrote:
> > On Wed, Dec 20, 2023 at 4:48=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@g=
mail.com> wrote: =20
>=20
> ...
> >=20
> > According to the timing diagram in the datasheet, SCLK is high during
> > idle, so don't we need `spi-cpol: true` here?
> >=20
> > Likewise, data is valid on the trailing SCLK edge, so don't we need
> > `spi-cpha: true` here?
> >=20
> >  =20
> V1 Rob Herring suggested that if device is not configurable, driver
> should set the spi mode

I'm not sure on that given it's fairly common to do evil things with
Not Gates to implement cheap level converters.  That tends to break
doing this entirely in driver.

However, I'm fine with whatever the current convention on this is.
We can always deal with inverters when hardware turns up that is
doing that.

> >> +  gpio-controller:
> >> +    description: Marks the device node as a GPIO controller.
> >> +
> >> +  "#gpio-cells":
> >> +    const: 2
> >> +    description:
> >> +      The first cell is the GPIO number and the second cell specifies
> >> +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
> >> +
> >> +  refin-supply:
> >> +    description: external reference supply, can be used as reference =
for conversion. =20
> >=20
> > If I'm understanding correctly, this represents both voltage inputs
> > REF+ and REF-, correct? The datasheet says "Reference Input Negative
> > Terminal. REF=E2=88=92 can span from AVSS to AVDD1 =E2=88=92 1 V". It s=
eems like they
> > should be separate supplies in case REF- is non-zero. Otherwise, how
> > can we know what voltage it is? (same comment applies to refin2.)
> > Yes, but in that case, the value of the referenced supply should reflec=
t =20
> that and be equal to (REF+)-(REF-). I'll add to the description this.

See other thread - I don't think that works for single ended where we should
probably provide an offset.
>=20
> ...
>=20
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts =20
> >=20
> > Why are interrupts required? What if the pin is not connected?
> >  =20
> From the datasheet, the reading of the conversions seem to be only
> interrupt based: "As soon as the next conversion is complete,
> the data register is updated; therefore, the period in which to
> read the conversion is limited." this paragraph suggests to me that
> interrupts are required

Nasty.  However, a valid use case would be to use a single channel
at a time, which case that statement doesn't matter.  We have other
devices that only support onehot channel sequencing - that would work
here.

>=20


