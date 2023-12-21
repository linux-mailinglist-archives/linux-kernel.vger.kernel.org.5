Return-Path: <linux-kernel+bounces-8417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55EB81B6D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A8AB2660D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964676DC1;
	Thu, 21 Dec 2023 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cSoyIyKs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB27318D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7cbdd011627so242823241.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703163546; x=1703768346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+rIonLAPWX8k6/DJ2PlKj7AAvhFNZVDSfcroSDgk3M=;
        b=cSoyIyKsMiVeFqvHZ/S/UHZlOv/ZXXqpg9eOiO9hcABGEzs5I81gkQKThFR3kgRYVo
         Egwz9EP7VTx5tvCpwNenajm+AE2rOVW4hhvAeVnxJtS/Z91tKolgkpyRUn8tMOtRXKK+
         mZi+sYT2taxrYYgYHv8ZfEAB7QGXvrgJmVgb/mcaM6eJ6iaw0olC5BEsMH5orT7CE8up
         LO6fjCqRl+fbrrsmNUM7L6LodenJszu1QwRnbv9gwcd4CwQs4noraShSx0hgc3TYPQcu
         QudKk/EmDPqm368YCJhQh+qE5Q5Q2veMvNM0Nya3EiapAZlnz/dJFTdcwb5KIuAD3KF9
         4y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163546; x=1703768346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+rIonLAPWX8k6/DJ2PlKj7AAvhFNZVDSfcroSDgk3M=;
        b=J0Chx24kw1lLwidss8A6Cb3aJXJaG+7I3pqB/Pu0ZlgcwZtt4n1BL0yOM4DZNM6IfJ
         ugp4Sr7d0iUEWvKOAbxfqRpxjZrJeO4tn6y2XCO/KOQLqT7Dy5pHi0GkyyW/nVq5NNW/
         w8b9glSu/s1FmsJK7TIkN93I3jTC6YP0UYreiGeMAv3z3H2I2LTjv2GPc8oymKS1eoTb
         UogLSCf27QPMuW8L5zi0sJfTw4QbXQtH4MlzqbFVrphETUoPfA6PVW3JezzQRi9beO7S
         XD1RAKnNr0+9hdVwGhmzEKdsTX5sbLHeK2eveaMjH+CtOvQq/blZoFYr6v9LFQbn7pl/
         gdQA==
X-Gm-Message-State: AOJu0YzZJpyROWX7EkmDboAnojPoEV/DoRarSmGaWRKu1ZwPEdhdQ5g6
	AVsDWDnn81B9pMpBkcD4A66m6bGTrJ08LnpV6OTCvQ==
X-Google-Smtp-Source: AGHT+IFUqqzHjmQvwYRqEIFAvklKHzwEfjzRE7ccVbVyT7d6Pc4DAZTRQVc1K7cWr/KAv8sTOXibR2GtGrR38VWuh88=
X-Received: by 2002:a05:6102:3d8d:b0:466:afed:f2d6 with SMTP id
 h13-20020a0561023d8d00b00466afedf2d6mr987307vsv.30.1703163546268; Thu, 21 Dec
 2023 04:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221091547.57352-1-brgl@bgdev.pl> <20231221091547.57352-2-brgl@bgdev.pl>
 <ZYQ1a_nQZ1GWg3gg@smile.fi.intel.com>
In-Reply-To: <ZYQ1a_nQZ1GWg3gg@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 21 Dec 2023 13:58:55 +0100
Message-ID: <CAMRc=MexKOET=WJOARSF=SPkvDYL2cw-svQZ1EiZ5MV7QC98VA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: sysfs: drop tabs from local variable declarations
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 21, 2023 at 10:15:47AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Older code has an annoying habit of putting tabs between the type and t=
he
> > name of the variable. This doesn't really add to readability and newer
> > code doesn't do it so make the entire file consistent.
>
> ...
>
> > +     long gpio;
> > +     struct gpio_desc *desc;
> > +     int status;
>
> Not fully reversed xmas tree order...
>

God dammit! :)

I'll fix this one when applying.

Bart

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

