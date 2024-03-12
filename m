Return-Path: <linux-kernel+bounces-100333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AAE8795D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5B5B213F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CD58AD4;
	Tue, 12 Mar 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E2L7PumP"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5067A726
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252853; cv=none; b=ubGGEt5Jeju0CPFbGt/nRVPuZn+apf9XLdDPvhcC07yr4YIqvK1kBMZCzQZzGG6FsUDl6JhQL9ReLKzExAE7ni8xUiuoOjxvqOm6gcZndHU/iqjOmIJULs3wMN65Jf0DKW0/FHJ+X3vvI+/ktrcutlf7MD8qT91RFqu7XVvSJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252853; c=relaxed/simple;
	bh=RNfz9UMeVHEZ4EC/7S+cusApvHD/n33RU7Q6sN1FNmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9JuKbFu+ip2Ge+rhCJr4V4GD2iYaSjgCOsR3vIxiZUtqFYXWex49AlUktCQ+nTwmSDgqxZzsTL1xO7PgK3MyKV/36nwuOgzN6IYmDS3hVcyQsUx8FiIUWdydMMsctMeMfLBkOzsyhhS97/QBopNQwdQq6uT+QiEILI1Tk/qo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E2L7PumP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d4515ec3aaso8106761fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710252848; x=1710857648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHhBAVPkSXMRlsnEU7VzojS2GB1k8UvtbfmWURp3Ays=;
        b=E2L7PumPmIMGXvuRkv8xfNWlK1dDz+7Fad+oLDWh54xlCUWdlg4L2tTalVYo6qStjT
         +Qv2IYkr1sgJCnNv+PQLXkHoxeQ/dijjmlcunf0OA79yXQ20GYaZuB41W482THZphy4G
         wGZcgjTBt+T51aa4/nvR9KFCi37EfFqJQZyQgVfLLLldXy8xrIEzeefrymRTnwPUqvqK
         p9kBkJ/PlNfuDiV9E+SDG5oVIu7a1G23ceJZy7qSOOo0HMWZxswRpQLfp3jYEZIIJgQ/
         hrZ9U6Oj2LO1JO1CgdTsufMaHrCgDL30yMvK9EMYdDgbIa8BmBTof5DR/0/5gV3ZxxrF
         szSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710252848; x=1710857648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHhBAVPkSXMRlsnEU7VzojS2GB1k8UvtbfmWURp3Ays=;
        b=WeAbSxQCQjh+VwM6AQrM02mV8yndVnaYD6xj8OF9792Tm9GGCnVWHpcUm40kK/D5nR
         RdQL6OLmNLFRJG1Td7+Tjhi6MHmkeVw7xkCI3dRXy91752Tk9g4wyMT1s9OP05RxQ++6
         SQsj+n+RER2rdEvnyefbWAiHgRvAfTdITzZKlhittA0fSJWkpsSYHvAL+oV6M2EB19qB
         Qow5R4Y3yB3OA/SDTJ9TkrtHNzBdYxdHhZnVgGhwuudRNPphpx0bZ0T30nDCNkQ6Sk4f
         z1lPdjNIC6mZw2dEaEBlA+lJ7T86nUHbGAPm75jAqF/JufHTxQ6ijyQrnd8P7An9Wkx5
         ezJg==
X-Forwarded-Encrypted: i=1; AJvYcCU4RKTD+OGFyWwDsa7ePh2PRgaB35A+5r9LxyfboLrgDcrXQGNZZA9C+MpF2sInbamIfiLA0g9GYAnoMxsALJsU2wmlOuaApLGVuzmA
X-Gm-Message-State: AOJu0YwNxzGGGW7iRzSXBkYEfNPr8im8iYNDOISbl6ABmYFW1sRHhtmY
	xwBeEtOoSKARjZxeqmmnI4JHIWdgU2eycgYjjJa5eC4GnFHunryEw+5Dyt27j4XIjnMQUolW2iP
	4mOwA2cYWN9nX+09yNn0ZvaZ48zYNabwXilZoIQ==
