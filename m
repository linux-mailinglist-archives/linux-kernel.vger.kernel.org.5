Return-Path: <linux-kernel+bounces-19012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39DF8266B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0692A1C21335
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18B212B87;
	Sun,  7 Jan 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IvP3RIHx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321E13AEE
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd0db24e03so11456911fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 15:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704668587; x=1705273387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUyJMmMauN0ROH+iLyigz7sdMZl69TBxoZLyZcJhrlY=;
        b=IvP3RIHxqwHWGaeXXYuNkZgD+2FVmtn9/hjapkI5IcF46v1pr6l4qRpVOBDc3mT3MA
         SE1+csR5OffPJJ265LwNQaytgh5MxbvjcVvX38CwizLBUzu5C9K1rUTJhsexnP67AthJ
         Xh+TaUewVTD5pI6FyWDDTkBVTSjj+l2bZGY1h7XlHjhHwgHHpLvj/3MoVCVv3EmKCXpr
         2N3mCyF3FQxi84wwRJEueX5gDtVSpnTdeCiTx9dnmlGKE37Rz3RGuAmoZ5DM+iZV5Z8e
         Ac7p5OkvPOws3LoucHwBlw2CFGqVEiFNavIjfH+Sj4qkhmXoXt/JZrvL8oybNEPG3sAF
         co8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704668587; x=1705273387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUyJMmMauN0ROH+iLyigz7sdMZl69TBxoZLyZcJhrlY=;
        b=FYi9yKp63nhYaY3wFIgX8eoAv6yPDmjel5PWe7RLYSZ1hrYkpGqzIp2ZPp+bcQg2Nr
         eKdPaNQeqchHm7UrtKt2h2j7z3GRrJN2F81Sb+8YrkwrM3tfElcVOhlSo8RjA2Stiec7
         MaoUP9GECp1aVEatqHSkagRPg5rSE/DUa4TDPpXh11jZXJ2lkNmSqmHvqO1qFImBsiyD
         73tJfIk7X69tzPKYUp9AOGwUa3WNaT7DyHVSFz10q5WpjFYLhamG/1vLY6GDETvyh97E
         2SbspuZ32W0hz1HomqcHIIW3Hv6ZKNkZZ9Y02uMRBKivx+RuuLrpDfcP/9hoFHGEoRT9
         pAjg==
X-Gm-Message-State: AOJu0Yy9fv2Ra8f9vEx8vtIbNL+CsK5Nd7/ZKT3dsWIqprTT+GdTBpOW
	pttLMLazAzdvfNQtjRWaOBCRqZuwYCU/beMp8Iu1vAn4B7Mq9Q==
X-Google-Smtp-Source: AGHT+IHoja2EIV1WYLymw+3UxRqHYksIv6dVgMukAHkD5wcpYIp2E8pb1gj69ZiXnSThS/LchOcP1Xj7/PYUHgQCUyA=
X-Received: by 2002:a05:651c:3de:b0:2cc:5945:4e22 with SMTP id
 f30-20020a05651c03de00b002cc59454e22mr476364ljp.85.1704668587219; Sun, 07 Jan
 2024 15:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
 <20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com> <20240107164356.3e8df266@jic23-huawei>
 <f431e418-0b7c-4362-be26-9d2f03e0de07@sirena.org.uk>
In-Reply-To: <f431e418-0b7c-4362-be26-9d2f03e0de07@sirena.org.uk>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 7 Jan 2024 17:02:56 -0600
Message-ID: <CAMknhBE7eUMzcD0bdymrhL2Lw3FubB3aHDWmJFD7YnaGNYmQ9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: add spi-rx-bus-channels
 peripheral property
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 3:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Sun, Jan 07, 2024 at 04:43:56PM +0000, Jonathan Cameron wrote:
> > David Lechner <dlechner@baylibre.com> wrote:
>
> > > This adds a new spi-rx-bus-channels property to the generic spi
> > > peripheral property bindings. This property is used to describe
> > > devices that have parallel data output channels.
>
> > > This property is different from spi-rx-bus-width in that the latter
> > > means that we are reading multiple bits of a single word at one time
> > > while the former means that we are reading single bits of multiple wo=
rds
> > > at the same time.
>
> > Mark, could you take a look at this SPI binding change when you have ti=
me?
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Are you saying that `spi: dt-bindings:` should be preferred over
`dt-bindings: spi:`?

I thought I was doing it right since I was following the guidelines of
[1] which says:

> The preferred subject prefix for binding patches is:
>     "dt-bindings: <binding dir>: ..."

[1]: https://www.kernel.org/doc/html//v6.7/devicetree/bindings/submitting-p=
atches.html

>
> > I don't want to apply it without your view on whether this makes sense
> > from a general SPI point of view as we all hate maintaining bindings
> > if they turn out to not be sufficiently future looking etc and we need
> > to deprecate them in favour of something else.
>
> This makes no sense to me without a corresponding change in the SPI core
> and possibly controller support, though I guess you could do data
> manging to rewrite from a normal parallel SPI to this for a pure
> software implementation.  I also see nothing in the driver that even
> attempts to parse this so I can't see how it could possibly work.

We currently don't have a controller that supports this. This is just
an attempt to make a complete binding for a peripheral according to
[2] which says:

> DO attempt to make bindings complete even if a driver doesn't support som=
e features

[2]: https://www.kernel.org/doc/html//v6.7/devicetree/bindings/writing-bind=
ings.html

So, will DT maintainers accept an incomplete binding for the
peripheral? Or will you reconsider this without SPI core support if I
can explain it better? It doesn't seem like a reasonable request to
expect us to spend time developing software that we don't need at this
time just to get a complete DT binding accepted for a feature that
isn't being used.

In the SPI core, I would expect this property to correspond to new
flags `SPI_RX_2_CH`, `SPI_RX_4_CH`, `SPI_RX_8_CH` and it would have
checks similar to other flags to make sure controller supports the
flag if the peripheral requires it. Likewise, struct spi_transfer
would probably need a rx_n_ch field similar to rx_nbits to specify if
individual xfers use the feature. But beyond that, yes I agree it
would be difficult to say how it should work without implementing it
on actual hardware.

