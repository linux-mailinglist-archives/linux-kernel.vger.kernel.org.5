Return-Path: <linux-kernel+bounces-12070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4764081EF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82BA2B21C52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D614594F;
	Wed, 27 Dec 2023 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EahBy56N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F74503C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7cc705bbb2eso804882241.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703688984; x=1704293784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YEoCHZ5YbHKWMDCfzuh616S+odKG8LJIvRgl7M4Mpc=;
        b=EahBy56NXWYpZ1ckmIzoG/o1jdXD5OdHTium85oQX3Tnzwd7Wc7QobNdCR6sQrMjp3
         Dfi3+ruxxG4bXevWLn3GtzlV18HSPyR9yQFRxf3pvrpCmurI4ZN0aJy31ag2pFaCo3RN
         f24gypzaFyZ2QKTUcaO+62fyhmRafv3hPxXjy3hKoTz83D44VAqYHceBVzW38I5/TmY8
         jqWX+J+sjpFt19lhBbugH4bjfQ2lKgI9nAMPTNbLzHN/t5Zqd5k/KquINk6jYuJLiYkn
         DMy7NqGFIy4Iys7Ar9TZhXgPv+fnO9/j90rY/A3jFcumRLK+6qbgy9oIP3CaOmTOzNVa
         5rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688984; x=1704293784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YEoCHZ5YbHKWMDCfzuh616S+odKG8LJIvRgl7M4Mpc=;
        b=JEv+QqbHqGeyfpJ5G9kHr+bPbDjIS0E4ilFfU4UBxdSq9wvESe6S9A4i7uUZwzcHbD
         OAXE3FMTvD0zdPsTsginw63knuY0xfy5SodDchHYWvCYSZGX9cxhfh7A675XoHq2EmEN
         gC3sF7STeqSOGPsopZ6eOq+PJtun9pYMq+0T4n3HbldjVVOi+RcjPKopkdLLCLVsAKSg
         odtdpJ9G/7IWtMFZSyV6rs1hkfylu76NUC72exQl+s1dQ4L2tsK8l9bSRJ6gsPbxPXZP
         UI6UzMviCJuNLNi6kK3mn4TGAONNo+nYXXuGTElVSjAkOr0ATA7ZoVZarL9Cyd9gdZwc
         aasw==
X-Gm-Message-State: AOJu0Yw3IxBlFe5wudzGc3vfPtnVDJskKYB2SmoOXV5yFyNpCVK8qTMY
	pUSPQxIUalrTVf/6mGsmg9n4H6LVp5CXAZ14ZUIIx1OsgLZeIf5nn5eETjc2
X-Google-Smtp-Source: AGHT+IFcz+rDLLCzdlPqjZpbjdOKE4CieGG5btiUUNEuOnKlegsq5d8mCATauLXsrQPtHp3uNqfvzOwLyHtHfCLV1lE=
X-Received: by 2002:a05:6102:3581:b0:467:2fec:4ef0 with SMTP id
 h1-20020a056102358100b004672fec4ef0mr652257vsu.24.1703688984649; Wed, 27 Dec
 2023 06:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222141117.2887788-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231222141117.2887788-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Dec 2023 15:56:14 +0100
Message-ID: <CAMRc=McE=GSu1QLEmsUC08uxXZJ1YSeHYfQTsSQr2oyoWbRfHQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: tangier: Add missing file to the MAINTAINERS
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When gpio-tangier was split the new born headers had been missed
> in the MAINTAINERS. Add it there.
>
> Fixes: d2c19e89e03c ("gpio: tangier: Introduce Intel Tangier GPIO driver"=
)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e0e74681511..da022945e184 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10750,6 +10750,7 @@ F:      drivers/gpio/gpio-pch.c
>  F:     drivers/gpio/gpio-sch.c
>  F:     drivers/gpio/gpio-sodaville.c
>  F:     drivers/gpio/gpio-tangier.c
> +F:     drivers/gpio/gpio-tangier.h
>
>  INTEL GVT-g DRIVERS (Intel GPU Virtualization)
>  M:     Zhenyu Wang <zhenyuw@linux.intel.com>
> --
> 2.43.0.rc1.1.gbec44491f096
>

Applied, thanks!

Bart

