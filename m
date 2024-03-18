Return-Path: <linux-kernel+bounces-106232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515487EB12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E71B21438
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE694D9EC;
	Mon, 18 Mar 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="db2NYrPT"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0971E48A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772440; cv=none; b=nXrEhzdInztjXvBB/j5dDCjrL7OkOaWrl6M+nCVUtO1R5xHXL2lr3U3o1C5AZDH2DFfV9tDqbp7p1q+fEmpdrU+bp/LpqdoTsrB3dGOHf2iFr9n4GbAf6dDehm0NtAk3K8xGZo9hEQuGfuGRHTxaOl7p7zu72P8Y35B/Cc56sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772440; c=relaxed/simple;
	bh=xao/3Agt8d0aMQsQF76L52RUQniX+Db+2a0FVq7MwNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hgw/s9s+yKoBprr2YQfInwNkflYNVr7y+CpypyogDyb5jrv4RI8jlYo/PUfZhDaggzwZxSNO/lekKQ7HXtwd0a1dYEOmUQxYXAEvrtSHT4F2ESSWDvc/OCvmppDIsQnNFu+U/vgub+sp6iESlNVzhCMHsTp71gf8yJrPojsjHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=db2NYrPT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d49f7e5d65so17277491fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710772436; x=1711377236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4WaCaBlDXQSpdiGfF0kKoiM9uc9CEyeM3Masdlw3TM=;
        b=db2NYrPT6vBBo4qUH4Jsm6SkMjNTfVZv1yjGf4MBTXQtUj1fW/ogzlIkweaXEOpa3U
         zIo/tSMcHaeLn64uZji0Y9jsuuZmazrFEcHtOUhJ89kLI+1UNMOS8N90Cdn+j7n+NC6g
         roUCJWs9csgXQVSAkserurBzux8b+CFjW4/o4k8VVwAm2Rwz+tXvmfYug0eWNkdJtup2
         SDlz2g65cJyiS6Ek1elyU8DKRLF2X1BgJoFZCAclvODAzkrwEX7h7dznb3rPC22bVxJ3
         S9s+QzroF6v3mQrDiA2R+UqbzWKPSRC0L9C0BRNJQHexwScKiPCwbLO6GXpheVLoRPNP
         Bo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772436; x=1711377236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4WaCaBlDXQSpdiGfF0kKoiM9uc9CEyeM3Masdlw3TM=;
        b=pZdjhHMwRrdM0Y17obhXh4PzRgDtRJYUBGBeIkjts79MFQc16aHEOCg013IATmngsO
         X8//R0KaGwm7RICxyxW3tJCuxfD7RuH/rA+oYMD6QVlGCVuIXtWRCLK2+HmtWD1UCalZ
         KFpr4ffOGl6xi4zgQikFL/1eTJRybjU2WV2sIF3K2fDC3BKdx31TvjkzBRm+IrNoFFZ7
         QK+TxNgjGi+kMCvKc6lFJQDJr+W43Jf3K7G0N4VOe4kVKKW3pJvqTiv7qX20/oE8h6zy
         gXvzZ8N9veQtz/wrK7iCGncj9b2wIpT7zfG1xoUAAtUcYhN7HVwG1cStsZc47fH+ypkq
         pWew==
X-Forwarded-Encrypted: i=1; AJvYcCWBq6khmRuVBGVh0sKTQKdLl4XTce49HWnyrOyKLBTnwjcANWsgGUQdtbSNLZw5J58zA/VHsKq0TH6M2ecb/cn5sIqaT44jbF9gHGaR
X-Gm-Message-State: AOJu0YxxvTFvFPXVHX4itk3eIBXRAHHd+yxRdGhfDkRVqzpHpgtCgPIl
	ZnBEychPP3viJBYZ5HMnd+iygSdxMVDSGCD0eMiBrBAZdH/6eeDVYpNaMiZtBHvaJK3HGhTmx6d
	q4yvZVWz/m4B8/FCSoODPj6ZcQIUpzR6rMjN+t6j31QHwkQks
X-Google-Smtp-Source: AGHT+IFYqFauIdiQUhBeV7HdqEk2qoQv5DhzmAjuX7YyvWGQXxPhKZpq8JA4xFhOiWXi0t4+DCL+1Y3+sNE6dIyiAzg=
X-Received: by 2002:a2e:2283:0:b0:2d4:71b9:4e3 with SMTP id
 i125-20020a2e2283000000b002d471b904e3mr8144991lji.51.1710772435773; Mon, 18
 Mar 2024 07:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
 <ZfX5jynjW4M9pvw1@surfacebook.localdomain> <CAMknhBGMUQFoQ9TxTTgy0dxHoyXkt+5tS93tpwz5Wo=h1UQD3Q@mail.gmail.com>
 <CAHp75VcP7sZKgoXzgTihf96rc5rz=U0Amoardj1Sy9uTMDHknA@mail.gmail.com>
In-Reply-To: <CAHp75VcP7sZKgoXzgTihf96rc5rz=U0Amoardj1Sy9uTMDHknA@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 18 Mar 2024 09:33:44 -0500
Message-ID: <CAMknhBFNnePpn5j=f-RXJCw11=4TTORhG0mt+FqazLQwvHBtPQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 3:23=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Mar 17, 2024 at 1:10=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> > On Sat, Mar 16, 2024 at 2:57=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > Thu, Mar 14, 2024 at 12:43:38PM -0500, David Lechner kirjoitti:
>

..

> > > > +     case AD7944_SPI_MODE_SINGLE:
> > > > +             ret =3D ad7944_3wire_cs_mode_conversion(adc, &indio_d=
ev->channels[0]);
> > > > +             if (ret)
> > > > +                     goto out;
> > > > +
> > > > +             break;
> > > > +     default:
> > > > +             /* not supported */
> > >
> > > No error code set?
> >
> > This is in an interrupt handler, so I didn't think there was anything
> > we can do with an error.
>
> return IRQ_NONE?
>

Wouldn't this just cause the interrupt handler to trigger again
immediately resulting in very high CPU load? I don't see any other IIO
ADC drivers using the generic triggered buffer returning anything
other than IRQ_HANDLED and I always assumed this was the reason.

