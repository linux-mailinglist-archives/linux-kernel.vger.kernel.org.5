Return-Path: <linux-kernel+bounces-105302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD087DBF4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA021F2151B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9C01C6A0;
	Sat, 16 Mar 2024 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BtiwT1Bu"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6B1BF3B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710630646; cv=none; b=N9A24C3Kz1RVwOQRLOdG8HhpBnSBiIya97jDINFy5fbHOUqdSNQnf5U2dlf8imwA1LKKrmwVM1JlHRmeEUqs8FGEfp7dfxyMp4ARbMyDyxbJ5i0hSxCIlsZjdKcUuXy4Wxjc2sgR7mWK/+Iv7OWjarZhWlSQnrC1y1r4NxzSkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710630646; c=relaxed/simple;
	bh=Uhj7RuEu3TT7o8nqkA5ICbmsKwrnzLLUZorqi+yjSQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwyvk6NxgnCzlPpkMFpUOYMyo2Dqqq57WAhtgqVSb/IustJL5qqRKhCACXF4GeYIOvzTg6G7YkCrTBIVKLKw8JGfnffrRhxcXSWTxZCBcwmgM1Gv5bGPfjFCGY710e31/wgzYwr4MtZBXfKkVz0/ESq9LSsO7KMo5etonHzy1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BtiwT1Bu; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d476d7972aso46439991fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710630640; x=1711235440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl4sFjjcqSK2fr0eOMNXJ6QZ5CiO7UIBTmMT5ISsPhc=;
        b=BtiwT1BuKVmTvFDSDKzdkPn8SF07cg+94PBaHMLQSHBkg+tfsXQP3a/ZOcVgEkvzs/
         g8x6L2JXI41wxMi0b9H11Hzvh4nZZWXNqVgGR2NDU+wo1fCzAtJtA0BoLcBGLLddFokX
         yAYgPzMvnOoF/lDRMtobkaDrB0Cy3TQc8tBomNYp50vhxeV6wMy6ndB9k4/BqnxR4e2S
         v57ACS5g65NWXCcXfZ4WyG1stFsJt3q0pXe/vVBhHHyVAxetSAvsNOl64HKDG75bEZi2
         Nm+7YR4v3A3rUeQehqoSli1fNx32vScMhrvx16NvUvRYhP9gXEcwguiCfAibka/51yur
         r5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710630640; x=1711235440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl4sFjjcqSK2fr0eOMNXJ6QZ5CiO7UIBTmMT5ISsPhc=;
        b=TVNaaGQ9+dpqdU/d/F0m4bzzr5LRJu49v9+In4MOAwDKwgKWyPRspe23NmWFJtDD6u
         q5EEN3zalEgL1pAtldU04uRf6t89fz8obf0qLbWi5+Y5Xhws725mnrkHyf3r9qbUA8PG
         Gbs1rwoTuvWIFKmvsB3jBTvdYg+1pFxEPrFhSOAJHxMz9UrpbHAIl16sZ1gicw72WN94
         SP+DqCJUILoV/uImoz4Vq8WCjS2kQ/orh4gtd07W0oJzz8jL8/eFkaRCn/a1ZyOCpGDI
         aH6VHjyw7VMgt6FwkOzCMfWxDxXY84BZadeKIzBuLEvKRzwkhT2v7UHRjlw1Nrf5GvrP
         kyHw==
X-Forwarded-Encrypted: i=1; AJvYcCVVOVTXdAZGMzf6qIIlB75YkkKnC0WnPcqh9gKV03GjDxYljmFarhfsbkbTPUFlKdl5GJ4uDYh3719wzJdG7Tz50dig9ToPNkViZsH1
X-Gm-Message-State: AOJu0Yzs7R+Z275aczFlCj8XIloLCAwTCvCzS4OuJdjXOveZ5FTrc9o1
	voXWOY6w80G5rHJQTL8u3hDfJ0E4dw72iy37PrzQBp/q2RGVcuBgwzI2r1Ty6a1Avkf7o75dSE3
	oIuRyACTvcpWzxG3GyyjwznpW61EcIo23W4H8KQ==
X-Google-Smtp-Source: AGHT+IEvrw5SUEGI5p9pbJLtqUB3GoGIHcBaqp3Ytwxa7hWCI7LiRj4SLqkMSLRikDcYTaVGedk5JlVdYX9PJM3Exgs=
X-Received: by 2002:a2e:8609:0:b0:2d4:64fc:65bb with SMTP id
 a9-20020a2e8609000000b002d464fc65bbmr6173889lji.48.1710630640102; Sat, 16 Mar
 2024 16:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
 <ZfX5jynjW4M9pvw1@surfacebook.localdomain>
