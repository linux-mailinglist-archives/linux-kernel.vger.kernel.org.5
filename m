Return-Path: <linux-kernel+bounces-25864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892282D6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32022815BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0488F9E5;
	Mon, 15 Jan 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Xo1i5YEz"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B6F50A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b857733f9aso1584769e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705313540; x=1705918340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn/IBVOWpMMRpEDU1Op72zgW/plcgEu56p6VAHHMjqg=;
        b=Xo1i5YEzqP0+3DdJ5/ASe/O2PaW2LSM2D6iYN6QiVEtmIR2S4u9/PXfg45zNaQdi2n
         d5hKC527sw/NOJvemuSpzAyWGjaFi30VctRs5GPaMhIR1Nz0uY8luKdJeRvCsYBMoejF
         vZMhUV/XFWbASWxbdFF8YRzGl2MTLGFPhevWwMDz29ymZNRnB7WpNN6s4fAwiMONQF7O
         7uQsb6XeW3jeRfLQSNhMw33YFfPuoi1anWuldQ0glcp58Vpl8eGn4/+5qqChNmtW0f0f
         gOOIhjy5w6t2Ot71uITylYGk1PqDMlou03VGjV721ZOzgUN7+jjGqhRKOzGPpBpuc6l8
         yh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313540; x=1705918340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zn/IBVOWpMMRpEDU1Op72zgW/plcgEu56p6VAHHMjqg=;
        b=OV98o73lhOinmYVUkg9V8kfJW+8V5Y591wXKOcviTNOJQm3ZMwgpM4hgmpi0oiiOgj
         pw9bTBxkJsGNnPLDjZHdqfKatR3DYs8f/vP093OUVAuL87ftREya02+IKvpfZxK8VnAT
         3dHub8kAM4SZZwdILxPJI8QHrf2S5ibFvcpDc7JTXskmHI0zqk0SmnFACyn2qjiUEBkp
         ESunQz8BPZssijC9+9nLYPqJuFqfhxMmxS8aD/QuefjfAPwFmq3yUfHUhjdZxHCb12E8
         Ta0SrW6nMYZiGGUIJZvWneEj9y6otPgA9ZVsoYbuaUDyefEqXPJIte/TrJgb3+eDS8or
         gJlw==
X-Gm-Message-State: AOJu0YwIdcxgQdg+OpH7TCLfUQjH8TF1Fhw95CDQ7vEflgca7czLtJoU
	UgBYsullGno86Yl0WdnyyNd+4ooJ8kkZuHKeBVL0X9tOwTuzag==
X-Google-Smtp-Source: AGHT+IG+6FfSJ/63KIfkM4DCBfQbaFiAAhpMVZ3g61Gxu6cr4QzwOSBvdT0o3Zf1lAyRS5xN53QYacrHnUdaf0bd8wM=
X-Received: by 2002:a05:6122:4304:b0:4b7:386:e209 with SMTP id
 cp4-20020a056122430400b004b70386e209mr1919852vkb.14.1705313539903; Mon, 15
 Jan 2024 02:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112042403.3940316-1-suhui@nfschina.com>
In-Reply-To: <20240112042403.3940316-1-suhui@nfschina.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 15 Jan 2024 11:12:09 +0100
Message-ID: <CAMRc=Mdx0OcvDN3rjjSe_K69xzEewe+JyR0639R1jOS9uhp1XA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mlxbf3: add an error code check in mlxbf3_gpio_probe
To: Su Hui <suhui@nfschina.com>
Cc: linus.walleij@linaro.org, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 5:24=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> Clang static checker warning: Value stored to 'ret' is never read.
> bgpio_init() returns error code if failed, it's better to add this
> check.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpio/gpio-mlxbf3.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
> index 7a3e1760fc5b..d5906d419b0a 100644
> --- a/drivers/gpio/gpio-mlxbf3.c
> +++ b/drivers/gpio/gpio-mlxbf3.c
> @@ -215,6 +215,8 @@ static int mlxbf3_gpio_probe(struct platform_device *=
pdev)
>                         gs->gpio_clr_io + MLXBF_GPIO_FW_DATA_OUT_CLEAR,
>                         gs->gpio_set_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_SET=
,
>                         gs->gpio_clr_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_CLE=
AR, 0);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "%s: bgpio_init() failed",=
 __func__);
>
>         gc->request =3D gpiochip_generic_request;
>         gc->free =3D gpiochip_generic_free;
> --
> 2.30.2
>
>

I added the Fixes: tag and applied it.

Bartosz

