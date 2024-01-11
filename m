Return-Path: <linux-kernel+bounces-23293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF382AA94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C845284735
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15C1094E;
	Thu, 11 Jan 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heWpginE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8AD291;
	Thu, 11 Jan 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e60e13703so2591445e9.0;
        Thu, 11 Jan 2024 01:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704964266; x=1705569066; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58H3B21puKPucFrgZrCCs4UrdvBkL+jeM2Mpg7ywRvc=;
        b=heWpginEoTaue2cw4AFKxoqn+1s5klWNgpIzpc3ZpRzmHBP5b6iwoOOk+w04OrfIC7
         xUEz014CLBc8rksDwPT8CNjw0EPnW+oSrSWy2fTklbY5sibD1ExleD2lu/tCFyE7cRen
         iLV+9YTszyT1770c+WaVD2ZuN1o7ayh4lHpjgvNOfnsz48Fp5bw+7n8KtM1qckX3LF2V
         wSUV0LifXmvwcLssN7hShY0dj9B6AlOs3rf+iXz+ts1UHuPb76hTTP9f5PdKdbDHq83Y
         5gi12sZylstf0J3U3179R/nlc01iwAbuKAEDpdQ8Ce+uGFnFwH73nUFBkpHhWRI9xDDD
         HRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704964266; x=1705569066;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58H3B21puKPucFrgZrCCs4UrdvBkL+jeM2Mpg7ywRvc=;
        b=m46Zv0gSe1deAIjyOrkHV4A5J9ihqP6fPSRQuRX4XI7L8IE66ll1ANx48H5C7sF/zX
         SbxG9OJgQNqsfPWsi25VX+s75bcaEO6rNXX4WQ5H4+LiJScDIDkP5+aT5iq5nZOh5A3m
         wbM5kDaTCWlHIe4W0Foxn/jiRKbAtFhPwUKgt2l9kt/8+AtBU82Zf34QD9rqdtYh5TAf
         QdyjwPgovpKu3flCQIjwmrIFiKewB+iGL17P659+VpzdRN42oO5SggLWEWAJ7MAaM6k7
         I7Mc+6PttnWRJODhqtYC2Dt7Q+IkKfi6kRiweMHn6wXjRKuo4wT6WToCzOdzrN+Lix2/
         BIDg==
X-Gm-Message-State: AOJu0YxQflsj9ym6KQm0PSODlY+BlA3XD9VNuWdMyd2p6cAsaZx4A45e
	zj66lnbtcyYVHTW+UgGCkGQ=
X-Google-Smtp-Source: AGHT+IE1tP3ziJ71aNWf7nd5bjIvUPih/2iLsXlWGYDp+UdvA8FDX5JyJaWF4HkNkgCLLNfW5toheA==
X-Received: by 2002:a05:600c:444c:b0:40e:498b:dd35 with SMTP id v12-20020a05600c444c00b0040e498bdd35mr207291wmn.26.1704964265350;
        Thu, 11 Jan 2024 01:11:05 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c430c00b0040e596320bfsm1151028wme.0.2024.01.11.01.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:11:05 -0800 (PST)
Message-ID: <4c15f3f2d54363698d13a9c5b50a82684e143afd.camel@gmail.com>
Subject: Re: [PATCH 04/13] spi: dt-bindings: adi,axi-spi-engine: add offload
 bindings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Frank Rowand
 <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>,  linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2024 10:14:16 +0100
In-Reply-To: <CAMknhBGwb+9Eo5ghG+Zk3BpMuMZfQxAAwGEGUMspcJzHzKWyXA@mail.gmail.com>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-4-e42c6a986580@baylibre.com>
	 <20240110231456.GB2854345-robh@kernel.org>
	 <CAMknhBGwb+9Eo5ghG+Zk3BpMuMZfQxAAwGEGUMspcJzHzKWyXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 18:06 -0600, David Lechner wrote:
> On Wed, Jan 10, 2024 at 5:15=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >=20
> > On Wed, Jan 10, 2024 at 01:49:45PM -0600, David Lechner wrote:
> > > The ADI AXI SPI Engine driver supports offloading SPI transfers to
> > > hardware. This is essentially a feature that allows recording an
> > > arbitrary sequence of SPI transfers and then playing them back with
> > > no CPU intervention via a hardware trigger.
> > >=20
> > > This adds the bindings for this feature. Each SPI Engine instance
> > > can have from 0 to 32 offload instances. Each offload instance has a
> > > trigger input and a data stream output. As an example, this could be
> > > used with an ADC SPI peripheral. In this case the trigger is connecte=
d
> > > to a PWM/clock to determine the sampling rate for the ADC and the out=
put
> > > stream is connected to a DMA channel to pipe the sample data to memor=
y.
> > >=20
> > > SPI peripherals act as consumers of the offload instances. Typically,
> > > one SPI peripheral will be connected to one offload instance. But to
> > > make the bindings future-proof, the property is an array.
> >=20
> > Is there some sort of arbitration between multiple offload engines on
> > the same chip select? If not, I don't see how it would work.
>=20
> There is only one SPI engine driving the SPI controller, so if two
> offloads are triggered at the same time, they will be executed
> serially.
>=20
> >=20
> > I think this whole thing could be simplified down to just 3
> > SPI controller properties: pwms, dmas, and adi,offload-cs-map. Each
> > property is has entries equal the number of offload engines. The last
> > one maps an offload engine to a SPI chip-select.
>=20
> Offloads could be connected to virtually anything, not just pwms and
> dmas, so making pwms and dmas controller properties doesn't seem right
> to me. What if we have one that uses a gpio trigger or clock trigger?
> Or what if we have one where the output goes to a DSP instead of DMA?
> This is why I made offload@ nodes with a compatible property - to
> describe what is actually connected to each offload instance since it
> could be an unlimited range of different things.
>=20

Yeah, again, that is conceptually correct but I'm just not sure if the extr=
a
complexity pays off. The peripheral device connected to the offload should =
know
what trigger + data path it has. So I don't really think that horrible to h=
ave
the properties in the peripheral device. And there's not much that boilerpl=
ate
code anyways (at least in ADI usecases). And, as already said, for the trig=
gers
we might be able to have something generic but for the dmas (or whatever el=
se)
would be more tricky. In IIO case, setting up an IIO DMA buffer, is one API=
 call
- so not much repetition in it...

- Nuno S=C3=A1
>=20


