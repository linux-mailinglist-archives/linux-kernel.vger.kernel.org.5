Return-Path: <linux-kernel+bounces-76269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0585F4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22CEB27DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26568383B2;
	Thu, 22 Feb 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FJPXRCu4"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF72BD1C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595293; cv=none; b=eCF9xhucMP5c8p+l/EQ4KTEaKNDeR+2YI+MN4JJBxwsSx5bL9+/SsSM8l0d2q0/5amS5VI3/jVBHR559rduOBAQzcXOhnvIUSs9iv++4TdF1WLkNxRZH2sDTDe/vN28h1pZzYjFbgo7R0RRY9E9Ez8ReXf7X85/fHVsI9sgnbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595293; c=relaxed/simple;
	bh=KdLVtMfTnlKIPD435kUd78Yt/hs3Qy4l7+vhYzsGrCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otJ3UESeXiF9z2c2Yqb8/rbHqjEljJhpOH6RzwpLKdhwnbH5TJCGeAyg2FQnDCeDPwn6ShBmNIsEoFYGgpqYVht7+ZhBBivxJyC8ycE6YxIRF6MEC5k03rfnbnbcFbyTXt08Q5VbRDZD3Qi6jd6DjvXNEc88vKcSgtRj251pgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FJPXRCu4; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4caabc3f941so347217e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708595291; x=1709200091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1sHDjDZbmERo2RS8RmyCaFBbTsqNTq/w73JUWaGVMQ=;
        b=FJPXRCu4eULJL4PeHC34UrtOqlr0BCcSIJ/1uWwEQDUx5oGOL+MJ2KO+WHTwjLVZE9
         srbwdIANqq18sGufqklzSZSxBtAChQYgnuM/omA65azFp7+PPyDMajih6ZlQS/ciL+sT
         W/dDGn3HMiTQUYJCh6BzbwYD2xxQmvUY3vMwESf38v8j4bAykk7L1nQvJvOGqENs2Zs1
         U+gN+7uPfK8WjZdK2rQgY9SYOO9iDDWmFLF/l54yRbAvQvxUhHuuCzae9/vaf8Wkm68b
         vvRrB1awYegfgJHl5xhz0biMVDmSCn8qE+jWNp/wGFlPYwuZhF0nn1Z8avVsvBAULvbi
         hJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708595291; x=1709200091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1sHDjDZbmERo2RS8RmyCaFBbTsqNTq/w73JUWaGVMQ=;
        b=j3fnsJKhfgbfDiB49FD2HBwd5DepoFtNjFURztvKMddvmkkedCN2vCuarXkwHWR21h
         OyRWCaW98hJfV39uv7KD12tYKyNQ1mwiMNBIv82sRENhC334Aebh0Wq/s6dtGFBMkMAp
         oI37e32iUh2QIHPYHMVRSUDh3IRBYKZQLNurHguNoyC5SlEvX8VlvvGz0v6nGOgfOKiW
         EI/JAPHxkfzKuZhLpxWQ1gJXEJ6enUsit4UUQPFapFvDdyiMjcwFLyH2aImL7Acj/OcC
         e5fep+f7VPex8xvv4NumbfsBvp5DZG1axkSR49t3NbwsJjaIUaGwKQwAMVdy6G0Cqi59
         v76Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY4Em8wgxKSo5ellUGRAGaTfk5cxs7AxxbP7TW0Gj5qCvXNUHN/FHjbIkq0TvsOCyawzfeLVzPyXjP+Ow5GYOVJ28zfsLjsHEB3xYd
X-Gm-Message-State: AOJu0Yxqyu5ofS0UUGUHjpsxVcoeBS9vVXoa+Up3kUnFWBGuJBImG+35
	oG9JPhT5YFY3FSYN2k4YEEpPM4DAM41V2FzV+LEiHFaJ652kCgrFcrzI01TBwZ7gi2+mkXTPRNu
	C0qU1jbkDPr+IOzhEXqlmeAmMu+PfIzVkLGnFBw==
