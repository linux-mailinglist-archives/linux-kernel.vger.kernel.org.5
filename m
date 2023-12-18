Return-Path: <linux-kernel+bounces-3191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904708168D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D50282F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6627E10977;
	Mon, 18 Dec 2023 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JXjl4cAI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875861118B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7cb36c458dcso456557241.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702889693; x=1703494493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zcy4Qs/F8NZOKre+BKtAjIT9nwGwO4y66Sp2H2m3iBE=;
        b=JXjl4cAI7nN7/IRj2h72po246CciLmd0O0YvatKql4XtkV3BaE0zkW3X4XZu/XCqqJ
         XuFa7+Q7HQfVuVgoz2DJVVYEDZKidvhUBFJcv1jd8+cmy9+vRJPO2BJ82kWKHh4Bwvvf
         7EU1yE5JcENhWdbvM5E31PJ1PkB2kUbJwi3jnu6jLEKnzDrh6hChOAc/OXSXWoSkoJkR
         ggpqkKxuyn9EWuYyKkGg3kFyqjYzyGhTGRft40pmc1Z/AlLvdwmm7D831Ug5p3onO5St
         33ISEjkTWQDd9dfUDR8jNJddColoHgk5jIWYxEjFVP54+SACOzUulIjkDZUaFLO6rJ7V
         kkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702889693; x=1703494493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zcy4Qs/F8NZOKre+BKtAjIT9nwGwO4y66Sp2H2m3iBE=;
        b=RhBqotPXOttUnNic9vZkblsZf37iN98yB0VV+RHv2XvwJd/t94mk00GMYZ+pF7GD67
         tNzfyIy32Wk21Z32cyHLeq8w7e0Ay7H6s+EUgTQwcN7M5u0ufaVaypT7o+9/OQNFl5Ht
         qAi59agj/rCcgxHAaAp20goyX7PXjwbSSdTXCz5ayYSfzgcfEp2Th24TPRQsVz2i24/R
         8v7Hmeppa0B/yLPP3yfT2vAlZ8RvDlVpiWphuONYOOJC6IzyQ/fex9wpWPb++Oh3KqCW
         dOfLoIGoaciMjpFNNO9d/Ll6y52A5atlwC6hlNdRqugQDs0WT0eWLIDye0ueV+lnv6tO
         piUw==
X-Gm-Message-State: AOJu0Yx1x78Kkp+lh5/o9jNOINllZHyOyDjwvFTIxpB/M0embhv+soO8
	GG2SO8g1NwdoI8mn5MN1HahgKUybIvsnmwYCh0nqzA==
X-Google-Smtp-Source: AGHT+IEd+o68wmUpyG+J7UjiDt2djCJTwff101JpGUud0EelGzhHfUSZ4qLWXzX9dq0fpdbr60RDEy8NiE6oVOuO4cc=
X-Received: by 2002:a05:6102:3d10:b0:466:9d70:6f03 with SMTP id
 i16-20020a0561023d1000b004669d706f03mr250157vsv.14.1702889693302; Mon, 18 Dec
 2023 00:54:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312181513+0800-wangjinchao@xfusion.com>
In-Reply-To: <202312181513+0800-wangjinchao@xfusion.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 09:54:42 +0100
Message-ID: <CAMRc=Me+wQroZhnVhwvdfFeOhFQ+1ACr1cLu2Pu8TQDpvyKpOA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: cleanup for duplicated including
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stone.xulei@xfusion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 8:16=E2=80=AFAM Wang Jinchao <wangjinchao@xfusion.c=
om> wrote:
>
> Remove second `#include <linux/err.h>`.
> Remove `#include <asm/errno.h>`.
> As they are guaranteed by the global `err.h`.
>
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
> V2:
>     Revise the comment per Andy's suggestion.
> V1: https://lore.kernel.org/all/202312151645+0800-wangjinchao@xfusion.com=
/
>
>  include/linux/gpio/driver.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 0aed62f0c633..df6857e579a1 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -701,7 +701,6 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
>  #else
>
>  #include <asm/bug.h>
> -#include <asm/errno.h>
>
>  static inline int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
>                                               struct irq_domain *domain)
> @@ -789,8 +788,6 @@ int gpio_device_get_base(struct gpio_device *gdev);
>
>  #else /* CONFIG_GPIOLIB */
>
> -#include <linux/err.h>
> -
>  #include <asm/bug.h>
>
>  static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *de=
sc)
> --
> 2.40.0
>

Applied, thanks!

Bart

