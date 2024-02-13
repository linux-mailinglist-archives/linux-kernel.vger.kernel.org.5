Return-Path: <linux-kernel+bounces-63780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91285344F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41FD1F21BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315805DF02;
	Tue, 13 Feb 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wqDTEDyU"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA535FDD5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836766; cv=none; b=trIgYlIy6OCaZn9DMb8PMs1KxiECTkrZasUfab46DTC1yEPBjVLMQFp1Q+zAinzgjdiipECUsgKtgxnDpUa4d+IAfytMgnd5rccSmD0of6h02aDWq25GvMApbvy0E9BB1IinF9RZRVXoZFLQ43ixQej23bKJq76lf6juLBgXkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836766; c=relaxed/simple;
	bh=fbF1PvlbWN3zD8U5fpR4FOV0dObiDAn6q6ytupi4qzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2J7bd87VV3ZBaRyTm+oEJNiO77ZYBibCzBJXjCi4Xr3GCaPmq8LN9XIHwBr1Bg+ipWE8lyY1HP4HDRqgYSZ+Ocwl6S978SMUkSDNghBrWf+Ya8l1VVnQQwdEjA8AhrV+lmY+IiU+F3Mw8W1lvNpV6ut+6sytdXs2fpSlJojmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wqDTEDyU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2dfa17547so1320954a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707836763; x=1708441563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ApEu/3sIgnPz+WuXL0PiSYq9FhzP3cQXV7R+bXp+jI=;
        b=wqDTEDyUE8oCDpS6e5+TBDLrtgBN7jsZ9kFRfNkHAzBtH7xqiHe5PaenGn2rbyCU/b
         //v0HkoAESaUHEEv6a2dODbdHquEkm5CPwQSuF0qS6agB+SNMtfhcV1rsyEthHnD0gTW
         14+KoeG7zuEXpkwQCkrnuEolK5qaIYgFX1LRjSbIesVs+gTvbBDKWkizZb/qaD0ZT96z
         XjK6/roKG7/kQnnWzbrB/jSbBACBSzJ8m0iya7FL08fSSk0kdLXC7/tTPpGZeYTey2d9
         es5LAesrwWZ4cHe9znrD5Iw8XTnXIeLanGSsQ2ET1ySNPsJp63Wj6YqgCDDE9Z4VfObV
         SY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836763; x=1708441563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ApEu/3sIgnPz+WuXL0PiSYq9FhzP3cQXV7R+bXp+jI=;
        b=fatDvLTEhd5E8gQSQKjRjl6HkBCOykzsAOtpObgl4jXuh2BUnID9w4GkmTS8LX+TrS
         yP1HZr3cFGZABkLDKKwhRcoy2mEYcIHcmqqLmNbxKIHJeopsobPp/o5EoO3xskuLXZ7x
         ON8iaeLzup+ueZCPILal0JJbN99SpNBCPEi1JOFGdBl8HsQZZDItxH4I52elReigg4J0
         RollA9xtI12owGcyV1gZwvsOXaEZ59iyQnuC3SRwIaSduFfFI5mztuagpzOZ6bJHupRz
         rsLr4kDChLWsruy7pKh7jmDXpAU1B2zebBz0u/G0fl8l1Q3p4fH/Wemlux+BHIrXwXDz
         31vQ==
X-Gm-Message-State: AOJu0YxxIDVrez2oPlpOU9MMCwuT+vorMgbTOTevFPzZnrIidikfdkft
	8CRDaPfbdSm3zW6n7AaYY4SA1U5af8UoraDFMyBsj+AL7T4+OExWGXja6lw3UfCaoV3pN4Dztt2
	HlngRSWRd27bMf47cqFCCP9lGqCZqiY+443lO4w==
X-Google-Smtp-Source: AGHT+IH++eu0yEteTnpJEBWZLuftuwuAi2WUJWHv6bizQcozGEbb7E3tLosD5iBoAdkxx8BtnXc5qmaF7ZVKdEk+5DA=
X-Received: by 2002:a05:6871:80f:b0:218:55c9:bb20 with SMTP id
 q15-20020a056871080f00b0021855c9bb20mr11649920oap.21.1707836762423; Tue, 13
 Feb 2024 07:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213920.49796-1-brgl@bgdev.pl> <Zct_7YcJk5-sg2pT@smile.fi.intel.com>
In-Reply-To: <Zct_7YcJk5-sg2pT@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 13 Feb 2024 16:05:51 +0100
Message-ID: <CAMRc=Md40TPhTq7jwWQz8HmCJEZc4ixmjqhVjbcNzo1e6zwHNg@mail.gmail.com>
Subject: Re: [PATCH] gpio: initialize descriptor SRCU structure before adding
 OF-based chips
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 12, 2024 at 10:39:20PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > In certain situations we may end up taking the GPIO descriptor SRCU rea=
d
> > lock in of_gpiochip_add() before the SRCU struct is initialized. Move
> > the initialization before the call to of_gpiochip_add().
>
> ...
>
> This is a bit unclear why you moved to that place and how it had been tes=
ted.
>

I didn't move it, I just added SRCU before it. It can be triggered by
a simple hog from DT. The link leads to a crash report.

> > @@ -991,10 +991,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *g=
c, void *data,
> >       if (ret)
> >               goto err_cleanup_gdev_srcu;
> >
> > -     ret =3D of_gpiochip_add(gc);
> > -     if (ret)
> > -             goto err_free_gpiochip_mask;
> > -
> >       for (i =3D 0; i < gc->ngpio; i++) {
> >               struct gpio_desc *desc =3D &gdev->descs[i];
> >
>
> >               if (ret) {
> >                       for (j =3D 0; j < i; j++)
> >                               cleanup_srcu_struct(&gdev->descs[j].srcu)=
;
> > -                     goto err_remove_of_chip;
> > +                     goto err_free_gpiochip_mask;
> >               }
> >
> >               if (gc->get_direction && gpiochip_line_is_valid(gc, i)) {
>
> >               }
> >       }
> >
> > -     ret =3D gpiochip_add_pin_ranges(gc);
> > +     ret =3D of_gpiochip_add(gc);
> >       if (ret)
> >               goto err_cleanup_desc_srcu;
> >
> > +     ret =3D gpiochip_add_pin_ranges(gc);
> > +     if (ret)
> > +             goto err_remove_of_chip;
> > +
> >       acpi_gpiochip_add(gc);
>
> My logic tells me that if you need to call gpiochip_add_pin_ranges() befo=
re
> calling of_gpiochip_add(). It won't collide right now, but allows to clea=
nup
> further (with the gpio-ranges parser be generalized for fwnodes and be mo=
ved
> to gpiolib.c from gpiolib-of.c).
>

But it was already called before gpiochip_add_pin_ranges() so it's
material for another patch.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