X-Google-Smtp-Source: AGHT+IFobjGrZnBdQYsBCX4YThs8/aguXzw16fqmoI9KgEewHdGjOBEBTH3H1gmzti+iCsQGiVyrLOJ1girSQrOaBOw=
X-Received: by 2002:a1f:ed02:0:b0:4c8:a2c6:c2be with SMTP id
 l2-20020a1fed02000000b004c8a2c6c2bemr1561844vkh.8.1708595290726; Thu, 22 Feb
 2024 01:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 10:48:00 +0100
Message-ID: <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in gpiochip_add_data_with_key()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no need to repeat for-loop twice in the error path in
> gpiochip_add_data_with_key(). Deduplicate it. While at it,
> rename loop variable to be more specific and avoid ambguity.
>
> It also properly unwinds the SRCU, i.e. in reversed order of allocating.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

This doesn't apply on top of gpio/for-next, I think it depends on one
of your earlier patches?

>  drivers/gpio/gpiolib.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 1706edb3ee3f..60fa7816c799 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -861,7 +861,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, =
void *data,
>                                struct lock_class_key *request_key)
>  {
>         struct gpio_device *gdev;
> -       unsigned int i, j;
> +       unsigned int desc_index;
>         int base =3D 0;
>         int ret =3D 0;
>
> @@ -965,8 +965,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, =
void *data,
>                 }
>         }
>
> -       for (i =3D 0; i < gc->ngpio; i++)
> -               gdev->descs[i].gdev =3D gdev;
> +       for (desc_index =3D 0; desc_index < gc->ngpio; desc_index++)
> +               gdev->descs[desc_index].gdev =3D gdev;
>
>         BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
>         BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
> @@ -992,19 +992,16 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc=
, void *data,
>         if (ret)
>                 goto err_cleanup_gdev_srcu;
>
> -       for (i =3D 0; i < gc->ngpio; i++) {
> -               struct gpio_desc *desc =3D &gdev->descs[i];
> +       for (desc_index =3D 0; desc_index < gc->ngpio; desc_index++) {
> +               struct gpio_desc *desc =3D &gdev->descs[desc_index];
>
>                 ret =3D init_srcu_struct(&desc->srcu);
> -               if (ret) {
> -                       for (j =3D 0; j < i; j++)
> -                               cleanup_srcu_struct(&gdev->descs[j].srcu)=
;
> -                       goto err_free_gpiochip_mask;
> -               }
> +               if (ret)
> +                       goto err_cleanup_desc_srcu;
>
> -               if (gc->get_direction && gpiochip_line_is_valid(gc, i)) {
> +               if (gc->get_direction && gpiochip_line_is_valid(gc, desc_=
index)) {
>                         assign_bit(FLAG_IS_OUT,
> -                                  &desc->flags, !gc->get_direction(gc, i=
));
> +                                  &desc->flags, !gc->get_direction(gc, d=
esc_index));
>                 } else {
>                         assign_bit(FLAG_IS_OUT,
>                                    &desc->flags, !gc->direction_input);
> @@ -1061,9 +1058,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc=
, void *data,
>         gpiochip_free_hogs(gc);
>         of_gpiochip_remove(gc);
>  err_cleanup_desc_srcu:
> -       for (i =3D 0; i < gdev->ngpio; i++)
> -               cleanup_srcu_struct(&gdev->descs[i].srcu);
> -err_free_gpiochip_mask:
> +       while (desc_index--)

What about gdev->descs[0]?

> +               cleanup_srcu_struct(&gdev->descs[desc_index].srcu);
>         gpiochip_free_valid_mask(gc);
>  err_cleanup_gdev_srcu:
>         cleanup_srcu_struct(&gdev->srcu);
> --
> 2.43.0.rc1.1.gbec44491f096
>

Bart

