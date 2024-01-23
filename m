Return-Path: <linux-kernel+bounces-35782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFF2839671
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5128B2478D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0A77FBD9;
	Tue, 23 Jan 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFNwnrWA"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5C7FBA1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031070; cv=none; b=tqc4qZ/v4Hn/V+Lf6k33Of4nBgnbe5BaMR/YucRpL0Aw2bxGOA3ozkvZCC30jmJsoyQe0dJVWuOb7chFfPzsU895QhpAUNJUR5H8UjGoJztQ3Az8uCVi6gWsKivHRAcWO1+3q+jv/GTdc3tG72jCjZmuKwpKcBsk2aUQfGlt4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031070; c=relaxed/simple;
	bh=BVjHHxnB0kUSnmJxZjaZ30d+pAJNurs59ft6L8A40FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYZ2IR1a5FnZEaXfDb+XEw9urzVANCs+mkGCgUlOgY/BkGSEbYJoP/ob7ZiQS7UPiZMptZtO4t5wnPbpYQUMoAEgvDokJj7Yidwsrv8kJRnC92b24Hz+EEVyZY9Wa2Ob5JwTtUkrYmts3r/PYj6lX0rxno+PDLA00ctCrfi6++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tFNwnrWA; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7831c604a84so319194985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706031067; x=1706635867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wFVvMcPTA9O9wI9dsmNSl1m60NsVaz3Z3bEn8FjhFOM=;
        b=tFNwnrWAuIn+T+ouAkIL/0DuHDUAXcRFZDqK6TH3KrAYRSaia0XkTH64217vUGXpPC
         L2yo9Rb3i39rxF6u1jwxcwmyGUFohUwE0aOt49TNfhhYZsSIfwUmMoKL6YkYdzguEiaU
         BxAqVnuj0wLKexu4WZPuh6jzrMP6lpAkkRWiWp9l/yVi/55Uwr0GHNwsBDg1zGuedTPJ
         RkDf7hVxdN36B1yd4nnepTLSallNjmleduiXQdR5vUx4EIDH8Ra8JR1pNfLgR4pEzg+i
         xOvN76EsmRF00WxWnPx35072bwEPzTnbDFQXsUMivzZSxsFDuf8SStZuyZf5iOl8g/XA
         DtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031067; x=1706635867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFVvMcPTA9O9wI9dsmNSl1m60NsVaz3Z3bEn8FjhFOM=;
        b=AX41NSlxTvq81yZLSoMbwGJf5/T3skhb4+vzTnXAj0KkeJVCF//nJeBBphEcekffL5
         K7RVf0DrrnPysaXkF9mY6TFNJyhcB0MLFU8tVqUVbP3Q0QV6Grd9Ubm3VNKod0hZMljC
         15a/Y1qzVI9HQf3bg2lb7ljQtBLps+oQoRVKTXG1uRu9EjNs1mtfM782zUFsD7AW+wOI
         W+AWATvN+3nvm2C5EhIS7w4pxz+a4vVpcVhwcl06j6qbjc/oGtl7mf57gGD1ImbKHOzn
         Rit2uGhzyXeYwRX7s7MvUGdbc22ekGTVDarkRm89nJ+Toim4nc2yCK2/3cNseamSlKuM
         djSQ==
X-Gm-Message-State: AOJu0YxsfLaLyvosLhegtAJNkhX9yDnh7TMc3JsXeyqkKukEpfEciiUe
	ibGEmwORNPAVLGchCSq49xVhkZakD9RVgouqzDSXm7CNxkJGcSClZJJn4JWOmLT82R5tq8O2j6Y
	yoGjTUFgf9ys+yL9rOEGwIcx38+ymhgtfOmzyhw==
X-Google-Smtp-Source: AGHT+IExqOZSCeuONz7SSCMdZN/EixYFSp68S4V4xbr4z4v6pt4eWQqoRuRMUJar2Pz8ZfIgocCgo8xj5GNuQjYdKNM=
X-Received: by 2002:ad4:5c4a:0:b0:681:3158:f362 with SMTP id
 a10-20020ad45c4a000000b006813158f362mr1310624qva.70.1706031066525; Tue, 23
 Jan 2024 09:31:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-4-peter.griffin@linaro.org> <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
In-Reply-To: <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 23 Jan 2024 17:30:55 +0000
Message-ID: <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: arnd@arndb.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	linux@roeck-us.net, wim@linux-watchdog.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com, chanho61.park@samsung.com, 
	semen.protsenko@linaro.org, kernel-team@android.com, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-fsd@tesla.com, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your review feedback.

