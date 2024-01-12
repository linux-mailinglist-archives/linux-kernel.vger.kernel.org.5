Return-Path: <linux-kernel+bounces-25022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517782C640
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DAA28A93F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD8171A9;
	Fri, 12 Jan 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1pgyGpfI"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2D16433
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ccbc328744so83647881fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705090163; x=1705694963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KODDiTlCYJz8VsTSh5FfV19+LAJgiCFhCmKp66prebs=;
        b=1pgyGpfIAUmtnVrgG2GiS1Bcof5zE5Ypo1c3vuQAugjD8jxG2OHBuff3dtj+ym2LH0
         FyP5ZZQlcse7lt4saVLhFZJnH20xpgYueXwZRK49kgnypWa8l+DNsKR8rLntNZWmtm50
         1vCV7vhpCi6J2vBeOIV5HevYJ7O6yLbLpUBa4QHyOaCFwZqjOHMOEd/xH5TtvwKBYdyy
         5chv0NuZ2RvA/o7RxNiyUpRS33VLb5WRuWqAZJgmkrdVYWta5/d1v27v7KGJsTdZ50Tn
         t43+45eMxxreA8nIsx+tkvVAER788TIkVyNrz5pvRncAJXBlH1e7znPk9fzwTwt+BVCh
         zMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705090163; x=1705694963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KODDiTlCYJz8VsTSh5FfV19+LAJgiCFhCmKp66prebs=;
        b=FgtpyFa9u9N9zeaMaXVL2+FeXhsDgChccbMGJrkgbVl+sspgRJzmgcOQ/oKskq/Fhm
         uXu6lXwb9Au09+A9VPq2n96VRMQHGw1CDFF4HO+ihpWNN6pAJ8AAYCvq/zjwl/rrlVNw
         NXKSpmotIYN2TrugiED5Mh8ml6srArdlZ+fLxUKpQO4VMOgNdkgRKIlYw3Jo4wMkUimw
         f1FgJVIIrK2JOn8OoanPC8O97t3ebVPiRRoGFkwt4KpewtwOvR18rD7CRk//axJzuPET
         EADt9cXDOReFRfbSPn3aN0t24VHtagec5bq7uY5zcvbc6T64SSVIJY7ZYfxjeQqSG6cr
         J21g==
X-Gm-Message-State: AOJu0YxRhtZy4Sk8Y8lYz5hPAy/WN9vtfAc+0TrOlHS7PGO63suaMy89
	1mN1ARB2tq2zan+qXx9p12xBQD3TXuk9qx3N9yKgnlbk6aZdhg==
X-Google-Smtp-Source: AGHT+IGEuMOKDSkYS95xvat9jZtpVVIWQ7N5qewHjvbrG746DxH65fTxGieC8qJkBQ+ThV+voOiRxrp6c9DBjmLGD8c=
X-Received: by 2002:a2e:7813:0:b0:2cd:85b9:5815 with SMTP id
 t19-20020a2e7813000000b002cd85b95815mr890369ljc.42.1705090162684; Fri, 12 Jan
 2024 12:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
 <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk> <CAMknhBGMRed9vDrDAuPJ5DnEe6MyHzd0VBebp5OaLX2Q+AyhMQ@mail.gmail.com>
 <CAMknhBE-1Khe9J-n5WQnH=mFnN0ukiq7=F-SEOU6J-2_u-R0bw@mail.gmail.com>
In-Reply-To: <CAMknhBE-1Khe9J-n5WQnH=mFnN0ukiq7=F-SEOU6J-2_u-R0bw@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Jan 2024 14:09:11 -0600
Message-ID: <CAMknhBGzOFnMnpt7B8iHd9VwWA-_zFVdiswDUAheovrHXyAv=Q@mail.gmail.com>
Subject: Re: [PATCH 01/13] spi: add core support for controllers with offload capabilities
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 3:32=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Thu, Jan 11, 2024 at 2:54=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > On Wed, Jan 10, 2024 at 3:36=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > >
> > > On Wed, Jan 10, 2024 at 01:49:42PM -0600, David Lechner wrote:
> > > > This adds a feature for specialized SPI controllers that can record
> > > > a series of SPI transfers, including tx data, cs assertions, delays=
,
> > > > etc. and then play them back using a hardware trigger without CPU
> > > > intervention.
> > >
> > > > The intended use case for this is with the AXI SPI Engine to captur=
e
> > > > data from ADCs at high rates (MSPS) with a stable sample period.
> > >
> > > > Most of the implementation is controller-specific and will be handl=
ed by
> > > > drivers that implement the offload_ops callbacks. The API follows a
> > > > prepare/enable pattern that should be familiar to users of the clk
> > > > subsystem.
> > >
> > > This is a lot to do in one go, and I think it's a bit too off on the
> > > side and unintegrated with the core.  There's two very high level bit=
s
> > > here, there's the pre-cooking a message for offloading to be executed=
 by
> > > a hardware engine and there's the bit where that's triggered by some
> > > hardwar event rather than by software.
> > >
> > > There was a bunch of discussion of the former case with David Jander
> >
> > I found [1] which appears to be the conversation you are referring to.
> > Is that all or is there more that I missed?
> >
> > [1]: https://lore.kernel.org/linux-spi/20220512163445.6dcca126@erd992/
> >
> > > (CCed) a while back when he was doing all the work he did on optimisi=
ng
> > > the core for uncontended uses, the thinking there was to have a
> > > spi_prepare_message() (or similar) API that drivers could call and th=
en
> > > reuse the same transfer repeatedly, and even without any interface fo=
r
> > > client drivers it's likely that we'd be able to take advantage of it =
in
> > > the core for multi-transfer messages.  I'd be surprised if there were=
n't
> > > wins when the message goes over the DMA copybreak size.  A much wider
> > > range of hardware would be able to do this bit, for example David's c=
ase
> > > was a Raspberry Pi using the DMA controller to write into the SPI
>
> For those, following along, it looks like the RPi business was
> actually a 2013 discussion with Martin Sperl [2]. Both this and [1]
> discuss proposed spi_prepare_message() APIs.
>
> [2]: https://lore.kernel.org/linux-spi/CACRpkdb4mn_Hxg=3D3tuBu89n6eyJ082E=
ETkwtNbzZDFZYTHbVVg@mail.gmail.com/T/#u

I found one more. A patch from Martin with the basic proposed API but
not much in the way of implementation. It looks like this is where the
idea fizzled out.

https://lore.kernel.org/linux-spi/0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6@mart=
in.sperl.org/

