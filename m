Return-Path: <linux-kernel+bounces-66371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F1855BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617E21C21F24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D68DF71;
	Thu, 15 Feb 2024 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="V7+8B+sz"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7E3C17
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982977; cv=none; b=tv7yxafUQNmT4keYQG/Qb5HNjTmcawOLzlWhZhfbBRylKDTvuBNNl5gtnhZGtv7fJPDoew22sbK5SFavBlY+G607pVWDC1qZzQoXSrsS14LGIieQQd6J0vMiVEG9IrKPKFxFlscSx2UMRTzQTfNxppEgX/e0GgvaobZ9sVTSQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982977; c=relaxed/simple;
	bh=7ATovh8Zrf+AwZ4JzRRGlxF09Y1ihfaCoTBUGRElC5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQretYk1OwDmXHo0JOak4IeCNmd6xFFJzoYX0OklZLQsrx465EV+69OS9xHht70Wn1nZ0S9PGSCTIqwHN3JncdtweJv7TXM6REZnZMjl4jVz4sVXoDsmVeM/YTlhR08LklZHO4Ec5f8lrnhAPogy6KU5M9vCx9Ubkqs9V2JE0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=V7+8B+sz; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4c03beb85f4so184491e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707982974; x=1708587774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3gVXOoEIsBekobrNYILlo8Y5CWblU12NL0RUb1vlGw=;
        b=V7+8B+szq5a/CqDzoO2AESzjfnYpBoOnGWJXiEhPfZDVQ0gs8YdIo7xmEJDI7KQCcf
         jeKlbM86BkFXbs7mdzCJFsujQ7HuwCYPitRDl37ztiFc6+0rMfw1GBU71nQKaTKPUl6y
         PdgadwkS+znM89ZhZIwWeLdWSi5lyxAWeP40bSd6vNKf8tK/g6JjVNz0Th0hjA/PUKxR
         qz+Oc8Lo3fkmyNMI+2YZGPg0pqK27qV6Lflgl+cpdQL/6qz7ZQzTJEp+0LpZnnv3o+oi
         4llbRVGX6n8CjA2z125QRi8G93NYnSSkSF7z3d7kW2kNuQ75LM20D2POI696MkqLREVj
         ET1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707982974; x=1708587774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3gVXOoEIsBekobrNYILlo8Y5CWblU12NL0RUb1vlGw=;
        b=IOWPYccOBCIcsbq9x1eehOcUpyWxdkxH3yiuoKrmzx6gzX1qSJr7ah/sHFEOzAs1Lj
         OitYyAELd/MCkhKIaZlV6RM/EbmXNDZMgENBjJIoyDiMyu8oKCyTh1I3NGUl4A8v6iNQ
         95ItnN+oqSmHwV1K5g6HTNgBJIRK5U9xpvUwhy2YsPl9dha+rFznvB1Q92+SU32RvORH
         x7AdKTDStCRceOf00qWOOo6ggajze0solA3z/a/aZPQN+Zy5ekUjhrQNa5UxAJrbcGCv
         VkiQ81vfYdB+5zS7KLMvzbnMOP5K6y0ElkD7ZuqWta07DRAt0xwyDNVgMwvZn+MXr340
         c0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsEoXPjtaorBjxvJfh9OXwj+a2seVhuP5SaO1f1fc99fg9uzvnBUrpYCyVm0BXsViLVtprPzHqoWE/6PUwtHHl0V5BzQqAH70n2u6y
X-Gm-Message-State: AOJu0YzYIl7Dy2mkrcDFyO/34zhmvs13Iqa2JwOUYOywchUYSAIVzK37
	Qf/3xPOGpfH1yMnX+UPn1xUKYMK1z6GIM/sWl5e9o7X6T0w3nPr6CXI5Y1oTft9Ib5BTmaVFV+I
	Z1IqftNcsDTkmbLv2NITJZQ8XhNSxjI+YKzaUzw==
X-Google-Smtp-Source: AGHT+IFAlRhKqIPfjRV7uMjuMrLjenZLw85BDQYZzQiiiKcQEWhjQrfyP3Pz1uxk1YHe2aHokf1HB+xX/1qJrqagbxA=
X-Received: by 2002:a1f:dd02:0:b0:4c0:1937:d29d with SMTP id
 u2-20020a1fdd02000000b004c01937d29dmr910895vkg.6.1707982974572; Wed, 14 Feb
 2024 23:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214085248.6534-1-brgl@bgdev.pl>
In-Reply-To: <20240214085248.6534-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 15 Feb 2024 08:42:43 +0100
Message-ID: <CAMRc=Mcn_vGBy0h6ZmiD922JUYRuXDSPSn19Wk5RRyFrU+31Fw@mail.gmail.com>
Subject: Re: [PATCH] gpio: sysfs: fix inverted pointer logic
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:52=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The logic is inverted, we want to return if the chip *IS* NULL.
>
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_devi=
ce with SRCU")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-gpio/15671341-0b29-40e0-b487-0a4cdc=
414d8e@moroto.mountain/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 6285fa5afbb1..e4a6df2b317d 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -801,7 +801,7 @@ void gpiochip_sysfs_unregister(struct gpio_device *gd=
ev)
>         guard(srcu)(&gdev->srcu);
>
>         chip =3D rcu_dereference(gdev->chip);
> -       if (chip)
> +       if (!chip)
>                 return;
>
>         /* unregister gpiod class devices owned by sysfs */
> --
> 2.40.1
>

Patch applied.

Bart

