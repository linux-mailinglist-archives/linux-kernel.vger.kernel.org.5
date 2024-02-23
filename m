Return-Path: <linux-kernel+bounces-77959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD9860D58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F42B2183F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1E1A731;
	Fri, 23 Feb 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hsc9L+4q"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D018E11
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678679; cv=none; b=h8//Wrn0huc+HzUCxh7xumt5YkkXwY/zHaH8AGO/xOymruu3ryuJHicCqNRBoWEqwtqGlwWGypW7PKB/5Tk6vKVm1Axv2D9KrhL0OC0vw4NeNs/2nYiNCO6sMeXqOFY0pRs6bzcYvYXONlQAGVgM7WJGGFE6mqT8n6JGX7S5N6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678679; c=relaxed/simple;
	bh=nlK5qHaZhiykL1gGFylKHCeTVd6rL0Q153oLIBBktCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJsYI7Wv42XRrdufnDKFo9zQn/pGCRFPvvIwlSTdZXpg5IpUlPNXxl13i6FIHElb8tUmYZPtbC1v3UbZfZI7a/6+sd5RxUtXpErhLkqG7DX9BVGOkqugQ7Hq8K6aXmXvdpyxNrObe9D7g6gISKRyVeD1Z/jYluWTovi89/Z3S4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hsc9L+4q; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46d60c75683so70877137.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708678677; x=1709283477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjhPEhBa12TItlvxQZxsnnjXxJoCDUZerm30n59NmwU=;
        b=hsc9L+4qeDS6W1HqxbjC7PeBfOfJt1ODkai83guOCktqMmL1LDOgoaLtMfyTRBkoWf
         xXQ1vbZ5r4/ojrbDZUCHa7J3Gy+qcXzl9mNM8XBfv2M3q9UlbVYvxD/lEto9KoVbVv24
         FIwrLb+gFmcdh4GhjU24KSzyCK/d/78lBA0Til/50FYmnEQnW0PvqL+ARiNWnkfZbbPK
         1+Dtb8u5s1cIgY8+n8W7Jn+RXGncrYfYOUoD1bXYgmkDhIQjCDPeZzvY7QwMe3gi1VSt
         GzKXdCIt79vNCMzhN/mZlSjzTjN227vvUasKylRDepNWUl3tKuO7y8P3gxGW1cuDG+zv
         QoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678677; x=1709283477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjhPEhBa12TItlvxQZxsnnjXxJoCDUZerm30n59NmwU=;
        b=tPNucMhZtAdLp2v4AkmoAh5Wze4G8jrW1yMQ1PzzzHgu1IrlwnS9wQXTD+ZTo6dvYQ
         b+kAeUZYpc53fblwZUy2UyHmL20CVrhpXmUijqdFfoI+eqv8Gb5ENyCN76PqxzNN0JmJ
         D1nG/TjKuqT+5gUVF7BSRD+eznHgSprLBwBjMma/rNrB1uYvJ1TSiFGzjl3VzvR+fsrt
         JqRGP9ZHoc9DNPXqUo2I1vzhu0K9UuSX9gOO+NkwZAh29bn7gOsAym3DIRBU/8uVp9Ct
         P9Fsc1IvdgzA5sgE34yhE2cvI2RjUK0+9LghQrRVI04gdPOjWieL3G98jN4UQ3sfRISz
         4h5w==
X-Forwarded-Encrypted: i=1; AJvYcCV/lalMS/mPm22PpsS7M6cFo/3SpQ9CHM4xsjub9icCgmxbwdNZjbJMZ/eQK1S4jTziEjjGqx63Aeqb7zTQM12mALTido0SmZe2wNCH
X-Gm-Message-State: AOJu0YxWLOD1z/tquBDhj9+v3m1fI0oIfUoZN2IRphrgZWc1mfNJg3dt
	/mYFFEfDVjjjE6NC3lTphKa5TugRvSXSP7yUTNhm7VBmo92PRQ9lpgK6bVjIaSpdgRG57FPIDS2
	tEX+wokNM7N+9wChKHx5c8N4zQDVzyssKPMYgJw==
X-Google-Smtp-Source: AGHT+IF5EtRLg2sHfJzKBquPxZdBzGX8N61QJTJeYEubsIh78w4hHntCP/VtMxzVtkyLbjkp9oBlqYwmlgEWyY3rL4I=
X-Received: by 2002:a05:6102:2910:b0:471:c4ad:4119 with SMTP id
 cz16-20020a056102291000b00471c4ad4119mr1380211vsb.8.1708678676895; Fri, 23
 Feb 2024 00:57:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220135431.22910-1-brgl@bgdev.pl>
In-Reply-To: <20240220135431.22910-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Feb 2024 09:57:46 +0100
Message-ID: <CAMRc=Me7h9fzTqu7hkfOOGdFz4dwcgcVOdLu+3KovX9nZk5U4A@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: delimit the fwnode name with a ":" when
 generating labels
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 2:54=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Typically, whenever a human-readable name is created for objects using
> a software node, its name is delimited with ":" as dashes are often used
> in other parts of the name. Make gpio-sim use the same pattern. This
> results in better looking default names:
>
>   gpio-sim.0:node0
>   gpio-sim.0:node1
>   gpio-sim.1:node0
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-sim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index c4106e37e6db..1f3dd95dd6da 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -420,7 +420,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *sw=
node, struct device *dev)
>
>         ret =3D fwnode_property_read_string(swnode, "gpio-sim,label", &la=
bel);
>         if (ret) {
> -               label =3D devm_kasprintf(dev, GFP_KERNEL, "%s-%pfwP",
> +               label =3D devm_kasprintf(dev, GFP_KERNEL, "%s:%pfwP",
>                                        dev_name(dev), swnode);
>                 if (!label)
>                         return -ENOMEM;
> @@ -833,7 +833,7 @@ static int gpio_sim_add_hogs(struct gpio_sim_device *=
dev)
>                                                           GFP_KERNEL);
>                         else
>                                 hog->chip_label =3D kasprintf(GFP_KERNEL,
> -                                                       "gpio-sim.%u-%pfw=
P",
> +                                                       "gpio-sim.%u:%pfw=
P",
>                                                         dev->id,
>                                                         bank->swnode);
>                         if (!hog->chip_label) {
> --
> 2.40.1
>

Patch applied.

Bart

