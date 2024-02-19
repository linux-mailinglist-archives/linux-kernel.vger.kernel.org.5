Return-Path: <linux-kernel+bounces-71684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66A85A8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE44282937
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCF93F8CA;
	Mon, 19 Feb 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XlHQKobR"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FCDDD7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360441; cv=none; b=CIyGe4oycXrtHaJVWjyknp/n/DFnJXfk3BUDnyGgB/OlkCTeyfWnBpIZnREIq3N8hlgstd3ospSORDX9j9r6atKzyE+age3bNGCS/vQsGKAjKpqFbzjL+oIyb/A2YVQQqvH+T0aRsZJ83l7PRA0mojQVBoycR5+rBjvklu78Q8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360441; c=relaxed/simple;
	bh=dtEUK5nfkYBZ+1Dam3EkwQrUU5nGP6eib7rtxh2Rl1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7dHLm9bRlXHZgF50etVverWZVJPqEAYHWqc4xlAabnaQ/bVkk5GBbHgGb/XSCzTFCeW9rgNTTKt9g4OTXi9uA4uLGc9amK0ne9B5NSg4n/A8mxnClqk/2DAHjwwx+Zax/GOYDVwRd8IzxGxcEkzhSOjWzWLu+CuF/b1hLj0AFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XlHQKobR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d208be133bso43913311fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708360437; x=1708965237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMor+uCXiNhCQItjarLKiZlTj6kgrpxeMD49cd/TJbU=;
        b=XlHQKobRyXx9OsoUiAzMz+q7lFwrF5xqM08skwXloy4G6Rq/8HjoIlvFwhj0knPphR
         VfSWtKOiKnDuZWpRYzsLmK2gcldWAV4pKj/xMZd9VjYJIImrL/jCobJwl510saeFjR8e
         6qF2F1iHi5uYlX8wL9N3U/AGuJNQPcWJ2aJeqehsQaIh5CEV5Wnkc5RGgtteubDl3Gnt
         8Ndhw0pGT1b7rS1v+Y/4v0rX83CGwby7NUGFw/qOQQh/pGlzdDggHB1TtwokjWaA7beW
         g/ITgumDYMHrsrMCGOHysG/zV4jpo3hx87v9UEO2Qf510l2TFHPsZCzMA1JV48Ub/sGO
         alyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708360437; x=1708965237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMor+uCXiNhCQItjarLKiZlTj6kgrpxeMD49cd/TJbU=;
        b=ab5lLr9cTPyDYJegkw+nhPSIZwd5b0ql+6xXsjaWlG3LwOMLtL5MYy8oPqftoXMtPY
         8BRli5rtr2lgKhRLg+cTRWYkqieHYCLOlwQWXdqfPeMhFC6NqEiHs+hPPRQCWHyLRs6J
         8Yuo1FxCwC1RtDRkP7iO+mxTziysYa03yihGRIhQn5DKaqt2mDwXVxVPQWZtW7HtsXG9
         WTXPHlvw6b/30X/kdzW9lcwN1YFr293h/IjIKahzuO60ZrWmpgAYrn08oqQZkW8RI23Z
         15k/CGo0VaRtFliDytUnj13npywpo9X+h5idookeP7qxgxszJIFlijchQKrVNioHxfbB
         lKjg==
X-Forwarded-Encrypted: i=1; AJvYcCU59BVzCTIcjYNCSyyT0V8S/eF1EikvNdxYFvvuCawQDtEP0Kww+4mhyaGgRA1cP5/C6P+kIcOJCxNA8iNQI4m0YyXbwO6Rh7jaOs7l
X-Gm-Message-State: AOJu0YxecTIZmfk6cZGmC5Dya50+7sGvqtqGv20Vz3UiRc8Mn5zypiHH
	/Zm7ZtCC+IY6ZDriAQHY9yITUpcwXfORfpkKWSqv2eriA5nEDEgDTmhinQEvfCxxQXfg7rcB14b
	Wg8wUidmSU22UOXIcCq9WpT3sjTVklmMW7peQRg==
X-Google-Smtp-Source: AGHT+IEjXtBOOeJ5ul8UbN04mgev81Ow0VDcOsDJAh8YI3oXNPhH78X3hvkf4ZhBzKYh+VVkKq9PHi9oPDLGpGORa38=
X-Received: by 2002:a2e:a9a1:0:b0:2d2:231d:8521 with SMTP id
 x33-20020a2ea9a1000000b002d2231d8521mr6004464ljq.15.1708360436382; Mon, 19
 Feb 2024 08:33:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208172459.280189-1-alisa.roman@analog.com>
 <20240208172459.280189-6-alisa.roman@analog.com> <CAMknhBHU6k8J_PLCmGYF48S1q3uXByiCwzcd+B3q3Cd-02CUow@mail.gmail.com>
 <84546728-f0cb-4b38-a71c-e053b9b9278e@gmail.com> <CAMknhBFp-4s+-D8kD9rh0-OCc3gBs3hFX1EZ9ZmOifQOyGgUug@mail.gmail.com>
