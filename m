Return-Path: <linux-kernel+bounces-3968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288DA817606
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CACB238A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE273496;
	Mon, 18 Dec 2023 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8tO9Q71"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B737348D;
	Mon, 18 Dec 2023 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso1164206b3a.2;
        Mon, 18 Dec 2023 07:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702914056; x=1703518856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fb3xViNCky7HL/E9H8gcMa197c94g0r+2fV811yw6SM=;
        b=G8tO9Q71dFhYDmSJ93FLJJ5pG5ZejhfJVtGHoy6TcTXHbNUhplFig3JzLXSDxaHvlC
         CU8+Sr94QFaKYUxJsJc/sLr43GpZW5SugAK0nF7MpBInDhG0zeIJT7tX9oFzmq37/1CS
         GGXW9wMzHA+Fbt6OWeXRUbrGhgemfrPayELm+uGxFYXKM4ZGENwj/KpPSuv1XUUgANmO
         3CCceUfPfwNeyucJ7QZ5qi1eoF1Xk1Amsc2KNvids7Q6l3hXmYDJKm7ra7F7AUVFvNZG
         EhaGAr0MTtWfSX08FyUZVEGrozZxDwRKM6dYnukUQaVOoHG9EHYop7A1SspQkzWtLqFi
         nloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914056; x=1703518856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb3xViNCky7HL/E9H8gcMa197c94g0r+2fV811yw6SM=;
        b=J9xJuBZdNcHaReOjYS5HU4xwP05QELZW2zsFZJi45d105/j3/981/oGNjiJnBB5/W+
         xUjhI7esGb7czsdiY3d6CNUOMIZ8+yGpbE7utX/Pq82weDeEzb2aLlTvRSoSFKgnZpvl
         NK2sUnZGgadlRT90ThxKb5/YRqiVQJivOEIyKw7pNyYpNuQXj5uc7f25rt9zZbsHJe0Z
         lohmnUj2Jf7ZuabT+kMMKS3XXmPWI4MlMkgnc/gKGw3Lp721e1bwb6GpHkWUq0ShxYlA
         fBr9z2OS4ViJFjXcaigM7N6hBmV3298NWSbJ3a6/mg5syz+1eIEGPXms31p6DcD2uaEl
         /E5Q==
X-Gm-Message-State: AOJu0Yy0eC0qizMC5C3YPT3H0oGHarhNjZH9kODaBbJ30PYYCHx0dqd/
	JTxoe/Lb7WTJQUKTQGSnF1A=
X-Google-Smtp-Source: AGHT+IGYIxS0lU5Kztj4lcstkl+IRTx8yCPAKAtucmPng8XS7d+le9tnfimdybDcvjWGm6uRePWsOQ==
X-Received: by 2002:a05:6a00:80de:b0:6d6:4c9:53f2 with SMTP id ei30-20020a056a0080de00b006d604c953f2mr2413715pfb.25.1702914056504;
        Mon, 18 Dec 2023 07:40:56 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id s5-20020a62e705000000b006d91c425eb7sm230242pfh.184.2023.12.18.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:56 -0800 (PST)
Date: Mon, 18 Dec 2023 23:40:51 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH v4 1/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZYBoA25z76uutBBI@rigel>
References: <20231216001652.56276-1-warthog618@gmail.com>
 <20231216001652.56276-2-warthog618@gmail.com>
 <CAMRc=McBVeQ=yRpGRsnPEULfPx15PBO3kiGscdS4s6-d0URc3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McBVeQ=yRpGRsnPEULfPx15PBO3kiGscdS4s6-d0URc3w@mail.gmail.com>

On Mon, Dec 18, 2023 at 04:24:50PM +0100, Bartosz Golaszewski wrote:
> On Sat, Dec 16, 2023 at 1:17 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > Store the debounce period for a requested line locally, rather than in
> > the debounce_period_us field in the gpiolib struct gpio_desc.
> >
> > Add a global tree of lines containing supplemental line information
> > to make the debounce period available to be reported by the
> > GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.
> >
> > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 154 ++++++++++++++++++++++++++++++------
> >  1 file changed, 132 insertions(+), 22 deletions(-)
> >
> > +static inline bool line_is_supplemental(struct line *line)
>
> Under v2 I suggested naming this line_has_suppinfo(). Any reason not
> to do it? I think it's more logical than saying "line is
> supplemental". The latter makes it seem as if certain line objects
> would "supplement" some third party with something. What this really
> checks is: does this line contain additional information.
>


My bad - responded to your first comment and then missed the rest.

Agreed - the naming could be better. Will fix for v5.

> > +{
> > +       return READ_ONCE(line->debounce_period_us);
> > +}
> > +
> > +static void line_set_debounce_period(struct line *line,
> > +                                    unsigned int debounce_period_us)
> > +{
> > +       bool was_suppl = line_is_supplemental(line);
> > +
> > +       WRITE_ONCE(line->debounce_period_us, debounce_period_us);
> > +
> > +       if (line_is_supplemental(line) == was_suppl)
> > +               return;
> > +
> > +       if (was_suppl)
> > +               supinfo_erase(line);
> > +       else
> > +               supinfo_insert(line);
>
> Could you add a comment here saying it's called with the config mutex
> taken as at first glance it looks racy but actually isn't?
>

Sure.  Though it is also covered by the gdev->sem you added, right?
So the config_mutex is now redundant?
Should I document it is covered by both?
Or drop the config_mutex entirely?

And you wanted some comments to explain the logic?
I thought this is a common "has it changed" pattern, and so didn't
require additional explanation, but I guess not as common as I thought.

Cheers,
Kent.

