Return-Path: <linux-kernel+bounces-151984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5118AB700
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A50AB21356
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC4D13D29E;
	Fri, 19 Apr 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfgMN3tu"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF813D256;
	Fri, 19 Apr 2024 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564170; cv=none; b=EfpoUu2412d1YKYjMDZqSJqXMs9j16pd2jjnOvJAafw/N2eg5cbQDvYccqVfSkg5AKQza+YVwyu1ssT1BQ7Vg6u0uAkOuqliSOg8l9lEZBj8uuZKmNNtQhDhQOeU7iMcRduOyPm6cyqlBWr6i3vFMbCbZy0dJePGjDA3Wtq3ejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564170; c=relaxed/simple;
	bh=0Bd3wIdBgrlvYxUJEi4bxf+sBvTDzY7qNhh2Qe4ysxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRyICJywDNfPR0KUxgPbJ8X1RkUEEGOqLaxfZHXw/tEloVS6yNbqjWQK2ay8PKjU9RkAwkqXwbDmVJU3joE42NoUc6MxZX4IGtHLae7I6EcvTfEq2uC1qukcAzndmGsJ9p57hMYUVU2s2T5CckCWdZyjBdFIVxwR1Z6fgqTHOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfgMN3tu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34388753650so1154937f8f.3;
        Fri, 19 Apr 2024 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713564167; x=1714168967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsymc2mzb8S4zOIq7K3bfL6qqeZtkWzdiLTaiYhq6wA=;
        b=FfgMN3tuNCcbifCUuope2vdzr2uE//tamAXdKI5nypXq7DMw0LvaDu4yjZ7sNvzANN
         h07XIwuY+IA3lQdnXMKpI12t6wahLrLkFERhKT40rN4iixmcJHjVHKm+4UQnRTwIshTf
         GLKfK3YBFIldvtK6+RvNT217/fGKXL3r+bZrcwxT8Q4Mi5xuMYojMEkjYjU24+aMLk+C
         oBNErcz0S1Meu5uNNcTpOpRFkkEwP4E4LAcdBO7sbLROM6bSClmhgaboa7R3zhIGRusY
         ZyGopTil6IWjgIbwMDFouf1MtbGQjm8HhMkfjSwGZGID9usKbqK/9AsMXjeP5dOy4tXn
         2COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564167; x=1714168967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsymc2mzb8S4zOIq7K3bfL6qqeZtkWzdiLTaiYhq6wA=;
        b=IbHCrQtkhaOsMJy0w+Ue307TR6cKoiSyxAZ+pvag5sPxAYzEHgrpmL9BgrG4hETad+
         tDWbxoI1PjCfNPfG3+/EQiBeOXZA7RvQop4aO8ZIryrAPBC21Me9YIiimjgpnccE858W
         oqs1uE1UUlEbw7bbPpe+KsIjMLoUYAKcrXBZIGir+21NmQc8DWcsJIkuBD1GpnI+I/En
         9Z0Ew0uPTLY3/iEOoEh7rvKtbiOCOnsG2m1DPteMr9koM0oSBVKZVTTtiMg65tBXH+5W
         cc2kvXu/8Iv/zFSMybk5C0p2fkvTjrR7fpypjBHoytuhw0OcXSMVYuRtKRXcO4KcVK+3
         UepQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjMaUBo13vGicJjROfZzUHvAdUWdZ/fQGqcHcoZg4l/r6ujV8wQjq+NkKUJrSoP/84dWQDTwvCuEg+jHwbk9o/AnTzC6GnXvFpiXzutPGgn39Kg78Zn5fcMuRkw/qmNJmR+a4Z0iOCdA==
X-Gm-Message-State: AOJu0Yz8MG22aiaKo2nNQ8u3cJ9Kys6iJ3938QBJnFM5gOs95n5OyRqk
	x+OCGuvlrkvmxRVwDIcQ01bTBEh+ZXg2/2EB1/3lqRODGCDYgbHZOa+AqUvW7j1anRGNXendJ5S
	U3wkcpM9kUnV1Pob9lbo/swvaIxY=
X-Google-Smtp-Source: AGHT+IET2unpdVrq46vQBXiZbshm7IBSPLsGuAzEJnj1Xd5WgRbJdAtbxfrhLXFWsH9Yk5KJ8qeT4VFlglf/Fbd9o+E=
X-Received: by 2002:adf:e50d:0:b0:343:f2e0:ff21 with SMTP id
 j13-20020adfe50d000000b00343f2e0ff21mr2139508wrm.23.1713564166779; Fri, 19
 Apr 2024 15:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com> <MW5PR84MB1842F4C102CBFA73E861F420AB0D2@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB1842F4C102CBFA73E861F420AB0D2@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 20 Apr 2024 01:02:10 +0300
Message-ID: <CAHp75Vd_zfuRc5nV42MHUjyOPQgf0+=A5Yyj8kaO7vYcmQsOzw@mail.gmail.com>
Subject: Re: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
To: "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc: Aapo Vienamo <aapo.vienamo@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:00=E2=80=AFPM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
> > -----Original Message-----
> > From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> > Sent: Friday, April 19, 2024 3:06 AM

..

> > +static int gnr_gpio_probe(struct platform_device *pdev)
> > +{
> > +     size_t num_backup_pins =3D IS_ENABLED(CONFIG_PM_SLEEP) ? GNR_NUM_=
PINS
> > : 0;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct gpio_irq_chip *girq;
> > +     struct gnr_gpio *priv;
> > +     void __iomem *regs;
> > +     int irq, ret;
> > +
> > +     priv =3D devm_kzalloc(dev, struct_size(priv, pad_backup,
> > num_backup_pins), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     regs =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(regs))
> > +             return PTR_ERR(regs);
> > +
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
> > +     ret =3D devm_request_irq(dev, irq, gnr_gpio_irq, IRQF_SHARED |
> > IRQF_NO_THREAD,
> > +                            dev_name(dev), priv);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to request interru=
pt\n");
>
> All of these early returns will leave the memory allocated to priv
> forever, since priv isn't saved anywhere until:

> > +     platform_set_drvdata(pdev, priv);

I'm not sure I got your comment right. Do you think there is a memory
leak on the error paths above? If so, can you elaborate, because I
don't see it?

--=20
With Best Regards,
Andy Shevchenko