In-Reply-To: <CAMknhBFp-4s+-D8kD9rh0-OCc3gBs3hFX1EZ9ZmOifQOyGgUug@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 19 Feb 2024 10:33:45 -0600
Message-ID: <CAMknhBEtz_fSR8gaT_ew5Tk-Q5r7WjbW6q8GqHG7EFN4WZcDhg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
	lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, robh+dt@kernel.org, 
	Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:13=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On Thu, Feb 15, 2024 at 7:22=E2=80=AFAM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
> >
> > Hello and thank you for the feedback!
> >
> > On 09.02.2024 00:27, David Lechner wrote:
> > > On Thu, Feb 8, 2024 at 11:25=E2=80=AFAM Alisa-Dariana Roman
> > > <alisadariana@gmail.com> wrote:
> > >>
> > >> Unlike the other AD719Xs, AD7194 has configurable differential
> > >> channels. The default configuration for these channels can be change=
d
> > >> from the devicetree.
> >
> > ...
> >
> > >>
> > >> +static const struct iio_info ad7194_info =3D {
> > >> +       .read_raw =3D ad7192_read_raw,
> > >> +       .write_raw =3D ad7192_write_raw,
> > >> +       .write_raw_get_fmt =3D ad7192_write_raw_get_fmt,
> > >> +       .read_avail =3D ad7192_read_avail,
> > >> +       .validate_trigger =3D ad_sd_validate_trigger,
> > >> +       .update_scan_mode =3D ad7192_update_scan_mode,
> > >> +};
> > >
> > > Isn't this identical to ad7192_info and ad7195_info now that .attrs i=
s
> > > removed? It seems like we could consolidate here.
> >
> > Those are not exactly identical since: 92 has bridge switch attribute,
> > 95 has bridge switch and ac excitation attributes and 94 has no custom
> > attributes. I used a different info structure for 94 in order to avoid
> > showing extra attributes.
> >
>
> Ah, I see what you mean. I didn't look close enough at the other patch
> removing one attribute to see that were still other attributes.
>
> > >
> > >> +
> > >>   static const struct iio_info ad7195_info =3D {
> > >>          .read_raw =3D ad7192_read_raw,
> > >>          .write_raw =3D ad7192_write_raw,
> > >> @@ -1009,6 +1049,80 @@ static const struct iio_chan_spec ad7193_chan=
nels[] =3D {
> > >>          IIO_CHAN_SOFT_TIMESTAMP(14),
> > >>   };
> > >>
> > >> +static struct iio_chan_spec ad7194_channels[] =3D {
> > >> +       AD7193_DIFF_CHANNEL(0, 1, 2, 0x001),
> > >> +       AD7193_DIFF_CHANNEL(1, 3, 4, 0x023),
> > >> +       AD7193_DIFF_CHANNEL(2, 5, 6, 0x045),
> > >> +       AD7193_DIFF_CHANNEL(3, 7, 8, 0x067),
> > >> +       AD7193_DIFF_CHANNEL(4, 9, 10, 0x089),
> > >> +       AD7193_DIFF_CHANNEL(5, 11, 12, 0x0AB),
> > >> +       AD7193_DIFF_CHANNEL(6, 13, 14, 0x0CD),
> > >> +       AD7193_DIFF_CHANNEL(7, 15, 16, 0x0EF),
> > >> +       AD719x_TEMP_CHANNEL(8, AD7194_CH_TEMP),
> > >> +       AD7193_CHANNEL(9, 1, AD7194_CH_AIN1),
> > >> +       AD7193_CHANNEL(10, 2, AD7194_CH_AIN2),
> > >> +       AD7193_CHANNEL(11, 3, AD7194_CH_AIN3),
> > >> +       AD7193_CHANNEL(12, 4, AD7194_CH_AIN4),
> > >> +       AD7193_CHANNEL(13, 5, AD7194_CH_AIN5),
> > >> +       AD7193_CHANNEL(14, 6, AD7194_CH_AIN6),
> > >> +       AD7193_CHANNEL(15, 7, AD7194_CH_AIN7),
> > >> +       AD7193_CHANNEL(16, 8, AD7194_CH_AIN8),
> > >> +       AD7193_CHANNEL(17, 9, AD7194_CH_AIN9),
> > >> +       AD7193_CHANNEL(18, 10, AD7194_CH_AIN10),
> > >> +       AD7193_CHANNEL(19, 11, AD7194_CH_AIN11),
> > >> +       AD7193_CHANNEL(20, 12, AD7194_CH_AIN12),
> > >> +       AD7193_CHANNEL(21, 13, AD7194_CH_AIN13),
> > >> +       AD7193_CHANNEL(22, 14, AD7194_CH_AIN14),
> > >> +       AD7193_CHANNEL(23, 15, AD7194_CH_AIN15),
> > >> +       AD7193_CHANNEL(24, 16, AD7194_CH_AIN16),
> > >
> > > Shouldn't these be differential channels since they are
> > > pseudo-differential inputs measuring the difference between AINx and
> > > AINCOM?
> > >
> > >> +       IIO_CHAN_SOFT_TIMESTAMP(25),
> > >> +};
> > >
> > > i.e. like this (where AINCOM is voltage0 AINx is voltagex)
> > >
> > > static struct iio_chan_spec ad7194_channels[] =3D {
> > >         AD7193_DIFF_CHANNEL(0, 1, 0, AD7194_CH_AIN1),
> > >         AD7193_DIFF_CHANNEL(1, 2, 0, AD7194_CH_AIN2),
> > >         AD7193_DIFF_CHANNEL(2, 3, 0, AD7194_CH_AIN3),
> > >         AD7193_DIFF_CHANNEL(3, 4, 0, AD7194_CH_AIN4),
> > >         AD7193_DIFF_CHANNEL(4, 5, 0, AD7194_CH_AIN5),
> > >         AD7193_DIFF_CHANNEL(5, 6, 0, AD7194_CH_AIN6),
> > >         AD7193_DIFF_CHANNEL(6, 7, 0, AD7194_CH_AIN7),
> > >         AD7193_DIFF_CHANNEL(7, 8, 0, AD7194_CH_AIN8),
> > >         AD7193_DIFF_CHANNEL(8, 9, 0, AD7194_CH_AIN9),
> > >         AD7193_DIFF_CHANNEL(9, 10, 0, AD7194_CH_AIN10),
> > >         AD7193_DIFF_CHANNEL(10, 11, 0, AD7194_CH_AIN11),
> > >         AD7193_DIFF_CHANNEL(11, 12, 0, AD7194_CH_AIN12),
> > >         AD7193_DIFF_CHANNEL(12, 13, 0, AD7194_CH_AIN13),
> > >         AD7193_DIFF_CHANNEL(13, 14, 0, AD7194_CH_AIN14),
> > >         AD7193_DIFF_CHANNEL(14, 15, 0, AD7194_CH_AIN15),
> > >         AD7193_DIFF_CHANNEL(15, 16, 0, AD7194_CH_AIN16),
> > >         AD719x_TEMP_CHANNEL(16, AD7194_CH_TEMP),
> > >         IIO_CHAN_SOFT_TIMESTAMP(17),
> > > };
> > >
> >
> > I tried to follow the existing style of the driver: for each
> > pseudo-differential channel(AINx - AINCOM) there is an iio channel like
> > this in_voltagex_raw; and for each differential channel(AINx - AINy)
> > there is an iio channel like this in_voltagex-in_voltagey_raw. AD7194
> > has 16 pseudo-differential channels/8 fully differential channels so I
> > thought the (AINx - AINCOM) channels should be static and only the 8
> > differential ones could be configured by the user from the devicetree b=
y
> > choosing the input pins.
> >
> > The existing style of the driver, AD7192 has 4 pseudo differential
> > channels and 2 (non configurable) differential channels:
> > static const struct iio_chan_spec ad7192_channels[] =3D {
> >         AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
> >         AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
> >         AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
> >         AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
> >         AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
> >         AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
> >         AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
> >         AD719x_CHANNEL(7, 4, AD7192_CH_AIN4),
> >         IIO_CHAN_SOFT_TIMESTAMP(8),
> > };
> >
> > Would it be better to respect the existing style or to do like you
> > suggested and have a total of 16 differential channels that are
> > configurable from the device tree?


Now that we have it sorted that AINCOM should be a supply, it does
sound like we should more closely follow the pattern from AD7192. But
to cover every possible programmable combination of AINx to AINy, we
would need 256 differential channels (16 * 16) in addition to the
other channels. Realistically, we probably don't need that many
though. Since I see that AD7192 has a differential channel where uses
AIN2 for both + and - I guess having 16 differential channels that are
configured via device tree would be enough to allow all 16 AINx inputs
to be used this way. Is there a use case where the same AINx would be
assigned to multiple channels at the same time?

>
> Looking at Table 20 in the AD7192 datasheet, I can see why AD7192 was
> done this way since only certain combinations of inputs can be used
> together. (Although I think indexes 4 to 7 should really be
> differential because they are the difference between the input and
> AINCOM which may not be GND, but it is probably too late to fix that.)
>
> Tables 22, 23 and 24 in the AD7194 datasheet show that this chip is
> much more configurable than AD7192 when it comes to assigning
> channels. There are basically no restrictions on which inputs can be
> used together. So I am still confident that my suggestion is the way
> to go for AD7194. (Although I didn't actually try it on hardware, so
> can't be 100% confident. But at least 90% confident :-p)

