Return-Path: <linux-kernel+bounces-32692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51527835EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B181C20845
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920139FEB;
	Mon, 22 Jan 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3V2X2tV"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CF3A1BB;
	Mon, 22 Jan 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917773; cv=none; b=U0UgtEVKmUwKsxI+SLwLhPdcwvAzvGBar1E2zzEyriHy3cuAVCFMo3vQp7f4y9mGu5scHrvtJOeEJidVG7czWF6hxi7DqXr+McKmYsQGXdLA1ODGqTMq1dc0GBA/wlfyk2PQYjRhzZSvY1rJPnwaKhDCZBNphgmdvY8Hg9iB9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917773; c=relaxed/simple;
	bh=yr5/pY5F3bbljYsjV3ZbgKqZ+6wIamtE7wbnetcG5Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSG8DH0lyXlvLDLgoM4DCumN7C7S/JZvBsy6hCqsIwyQW6RE/K4C/TnxYSZkX2yRX1LRaiKIPu/rLMKBD+n7b69Fw89j022MBr1q82dLBp3PdqkE/VnkAECV3b4rNHT8W5lVc20qspDysXa5CP4h0JbLjOmbiVOBFl0bPhZiwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3V2X2tV; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-595d24ad466so2047860eaf.0;
        Mon, 22 Jan 2024 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705917771; x=1706522571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=be1sWfrBuq3C8e6dZyHZX6I3ErBa0Gp9ywBnEmhOm9U=;
        b=M3V2X2tVuxfHOlKTkBiON6DNKsoDDkgKBCk/2kwxi9Yfqmz9PIrK1tZ58vSW5Lg/a2
         E6mECX4GWbNpqxUytGEMm1UHKQTijd5mU8rVDLKn/szYYNtUM90MocaFgBMbGMZHecXe
         bQAMXHutRXVvsSFV15fsuA7AyfIKSg6QL4maQa9UDzvCmX9qvhvH+nKqF/24DEVBZ0ew
         4ZQGQaKRRLZTMXB0fRmb5PzNbYzWDnx7QHajzwnZIeA57LZ0GBNxSf93PTrS2Vhz1Vac
         HeQgRIaWn0yrRi79S6ebEq7IaJwFFm8jVLdm+yxWbjEESa/MRXh6w6DL6zss/HEgkhr+
         lANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917771; x=1706522571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be1sWfrBuq3C8e6dZyHZX6I3ErBa0Gp9ywBnEmhOm9U=;
        b=PSEXBaHd2MZjx2n0jYj4y4STkGdzxXyKTa13MSo0ke1lWFyu7KAXeAExCKMP0YRYOY
         //9Uvte007ln5KZexkzfye5RpgJBVIDXD9MM44UHzzCJfclvn9rCL20cH+qXCvV5HGzQ
         hUIb0hvRsJEe3hyaOwNYDpUCbUPI0ytVzgOZxx8xjd2ED5EtGtxgRE/3koGg9HbdUxk9
         opSdQfONQym1yT69NMTTQ4CmGDQw4JdxQnw9nOTLZW0GE0/GpUB1DaWzArtWzwOTRYjD
         1YdWUSV8qb2AgxP+GIeEDHAcI/HwX2sG+Lm+h38sZSQoPk0s/sYXdzxNua4Xc0uzHUbN
         S+tA==
X-Gm-Message-State: AOJu0YyHXInAVpRwM379XZFqWyL6inxR0LnihfZt3hle55L+DBL6wrcb
	7K6+ys4LhJmuf5mgWIj2SVasccSYxRVOnRvFfBKTVi4JCT3g118qgfZ8VGf/SA9OfPW/a5Ai4VY
	Pd9j4dXBpbgj8XL7rjED2WUUSKMU=
X-Google-Smtp-Source: AGHT+IHsxnpL6bqH4oc5mbz/r2JMIxIACxNiDGOWEgDp4R44ux6kf/bRIqEdYEAIw2wJTa6XcPwsjyVngTCts6jd35I=
X-Received: by 2002:a05:6870:568d:b0:210:a7d4:44ef with SMTP id
 p13-20020a056870568d00b00210a7d444efmr4302089oao.110.1705917770894; Mon, 22
 Jan 2024 02:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109073849.10791-1-Wenhua.Lin@unisoc.com> <20240109073849.10791-3-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240109073849.10791-3-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 22 Jan 2024 18:02:14 +0800
Message-ID: <CAAfSe-uTZx9Be8NCWqyTXb7GDU73--N0VmRCeh24G_-5-yL5qw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] gpio: eic-sprd: Optimize the calculation method of
 eic number
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 15:39, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> The num_eics is a default value, but some SoCs support more than 8.
> In order to adapt to all projects, the total number of eics is
> automatically calculated through dts.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/gpio/gpio-eic-sprd.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 806b88d8dfb7..2dd0e46c42ad 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -108,7 +108,6 @@ static struct sprd_eic *to_sprd_eic(struct notifier_block *nb)
>
>  struct sprd_eic_variant_data {
>         enum sprd_eic_type type;
> -       u32 num_eics;
>  };
>
>  static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
> @@ -118,22 +117,18 @@ static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
>
>  static const struct sprd_eic_variant_data sc9860_eic_dbnc_data = {
>         .type = SPRD_EIC_DEBOUNCE,
> -       .num_eics = 8,
>  };
>
>  static const struct sprd_eic_variant_data sc9860_eic_latch_data = {
>         .type = SPRD_EIC_LATCH,
> -       .num_eics = 8,
>  };
>
>  static const struct sprd_eic_variant_data sc9860_eic_async_data = {
>         .type = SPRD_EIC_ASYNC,
> -       .num_eics = 8,
>  };
>
>  static const struct sprd_eic_variant_data sc9860_eic_sync_data = {
>         .type = SPRD_EIC_SYNC,
> -       .num_eics = 8,
>  };
>
>  static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd_eic,
> @@ -619,6 +614,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
>         struct gpio_irq_chip *irq;
>         struct sprd_eic *sprd_eic;
>         struct resource *res;
> +       u16 num_banks = 0;
>         int ret, i;
>
>         pdata = of_device_get_match_data(dev);
> @@ -652,10 +648,12 @@ static int sprd_eic_probe(struct platform_device *pdev)
>                 sprd_eic->base[i] = devm_ioremap_resource(dev, res);
>                 if (IS_ERR(sprd_eic->base[i]))
>                         return PTR_ERR(sprd_eic->base[i]);
> +
> +               num_banks++;
>         }
>
>         sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
> -       sprd_eic->chip.ngpio = pdata->num_eics;
> +       sprd_eic->chip.ngpio = num_banks * SPRD_EIC_PER_BANK_NR;
>         sprd_eic->chip.base = -1;
>         sprd_eic->chip.parent = dev;
>         sprd_eic->chip.direction_input = sprd_eic_direction_input;
> --
> 2.17.1
>

