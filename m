Return-Path: <linux-kernel+bounces-63639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F248532A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477BA1F276FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDBC57330;
	Tue, 13 Feb 2024 14:07:17 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BDE56767;
	Tue, 13 Feb 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833236; cv=none; b=A7wwfHVxL38fDT81wuEB6lM4RCRKnQssm8kK17eQKJlg2tKf4XzIw/EQ/Ia1JpG1bLutJ7juEuK47rlO+Fyp2L4u4y8NHADqY6M2ziGj6J2rmnMtaELF4q1OwkqO/B9Eqt/9TuIViCh/g7d/V0EIJ6MrizTUdu1qMh2jOumQ+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833236; c=relaxed/simple;
	bh=hCy8XKbHlR7uQt0hNNtGeqc9sm+P7YSZ8tDErY2v34Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCbF/aSIVZXfeujnxOzt5LReJd316ZpxSQC4f737kyaX1sA0/+7vEaVHcoSqVfNmIp+KIh/uviRV3YQB6fPEFPXwMBAAv7eaE915G4qMUZqtbYEyZRIMWPnDy6blun47Ylia1I4GKLVNdWUrMLjngm+nsqoz3duaeDGNBw4lhAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c03fb1d806so141655b6e.0;
        Tue, 13 Feb 2024 06:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833234; x=1708438034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzEZhYWKOOpUs1fPYieciYVVHUhs9BpFyMBaC1l2dEU=;
        b=gwAezByA9barWyTtDjUCufYzPODzpppKiTp2Xk27Hb/XUeBfnR2dvUmucGatJsM5c2
         fp7PX1gIcFrRTPiLnZ+/Y+wfN00bMAxz31oWHPVhoB+pF0K+bFwJ+JmXa52sqRHmChoh
         sfzrtBy1VGIw8YlIwl7xoJAo0BT4a9oLm7L7NN0JQRnggvvm8nJzw4HasNdEsbArHKqe
         9aLV+J2bz4T/+yhuYxY6zhCOXNfpT3zlAi8CR7xgvj2ynyIu46sEqqcGqE5rg67lTyvs
         7/tfqeOaIa4En9hP8UU7OQNrL14aVjAO3DRp64wNCi90mogbvFuJO/4mLHer3PRlaobJ
         C33w==
X-Gm-Message-State: AOJu0Yzo9eHh1u8rFCHJzNl93meaM6AkV1hBZl/5EAZUWKUPknpe0XwA
	8bmP3hV+kWzzW07k1uZyGAXWFXcO43jsWYKD/HPgekRAtiVuu6AwmO/PRxFvwBa2mCXEcsvdVgN
	M599ojxL11h/qgBCEooOnsD2kp7AA5Uy9
X-Google-Smtp-Source: AGHT+IFU9zV/V2+8Z/Xgega9DZ8eVpFDVnakZiWISyrS/fAq4AnPSgcwcz+5TJGmeh9nReRKH596xl5InZWQT6+R8VY=
X-Received: by 2002:a4a:a6cd:0:b0:59c:d8cd:ecee with SMTP id
 i13-20020a4aa6cd000000b0059cd8cdeceemr8771273oom.1.1707833233837; Tue, 13 Feb
 2024 06:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210175922.137704-1-clamor95@gmail.com> <20240210175922.137704-2-clamor95@gmail.com>
In-Reply-To: <20240210175922.137704-2-clamor95@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2024 15:07:02 +0100
Message-ID: <CAJZ5v0j3f9xKpE0XBNrv33u68zo5fasEP5yQU_K5qU2oz7RwgA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] thermal: thermal-generic-adc: add temperature
 sensor function
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 6:59=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> Existing thermal-generic-adc states to be an adc-based thermal
> sensor, which is not entirely true. It provides a thermal sensor
> cell, but it does not provide an IIO sensor cell, which would
> benefit devices that use adc sensors to detect temperature and
> need a custom calibration table.

After reading this changelog and the subject I have to
reverse-engineer the patch to actually find out what's going on.

In particular, are there any user-visible changes of this and if so,
what are they?

> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/thermal/thermal-generic-adc.c | 57 ++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/ther=
mal-generic-adc.c
> index 1717e4a19dcb..7e87d928512c 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -7,6 +7,7 @@
>   * Author: Laxman Dewangan <ldewangan@nvidia.com>
>   */
>  #include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -73,6 +74,60 @@ static const struct thermal_zone_device_ops gadc_therm=
al_ops =3D {
>         .get_temp =3D gadc_thermal_get_temp,
>  };
>
> +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> +       {
> +               .datasheet_name =3D "temp",
> +               .type =3D IIO_TEMP,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +               .indexed =3D 1,
> +               .channel =3D 0,
> +       }
> +};
> +
> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> +                                struct iio_chan_spec const *chan,
> +                                int *temp, int *val2, long mask)
> +{
> +       struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       if (mask !=3D IIO_CHAN_INFO_RAW)
> +               return -EINVAL;
> +
> +       ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, temp);
> +       if (ret < 0)
> +               return ret;
> +
> +       *temp /=3D 1000;
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info gadc_thermal_iio_info =3D {
> +       .read_raw =3D gadc_thermal_read_raw,
> +};
> +
> +static int gadc_iio_register(struct device *dev, struct gadc_thermal_inf=
o *gti)
> +{
> +       struct gadc_thermal_info *gtinfo;
> +       struct iio_dev *indio_dev;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct gadc_therm=
al_info));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       gtinfo =3D iio_priv(indio_dev);
> +       memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
> +
> +       indio_dev->name =3D dev_name(dev);
> +       indio_dev->info =3D &gadc_thermal_iio_info;
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       indio_dev->channels =3D gadc_thermal_iio_channel;
> +       indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_channel);
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
>  static int gadc_thermal_read_linear_lookup_table(struct device *dev,
>                                                  struct gadc_thermal_info=
 *gti)
>  {
> @@ -156,7 +211,7 @@ static int gadc_thermal_probe(struct platform_device =
*pdev)
>
>         devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
>
> -       return 0;
> +       return gadc_iio_register(&pdev->dev, gti);
>  }
>
>  static const struct of_device_id of_adc_thermal_match[] =3D {
> --
> 2.40.1
>

