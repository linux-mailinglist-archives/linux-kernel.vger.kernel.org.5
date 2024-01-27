Return-Path: <linux-kernel+bounces-41395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6D83F012
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2371F1F24044
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF881A723;
	Sat, 27 Jan 2024 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LE0BRl6u"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6819474
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706389176; cv=none; b=HDfDEpNp9iGS6dVBsQ9azdignlR1RErrBEz878nKcOO5Ao5W5rT2atuq4nujKmv0VEakiq3O3cahTJJhuoj2ZZJ3FyHdoRsfAi6RPd9VFsG4UrLBXhOiZzS3sMHnL2Lmaz1vWg5Lj7/x7s9hlkbGFtEnivFn2xWlq7ioNsrZ3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706389176; c=relaxed/simple;
	bh=X7sfGFwjXzv3hDjZ7pBOcFdlwJFwBoQuoJ8UWnTjxa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeCZkkUUwdQZSIk0oW60wOBzRsxye/gwUuqbij9uU9iBMZ9RSeLEwQVm8fm0NewKhLuumqRoSvcK7IQ70BgCWSwtAkkcyRy0DydaHET8pQqACghGhuR3fYrjvggK0w/ZnEknYR+qiar6n3jncPkjtv3Q22p9LOrESDky8CtKtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LE0BRl6u; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7838af983c1so122782185a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 12:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706389172; x=1706993972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi+XXGXLtGOnaTnHAzpID7MnZZG5IPUxmL4L9FGcLVk=;
        b=LE0BRl6u8pGAYbXPj2TltHHMj5sgjsvlRiXMPjku3ejzVRa74uhaY9HkJxhUoNZ7FB
         gJA27MdJNPaQSGYaRm+DrNgFLj52sbOAj581XOJktHeHu2bbG0M5v0QE5kADi3WGWKdR
         fF7UOFRaeEbL3Rctx8TH2RelGg/lEs7XIOvhixiRgKmWrHP1YabP4uLofVYF9hFRbdEC
         l+p+03d9MJT6xjSwhDUFJ6J7EZRiZVyvcxzI6rh35Yu/Qlti3CQ9DkLH/A44yI5ksJwA
         A63VbGTMWJFqq3rKTaecturOD8PanVubpBdsUOLu1fx4yirmAiM/pB71a6wi95b3hEB0
         ni9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706389172; x=1706993972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi+XXGXLtGOnaTnHAzpID7MnZZG5IPUxmL4L9FGcLVk=;
        b=omgEUmo1gCjM93xzxNwftSXi3h6db7P2pl2LC3Q3TwRdCARN/+YswfYcSchldscUrp
         NpLZoIpJFfrIG3uBBGsl8y0Y9EnJrLfuti+NmVAe5A8pLb30oInmMXoG+wYHsTECG8B2
         a5hLSgF+iPapRCLul3ovwCfx2upJc3Wsv0/UK3g6gAJmUR6HZyvU3mWFOQcAjuSPdO03
         lqFJrkfWmpFNOwPSUvyGZXq8Ob1yIjADC1Y/BRnvVYk33FF7XS1id6vB0Jhel+gCpt6L
         /UMTeBxNKHHvStq4XmhP6tUTFrozri68YfGn1be1SlF2jwc8EkPGqip5BhNP8uinH8UA
         54Vg==
X-Gm-Message-State: AOJu0Yz14xWmp1McdSEygC/DZxuy8JDLFL96219h5YRH01Rg7ZzyCuV4
	Jo+5NbG0Sv/ax7WARVBazKnIeCxxtD6TbG4tTAbOOrwVpAec/v9A3lSU8Kx/H+eMo/ToZ0Yx8UI
	dE13ULcv+m2A5/mV3B2vfzg/g8WqOHOH2SROsaQ==
X-Google-Smtp-Source: AGHT+IHfJzVeJM2xkAmUTr8ZLVYE1O6BzSpTjAVfgyKB0IlYK7KettRLZzpgOBAYKoyC3tCT7jMMH6X40Yjsa9zTcz0=
X-Received: by 2002:ac8:5893:0:b0:42a:96ef:6deb with SMTP id
 t19-20020ac85893000000b0042a96ef6debmr1350096qta.61.1706389172118; Sat, 27
 Jan 2024 12:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-j7200-pcie-s2r-v2-0-8e4f7d228ec2@bootlin.com> <20240102-j7200-pcie-s2r-v2-1-8e4f7d228ec2@bootlin.com>
In-Reply-To: <20240102-j7200-pcie-s2r-v2-1-8e4f7d228ec2@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 27 Jan 2024 21:59:21 +0100
Message-ID: <CAMRc=MepTF6vV=MwqDNL2_PRjymn18b-RH7TN5TYAGaO=VGDWw@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] gpio: pca953x: move suspend()/resume() to suspend_noirq()/resume_noirq()
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	Vignesh R <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Tom Joseph <tjoseph@cadence.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, 
	gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
	thomas.petazzoni@bootlin.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 3:37=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> Some IOs can be needed during suspend_noirq()/resume_noirq().
> So move suspend()/resume() to noirq.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 00ffa168e405..6e495fc67a93 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -1234,7 +1234,7 @@ static void pca953x_save_context(struct pca953x_chi=
p *chip)
>         regcache_cache_only(chip->regmap, true);
>  }
>
> -static int pca953x_suspend(struct device *dev)
> +static int pca953x_suspend_noirq(struct device *dev)
>  {
>         struct pca953x_chip *chip =3D dev_get_drvdata(dev);
>
> @@ -1248,7 +1248,7 @@ static int pca953x_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int pca953x_resume(struct device *dev)
> +static int pca953x_resume_noirq(struct device *dev)
>  {
>         struct pca953x_chip *chip =3D dev_get_drvdata(dev);
>         int ret;
> @@ -1268,7 +1268,8 @@ static int pca953x_resume(struct device *dev)
>         return ret;
>  }
>
> -static DEFINE_SIMPLE_DEV_PM_OPS(pca953x_pm_ops, pca953x_suspend, pca953x=
_resume);
> +static DEFINE_NOIRQ_DEV_PM_OPS(pca953x_pm_ops,
> +                              pca953x_suspend_noirq, pca953x_resume_noir=
q);
>
>  /* convenience to stop overlong match-table lines */
>  #define OF_653X(__nrgpio, __int) ((void *)(__nrgpio | PCAL653X_TYPE | __=
int))
>
> --
> 2.39.2
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

