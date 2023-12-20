Return-Path: <linux-kernel+bounces-6553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C265819A48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3081C21052
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D944D19BB8;
	Wed, 20 Dec 2023 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="v8ILWJwy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE51DA33
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4b6c3a37ddeso675901e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703060188; x=1703664988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdtLFukSYKWmYynS80QImJw0tgI06bZ4ZKFg+X9Mqb0=;
        b=v8ILWJwyawDOgm4me8Su39pXdXkp44E9sP1g2CMQ6X+ZLaASBt/mL2N67iedsV/FRt
         ULyupbONBo18qIRFQ4mEiEk0rjBo0jiIDuK30pIYJml1QHLaeXGdl1HgCctHEPR+flou
         vyjQA4V+LVXdingX3rZF+pXxMRIzTG/mB2Mw8UBI3N4NaP106NuJkKqFV2t3R12Jr6vQ
         S0GEKRebRS9H+hJK9PtXUOr7gIxeVSNaLCwRGOuWr78Qpaa3tweGMyOgAanhOvS0fsPs
         5c9zpTkcQiMSujAhOPqUFVtw1R7Yc+OP/EdWTl6D9H3O5lY3z8M0z/yp8lRxIPqZtaT/
         +rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703060188; x=1703664988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdtLFukSYKWmYynS80QImJw0tgI06bZ4ZKFg+X9Mqb0=;
        b=uNQTMdJegWDXcrhJXKbzY0BQ+1GWwAGRIMaHvVayHbl3PNTKBe4huszrfvY3EaVt3h
         0DJ8+435SrD9lJfhzrR2WuzpaWnmTTJ1O1eXefvBbHOurhPfqMuuXrgvtEL8tqWvW0wh
         uM8jyGyx4J6jaSIAr215oeTecFwMpHWkDHJX7gUJqOsU3jFLpR6AqqOcVFgYytMAYDQU
         5CPlvv2rCdsUlejFMnbYJpuRYXiSA0sxORiPL2Wjoyx1L3m8a2iGVsWs0cL9wAeIxcQA
         pJsGXeE4TG+yaHmjZk2g9Yi/V3CF5khQpOoAZ03WGXoL4H1H/gmLmlRHwhNsl2R9vVdy
         UJbA==
X-Gm-Message-State: AOJu0Yz/ranwz9KJ8pscT3qKHC/7QT1x5hfzPat1tNiSz69+KEfemQRn
	Po0bzcrYZScjFvrJeisBiERFRqD8xTizdHOWRJwQ8BDdYDmcauDQP6A=
X-Google-Smtp-Source: AGHT+IGCs91iOMhB1HDLmGWTDjKTl15UCjrTXw6C5O4CXa5jbAXrbAj2/d7CTEm2KzCcEHnIkFVkyRvG/ZlUfSLTyI4=
X-Received: by 2002:ac5:cc49:0:b0:4b6:cdb7:9818 with SMTP id
 l9-20020ac5cc49000000b004b6cdb79818mr1809694vkm.8.1703060188540; Wed, 20 Dec
 2023 00:16:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219125706.23284-1-brgl@bgdev.pl> <ZYGyumQXaM8PXzcz@smile.fi.intel.com>
In-Reply-To: <ZYGyumQXaM8PXzcz@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Dec 2023 09:16:17 +0100
Message-ID: <CAMRc=McFsswSjCU5m+_wmmxQh+T1DkwnrBsYp_KsQfOSwENvLw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: use __counted_by() for GPIO descriptors
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Dec 19, 2023 at 01:57:06PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Pull the array of GPIO descriptors into struct gpio_device as a flexibl=
e
> > array and use __counted_by() to control its size.
>
> How big is the struct gpio_device? Unifying like this might provoke subtl=
e
> errors on very fragmented memory, where k*alloc() might not find enough f=
ree
> space. Note, k*alloc() guarantees finding only memory for a single page.
> With PAGE_SIZE =3D 4k, this might be an issue.
>
> I would suggest, if nothing prevents us from switching, to use kvmalloc()=
.
>

That's a good point but there's another thing. We need to call
gpiochip_get_ngpios() before the allocation. I need to revisit this
one.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

