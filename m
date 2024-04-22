Return-Path: <linux-kernel+bounces-153164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3478ACA77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DF31C20AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF63913C3F4;
	Mon, 22 Apr 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yazwWYqp"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45213D623
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781258; cv=none; b=Z7XR+miqr6goQSvbKY4vigX/XV3Cy1hL2Tt3dwoghrCNPtu/BCetj9h+B+IIRCxRnpV9Gz/FF2Ywvs+JYVieXYxjFNTNulB/XUFmvGQXotQLNzbjWhhFxZdE5L2zHvlDZB7IZshsZIfPJi9HzTYLPgFyZUW/PE9EAOYRvFY0joQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781258; c=relaxed/simple;
	bh=aDZG2lDnq+hlwDfokO8r20HjfALS7hd3CmW+2KPsvoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZGoc3+xKZC2zzbvW8OL8l9ecRji076joPhHCinvMTaRuvELFzi2lrQ1oV6Nnnl6XTXF4Z3TfcZ4IrA6eiz6yt9oe9br4L4UhAd6ZXpjKT63nu+Rv9+UiPoZx92y7xKSDEJjvAu90fPNvMt9CrCjni0cKznWEdkZ0iWLTolBnZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yazwWYqp; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d858501412so56886111fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713781254; x=1714386054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6n3QpSD2GmO3aRxqZjaA+3Qv43wmj5fZfLqd7FRwxQ=;
        b=yazwWYqpf9xn7faT1wou0Og2IiTFr1DF1uCPWVjw5ypNfFu2j0/ETzOWOQd7i80wUR
         B9ADs/vcUpYKLG/08IIjO2xya0FBcC6od2r6Q9VraZty8pWs7qzQpo1kihq7SolX/xg/
         lP0R/ESzADXVcVibDrtGRKYG/vZtetEmfMVcS1oqDycddZ4Ix2iTlLC0K8emqRjvYnSQ
         NuBiGixAMrnKJdCHJEk2x427WmlzgJ+538awzudPVd4Gxs9GfdMtoazJb1qLLA97uatG
         BHASOeiIkdwoXujH5SkILT4UBYBcq7LYCawayxEzSWbRJ/VTDr1+bdualRSme+IMIV+P
         ADPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713781254; x=1714386054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6n3QpSD2GmO3aRxqZjaA+3Qv43wmj5fZfLqd7FRwxQ=;
        b=T1aAkWDKq0jBpHNuAB4r9WoRo312jCobj8DXcBWAtixeocId2NZJNXgnAPn2M2PdqH
         PQd2Md3zyMfNc8bXBjtz4B6hzpLIaKB1m5vyDj7G6K+aM4iC/lDTt01VejM4AUD663vy
         2oKYkM9jDHJzk8d9rqPdVhZ4C+XAvJa7/W0yxyRpK5wo+Q+KnKchom0mFiuQKUbb8G53
         exJC2+/8KnQAqbrKI2FIH1krDsTWo8qBC/WWxuIfxe1t2onEhF/0ogVCdG+Cu9OtfWpz
         RtdD4Ox1T/Dw3NRXH/eK/vKXIG2Xvu/5YEtdW+M8Gn9QteAesfMbsKCASr9gcEbJ6uO5
         vM+g==
X-Forwarded-Encrypted: i=1; AJvYcCUvInPkpYKMp3ee9AHvSQwGaQp6awbPhtZH6T+/LwBJTtlKCNIalJzqDchD0xSsEzAde4rF2Mn70g57IbsjYN2Y62wqBQ1JsKUJMp8+
X-Gm-Message-State: AOJu0YxzrxEQt4BhiGv7tqYZRc1iAoau8lilE650QyHbKzc6PIWgXqmd
	MGGjT8lJs8nhRhvj+uDkh/tz1B5H/VvGmUA+8qzBe64QfpOmYZS8zyNh+ejnb7K1OvN6VS+SyRG
	H5ctXkgyVISRpRUEj7+kTKKmChKLrFDywg6iv3Q==
X-Google-Smtp-Source: AGHT+IHr2ThsGdQtCcOcItjjiHDeJR/H4Tg2szdpz/AaCf4bt15EJa9zH07VzlC1p3stpJp/fhYMSq7J43V38aJacQY=
X-Received: by 2002:a05:651c:49e:b0:2d6:c5d7:8477 with SMTP id
 s30-20020a05651c049e00b002d6c5d78477mr5433987ljc.36.1713781254425; Mon, 22
 Apr 2024 03:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
 <MW5PR84MB1842F4C102CBFA73E861F420AB0D2@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHp75Vd_zfuRc5nV42MHUjyOPQgf0+=A5Yyj8kaO7vYcmQsOzw@mail.gmail.com>
In-Reply-To: <CAHp75Vd_zfuRc5nV42MHUjyOPQgf0+=A5Yyj8kaO7vYcmQsOzw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Apr 2024 12:20:43 +0200
Message-ID: <CAMRc=Me_XTQmWMi-+XAm-FwkEwgUM+rsG2gYP8jLGZaH58c4PA@mail.gmail.com>
Subject: Re: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Elliott, Robert (Servers)" <elliott@hpe.com>, Aapo Vienamo <aapo.vienamo@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 12:02=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 19, 2024 at 11:00=E2=80=AFPM Elliott, Robert (Servers)
> <elliott@hpe.com> wrote:
> > > -----Original Message-----
> > > From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> > > Sent: Friday, April 19, 2024 3:06 AM
>
> ...
>
> > > +static int gnr_gpio_probe(struct platform_device *pdev)
> > > +{
> > > +     size_t num_backup_pins =3D IS_ENABLED(CONFIG_PM_SLEEP) ? GNR_NU=
M_PINS
> > > : 0;
> > > +     struct device *dev =3D &pdev->dev;
> > > +     struct gpio_irq_chip *girq;
> > > +     struct gnr_gpio *priv;
> > > +     void __iomem *regs;
> > > +     int irq, ret;
> > > +
> > > +     priv =3D devm_kzalloc(dev, struct_size(priv, pad_backup,
> > > num_backup_pins), GFP_KERNEL);
> > > +     if (!priv)
> > > +             return -ENOMEM;
> > > +
> > > +     regs =3D devm_platform_ioremap_resource(pdev, 0);
> > > +     if (IS_ERR(regs))
> > > +             return PTR_ERR(regs);
> > > +
> > > +     irq =3D platform_get_irq(pdev, 0);
> > > +     if (irq < 0)
> > > +             return irq;
> > > +
> > > +     ret =3D devm_request_irq(dev, irq, gnr_gpio_irq, IRQF_SHARED |
> > > IRQF_NO_THREAD,
> > > +                            dev_name(dev), priv);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "failed to request inter=
rupt\n");
> >
> > All of these early returns will leave the memory allocated to priv
> > forever, since priv isn't saved anywhere until:
>
> > > +     platform_set_drvdata(pdev, priv);
>
> I'm not sure I got your comment right. Do you think there is a memory
> leak on the error paths above? If so, can you elaborate, because I
> don't see it?
>

Elliott: if probe fails and we return, all devm_ resources will be
released. I don't see any error in this code either.

Bart

