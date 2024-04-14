Return-Path: <linux-kernel+bounces-144319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95948A4493
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D061F215DE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1613664E;
	Sun, 14 Apr 2024 18:09:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A225364BF;
	Sun, 14 Apr 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713118160; cv=none; b=GDBm7oHrvdfWRW9C551dZ9vwulAMZs2UMmxIBh8OKBi9bfh0gVRpgRqCSoeY/0GLyS0K9p56UM9wpHVn8JPdtzcNrmVf+/cQQefPbvSpJe0cA1hQ6a5Kxa3tuBWxwh1EkLqzMCRrcbuKdgiRw6F4TtG4y06IUmWVqDHHL7MZd4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713118160; c=relaxed/simple;
	bh=5W4wffcDNukhqRi6VZPxph8HGoy90QshrDyX2MHGka4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHERJ1K1yU/U++w4rP41i/VLmXL2M4wOhf50xkIuxhnwoATqtqg7AH2Y+kc1Gi3AHRQDceBlnT+oWUHKpgUiGa6JsN55hd5sA7RJctzI4ac3jHMyzssBbFkeDQZp1ySpBm4KP6RVdpA/wENNbTO7kiW4I6f9ir+VMR9luE040tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VHdYd4ZK1z6K5qF;
	Mon, 15 Apr 2024 02:07:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C5186140B38;
	Mon, 15 Apr 2024 02:09:08 +0800 (CST)
Received: from localhost (10.48.158.114) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 14 Apr
 2024 19:09:08 +0100
Date: Sun, 14 Apr 2024 19:09:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	<lars@metafoo.de>, <Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add AD4000
Message-ID: <20240414190907.000011e5@Huawei.com>
In-Reply-To: <87058695-a1a6-4e68-87c5-accdb8451bf4@baylibre.com>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
	<7c877c865f0b7da28d9f1f177b3b2692b0ae20b9.1712585500.git.marcelo.schmitt@analog.com>
	<CAMknhBGKNZhGbD7pQ0Z7SMCWqxqGux0LcO_wW0XGP4hLTOwNBg@mail.gmail.com>
	<ZhVfARtMfOLOPRid@debian-BULLSEYE-live-builder-AMD64>
	<20240413171409.4575fe6f@jic23-huawei>
	<87058695-a1a6-4e68-87c5-accdb8451bf4@baylibre.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 13 Apr 2024 12:33:54 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/13/24 11:14 AM, Jonathan Cameron wrote:
