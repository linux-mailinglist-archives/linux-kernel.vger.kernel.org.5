Return-Path: <linux-kernel+bounces-2895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043128163EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF30B28287C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468321FDC;
	Mon, 18 Dec 2023 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IQO386vW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061F1FB5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cc5e48779aso12971881fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702861243; x=1703466043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYhM54+sMY2tBRKqpDaD5Gx2Jei7oYxE5mh0exAmkgk=;
        b=IQO386vW6DGGmQQjD2LzYmJJorHBqdMYptvsqfBlulPsSD4whf+Ehh6k4Lz7KR9Ikj
         MPik2LKqs2gJS1XZi78AjYOoCTUvlqGBEgC0PQhJ6u08OZ3yenbyTOySET7//857oytM
         uwmSlKRi8wM1pUTEQlaJ0Kl6gCqzXG1YXCE1lf52muJ8kL+Q5prwwLovOQKLQNVOlgbF
         0tZ/6w5X1fQFaSUXiSB1XAKK/Y9wiV5UqSH4+VN48PbzO74J3INS8DANQb77oaBSrpui
         +u+534eXrPUwqJ3QJtiodPWK0732pXF1Qbw37b8nozGWHhPJ0cGEvdxzDMJCu0l5tQju
         804A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702861243; x=1703466043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYhM54+sMY2tBRKqpDaD5Gx2Jei7oYxE5mh0exAmkgk=;
        b=wiamdKphqzvG8HfRe1CApY2ppXJDB+2wwTR4f379oVBw0BsrPz8kkvbslndGtsqn0b
         XqeprvMahEORx89UzJ3MFGYBal9WQocqVS7Oq9ybvbFDQ5yANaPn8N8CkEIJrAB3bkD3
         BaWfAGfXdUzfStATLvRn4Wdf3ARtd1qAChCihzXqzNmMZyjhRP6G0hF+aNPOLBpD5PTC
         t/u6Gtjlo9RaYQG6arpcGo8K/ftn+FwJpH/1fTZXh/PgpuOSMso3UI064N8yJuY5QRTE
         TS5I7yl/dR2B/hjmQ/Os1oE/CprJI/HgnicUll+zP9R1ojNAMq/hiJMnh9ie6s4Kgetb
         QEEA==
X-Gm-Message-State: AOJu0YyxrQd2SyDRWZbVWHrnXoqESevTZ+BuoI3pR4PnHIycyxSGC+wd
	GJMyES0RbnO7dASEgjlKkn4GBcmpOiWkndJBl2ioPQ==
X-Google-Smtp-Source: AGHT+IGT+13egZruEA6UBIyNn6mhLZfwdbUiXunPJ5JYwT6M/cXeoLwloFIFi6Do8ovp2sRvdiDM906QH2fckik0l2c=
X-Received: by 2002:a05:651c:2106:b0:2cc:1f36:2abe with SMTP id
 a6-20020a05651c210600b002cc1f362abemr3032047ljq.92.1702861243536; Sun, 17 Dec
 2023 17:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
 <CAMknhBEfisaSbHhnnei=gT1HZvHNWHrJD3O2y4b_TikkH=v2Ag@mail.gmail.com>
 <e4a9dde7-dca6-4862-bfb3-a93b879c9a1f@gmail.com> <CAMknhBFQ56SwMvOni6UDqvaq8t0iydHcggiL0biUeLQ6OV1ONA@mail.gmail.com>
 <a1f60bf6-5fb6-4814-b3b5-799fb8ffb847@gmail.com> <20231217135007.3e5d959a@jic23-huawei>
In-Reply-To: <20231217135007.3e5d959a@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 Dec 2023 19:00:32 -0600
Message-ID: <CAMknhBEzM202_pu=yYcmuC2Tz1HNv2zC=iy77q09hryfcGQ=Zw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: adc: add AD7173
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ceclan Dumitru <mitrutzceclan@gmail.com>, linus.walleij@linaro.org, brgl@bgdev.pl, 
	andy@kernel.org, linux-gpio@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 7:50=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 14 Dec 2023 19:03:28 +0200
> Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:
>
> > On 12/14/23 18:12, David Lechner wrote:
> > > On Thu, Dec 14, 2023 at 1:43=E2=80=AFPM Ceclan Dumitru <mitrutzceclan=
@gmail.com> wrote:
> > >> On 12/12/23 17:09, David Lechner wrote:
> > >>> On Tue, Dec 12, 2023 at 11:45=E2=80=AFAM Dumitru Ceclan <mitrutzcec=
lan@gmail.com> wrote:
> >
> > >> ...
> > >>
> > >>>> +  interrupts:
> > >>>> +    maxItems: 1
> > >>>
> > >>> Shouldn't this be 2? The datasheet says there is a "Data Output Rea=
dy"
> > >>> signal on the DOUT/RDY pin and an "Error Output" on the SYNC/ERROR
> > >>> pin. Although I could see how RDY could be considered part of the S=
PI
> > >>> bus. In any case, a description explaining what the interrupt is wo=
uld
> > >>> be useful.
> > >>>
> > >>
> > >> I do not see how there could be 2 interrupts. DOUT/RDY is used as an
> > >> interrupt when waiting for a conversion to finalize.
> > >>
> > >> Sync and Error are sepparate pins, Sync(if enabled) works only as an
> > >> input that resets the modulator and the digital filter.
> > >
> > > I only looked at the AD7172-2 datasheet and pin 15 is labeled
> > > SYNC/ERROR. Maybe they are separate pins on other chips?
> >
> > Yep, sorry, missed that. All other supported models have them separate.
>
>
> > >
> > >>
> > >> Error can be configured as input, output or ERROR output (OR between=
 all
> > >> internal error sources).
> > >>
> > >> Would this be alright
> > >>   interrupts:
> > >>
> > >>     description: Conversion completion interrupt.
> > >>                  Pin is shared with SPI DOUT.
> > >>     maxItems: 1
> > >
> > > Since ERROR is an output, I would expect it to be an interrupt. The
> > > RDY output, on the other hand, would be wired to a SPI controller wit=
h
> > > the SPI_READY feature (I use the Linux flag name here because I'm not
> > > aware of a corresponding devicetree flag). So I don't think the RDY
> > > signal would be an interrupt.
> > >
> >
> > Error does not have the purpose to be an interrupt. The only interrupt
> > used from this chip is the one from the DOUT/~RDY pin. Sure, it is wire=
d
> > to the SPI controller, but when you can't also receive interrupts on
> > that very same CPU pin an issue arises. So that pin is also wired to
> > another GPIO with interrupt support.
>
> You've lost me.  It's a pin that has a state change when an error conditi=
on
> occurs.  Why not an interrupt?  Doesn't matter that the driver doesn't
> use this functionality. dt-bindings should be as comprehensive as possibl=
e.
> Given it's a multipurpose pin you'd also want to support it as a gpio to =
be
> complete alongside the other GPIOs.
>
> >
> > This is the same way that ad4130.yaml is written for example (with the
> > exception that ad4130 supports configuring where the interrupt is route=
d).
> >
> > In regards to SPI_READY _BITUL(7) /* slave pulls low to pause */: the
> > ad_sigma_delta framework (if it can be called that) is written to expec=
t
> > a pin interrupt, not to use SPI_READY controller feature.
>
> SPI_READY is supported by only a couple of controllers. I'm not even that
> sure exactly how it is defined and whether that lines up with this usecas=
e.
> From some old asci art. https://lore.kernel.org/all/1456747459-8559-1-git=
-send-email-linux@rempel-privat.de/
>
> Flow control: Ready Sequence
> Master CS   |-----1\_______________________|
> Slave  FC   |--------2\____________________|
> DATA        |-----------3\_________________|
>
> So you set master and then wait for a flow control pin (the ready signal)=
 before
> you can actually talk to the device.
>
> Here we are indicating data is ready to be be read out.
>
> So I don't 'think' SPI_READY applies.
>
> Jonathan
>

I'm not arguing that SPI_READY applies in this particular case, but
FWIW it does seem to me like...

1) SPI_READY could be implemented in any SPI driver using a GPIO
interrupt (similar to how we already have GPIO CS)
2) In cases where the SPI controller does have actual hardware support
for SPI_READY and the ADC chip A) uses CS to trigger a conversion and
B) has a "busy" signal that goes low when the conversion is complete,
then the SPI_READY feature could be used to make reading sample data
more efficient by avoiding any CPU intervention between CS assertion
and starting the data xfer due to waiting for the conversion to
complete either by waiting for an interrupt or sleeping for a fixed
amount of time.

