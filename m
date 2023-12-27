Return-Path: <linux-kernel+bounces-12068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8B81EF98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950C5283288
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782645954;
	Wed, 27 Dec 2023 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bpXkj2jw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E645948
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b73593f37dso264021e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703688765; x=1704293565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD8e1CdpebY37eIukBJ2i1jsWTXkJgQTifus7FLNfqs=;
        b=bpXkj2jwLif3eFZMo88XN4/MC/KsdgZcy0QaXtwMAFpj9kplh4kmQe78beT4fbQoQJ
         YP3L02LvbJhHcFed5chYyyLwOguIS0buD6zXxD2XZgStGS6+HszueDXKZw+E2AEHdYee
         NTfmNiIRlY/QRyW/09YFEiJkOUYMgWoY6j7a0NNKT42iA4unn5XpN2y30QekCr8T4R1m
         qdD5vhjTlBWbTON8wYFdOatx/ioq3s0ulFXwuo7x64O6KJScd9PnYONqzo9rdmNvmZiu
         Bj+wjinKNjUQUyivFvuPzLFUGoi5UnNW/DbIzvaFdyyqQHp8nrXBguoJYLijJxt9vEOV
         aRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688765; x=1704293565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nD8e1CdpebY37eIukBJ2i1jsWTXkJgQTifus7FLNfqs=;
        b=qw+e189tnLRt8uLUv8SUsKFrRyrNKYj2GfkdDjCx25/sbs+w3c2R2M5vgoYp7uXsLn
         UkaM2YwhNco0+rU4aeZn1w1zDz09stoCoje3FdRPeewJxcuWtpnWg+ylqw8eIP65/j1/
         ViW6IMJHikG8G17E9zcTw4UF61leC/hULeWIn7EgdOzUwvLO/haSlK6RzkjZEPgj32Eb
         p8mQOqFravLyM9RJhwAQTtccCZUNp1vKgyxzN6IoQR6GxJhzPc5meDRYHB6E76khC2cn
         nXeQOzhr/nC93/NvoNNNTA8wK8NPINlhBA3r7bJ7tC7XvCvcdJVwATjYwT3WwEINfd3K
         4QFg==
X-Gm-Message-State: AOJu0YytWA6YCykPi7nyu2BT31w1iepxzgE9VAQnyCVYeFaaV7Fcpn8b
	cEQtILEqBibsBtcSrSJGLnUMYxUOqeRLHGaxZ+x5YOa9+5qV+w==
X-Google-Smtp-Source: AGHT+IHVOzGzMP1hxydPmKWb0O88z9baoC9mI9U03wTMP0dkeay8FoRs5TGqVM00Vc5LOAVbFReETVEFcvIaEpCvz5c=
X-Received: by 2002:a05:6122:3296:b0:4b6:af71:1af3 with SMTP id
 cj22-20020a056122329600b004b6af711af3mr2866069vkb.11.1703688765186; Wed, 27
 Dec 2023 06:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222141952.16254-1-brgl@bgdev.pl>
In-Reply-To: <20231222141952.16254-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Dec 2023 15:52:34 +0100
Message-ID: <CAMRc=MfrvGWx-PVtNcQ77jE3zR7gNy0=mwp9745ComK4xFxfdw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: split out the uAPI into a new section
To: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:19=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Kent Gibson is the author of the character device uAPI v2 and should be
> Cc'ed on all patches aimed for it. Unfortunately this is not the case as
> he's not listed in MAINTAINERS. Split the uAPI files into their own
> section and make Kent the reviewer.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  MAINTAINERS | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9104430e148e..2867da6e233d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9006,8 +9006,6 @@ R:        Andy Shevchenko <andy@kernel.org>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> -F:     Documentation/ABI/obsolete/sysfs-gpio
> -F:     Documentation/ABI/testing/gpio-cdev
>  F:     Documentation/admin-guide/gpio/
>  F:     Documentation/devicetree/bindings/gpio/
>  F:     Documentation/driver-api/gpio/
> @@ -9016,6 +9014,17 @@ F:       include/dt-bindings/gpio/
>  F:     include/linux/gpio.h
>  F:     include/linux/gpio/
>  F:     include/linux/of_gpio.h
> +
> +GPIO UAPI
> +M:     Linus Walleij <linus.walleij@linaro.org>
> +M:     Bartosz Golaszewski <brgl@bgdev.pl>
> +R:     Kent Gibson <warthog618@gmail.com>
> +L:     linux-gpio@vger.kernel.org
> +S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> +F:     Documentation/ABI/obsolete/sysfs-gpio
> +F:     Documentation/ABI/testing/gpio-cdev
> +F:     drivers/gpio/gpiolib-cdev.c
>  F:     include/uapi/linux/gpio.h
>  F:     tools/gpio/
>
> --
> 2.40.1
>

Applied with Linus dropped from maintainers of GPIO uAPI.

Bart