> > On Tue, 9 Apr 2024 12:30:09 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >  =20
> >> On 04/08, David Lechner wrote: =20
> >>> On Mon, Apr 8, 2024 at 9:32=E2=80=AFAM Marcelo Schmitt
> >>> <marcelo.schmitt@analog.com> wrote:   =20
> >>>> =20
>=20
> ...
>=20
> >>>> +
> >>>> +  adi,spi-mode:
> >>>> +    $ref: /schemas/types.yaml#/definitions/string
> >>>> +    enum: [ single, chain ]   =20
> >>>
> >>> It sounds like there are more possible wiring configurations for these
> >>> chips that I thought when suggesting reusing this binding from AD7944
> >>> so we probably need more options here. (see my reply to the cover
> >>> letter for the complete context of these remarks)
> >>>
> >>> We identified A) an additional wiring configuration where SDI of the
> >>> ADC chip is wired to SDO of the SPI controller and B) a potential need
> >>> to pin mux between wiring modes to work around SPI controller
> >>> limitations perhaps we could omit the adi,spi-mode property and just
> >>> use the standard pinctrl properties.
> >>>
> >>>   pinctrl-names: =20
> >=20
> > I'm lost on how pinctrl makes sense here.
> > Yes you are changing the modes of the pins, but not in a conventional s=
ense
> > of some register that is being updated to say now use them like this.
> > The mode is dependent on the timing sequence of how the pins are used.
> > Otherwise looking at it a different way it's an external wiring thing we
> > aren't controlling it at all.  Is pinctrl suitable for that?
> > I always thought of it as a way to change configurations of SoC pins. =
=20
>=20
> Yes, this is exactly what I think we need here.
>=20
> To write to the register, the chip has to be wired like this ("default"):
>=20
>                                          +-------------+
>      +-----------------------------------| SDO         |
>      |                                   |             |
>      |              +--------------------| CS          |
>      |              v                    |             |
>      |    +--------------------+         |     HOST    |
>      |    |        CNV         |         |             |
>      +--->| SDI   AD7944   SDO |-------->| SDI         |
>           |        SCK         |         |             |
>           +--------------------+         |             |
>                     ^                    |             |
>                     +--------------------| SCLK        |
>                                          +-------------+
>=20
> But to read sample data, the chip has to be wired in one of these
> 3 configurations:
>=20
>=20
> 3-wire mode ("single"):
>=20
>                                          +-------------+
>                     +--------------------| CS          |
>                     v                    |             |
>     VIO   +--------------------+         |     HOST    |
>      |    |        CNV         |         |             |
>      +--->| SDI   AD7944   SDO |-------->| SDI         |
>           |        SCK         |         |             |
>           +--------------------+         |             |
>                     ^                    |             |
>                     +--------------------| SCLK        |
>                                          +-------------+
>=20
> 4-wire mode ("multi"):
>                                          +-------------+
>      +-----------------------------------| CS          |
>      |                                   |             |
>      |              +--------------------| GPIO        |
>      |              v                    |             |
>      |    +--------------------+         |     HOST    |
>      |    |        CNV         |         |             |
>      +--->| SDI   AD7944   SDO |-------->| SDI         |
>           |        SCK         |         |             |
>           +--------------------+         |             |
>                     ^                    |             |
>                     +--------------------| SCLK        |
>                                          +-------------+
>=20
> Chain mode ("chain"):
>=20
>                                          +-------------+
>                     +--------------------| CS          |
>                     v                    |             |
>           +--------------------+         |     HOST    |
>           |        CNV         |         |             |
>      +--->| SDI   AD7944   SDO |-------->| SDI         |
>      |    |        SCK         |         |             |
>     GND   +--------------------+         |             |
>                     ^                    |             |
>                     +--------------------| SCLK        |
>                                          +-------------+
>=20
>=20
> If we want to be able to both write the register and read data,
> some reconfiguration is needed. It might be possible to read data
> using the register-write wiring configuration, but that only
> works if SDO can be set to the correct state *before* the
> CS line changes. This is not something that I think most SPI
> controllers can do (e.g. Marcelo mentioned in the cover letter
> that RPi always returns SDO to low after every xfer while
> the AXI SPI Engine leaves SDO wherever it was last).
>=20
> >=20
> > A pointer to some precendence in another driver for using it like this
> > would go some way towards convincing me.
> >=20
> > Jonathan
> >  =20
>=20
>=20
> I didn't find much precedence for something like this, but I
> found devicetree/bindings/net/mediatek-bluetooth.txt that uses
> pinctrl to pull a UART Rx pin low for a bootstrap mode which
> sounds very similar to what we need to do here (pull the SPI
> controller SDO pin high or low for 3-wire or chain mode).
>=20
> For example, if we wanted to use 3-wire mode for reading
> data, we would set the pinctrl to "default" to write the
> register to configure the chip during driver probe. Then
> to read data, we would change the pinctrl to "single" before
> doing the SPI xfer to ensure that the ADC SDI pin is pulled
> high independent of what the SDO line of the SPI controller
> is currently doing.

Ah ok.  This is implying that we are switching to a controllable
mode to pull that pin high (or I guess one where it is always
high).  I'm not sure if that's more common than an SPI controller
where you can set the 'don't' care state to high or low.
I assume we can't get away with just setting the output buffer
to all 1s because it won't hold that state between transfers?

Feels like that could be rolled into the SPI subsystem with
any necessary transitions handled there (maybe)

Just to check, this isn't just a case of a missing pull up
resistor to drag that line correctly when it isn't actively
driven (combined with all 1s in the write buffer) etc?

Jonathan


>=20
>=20
>=20


