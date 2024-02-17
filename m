Return-Path: <linux-kernel+bounces-70026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CADDB8591F1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF89B22525
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280957E569;
	Sat, 17 Feb 2024 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Orb4N8kv"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32D7E105
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708196623; cv=none; b=doF1nSZq96piGwteqrznJMy6fBKUrs7Qt4E/qECcg4fhM0u8c1hFm1o2dZVf+uucBwroYhZ3eR00dXFZ1i06eO8Xi+OznFOxadiHyN7IuOAi7ixA77LeitBbro0q9Puj3MxgtFjWMdATVIRGocUBPml/3pOVI4hv93B1/o51rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708196623; c=relaxed/simple;
	bh=AAnr2V/wjbiV6YtHuxAn/t5m7pz+CXEDnDMRlKCuoHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp9srXxGgP4YSkcPVjDXg8Dz+ZjlHEHJADY0clvJidOGQKNxx7+aVaYSzMj+koeoNvwqGh8Mxv5rr0wr/NXk21coBVwAmenS0SNQdH0jcT1AGh10DooMfbfuggMQvcQOpz5kx7gSAfDqdTYPvlQjQIz2I5piMaAIA0eOCX7rKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Orb4N8kv; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59fca9dc69eso64741eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708196621; x=1708801421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOn+Bsy7l6RfWFmq6vXphAJvxzNZMzFc4+lcGeMdTVQ=;
        b=Orb4N8kvcBriaOhGfc8Qj3JyJ6mqFptkkKdklcYDL+hzlVVBFq6cSYSmWNf2FBWKIG
         JCnKt1y3A4jGwWTp9RXyEzcQXH67XNJRwBL9/fhHgjlkzxSzzzTzecMW9lSrF5VXnSX1
         A4l6CK4+58+uVQpuHHx0TTaEWwQ9tNmANAMNux9cPHjTbIk6+e02MRGJ++17Hx09k3k/
         f8+oY3m+6XT/qq4YZjgni1Oy4QSHGGXMhpWBUUsIs3mfhW4JSiMoleb//CwJcHeLIb+C
         YV6F5tgV4xm1rcM/XpkX6fjtHZ+ygB419RMuUa/B7UsgK7oKN+gWPnrFal+vazrEqah8
         BwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708196621; x=1708801421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOn+Bsy7l6RfWFmq6vXphAJvxzNZMzFc4+lcGeMdTVQ=;
        b=bEV/6MZKtfAq3eYev8HPlMe86++kqBheo6KFtdbuI7/J+iuF/1UoWcS3wQ67EFEVwD
         qtSIavfWzQgjrDxuvmRpq0v3iUIj+Es7lyJJwyfPGe9EkUi8cGC1LJTUd4KZX12wqZTL
         VGfrh35CUI2uo43LOW717591Fd64hp4nAS/s72MdW0/2Ve1MBgEkaW12gXSrVb9h8fpL
         dy8bhbDybfIGX0sBs95W8X0CJvv9+wHtoxyOB/og6JRgKctzztVulVOWxGCeeiVzP1xv
         qBW0PQBIKLPPfwTTXejzQ9xfJCp57TJxQ+qF1xO/mAGpxYaNu+0vb6+bWvOcSssWzz5y
         inHw==
X-Forwarded-Encrypted: i=1; AJvYcCVpy2GNOvaG6qJYPZe/zQTfDIWuvncaISx+kUN0ECfNjZ1p1pvgoSjAlYHcNIfFhisg8AEfZ1M7/ADQuFjlPh7xFbtIPZRxUaYs2prC
X-Gm-Message-State: AOJu0YypyFs0NEmJVt9lHgDQPesnjbPLxFp1SjEYb43+Qo1Jqt8eACS6
	GRFXpf65aOWkGXe+72C3q0PVyC+XKDZpQ1KWFhASoPktGsyNG+yT+PLsMI+x9eU43zWQCiQpno2
	hBxliwaTiKV2eBNIsLIURQk5NkGsfNuWTSWPGPg==
X-Google-Smtp-Source: AGHT+IHwg44JWZ/tfyLReDwK9TmmBxLy7cMx4rS+ix8ZOLzSlyYxFk2kOdn+nn1MzvZ/wN+UaSMTtKr9Eo3fzBOoGec=
X-Received: by 2002:a05:6871:d086:b0:21e:390d:8c0a with SMTP id
 mw6-20020a056871d08600b0021e390d8c0amr10082287oac.16.1708196621203; Sat, 17
 Feb 2024 11:03:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216135217.129795-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240216135217.129795-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 17 Feb 2024 20:03:30 +0100
Message-ID: <CAMRc=Mc9vQwtV+Sa0aazq=A=z1FSbwK9rNayHM5Sr5Mt9oNOEw@mail.gmail.com>
Subject: Re: [PATCH] gpio: constify opaque pointer "data" in gpio_device_find()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:52=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The opaque pointer "data" in each match function used by
> gpio_device_find() is a pointer to const, thus the same argument passed
> to gpio_device_find() can adjusted similarly.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpio/gpiolib.c      | 2 +-
>  include/linux/gpio/driver.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 0e332b24c7b8..8c9cb324b7a4 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1112,7 +1112,7 @@ EXPORT_SYMBOL_GPL(gpiochip_remove);
>   * If the function returns non-NULL, the returned reference must be free=
d by
>   * the caller using gpio_device_put().
>   */
> -struct gpio_device *gpio_device_find(void *data,
> +struct gpio_device *gpio_device_find(const void *data,
>                                      int (*match)(struct gpio_chip *gc,
>                                                   const void *data))
>  {
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 51b23211794d..251a610f2234 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -628,7 +628,7 @@ int devm_gpiochip_add_data_with_key(struct device *de=
v, struct gpio_chip *gc,
>                                     void *data, struct lock_class_key *lo=
ck_key,
>                                     struct lock_class_key *request_key);
>
> -struct gpio_device *gpio_device_find(void *data,
> +struct gpio_device *gpio_device_find(const void *data,
>                                 int (*match)(struct gpio_chip *gc, const =
void *data));
>  struct gpio_device *gpio_device_find_by_label(const char *label);
>  struct gpio_device *gpio_device_find_by_fwnode(const struct fwnode_handl=
e *fwnode);
> --
> 2.34.1
>

Applied, thanks!

Bart