On Tue, 23 Jan 2024 at 11:19, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/01/2024 23:57, Peter Griffin wrote:
> > Instead of obtaining the PMU regmap directly use the new exynos_pmu_*()
> > APIs. The exynos_pmu_ APIs allow support of newer Exynos SoCs that have
> > atomic set/clear bit hardware and platforms where the PMU registers can
> > only be accessed via SMC call.
> >
> > As all platforms that have PMU registers use these new APIs, remove the
> > syscon regmap lookup code, as it is now redundant.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/watchdog/Kconfig       |  1 +
> >  drivers/watchdog/s3c2410_wdt.c | 25 +++++++++----------------
> >  2 files changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 7d22051b15a2..b3e90e1ddf14 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -513,6 +513,7 @@ config S3C2410_WATCHDOG
> >       depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> >       select WATCHDOG_CORE
> >       select MFD_SYSCON if ARCH_EXYNOS
> > +     select EXYNOS_PMU
>
> This does not look compatible with S3C64xx and S5Pv210.

Please refer to my reply to Guenter on how I propose fixing that in v2.

>
> >       help
> >         Watchdog timer block in the Samsung S3C64xx, S5Pv210 and Exynos
> >         SoCs. This will reboot the system when the timer expires with
> > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> > index 349d30462c8c..fd3a9ce870a0 100644
> > --- a/drivers/watchdog/s3c2410_wdt.c
> > +++ b/drivers/watchdog/s3c2410_wdt.c
> > @@ -28,6 +28,8 @@
> >  #include <linux/regmap.h>
> >  #include <linux/delay.h>
> >
> > +#include <linux/soc/samsung/exynos-pmu.h>
> > +
> >  #define S3C2410_WTCON                0x00
> >  #define S3C2410_WTDAT                0x04
> >  #define S3C2410_WTCNT                0x08
> > @@ -187,7 +189,6 @@ struct s3c2410_wdt {
> >       struct watchdog_device  wdt_device;
> >       struct notifier_block   freq_transition;
> >       const struct s3c2410_wdt_variant *drv_data;
> > -     struct regmap *pmureg;
> >  };
> >
> >  static const struct s3c2410_wdt_variant drv_data_s3c2410 = {
> > @@ -355,8 +356,8 @@ static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
> >       const u32 val = mask ? mask_val : 0;
> >       int ret;
> >
> > -     ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg,
> > -                              mask_val, val);
> > +     ret = exynos_pmu_update(wdt->drv_data->disable_reg,
> > +                             mask_val, val);
> >       if (ret < 0)
> >               dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
> >
> > @@ -370,8 +371,8 @@ static int s3c2410wdt_mask_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
> >       const u32 val = (mask ^ val_inv) ? mask_val : 0;
> >       int ret;
> >
> > -     ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_reg,
> > -                              mask_val, val);
> > +     ret = exynos_pmu_update(wdt->drv_data->mask_reset_reg,
> > +                             mask_val, val);
> >       if (ret < 0)
> >               dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
> >
> > @@ -384,8 +385,8 @@ static int s3c2410wdt_enable_counter(struct s3c2410_wdt *wdt, bool en)
> >       const u32 val = en ? mask_val : 0;
> >       int ret;
> >
> > -     ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->cnt_en_reg,
> > -                              mask_val, val);
> > +     ret = exynos_pmu_update(wdt->drv_data->cnt_en_reg,
> > +                             mask_val, val);
> >       if (ret < 0)
> >               dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
> >
> > @@ -617,7 +618,7 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
> >       if (!(wdt->drv_data->quirks & QUIRK_HAS_PMU_RST_STAT))
> >               return 0;
> >
> > -     ret = regmap_read(wdt->pmureg, wdt->drv_data->rst_stat_reg, &rst_stat);
> > +     ret = exynos_pmu_read(wdt->drv_data->rst_stat_reg, &rst_stat);
> >       if (ret)
> >               dev_warn(wdt->dev, "Couldn't get RST_STAT register\n");
> >       else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
> > @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >       if (ret)
> >               return ret;
> >
> > -     if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> > -             wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> > -                                             "samsung,syscon-phandle");
> > -             if (IS_ERR(wdt->pmureg))
> > -                     return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
> > -                                          "syscon regmap lookup failed.\n");
>
>
> Continuing topic from the binding: I don't see how you handle probe
> deferral, suspend ordering.

The current implementation is simply relying on exynos-pmu being
postcore_initcall level.

I was just looking around for any existing Linux APIs that could be a
more robust solution. It looks like

of_parse_phandle()
and
of_find_device_by_node();

Are often used to solve this type of probe deferral issue between
devices. Is that what you would recommend using? Or is there something
even better?

Thanks,

Peter

