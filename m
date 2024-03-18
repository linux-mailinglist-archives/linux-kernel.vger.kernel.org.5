Return-Path: <linux-kernel+bounces-106379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173987ED75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A4B1C21414
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856FA535B2;
	Mon, 18 Mar 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK8GHzEf"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6853800;
	Mon, 18 Mar 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779141; cv=none; b=cZBBYo2yQPDQ3NvsBEIfsvgAdW9gmqgH73RuvKdyDNMektHN0MsqshtvIiOJI1eOn0hcmYCTKmfjIqYQbk905k5Q3HkTexyeb96xUAgp0EG+I0Ty9KAMUH0U6nLcC1TAk2SfRhPaLJLwnk7vS7nsxeg/sCCehS7vTWPpXWFCf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779141; c=relaxed/simple;
	bh=giesbGcq46KOYjY4GQjwDETYa8Xdax981n2V4JqW9Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSSraL5zT6h8ZuejXSJwBTGvmYdjAW1hZE8T+vS1I4Zs9rBqAGv3T7+pV554KGK/jUaVTBdY2uMR3fVm46H7C/UDyYF5zVBAg1hY8ddBpa80tgbG6tApsrhCPlf4oh/Do0HuoeTzHtoDYqbXXrNGkoxUNO8SoSPw0taoJOp7Sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK8GHzEf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso4203130e87.1;
        Mon, 18 Mar 2024 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710779138; x=1711383938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rKzlf71EVD205LMfgxNC4ncRodr1B+XZa8lyvjKqeg=;
        b=fK8GHzEf/pv5Qo1KbkCa52NyuWgxPo+m5Tauzxbd230lCtYXYnfhWPDxnJDkbPfJCS
         joCloX4fcBlhhYnzDJcuwX4+1+n1/n9XB9xL8B4gZ6fqzFsI+NaL79cxY1ULtoUpMUs5
         S0nh8vfte4YHu5/+l3lYXzNFSMNUdge4XMHKGoNqunXsg++Kq4BaZ9JR+PicDreT7obX
         UFz943/qEB7Ap+212FcU/Tsgr0HP9BTBKgia98m0MeDPDmf3EaKEIYcS0xtL711kCEZ1
         wOfwi8UF0mCsNhMYFG3xySS1guBamtO7PkWfH6FZ9fTsEuvpM1rpQwffNsnJQeKHTFGJ
         DC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710779138; x=1711383938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rKzlf71EVD205LMfgxNC4ncRodr1B+XZa8lyvjKqeg=;
        b=Hhk++oqBfaKpPpZ3WSwBtVG/jEOSCWnGhaBtglNMnIG/mvZIdYfXpaLVBa6kM+6+Ku
         g5t72YojcKYIRjVG8ROu36MPrq3jzvur6RcrRFddB2CfEZJ1B8TJ4gGGErgsYpO/gmWd
         X1W3KmQfo+hjgK2Lr5KCRTLvbRLBFeARPetu2XbCCKzHtCM5Kk8DaKjAPEf1aN7gfjNg
         fcCP9TlRKU/RYlfsADKYsRPYtjpOTSho/mGAbpbwwKzynP2hjwargVFcS0HR6YwEBB3V
         bOS/w5KgfvCobm0BCP6AMzoqbGlHFX/XsihMnPZmbWKeHRQlqKIKnxg5V7n5Qz2llAuu
         JRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA0rlKGlAo16i4lPZUeIHBPx0i440/cK5LAW3HDg9De3LZiOd4Lm+3/FYlYx1vYyV5OgvuKKAEbfS9ysh8+Og00N3V5NsrhSnrFZvUQZcm628Y7IfVzstwNy11OPsNuXg3S1J9LYuT
X-Gm-Message-State: AOJu0Yw5jfHgmKiNK/6upQfoKk+eTBNvxS1ETmtzFDbd3PwVKp7nbTZQ
	dlHUGjd8uGn2s9hB7+En+GIpdf8IW7PhQ4ywxBnDA9HW6qARFhROI+lm0RymnMekIgA9KRUvVeX
	ysb6w03rDqONw6UAPSMfnNGlWXLk=
X-Google-Smtp-Source: AGHT+IHUVjI+PiZTW/dgaH8rFzDbABi0kBoA7wGjdMUWeKhXqVOvRy6JM3ZhYq76Nb8UlEyHjKdduSpwKRa9nyTv2jg=
X-Received: by 2002:ac2:5b10:0:b0:513:dd66:d5ed with SMTP id
 v16-20020ac25b10000000b00513dd66d5edmr5869957lfn.29.1710779137934; Mon, 18
 Mar 2024 09:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
 <ZfX5jynjW4M9pvw1@surfacebook.localdomain> <20240318124041.0000032d@Huawei.com>
 <CAHp75VeQcvuEy4V6-+3PeWTZJ9=Qae0AiiNB93OOw3wuc-uh3A@mail.gmail.com> <CAMknhBG4OAc=qsZZrahYBiwOEK=XM3pUWup9O5J5W4dMCS4FUw@mail.gmail.com>
In-Reply-To: <CAMknhBG4OAc=qsZZrahYBiwOEK=XM3pUWup9O5J5W4dMCS4FUw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Mar 2024 18:25:01 +0200
Message-ID: <CAHp75VcvbMP4TvJLb+3PZWARNj0gc-MYayv6GiMY9GjZ4usT_Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron <jic23@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 4:17=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On Mon, Mar 18, 2024 at 8:10=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 18, 2024 at 2:41=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:

..

> > > > >  struct ad7944_adc {
> > > > >     struct spi_device *spi;
> > > > > +   enum ad7944_spi_mode spi_mode;
> > > > >     /* Chip-specific timing specifications. */
> > > > >     const struct ad7944_timing_spec *timing_spec;
> > > > >     /* GPIO connected to CNV pin. */
> > > > > @@ -58,6 +75,9 @@ struct ad7944_adc {
> > > > >      } sample __aligned(IIO_DMA_MINALIGN);
> > > > >  };
> > > >
> > > > Have you run `pahole` to see if there is a better place for a new m=
ember?
> > >
> > > I know this matters for structures where we see lots of them, but do =
we actually
> > > care for one offs?  Whilst it doesn't matter here I'd focus much more
> > > on readability and like parameter grouping for cases like this than w=
asting
> > > a few bytes.
> >
> > This is _also_ true, but think more about cache line contamination.
> > Even not-so-important bytes may decrease the performance. In some
> > cases it's tolerable, in some it is not (high-speed ADC). In general I
> > assume that the developer has to understand many aspects of the
> > software and cache line contamination may be last but definitely not
> > least.
>
> Where could someone who doesn't know anything about cache line
> contamination learn more about it? (searching the web for that phrase
> doesn't turn up much)

Agree that I have written a rarely used term.

[1]: https://en.wikipedia.org/wiki/Cache_pollution

--=20
With Best Regards,
Andy Shevchenko

