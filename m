Return-Path: <linux-kernel+bounces-149335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1A68A8FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB71B21B61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE653AC;
	Thu, 18 Apr 2024 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oOBChsbV"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EF86642
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398403; cv=none; b=bR85A9UgD8XI2S4ye7cV5ozmtz5ljbDp3rJtRWqGkB2FpVsoUbVtsKbLdhvW6n27eN550ofi1nCkAfou7q7l4gYacDhakQMa8zjlv+jhliGmkL0yO+Yp1NmonKt8a9lSEwEPEDujSOp/Tu8gX2CmZQu8wl59qJHPAfEhBAJLWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398403; c=relaxed/simple;
	bh=SfWbGLTYXXko8g2ioHPgogIxHHSTBHU9JaaAWEgZaPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVpEvEKhfhwvm5pF3ZjD1LgUrO3NWxgzu2iyABXMI5B9meaXdWeFKVvJKYTLFtWMiihbNPYPQ3F79BuBhUZIECI0N+S+Wa7tAiHwMLZYVKtJFuJlW/mwb3Sk/LjSukaYCRK6QYTC9b+fh1rFgjh6kd+oFTEw9a4QlDVZjv43RL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oOBChsbV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so3581731fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713398398; x=1714003198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBvypBsMvnG3H6XpbX8oQ6ldyKG2ZjkHSahsMgFb2XE=;
        b=oOBChsbVsOFa8oWtfZbRaRpeWBRgGUYWPW83P7fhW2DXgmnwprf5o0Ri81EXBmQ3qD
         dYPJ4oRkq4CIPcFETgdZZFFGdCSmc2PPF/13s2KdTh8sAhCRL/nRmUGMpp1XoDWU/zQd
         wNAV9XLc8Hc1LKKH5AA5KzrHFdrvF7zMds3lVO5UX2nzsZOT6pE9PgMo6Z2Qg5wl6Mba
         ECriZgvQwadaNt+GgtYxu/F5jDH1+zpbpJVESf2MCNig1ALr6x2wY+bEBIcn+Dl38oiB
         Ov7Fil/z3eK4XSoegvTkzxjtTEX9HfmlG+vCDuVdjAYGTyHCK/77oqjYVhYH7xOmbnBd
         yO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713398398; x=1714003198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBvypBsMvnG3H6XpbX8oQ6ldyKG2ZjkHSahsMgFb2XE=;
        b=hkkp7WQBADVNLE9K0q5UEhCNI8W/3b0IISk/hAUQ/BazZ4gelOQNmMO4lmx9QHDX1I
         2wCxFI7d0/BYKEWUBtKGtrCtV9AHk3Rs9Q0gdic0S6kZyH9Ypf9ZTyUhWre962lyOKdd
         p496aiDJMs7BhoOFOu1jz4nSRNGacbGgVOGJXCCjoon3rJKybTV+nj2OdqhzOmh6ZLnu
         3Eb+9r1vlnukylaZ7QGXz8KQePag2Q1oFLTr6sixRz7M7/Fd7MNyuy3U0i6EpncBzDDS
         gz6ifmagYz9R4ue3eAT1C/sXT8VSv+g4V/ZbBTOBpTvJpEb+Q7RYA4a2UCq4xmL1r8S4
         lorg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5trWmAcFb2bKCuCVxJVooF/ib9/U0EG+0tfn9krJ2SYkHK/XIe4SpSTCK/41W9npwQIwgoCTXzW+oV9ypG3WxKzagzY0pQ+oRhV7
X-Gm-Message-State: AOJu0YwdntH4Reij+p6e/3AXCnYEeE2PSYob3+jYmPMNWkOlDWX3GrU8
	O5GBSy9DdIz28OLzdxpjebUHDAGyO2xz/oTbBZ0U8PeHFi6B7jA1q7HkN8sIfZ9TGVe4FEBSPNS
	2MGz+aG991kJs2mC4tzLwi4vniYiAiaPlibPuyQ==
X-Google-Smtp-Source: AGHT+IF9iJoCVl2UcqxxnXv8/WOse6a8aMNaA2CPr6Om2Kf0MS6MQL//ey1KZCqoYUnWuKSzrCZaUfF2mVdQ6TjVmJA=
X-Received: by 2002:a2e:994d:0:b0:2da:6f70:38b6 with SMTP id
 r13-20020a2e994d000000b002da6f7038b6mr487474ljj.35.1713398398135; Wed, 17 Apr
 2024 16:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417230637.2592473-1-dtokazaki@google.com>
In-Reply-To: <20240417230637.2592473-1-dtokazaki@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Apr 2024 01:59:46 +0200
Message-ID: <CAMRc=Mcbi8BQ-tHNs+BVjbm3aDSVY0zzOM4QfND3d2y8ryT62g@mail.gmail.com>
Subject: Re: [PATCH v1] at24: fix memory corruption race condition
To: Daniel Okazaki <dtokazaki@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-team@android.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:07=E2=80=AFAM Daniel Okazaki <dtokazaki@google.co=
m> wrote:
>
> If the eeprom is not accessible, an nvmem device will be registered, the
> read will fail, and the device will be torn down. If another driver
> accesses the nvmem device after the teardown, it will reference
> invalid memory.
>
> Move the failure point before registering the nvmem device.
>
> Signed-off-by: Daniel Okazaki <dtokazaki@google.com>
> ---
>  drivers/misc/eeprom/at24.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 572333ead5fb..4bd4f32bcdab 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -758,15 +758,6 @@ static int at24_probe(struct i2c_client *client)
>         }
>         pm_runtime_enable(dev);
>
> -       at24->nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> -       if (IS_ERR(at24->nvmem)) {
> -               pm_runtime_disable(dev);
> -               if (!pm_runtime_status_suspended(dev))
> -                       regulator_disable(at24->vcc_reg);
> -               return dev_err_probe(dev, PTR_ERR(at24->nvmem),
> -                                    "failed to register nvmem\n");
> -       }
> -
>         /*
>          * Perform a one-byte test read to verify that the chip is functi=
onal,
>          * unless powering on the device is to be avoided during probe (i=
e.
> @@ -782,6 +773,15 @@ static int at24_probe(struct i2c_client *client)
>                 }
>         }
>
> +       at24->nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> +       if (IS_ERR(at24->nvmem)) {
> +               pm_runtime_disable(dev);
> +               if (!pm_runtime_status_suspended(dev))
> +                       regulator_disable(at24->vcc_reg);
> +               return dev_err_probe(dev, PTR_ERR(at24->nvmem),
> +                                    "failed to register nvmem\n");
> +       }
> +
>         /* If this a SPD EEPROM, probe for DDR3 thermal sensor */
>         if (cdata =3D=3D &at24_data_spd)
>                 at24_probe_temp_sensor(client);
> --
> 2.44.0.683.g7961c838ac-goog
>

Looks good, can you add a Fixes tag?

Thanks,
Bartosz

