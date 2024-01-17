Return-Path: <linux-kernel+bounces-29232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA8C830B52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C051F2BCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEBB2263E;
	Wed, 17 Jan 2024 16:37:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230F225DC;
	Wed, 17 Jan 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509461; cv=none; b=k9af4V0jGTTCyXH/sP07hWibvhoQOPMrAktbzrWb9y2MpBDZyCSsYjU99libZqX7nvy29OOQfr5021Tmj7jLI7AK5HW0frD1kGOolpbhC7QXq8OfpHRA4RRVpugnPR6ccvicy/QUHU1D5tsScN66GkFKeg6n3BHiK3xL2vG9aLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509461; c=relaxed/simple;
	bh=pl8tjrmKOS5lUY6LjsQDjtwjBq2zjZttjuXZvCOf3I0=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=R9vCEEe5DyJE6i+lkbFLUDwS3rV83AnFF6T2EKgfLek83EahOalJZntWuLS7CkVovD1p6qzme0lE26WgWxZkuDF71X3bLwYDAH7iR1Y0qi03/arE/LmMM/PVEEY39jEQSvyjQ68d8TSN4MYjU3pgLeVauYf98h2QjveeA2aoJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TFWgX6NMqz6J9bQ;
	Thu, 18 Jan 2024 00:34:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 37BE2140AA7;
	Thu, 18 Jan 2024 00:37:29 +0800 (CST)
Received: from localhost (10.48.153.213) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 16:37:28 +0000
Date: Wed, 17 Jan 2024 16:37:25 +0000
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
Message-ID: <20240117163725.00003981@Huawei.com>
In-Reply-To: <18c239af-71ee-49d8-878e-e1770c3e2d46@gmail.com>
References: <20231220104810.3179-1-mitrutzceclan@gmail.com>
	<CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
	<20240116163003.0000039d@Huawei.com>
	<18c239af-71ee-49d8-878e-e1770c3e2d46@gmail.com>
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

On Wed, 17 Jan 2024 14:43:21 +0200
Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:

> On 1/16/24 18:30, Jonathan Cameron wrote:
> > On Mon, 15 Jan 2024 15:53:39 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> >> On Wed, Dec 20, 2023 at 4:48=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@=
gmail.com> wrote: =20
>=20
> ...
>=20
> >> Sorry for the late reply as I see this has been applied already but...=
 =20
> > We have plenty of time.  Rather than dropping the ad7173 from my tree,
> > I'd prefer to see additional patches on top to tidy up whatever
> > makes sense from David's feedback.
> >  =20
> Alright then.
>=20
> ...
>=20
> >>
> >> As discussed in v8 [1] it is not clear what signal this is. Based on
> >> that discussion, I'm assuming the RDY signal, but how would bindings
> >> consumers know that without a description since it is not the only
> >> digital output signal of the chip? And why the ERROR signal was
> >> omitted here was never addressed AFAICT.
> >>
> >> [1]: https://lore.kernel.org/linux-iio/20231217135007.3e5d959a@jic23-h=
uawei/ =20
> >=20
> > I'd forgotten about that.  Adding interrupt-names would be the easiest
> > way to resolve this.
> >  =20
>=20
> I'll add this, but my curiosity for the long run is: How should
> differences between what bindings include and what drivers support
> should be managed and documented?

Drivers almost always support a subset of functionality of the device.
This isn't much different.  The driver 'should' use interrupt-names
but it doesn't need to support all the things that the binding says should
be in there.

Sometimes we document things in a driver, but there isn't any obligation to
do so and those docs are often out of date.

>=20
> ...
>=20
> >>> +
> >>> +  refin-supply:
> >>> +    description: external reference supply, can be used as reference=
 for conversion.   =20
> >>
> >> If I'm understanding correctly, this represents both voltage inputs
> >> REF+ and REF-, correct? The datasheet says "Reference Input Negative
> >> Terminal. REF=E2=88=92 can span from AVSS to AVDD1 =E2=88=92 1 V". It =
seems like they
> >> should be separate supplies in case REF- is non-zero. Otherwise, how
> >> can we know what voltage it is? (same comment applies to refin2.) =20
> >=20
> > Agreed, in this case these are directly used as references (we recently
> > had another driver that could take a wide range of negative and positive
> > inputs but in that case an internal reference was generated that didn't
> > made it not matter exactly what was being supplied.  Not true here thou=
gh!
> >  =20
> Wouldn't it be alright to specify that the voltage specified here should
> be the actual difference (REF+)-(REF-)?

How do you establish the offset to apply to single ended channels if you do=
n't
know the value of REF- (relative to local ground)?

So no - as the device supports single ended channels the difference isn't
enough information.  It would probably be fine to do as you say if it
were a device with only differential channels where all that matters is
the scaling.

>=20
> ...
>=20
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - interrupts   =20
> >>
> >> Why are interrupts required? What if the pin is not connected?
> >> =20
> > Ah. I clearly failed to review this one closely enough.
> >=20
> > Absolutely agree that interrupts should never be required.
> > No need for the driver to work if they aren't, but the binding
> > shouldn't require them!
> >=20
> > Jonathan
> >  =20
>=20
> To make sure that I understand, the driver will not probe without
> interrupts, but it is alright to make then optional in the bindings?

Yes - it is fine for a driver to only support a subset of functionality
and fail to probe if that subset isn't what the hardware enables.

>=20
> This is in the case that someone will want to use this binding and
> implement reading with polling?

Yes.

J


