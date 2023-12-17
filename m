Return-Path: <linux-kernel+bounces-2617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B8815F82
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B59B21B83
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE644396;
	Sun, 17 Dec 2023 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHw12kjq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDDA44373;
	Sun, 17 Dec 2023 13:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FF6C433C8;
	Sun, 17 Dec 2023 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702821027;
	bh=/CcuNmqN52zYvPRkUzjQtGuO/nnq5PUkRpKVWAUrwCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EHw12kjqfyJ85oNK19fgeKkhrLzPr70n75sZmTed5fSHrcsEddvcjDFWhQ+FqBooK
	 5/YY9glFS+MzDHgvXz9p5QHq7eiBPh3CmDWf6zsap1N5AxxEANwaGlo03FKJEFGZKu
	 gq8E7Sk94Z1d3HsfEAtiuNIVwTLD7fZYeCm11ky2gMC2mmfe8HcN/84MAQfjjmI5DN
	 jTET0cerEcVlU5KNMKzehjQE+m3aAYURM4WwYYdvMAQAM6BW6dbf3fojeRD40utbsX
	 Rn5Rl1DVY42RS9rBYhH6uIxEEwgU8IicP20Yx2HhOvTZmJiuHN1lejYjn+FyI+SOtV
	 UVMp6N8/UOHXg==
Date: Sun, 17 Dec 2023 13:50:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linus.walleij@linaro.org,
 brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: adc: add AD7173
Message-ID: <20231217135007.3e5d959a@jic23-huawei>
In-Reply-To: <a1f60bf6-5fb6-4814-b3b5-799fb8ffb847@gmail.com>
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
	<CAMknhBEfisaSbHhnnei=gT1HZvHNWHrJD3O2y4b_TikkH=v2Ag@mail.gmail.com>
	<e4a9dde7-dca6-4862-bfb3-a93b879c9a1f@gmail.com>
	<CAMknhBFQ56SwMvOni6UDqvaq8t0iydHcggiL0biUeLQ6OV1ONA@mail.gmail.com>
	<a1f60bf6-5fb6-4814-b3b5-799fb8ffb847@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2023 19:03:28 +0200
Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:

> On 12/14/23 18:12, David Lechner wrote:
> > On Thu, Dec 14, 2023 at 1:43=E2=80=AFPM Ceclan Dumitru <mitrutzceclan@g=
mail.com> wrote: =20
> >> On 12/12/23 17:09, David Lechner wrote: =20
> >>> On Tue, Dec 12, 2023 at 11:45=E2=80=AFAM Dumitru Ceclan <mitrutzcecla=
n@gmail.com> wrote: =20
>=20
> >> ...
> >> =20
> >>>> +  interrupts:
> >>>> +    maxItems: 1 =20
> >>>
> >>> Shouldn't this be 2? The datasheet says there is a "Data Output Ready"
> >>> signal on the DOUT/RDY pin and an "Error Output" on the SYNC/ERROR
> >>> pin. Although I could see how RDY could be considered part of the SPI
> >>> bus. In any case, a description explaining what the interrupt is would
> >>> be useful.
> >>> =20
> >>
> >> I do not see how there could be 2 interrupts. DOUT/RDY is used as an
> >> interrupt when waiting for a conversion to finalize.
> >>
> >> Sync and Error are sepparate pins, Sync(if enabled) works only as an
> >> input that resets the modulator and the digital filter. =20
> >=20
> > I only looked at the AD7172-2 datasheet and pin 15 is labeled
> > SYNC/ERROR. Maybe they are separate pins on other chips? =20
>=20
> Yep, sorry, missed that. All other supported models have them separate.

=20
> >  =20
> >>
> >> Error can be configured as input, output or ERROR output (OR between a=
ll
> >> internal error sources).
> >>
> >> Would this be alright
> >>   interrupts:
> >>
> >>     description: Conversion completion interrupt.
> >>                  Pin is shared with SPI DOUT.
> >>     maxItems: 1 =20
> >=20
> > Since ERROR is an output, I would expect it to be an interrupt. The
> > RDY output, on the other hand, would be wired to a SPI controller with
> > the SPI_READY feature (I use the Linux flag name here because I'm not
> > aware of a corresponding devicetree flag). So I don't think the RDY
> > signal would be an interrupt.
> >  =20
>=20
> Error does not have the purpose to be an interrupt. The only interrupt
> used from this chip is the one from the DOUT/~RDY pin. Sure, it is wired
> to the SPI controller, but when you can't also receive interrupts on
> that very same CPU pin an issue arises. So that pin is also wired to
> another GPIO with interrupt support.

You've lost me.  It's a pin that has a state change when an error condition
occurs.  Why not an interrupt?  Doesn't matter that the driver doesn't
use this functionality. dt-bindings should be as comprehensive as possible.
Given it's a multipurpose pin you'd also want to support it as a gpio to be
complete alongside the other GPIOs.

>=20
> This is the same way that ad4130.yaml is written for example (with the
> exception that ad4130 supports configuring where the interrupt is routed).
>=20
> In regards to SPI_READY _BITUL(7) /* slave pulls low to pause */: the
> ad_sigma_delta framework (if it can be called that) is written to expect
> a pin interrupt, not to use SPI_READY controller feature.

SPI_READY is supported by only a couple of controllers. I'm not even that
sure exactly how it is defined and whether that lines up with this usecase.
=46rom some old asci art. https://lore.kernel.org/all/1456747459-8559-1-git-s=
end-email-linux@rempel-privat.de/

Flow control: Ready Sequence
Master CS   |-----1\_______________________|
Slave  FC   |--------2\____________________|
DATA        |-----------3\_________________|

So you set master and then wait for a flow control pin (the ready signal) b=
efore
you can actually talk to the device.

Here we are indicating data is ready to be be read out.

So I don't 'think' SPI_READY applies.

Jonathan


>=20


