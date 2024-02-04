Return-Path: <linux-kernel+bounces-51846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99517848FF3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BB1283090
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0224B2A;
	Sun,  4 Feb 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3SmweqwH"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73324A12
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707071698; cv=none; b=sY4k5AgvejVV/pXzgOwPLDUZThG8VcrfHG/wPkdrWZQb4kJhNnuMNdcndlR7HWzgYeppxy0XiMj6+0HKh9ZZqc1q5J/3CO5s1sp8Zu/XgoiKBXVst7fAys9Aun1pVMBgABAyJ6Q/Eenu63gvd7PcYoeRIshw9QiXj55RDnTKBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707071698; c=relaxed/simple;
	bh=ZQmBds6I526OgZz80vHGXLR8h+4khj0jQbh9dcT7Leg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sf/YVSviimWMXqmrFx6/i7wmiuPylLyMmlbFQ2VcoxmQBBOPwj+JG0vt2mA0nq5KMnNpmg82JZhkKVzKAIpWc+O60U9d9v+my1hL9CE1w2kLFS8a0JgklyaWsLASCHzny68UvFe2c2gK0PhYORHCHXKCQ81XnZC5UQQZC74/n6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3SmweqwH; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46d2635b15eso347235137.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 10:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707071694; x=1707676494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGNDwLihPkMuiLw24VbnCKgstM3WE3ciwlWemrRdu3A=;
        b=3SmweqwHUrwfsOEJOAZmta1tuy+WcYkPOevVJeoYnjuY80DL3iSOnr4kOypIk7U0hd
         rTsustcOAW9D1ENXdLl+IPCVbn22o//g2DBTPiWqR4gImEYbOLJW2BvvOhzOolfZaFkr
         AQSokmNcGtEAmZO42ctEkhqVA2ikTO6J8gKEINdI3+iI2+TtyEiBYsMtm5XaOgIzwW8Q
         MpelDkbt2IifhO+Df3hETXO5smbOZGfqiOeOIjBr18Ow7FrI19vI3WYwM989rgOaVYK2
         4xzdyWUiTHRFhejg3FFGbnOX5qU+AJC2pCcsIdpkCXpN2hQkv03FzZB0YB/wMNGbcoRz
         avNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707071694; x=1707676494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGNDwLihPkMuiLw24VbnCKgstM3WE3ciwlWemrRdu3A=;
        b=QFuhWTRSy+jVhXy1GdrUdotLK2NPVHEztn42VcJTqaFnrmU85oOUo/V1t3L+RTLala
         CI4q2sN5G2sVcQVHF6D2bzT/gWD9h4jtaIfxrq5QT9k34Ai3D171A3z6NTGZzcYfy50V
         JnQvb4e3hMoXlriHDZmyhPdcYdf6s9ToMSgT9FqTrE6gwiagHQZqf2JZ5H0YeT+Nus2i
         Bp5cojbREZR75icvAKTq5SLKFjmimWdNVlUAqXaPxUPMlHeW1Wf42UKxsIhJW6jLtaiG
         ZU5DcNmueO0UhF/XHdV9FarITRNhcwYAAuEzwRDc9NK3bcbinmX8Hp8HTRGP5ltWfbnU
         F3FQ==
X-Gm-Message-State: AOJu0YwkCeVNE0F6JJSHN+yf0V/xfAfFMdHWs+LoEELelWmt3UejrSFU
	TSHK/4Py6nTjplSBtuHawYc/MXuTP4ZRjKsCikniUGO7UXkSXRk1Cr7xT5czuFtLyjcY5f/9/Kq
	lR0OyTn78MK5wAdL5su0z7HrTD18odjXwNjQdww==
X-Google-Smtp-Source: AGHT+IHpA95+RI8LHK0B2t1V6F3nSm87L8MTP3VxDtNMWGAw1mCIDHwdb/VXuS3XWPK8lxe1OKGcU0XJo3BjMCyMZb4=
X-Received: by 2002:a05:6102:1898:b0:46d:2b14:db7 with SMTP id
 ji24-20020a056102189800b0046d2b140db7mr706816vsb.4.1707071694229; Sun, 04 Feb
 2024 10:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-bus_cleanup-gpio-v1-1-82d91b4ee1de@marliere.net>
In-Reply-To: <20240204-bus_cleanup-gpio-v1-1-82d91b4ee1de@marliere.net>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 4 Feb 2024 19:34:43 +0100
Message-ID: <CAMRc=MdSApjK2b66LxLE9XZufvT-+SThuqjdr+yG-hsKEb4sVw@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpiolib: make gpio_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 5:29=E2=80=AFPM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the gpio_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index d50a786f8176..24d046268a01 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -63,7 +63,7 @@ static int gpio_bus_match(struct device *dev, struct de=
vice_driver *drv)
>         return 1;
>  }
>
> -static struct bus_type gpio_bus_type =3D {
> +static const struct bus_type gpio_bus_type =3D {
>         .name =3D "gpio",
>         .match =3D gpio_bus_match,
>  };
>
> ---
> base-commit: 3eac8bbed22e940ac1645a884f221bef408f675c
> change-id: 20240204-bus_cleanup-gpio-57eea8d32a5a
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>

Ha! Does the same work now for struct device_type?

Because I just sent this:
https://lore.kernel.org/linux-gpio/20240201162758.50733-1-brgl@bgdev.pl/

And maybe I should make it const right away.

Bart

