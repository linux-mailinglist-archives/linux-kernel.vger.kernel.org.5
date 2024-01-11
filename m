Return-Path: <linux-kernel+bounces-23953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D740882B468
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A41B235F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41948537E9;
	Thu, 11 Jan 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fbuJpoFg"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3052F78
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so67172171fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704995873; x=1705600673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIIeAnjVtiEzwNi51WQJcgMz4b/6vXhUoTESmsgqD3I=;
        b=fbuJpoFg4XKb+qqfc0DlpQ3P5zlOYh+Hubjz7VmektWFRQT/C+bubbf0xd7luCiqnS
         W56iKXQK3BKMJ2Fg27SpzxeSGtgS0ja58U4/zFoEdurnagxeuKNnmhZbaNC31TvtKoMR
         nHthmiScL7GAr/9xyuBCUlVZ5u1DjZMlxHgFY92MaJFBkYya4DF9vmrT77XUH/YzBZ0n
         qQxCa6LsK6EntUh4dX/lU3Bh55j+V342C+0HHI4LP/XJxNk2pltaUipFNPHeYIYKSWBW
         EpH+Yj3+7IRt+n7WGtnnGAXxIhBkAN3nMDvrt2zSZkk+3c8j8gss5kqi4ZteVGj44qIr
         X8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704995873; x=1705600673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIIeAnjVtiEzwNi51WQJcgMz4b/6vXhUoTESmsgqD3I=;
        b=ttMybrhvWRfv6ODrJq3PwOEu20BeHMfWAVYCXdTovlZHiqLWb+JODNV4+ZyBtKdat7
         EzQdFuR9QyiVTEX0J6WSqSKEI57ZJV3bIXFRNv+njZUhYbcsZtUs+YlfH1QDku1qgWXh
         MVkmXgF7BHlQk5mn4i/SQoEAwqwhpEBgvDPmIwucWLvPgE6YnpTaWzAtp26NdfA/cxbR
         p/eEF/uNphFBM78dJQKLF3mBewuBWPFZa9fd+7RUW7uz159sWsWIVlyJrMQlaHcLNrLE
         96hS7nnVZ6zta4uubo6g2iFy7bn3eOCkr7u2e6Tj0rm7c+opRf8nb3JUm694cR/RADuw
         HTfQ==
X-Gm-Message-State: AOJu0YxTyOhXkZ/D/C1G8VV7/8xlu00jNirxSTQ0X6IpgPju8FcMDZR2
	8q3USdNwGl30DI0HSiAGO5Jr33Q2utcOA61JRdl5e33sFRG6sQ==
X-Google-Smtp-Source: AGHT+IHTHFHgOxQHH3kFRf98AOHdLGEvuqdjqKXJ0SrG1lf8zP10i7sGdzjJujc+f8huruMNKYE4dgf6/S/NYhjxxd4=
X-Received: by 2002:a2e:b0cc:0:b0:2cb:2d48:32b with SMTP id
 g12-20020a2eb0cc000000b002cb2d48032bmr53184ljl.53.1704995872651; Thu, 11 Jan
 2024 09:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-5-e42c6a986580@baylibre.com>
 <a94d7aae-3d5c-4204-83f6-5374c3166f58@sirena.org.uk> <CAMknhBEEC4F2_hpJ_405bfrb3KNkAYpjDoJbnmOFXodp8yLACg@mail.gmail.com>
 <d19dac5c-eef6-4543-9eee-787262c0f52c@sirena.org.uk>
In-Reply-To: <d19dac5c-eef6-4543-9eee-787262c0f52c@sirena.org.uk>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jan 2024 11:57:41 -0600
Message-ID: <CAMknhBFXBVXZ8BFaNi9Anih3kH79T2Z8Jy72mQ2GcKj+38mxJg@mail.gmail.com>
Subject: Re: [PATCH 05/13] spi: axi-spi-engine: add SPI offload support
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 7:00=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Jan 10, 2024 at 04:31:25PM -0600, David Lechner wrote:
> > On Wed, Jan 10, 2024 at 3:39=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > Glancing through here I'm not seeing anything here that handles DMA
> > > mapping, given that the controller will clearly be doing DMA here tha=
t
> > > seems surprising.
>
> > In the use case implemented in this series, the RX data is going to
> > DMA, but in general, that doesn't have to be the case. In theory, it
> > could get piped directly to a DSP or something like that. So I left
> > the RX DMA part out of the SPI controller and implemented as a
> > separate device in "iio: offload: add new PWM triggered DMA buffer
> > driver". The SPI controller itself isn't aware that it is connected to
> > DMA (i.e. there are no registers that have to be poked to enable DMA
> > or anything like that).
>
> If there's a buffer being assigned to the device (or removed from the
> device) it needs mapping, this will ensure the device is allowed to
> access it if there's IOMMUs involved, and that there's no pending cache
> operations which could corrupt data.

Currently, in this series, the mapping is being handled by the
existing DMA buffer framework in the IIO subsystem. It is the IIO
device that owns/manages the DMA rather than the SPI controller. Nuno
has also made some relevant comments in some of the other threads
about why it would be preferable to do it that way. But this sounds
like something we should come back to later after we have a look at
breaking down this series into smaller parts.