In-Reply-To: <ZfX5jynjW4M9pvw1@surfacebook.localdomain>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 16 Mar 2024 18:10:28 -0500
Message-ID: <CAMknhBGMUQFoQ9TxTTgy0dxHoyXkt+5tS93tpwz5Wo=h1UQD3Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 2:57=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Thu, Mar 14, 2024 at 12:43:38PM -0500, David Lechner kirjoitti:
> > This adds support for AD7944 ADCs wired in "3-wire mode". (NOTE: 3-wire
> > is the datasheet name for this wiring configuration and has nothing to
> > do with SPI_3WIRE.)
> >
> > In the 3-wire mode, the SPI controller CS line can be wired to the CNV
> > line on the ADC and used to trigger conversions rather that using a
> > separate GPIO line.
> >
> > The turbo/chain mode compatibility check at the end of the probe
> > function is technically can't be triggered right now but adding it now
> > anyway so that we don't forget to add it later when support for
> > daisy-chaining is added.
>
> ...
>
> > +enum ad7944_spi_mode {
> > +     /* datasheet calls this "4-wire mode" */
> > +     AD7944_SPI_MODE_DEFAULT,
> > +     /* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!)=
 */
> > +     AD7944_SPI_MODE_SINGLE,
> > +     /* datasheet calls this "chain mode" */
> > +     AD7944_SPI_MODE_CHAIN,
>
> Why not kernel doc?

This isn't a public/shared enum so it doesn't seem like it needs it.
It would just add redundant enum member names.

>
> > +};
>
> ...
>
> >  struct ad7944_adc {
> >       struct spi_device *spi;
> > +     enum ad7944_spi_mode spi_mode;
> >       /* Chip-specific timing specifications. */
> >       const struct ad7944_timing_spec *timing_spec;
> >       /* GPIO connected to CNV pin. */
> > @@ -58,6 +75,9 @@ struct ad7944_adc {
> >        } sample __aligned(IIO_DMA_MINALIGN);
> >  };
>
> Have you run `pahole` to see if there is a better place for a new member?

Nope. Not familiar with this tool. I can address this in a planned
patch that will be adding more members to this struct.

>
> ...
>
> > +/*
>
> The below is mimicing the kernel doc, but there is no marker for this.
> Why?

I received feedback on another patch in a different subsystem that
static functions shouldn't use /** since they aren't used outside of
the file where they are.

>
> > + * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversi=
on and
> > + *                                   acquisition
> > + * @adc: The ADC device structure
> > + * @chan: The channel specification
> > + * Return: 0 on success, a negative error code on failure
> > + *
> > + * This performs a conversion and reads data when the chip is wired in=
 3-wire
> > + * mode with the CNV line on the ADC tied to the CS line on the SPI co=
ntroller.
> > + *
> > + * Upon successful return adc->sample.raw will contain the conversion =
result.
> > + */
>
> ...
>
> > +     struct spi_transfer xfers[] =3D {
> > +             {
> > +                     /*
> > +                      * NB: can get better performance from some SPI
> > +                      * controllers if we use the same bits_per_word
> > +                      * in every transfer.
>
> I believe you may reformat this to reduce by 1 line.
>
> > +                      */
> > +                     .bits_per_word =3D chan->scan_type.realbits,
> > +                     /*
> > +                      * CS is tied to CNV and we need a low to high
> > +                      * transition to start the conversion, so place C=
NV
> > +                      * low for t_QUIET to prepare for this.
>
> This also seems narrow.

I have another patch in the works that will be moving these, so it can
be addressed then.

>
> > +                      */
> > +                     .delay =3D {
> > +                             .value =3D T_QUIET_NS,
> > +                             .unit =3D SPI_DELAY_UNIT_NSECS,
> > +                     },
> > +
> > +             },
> > +             {
> > +                     .bits_per_word =3D chan->scan_type.realbits,
> > +                     /*
> > +                      * CS has to be high for full conversion time to =
avoid
> > +                      * triggering the busy indication.
> > +                      */
> > +                     .cs_off =3D 1,
> > +                     .delay =3D {
> > +                             .value =3D t_conv_ns,
> > +                             .unit =3D SPI_DELAY_UNIT_NSECS,
> > +                     },
> > +             },
> > +             {
> > +                     /* Then we can read the data during the acquisiti=
on phase */
> > +                     .rx_buf =3D &adc->sample.raw,
> > +                     .len =3D BITS_TO_BYTES(chan->scan_type.storagebit=
s),
> > +                     .bits_per_word =3D chan->scan_type.realbits,
> > +             },
> > +     };
>
> ...
>
> > +     case AD7944_SPI_MODE_SINGLE:
> > +             ret =3D ad7944_3wire_cs_mode_conversion(adc, &indio_dev->=
channels[0]);
> > +             if (ret)
> > +                     goto out;
> > +
> > +             break;
> > +     default:
> > +             /* not supported */
>
> No error code set?

This is in an interrupt handler, so I didn't think there was anything
we can do with an error.

>
> >               goto out;
> > +     }
>
> ...
>
> > +     if (device_property_read_string(dev, "adi,spi-mode", &str_val) =
=3D=3D 0) {
> > +             ret =3D sysfs_match_string(ad7944_spi_modes, str_val);
>
> Don't you want use new fwnode/device property API for making these two in
> one go?

I didn't know there was one. I assume you mean
fwnode_property_match_property_string().

>
> > +             if (ret < 0)
> > +                     return dev_err_probe(dev, -EINVAL,
>
> Why shadowing the error code?

Cargo culted from one of a few of users of sysfs_match_string() that does t=
his.

Jonathan already picked this patch up so I can follow up with a patch
to clean up these two items.

>
> > +                                          "unsupported adi,spi-mode\n"=
);
> > +
> > +             adc->spi_mode =3D ret;
> > +     } else {
> > +             /* absence of adi,spi-mode property means default mode */
> > +             adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