X-Google-Smtp-Source: AGHT+IERJ/rpv5Wl0fKtFBs5+P9ARp4/wWg+dr8a4LK3zFX9bbNJCrn9b/Gg30XUh4iaQqytjgejBFIsYucV3ChpNqw=
X-Received: by 2002:a05:651c:2224:b0:2d4:5359:7098 with SMTP id
 y36-20020a05651c222400b002d453597098mr897028ljq.18.1710252847939; Tue, 12 Mar
 2024 07:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com>
 <8ee551edeff9c4c959a4dbda53d1a2a26a9bb62c.camel@gmail.com>
In-Reply-To: <8ee551edeff9c4c959a4dbda53d1a2a26a9bb62c.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 12 Mar 2024 09:13:56 -0500
Message-ID: <CAMknhBE8OwrtbJ9xYVZ8ObsZTnxmn9Fpk2a-gj1aCSaN-whDRg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7944: Add support for "3-wire mode"
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 4:08=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Mon, 2024-03-11 at 16:26 -0500, David Lechner wrote:

..

> >  /*
> >   * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion and=
 acquisition
> >   * @adc: The ADC device structure
> > @@ -167,9 +246,22 @@ static int ad7944_single_conversion(struct ad7944_=
adc *adc,
> >  {
> >       int ret;
> >
> > -     ret =3D ad7944_4wire_mode_conversion(adc, chan);
> > -     if (ret)
> > -             return ret;
> > +     switch (adc->spi_mode) {
> > +     case AD7944_SPI_MODE_DEFAULT:
> > +             ret =3D ad7944_4wire_mode_conversion(adc, chan);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             break;
> > +     case AD7944_SPI_MODE_SINGLE:
> > +             ret =3D ad7944_3wire_cs_mode_conversion(adc, chan);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             break;
> > +     case AD7944_SPI_MODE_CHAIN:
> > +             return -EOPNOTSUPP;
>
> This mode is not really supported for now and in theory we can't really h=
ave
> adc->spi_mode =3D AD7944_SPI_MODE_CHAIN, right? So, I would just make thi=
s the
> 'default' branch and not care about chain mode (implementing it when addi=
ng it).

The compiler was happy with this, but yeah, default: is probably safer.

..

> > +     if (!adc->cnv && adc->spi_mode =3D=3D AD7944_SPI_MODE_DEFAULT)
> > +             return dev_err_probe(&spi->dev, -EINVAL, "CNV GPIO is
> > required\n");
> > +     else if (adc->cnv && adc->spi_mode !=3D AD7944_SPI_MODE_DEFAULT)
> > +             return dev_err_probe(&spi->dev, -EINVAL,
> > +                                  "CNV GPIO in single and chain mode i=
s not
> > currently supported\n");
> > +
>
> Redundant else...

yup

>
> >       adc->turbo =3D devm_gpiod_get_optional(dev, "turbo", GPIOD_OUT_LO=
W);
> >       if (IS_ERR(adc->turbo))
> >               return dev_err_probe(dev, PTR_ERR(adc->turbo),
> > @@ -369,6 +486,10 @@ static int ad7944_probe(struct spi_device *spi)
> >               return dev_err_probe(dev, -EINVAL,
> >                       "cannot have both turbo-gpios and adi,always-turb=
o\n");
> >
> > +     if (adc->spi_mode =3D=3D AD7944_SPI_MODE_CHAIN && adc->always_tur=
bo)
> > +             return dev_err_probe(dev, -EINVAL,
> > +                     "cannot have both chain mode and always turbo\n")=
;
> > +
>
>
> I'm fine in having this now but shouldn't we only have the above when we =
do support
> chain mode? A bit odd having it when we don't even allow chain mode.
>

Yeah, we could wait to add this. It seemed like something easy to
overlook though if we don't add chain mode right away, so I just went
ahead and added it now.

