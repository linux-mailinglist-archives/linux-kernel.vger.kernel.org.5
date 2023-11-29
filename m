Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6C7FD1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjK2JN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjK2JN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:13:57 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FDF1A5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:14:03 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-462a24a7583so2035428137.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701249242; x=1701854042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIMu2gy1DtmikoCfchTvOV2bl6nFUJDXNkFi9sSRetA=;
        b=MrKQXUGIAd0d43mL8cEZleQQ8pxkN5xA2l3zKmPjGDnyo14XmMQR/sjBh4JQQPhWaN
         mNYWSBNiDNivgmLGU5eBHjWpdRJiRHf7w12f2Hx/lVkV/NlZVYcitNqdAx52U+X/M6O3
         j2uo7TCl7VknZbmtoop7U2NqmMZbcbStpk3DrrqtiKEkJnUx4Ol57vXzlkPbCRB1NXis
         BLOUcHaBtTh5XNwKrYzMzspmq7ZuPsH/CXE0Ly8D4YpAdIHk2Xx4KHrVGzYoiTfdbRK0
         1IwU9nfo6QiXlhrnoFRs7JEVMHDmWLjlyxUNVV7N9ny4WUHxDKFXedX7bNKC/40zo/B4
         NAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249242; x=1701854042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIMu2gy1DtmikoCfchTvOV2bl6nFUJDXNkFi9sSRetA=;
        b=bDg30RhrAS3p1R1stYGX+WQN8v0lnwMCaDEdxjXeCveJaPb3ylBGtOdsusKTqdjzhF
         QXGLoCTbR63r6W4wznlHDjd9KlcqJ1eVY4WJhH7ISicwfHcp4Vq3qjdEMQ7k4zKaGfGY
         eHpZ+u5yvIuP/sh6QISnIQ+i/c49eHP6rV4iOyXv0Fcs6BcfcCI/Xr4MkXk/eE0QHLrg
         kxc/uf5ZMkpBnP/NmgDBnUnLEl0umrr4k9QwvgElwmWUj2OmVZ9V5cEirWzKJ4QjCkOw
         uTvy6FrIOe4QEv7jjyGS9/NHRAQY3GLAbp+JT3hS/nXiPnU99QMuWkietVlevMAq560b
         CZFA==
X-Gm-Message-State: AOJu0YxWppLxsK3xexZYbUJmWSIo99NKzysAXAYjMjc+1xSfC6xj3YKb
        emkS3kYGWP9ttaAMijgqpq9jMTWDOOiUBzCQ8O50cw==
X-Google-Smtp-Source: AGHT+IEWQpF7n/VRP1a03EcSHWgG73bdr7xdU+s/MO65we+YnMT5ycq1KQh5qPJsyWEwKH36YfJn9Sonu9Jdzoxuaok=
X-Received: by 2002:a67:e3ce:0:b0:462:a044:aee0 with SMTP id
 k14-20020a67e3ce000000b00462a044aee0mr16831554vsm.15.1701249242319; Wed, 29
 Nov 2023 01:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20231123103032.11396-1-brgl@bgdev.pl>
In-Reply-To: <20231123103032.11396-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Nov 2023 10:13:51 +0100
Message-ID: <CAMRc=McTQEcwS6JqRsVoZjPYB=KLCjDW7vqjnvL6np8hSfJP+Q@mail.gmail.com>
Subject: Re: [PATCH v2] eeprom: at24: use of_match_ptr()
To:     Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:30=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This driver does not depend on CONFIG_OF so using of_match_ptr() makes
> sense to reduce the size a bit.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - use __maybe_unused to avoid warnings about at24_of_match not being used
>
>  drivers/misc/eeprom/at24.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index f61a80597a22..8279adade07e 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/nvmem-provider.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> @@ -242,7 +243,7 @@ static const struct i2c_device_id at24_ids[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, at24_ids);
>
> -static const struct of_device_id at24_of_match[] =3D {
> +static const struct of_device_id __maybe_unused at24_of_match[] =3D {
>         { .compatible =3D "atmel,24c00",          .data =3D &at24_data_24=
c00 },
>         { .compatible =3D "atmel,24c01",          .data =3D &at24_data_24=
c01 },
>         { .compatible =3D "atmel,24cs01",         .data =3D &at24_data_24=
cs01 },
> @@ -812,7 +813,7 @@ static struct i2c_driver at24_driver =3D {
>         .driver =3D {
>                 .name =3D "at24",
>                 .pm =3D &at24_pm_ops,
> -               .of_match_table =3D at24_of_match,
> +               .of_match_table =3D of_match_ptr(at24_of_match),
>                 .acpi_match_table =3D ACPI_PTR(at24_acpi_ids),
>         },
>         .probe =3D at24_probe,
> --
> 2.40.1
>

Patch applied.

Bart
