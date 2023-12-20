Return-Path: <linux-kernel+bounces-6901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5068819F24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E42B2174D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8624B26;
	Wed, 20 Dec 2023 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dhxn1kBD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442C25550
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-466c7eae53bso21794137.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703075748; x=1703680548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5q57e0yI1dw2nfIkLVz7L+kM2nw1Ddm91mJrAmwHjE=;
        b=dhxn1kBDrX+hmPW3UKzfEKizBj0QPltSytVrrNvJU5MVSA83zb6waxKAIcK+DROwL8
         NS7Nevf6izB2BSiTnjbcJAnurKs9ezdFISh8lT+Jq94r58qKO86KAxDCtkZrE5rdPszn
         7gvnZ/V20jsEjSOvdUBdm3jt+Dw0n+pSQdSpvsSMwjesG5h4PDgZr3xWjjg0DofMzNvR
         l4MAg6ii9BxFKcV2MktfVGC/vFT+ro0Rx8kH5xqb+zAs3Il2gWIYrkj4eYttRghSp82n
         qn0+Dnzf50wgSvYy21YhkSxunctGf89wdy+qXGP/8DHIOyvXIJb0Mqh/Foc3kB2DcqKC
         leQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703075748; x=1703680548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5q57e0yI1dw2nfIkLVz7L+kM2nw1Ddm91mJrAmwHjE=;
        b=sDeNeW3q3XpjjN4+RxEy8cl7ZT0bdnZ7LMQU9+VNlBmcgvUIK2dTnvBo1Ce8yDhRfk
         NO2HfjSq+DyDrRDUWWm/62CX4kbZJvij0nnDcWfDKup8ninXiXoxWdS1S+ILNMHD/rh5
         8rmRnu4IEFhgGVvlJ0+DzpU6/beVQdX8YcX7DAtJ9/YYSVcnR5BHByjo7fWm5fAqgM97
         ZNwcu8a7UFGX/8LTERKlC1umKMgyeukdcyri7U5+r4bUK7eYDc5vc2Pkmu30E0GdUd3q
         8/L6ZtVTx3MP5BxO6WbUl/8sxKwUrHIER/kW9yCQ6Avm1Vd5IfnAoDZE8EjAtqMfaqbL
         FJvg==
X-Gm-Message-State: AOJu0YxESK36d0UXkQdi3od78KrpONOXpg3iFMcGogzH1vKLAxouHNPF
	2XwTBXZzxN0l/+Kn88l+4i3vqWS/jdVx6Ii0w5yWEKi9+0jpxQn4
X-Google-Smtp-Source: AGHT+IGTgI8+TbffUVpoa3RFSUatMapO3hg0Xf4GerUA7/+fM9d5IKIR4fIpSpkBR78ygqxi/+5GnKcKI8/AeAJ+WqY=
X-Received: by 2002:a05:6102:4b17:b0:466:9d92:786c with SMTP id
 ia23-20020a0561024b1700b004669d92786cmr3279485vsb.8.1703075748043; Wed, 20
 Dec 2023 04:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219125706.23284-1-brgl@bgdev.pl> <ZYGyumQXaM8PXzcz@smile.fi.intel.com>
 <CAMRc=McFsswSjCU5m+_wmmxQh+T1DkwnrBsYp_KsQfOSwENvLw@mail.gmail.com>
In-Reply-To: <CAMRc=McFsswSjCU5m+_wmmxQh+T1DkwnrBsYp_KsQfOSwENvLw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Dec 2023 13:35:37 +0100
Message-ID: <CAMRc=MesmR+=gMsk2y0Y7jiwtFpcHCofYsi3mxWFrdY9=1Y46A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: use __counted_by() for GPIO descriptors
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:16=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Dec 19, 2023 at 4:12=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Dec 19, 2023 at 01:57:06PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Pull the array of GPIO descriptors into struct gpio_device as a flexi=
ble
> > > array and use __counted_by() to control its size.
> >
> > How big is the struct gpio_device? Unifying like this might provoke sub=
tle
> > errors on very fragmented memory, where k*alloc() might not find enough=
 free
> > space. Note, k*alloc() guarantees finding only memory for a single page=
.
> > With PAGE_SIZE =3D 4k, this might be an issue.
> >
> > I would suggest, if nothing prevents us from switching, to use kvmalloc=
().
> >
>
> That's a good point but there's another thing. We need to call
> gpiochip_get_ngpios() before the allocation. I need to revisit this
> one.
>

It's trickier than I thought. We need the struct device to exist (have
its software node assigned) before we check the property but we cannot
allocate gdev (embedding struct device) + descs before we have read
it. Eh, maybe it's not worth it and let's keep the two allocations
separate.

Bart

> Bart
>
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >

