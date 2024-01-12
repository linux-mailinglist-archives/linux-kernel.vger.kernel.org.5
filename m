Return-Path: <linux-kernel+bounces-24873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E8F82C400
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34A028641F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7877640;
	Fri, 12 Jan 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWm2pAhQ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC777628;
	Fri, 12 Jan 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso7473146e87.2;
        Fri, 12 Jan 2024 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705078252; x=1705683052; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KQHS5uhAPLXX77N7c+DiAec7npytpUQMPbZLsyEtnW0=;
        b=RWm2pAhQWPj/qnCrDXtw7d/zwgvE5W2KAV/UuUz/FSKYr0ObJDTJ5fr1PrkEUzyTYZ
         XPNULY7SuOSi4vNZ/5jzGtupY0H7/gph2DuHuTE7sYaLQgpgCVjsW1CzSMMf1F8opuIZ
         +RbsqbR7jywIeT2ZiipKk4Oz6rChLYFrDHzqoEInH/NasEh40Cg2VDMkJIIPtKgUh6uo
         h67REB0Szv8UR2vZ3vEK7m3Utg9ZeA8olWCqimMg2L4XiMJojYkX8nx2h1bBZj6wmgAO
         4CcQBafAHSA7rIZSfKwtjiR1/AUiGxbhU9su/HMdMBE3qIjRVcQCgInBEC35iJlbWmSs
         5T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705078252; x=1705683052;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQHS5uhAPLXX77N7c+DiAec7npytpUQMPbZLsyEtnW0=;
        b=AoV5w5A5hM/wRWRARHJ6Fdq5wO00bI+80n/9Hm7SnnNT4Eh8R7LJVXcDlupptwhhD4
         YqcjoQJyxfEmcjzyztNfMKYRC8MOUDNMiUWgG+PC+eQh65Ll3xD4W/fHNo4VMy08cQNj
         nXmEKFtBjdrnRNO61QmgtU7oQbL4vj0jkyQ5oD5ehv6JHCJp2zyAqX6vU9YHccBiHfsL
         dvCZg27qRvBfHbvEDhJln5Go2LRiMN9rcCpNhPs6xDqwZEYlUGPe+dlRiHeAgnPxzoMm
         SgTUfi5zl2Js5UXK0vt1fbSGnWbGuvO5du/RVVoPweFjuaBtI9m2M9fzS1zuxL/ThFRH
         Pw1A==
X-Gm-Message-State: AOJu0YwVBr7xJdUnwQiAjMd+1U8kKs+5hrScLw3rSdIT7r/JwW6HWDSs
	ckGk+XIAT/br+l5YJZmFkVE=
X-Google-Smtp-Source: AGHT+IG0JbLjMh66GE8r+eKEihDIGqjY2VovbrYwRbs1HfxFnWNa1ypfo+/6YnqpnC+UosIzXqBdJg==
X-Received: by 2002:a19:6502:0:b0:50e:3084:4ac7 with SMTP id z2-20020a196502000000b0050e30844ac7mr722222lfb.53.1705078251324;
        Fri, 12 Jan 2024 08:50:51 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402110b00b00558aa40f914sm1709327edv.40.2024.01.12.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 08:50:51 -0800 (PST)
Message-ID: <96e211915fbc2cfb245a377e3ea6ddf3ef55d8f7.camel@gmail.com>
Subject: Re: [PATCH 06/13] iio: buffer: add hardware triggered buffer support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,  Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand
 <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>,  linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2024 17:50:50 +0100
In-Reply-To: <CAMknhBHs32nHH8o-m3ByFfiKGAY=U7is18LMM2tGhH-v4v+8EQ@mail.gmail.com>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-6-e42c6a986580@baylibre.com>
	 <20240112123711.0000422a@Huawei.com>
	 <CAMknhBHs32nHH8o-m3ByFfiKGAY=U7is18LMM2tGhH-v4v+8EQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-12 at 09:42 -0600, David Lechner wrote:
> On Fri, Jan 12, 2024 at 6:37=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >=20
> > On Wed, 10 Jan 2024 13:49:47 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >=20
> > > This adds a new mode INDIO_HW_BUFFER_TRIGGERED to the IIO subsystem.
> > >=20
> > > This mode is essentially the hardware version of INDIO_BUFFER_TRIGGER=
ED
> > > where the trigger has the semantics of INDIO_HARDWARE_TRIGGERED and t=
he
> > > buffer has the semantics of INDIO_BUFFER_HARDWARE.
> > >=20
> > > So basically INDIO_HW_BUFFER_TRIGGERED is the same as
> > > INDIO_BUFFER_HARDWARE except that it also enables the trigger when th=
e
> > > buffer is enabled.
> >=20
> > If the trigger isn't routeable to multiple devices we normally don't
> > make it visible at all.
> >=20
> > I'm not yet understanding what a trigger actually means in this case.
> > Why do you need it to be userspace configurable?
> >=20
> > J
> >=20
>=20
> It looks like this question was answered in another thread (we need to
> configure the sampling frequency from userspace). But there you
> mentioned that adding a trigger for that seemed overkill. So you would
> you suggest to add the sampling_frequency sysfs attribute to the
> iio:deviceX instead and just forget about the trigger part? It seems a
> bit odd to me to have an attribute that may or may not be there
> depending other hardware external to the ADC chip. But if that is a
> normal acceptable thing to do, then it does seem like the simpler
> thing to do.

Well, for these converters you usually always need some sort of trigger to =
tell the
engine to fetch the data. But if not, you could make it optional in the dri=
ver (I
guess a trigger will always be a pwm, gpio, clk, etc...) and only expose th=
e
interface if needed. Yes, if we start having tons of devices with optional =
triggers
(which is not the case so far) I agree we would be duplicating logic all ov=
er the
place.

But let's see where all this discussion leads us. AFAIU, having the trigger=
s somehow
directly in the spi framework is also an option. If we can make that generi=
c enough
and with a nice interface I think that would make the most sense as this tr=
igger
affects the offload engine which is a spi controller thing. Let's see where=
 we end up
:)

- Nuno S=C3=A1

