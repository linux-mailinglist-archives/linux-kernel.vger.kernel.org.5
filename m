Return-Path: <linux-kernel+bounces-76770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FFC85FC47
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5901F260CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED914C5B4;
	Thu, 22 Feb 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCZchb6Q"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDE1474AC;
	Thu, 22 Feb 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615496; cv=none; b=XmpYMV4PboRlktWkYtkJ/subzUXHsTmF6PQtswI9TjEdV9qeJVRA+t3+KgniTUpQReTf/28Fesr6CpYSBDbCLnhOD1sIP3DWnbRhJ7gVnymrMQPXAmFxupT/xYuOUMd2GxCo2XYjZSxg8xaAR9/nwyy/im8zbXDxsvE3lGwm+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615496; c=relaxed/simple;
	bh=PIuBPcgaPYP64DROgSWdjJBcFxfi8DMAGUUPjPDY8KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLvclCvy+teZbDuR69K9PzkpJjnrj8a3zo1m/ueY5+XliOpxWIoTV7P9UAHg1Sh9mbiT+GOQQTO2zZ902zKZx/RLicWUECMCWRy4hLvuBOnQRcIOov62u7rAQ49iYLGIT8NdzDOpLUwjIrRTfdgC2RCiepZ+4YKm3zSjoJsxEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCZchb6Q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e3ffafa708so5249118b3a.1;
        Thu, 22 Feb 2024 07:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615494; x=1709220294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aXQfNeMLkgL8vNtlootrbSOlal3IIy+GDwI0MRVyyC8=;
        b=ZCZchb6QwRsqlA09Bjp8kQCk+ufUG9+Q7TP+ksBUC0Kj6UY0+RrrL6qTRtBX+Fx9Vc
         Jo4h+SnoKgOGzbVNdWhc4BRBO8oCmuGzVxCuDS9qUcar8pyAtPkB3H/kWL+zq7XDJNr7
         Ubf7doBX338beOpmN5XxDuK/A1QLtWmrXaQ8iGAxJ7xg1dwwO5oUGa6jjmJJWBT3dTnq
         mQm0mB3VwhFPUul/8StkxCjT0ABL/uaDjNFoADJGlb6K6xdVdLF49pCa1lr3KrVR/qBo
         a0ZbqCsDz6EcjUFqSqlwoBXJHBlfkgfLWAIJcMwjfUwKa+vroPbppbmlEpmw87glennm
         pVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615494; x=1709220294;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXQfNeMLkgL8vNtlootrbSOlal3IIy+GDwI0MRVyyC8=;
        b=mjZRZ1rm6sX8lW1twirzsCUuvdksgdvha3oAS56wcaN8jkDMd+4Ep2fOKKJmNymhR7
         Cwp0YN3hMAvvr7dhXFGSb13phLNCUQ/SMAGp1hOVePaIKhsGqf5xknxl7yShkqT30dPW
         xqHmnXMk6ZVz2ROmsaVtcQS/37RwM4Y1yPk3KNoovcWI4HBSZUrINfalTmKvjmQyBUnv
         od2JDeKnGRU/pvGF1r0abZB1bjkCULxvpRCtr7MHmdQrWg57cGU/Ct3E7MeLM6b0nBNw
         OAYhJr9D1Llk0vjMzr1hdhgykxTdvR1YlEEtQvfA7SuLU4YvwFoIR9vyJuoQbZ8WdKcV
         /mFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy6q+uzbA7a8luup9CwrG1D6svzy0fpZuazU46T9/EAyA3arogiQ+stuibvKE8W5KNSD6jSRYYIyRz76cj8FlqU+lFMIHWDO9wWCOQSPRdJZ/Tm4FJicrv0kuXr30XOEEh7EVGP/WBqLawEd3ikugg0ojifP8qRdhaDcW05Mp+6i7n8s3+3mnRpEnHzRfNgRkyxK/jE01uj+KYXRzv3s5iNTFqQlAHUsaIL5CkOqMyMiXo01jC/KIVuewL
X-Gm-Message-State: AOJu0YwuQ1l4i0ecFOJ7mDz64dl3hDth0ch1mmqkG9XvOPF8xrvWWPem
	9VB/3/DvkPY03Sq+kUIET2FVYLTi8NORE1WqvChLvn4wWeuSjCpo
X-Google-Smtp-Source: AGHT+IFOCTi3dMlzjGviA7Kz3InAm5islYUdD+oRHJxhgo5nOUg6H4x7H8pBurwv2VMO/+nCHiFKIQ==
X-Received: by 2002:a05:6a21:3994:b0:19c:a4d3:2041 with SMTP id ad20-20020a056a21399400b0019ca4d32041mr31039509pzc.42.1708615494137;
        Thu, 22 Feb 2024 07:24:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78ec2000000b006e4d2cbcac8sm998069pfr.94.2024.02.22.07.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:24:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4a545c16-7518-49d2-b158-7fcabe3508c5@roeck-us.net>
Date: Thu, 22 Feb 2024 07:24:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] devm-helpers: Add resource managed version of mutex
 init
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Aleksandr Mezin <mezin.alexander@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-gpio@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240222145838.12916-1-kabel@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240222145838.12916-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 06:58, Marek Behún wrote:
> A few drivers are doing resource-managed mutex initialization by
> implementing ad-hoc one-liner mutex dropping functions and using them
> with devm_add_action_or_reset(). Help drivers avoid these repeated
> one-liners by adding managed version of mutex initialization.
> 
> Use the new function devm_mutex_init() in the following drivers:
>    drivers/gpio/gpio-pisosr.c
>    drivers/gpio/gpio-sim.c
>    drivers/gpu/drm/xe/xe_hwmon.c
>    drivers/hwmon/nzxt-smart2.c
>    drivers/leds/leds-is31fl319x.c
>    drivers/power/supply/mt6370-charger.c
>    drivers/power/supply/rt9467-charger.c
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>   drivers/gpio/gpio-pisosr.c            |  9 ++-----
>   drivers/gpio/gpio-sim.c               | 12 ++--------
>   drivers/gpu/drm/xe/xe_hwmon.c         | 11 ++-------
>   drivers/hwmon/nzxt-smart2.c           |  9 ++-----
>   drivers/leds/leds-is31fl319x.c        |  9 ++-----
>   drivers/power/supply/mt6370-charger.c | 11 +--------
>   drivers/power/supply/rt9467-charger.c | 34 ++++-----------------------
>   include/linux/devm-helpers.h          | 32 +++++++++++++++++++++++++
>   8 files changed, 47 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
> index e3013e778e15..dddbf37e855f 100644
> --- a/drivers/gpio/gpio-pisosr.c
> +++ b/drivers/gpio/gpio-pisosr.c
> @@ -7,6 +7,7 @@
>   #include <linux/bitmap.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/gpio/driver.h>
>   #include <linux/module.h>
> @@ -116,11 +117,6 @@ static const struct gpio_chip template_chip = {
>   	.can_sleep		= true,
>   };
>   
> -static void pisosr_mutex_destroy(void *lock)
> -{
> -	mutex_destroy(lock);
> -}
> -
>   static int pisosr_gpio_probe(struct spi_device *spi)
>   {
>   	struct device *dev = &spi->dev;
> @@ -147,8 +143,7 @@ static int pisosr_gpio_probe(struct spi_device *spi)
>   		return dev_err_probe(dev, PTR_ERR(gpio->load_gpio),
>   				     "Unable to allocate load GPIO\n");
>   
> -	mutex_init(&gpio->lock);
> -	ret = devm_add_action_or_reset(dev, pisosr_mutex_destroy, &gpio->lock);
> +	ret = devm_mutex_init(dev, &gpio->lock);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index c4106e37e6db..fcfcaa4efe70 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -12,6 +12,7 @@
>   #include <linux/completion.h>
>   #include <linux/configfs.h>
>   #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/err.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/gpio/driver.h>
> @@ -307,13 +308,6 @@ static ssize_t gpio_sim_sysfs_pull_store(struct device *dev,
>   	return len;
>   }
>   
> -static void gpio_sim_mutex_destroy(void *data)
> -{
> -	struct mutex *lock = data;
> -
> -	mutex_destroy(lock);
> -}
> -
>   static void gpio_sim_put_device(void *data)
>   {
>   	struct device *dev = data;
> @@ -457,9 +451,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
>   	if (ret)
>   		return ret;
>   
> -	mutex_init(&chip->lock);
> -	ret = devm_add_action_or_reset(dev, gpio_sim_mutex_destroy,
> -				       &chip->lock);
> +	ret = devm_mutex_init(dev, &chip->lock);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/xe/xe_hwmon.c b/drivers/gpu/drm/xe/xe_hwmon.c
> index 174ed2185481..bb88ae1c196c 100644
> --- a/drivers/gpu/drm/xe/xe_hwmon.c
> +++ b/drivers/gpu/drm/xe/xe_hwmon.c
> @@ -3,6 +3,7 @@
>    * Copyright © 2023 Intel Corporation
>    */
>   
> +#include <linux/devm-helpers.h>
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/hwmon.h>
>   #include <linux/types.h>
> @@ -729,13 +730,6 @@ xe_hwmon_get_preregistration_info(struct xe_device *xe)
>   		xe_hwmon_energy_get(hwmon, &energy);
>   }
>   
> -static void xe_hwmon_mutex_destroy(void *arg)
> -{
> -	struct xe_hwmon *hwmon = arg;
> -
> -	mutex_destroy(&hwmon->hwmon_lock);
> -}
> -
>   void xe_hwmon_register(struct xe_device *xe)
>   {
>   	struct device *dev = xe->drm.dev;
> @@ -751,8 +745,7 @@ void xe_hwmon_register(struct xe_device *xe)
>   
>   	xe->hwmon = hwmon;
>   
> -	mutex_init(&hwmon->hwmon_lock);
> -	if (devm_add_action_or_reset(dev, xe_hwmon_mutex_destroy, hwmon))
> +	if (devm_mutex_init(dev, &hwmon->hwmon_lock))
>   		return;
>   
>   	/* primary GT to access device level properties */
> diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
> index 7aa586eb74be..00bc89607673 100644
> --- a/drivers/hwmon/nzxt-smart2.c
> +++ b/drivers/hwmon/nzxt-smart2.c
> @@ -5,6 +5,7 @@
>    * Copyright (c) 2021 Aleksandr Mezin
>    */
>   
> +#include <linux/devm-helpers.h>
>   #include <linux/hid.h>
>   #include <linux/hwmon.h>
>   #include <linux/math.h>
> @@ -721,11 +722,6 @@ static int __maybe_unused nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
>   	return init_device(drvdata, drvdata->update_interval);
>   }
>   
> -static void mutex_fini(void *lock)
> -{
> -	mutex_destroy(lock);
> -}
> -
>   static int nzxt_smart2_hid_probe(struct hid_device *hdev,
>   				 const struct hid_device_id *id)
>   {
> @@ -741,8 +737,7 @@ static int nzxt_smart2_hid_probe(struct hid_device *hdev,
>   
>   	init_waitqueue_head(&drvdata->wq);
>   
> -	mutex_init(&drvdata->mutex);
> -	ret = devm_add_action_or_reset(&hdev->dev, mutex_fini, &drvdata->mutex);
> +	ret = devm_mutex_init(&hdev->dev, &drvdata->mutex);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
> index 66c65741202e..e9d7cf6a386c 100644
> --- a/drivers/leds/leds-is31fl319x.c
> +++ b/drivers/leds/leds-is31fl319x.c
> @@ -8,6 +8,7 @@
>    * effect LEDs.
>    */
>   
> +#include <linux/devm-helpers.h>
>   #include <linux/err.h>
>   #include <linux/i2c.h>
>   #include <linux/leds.h>
> @@ -495,11 +496,6 @@ static inline int is31fl3196_db_to_gain(u32 dezibel)
>   	return dezibel / IS31FL3196_AUDIO_GAIN_DB_STEP;
>   }
>   
> -static void is31f1319x_mutex_destroy(void *lock)
> -{
> -	mutex_destroy(lock);
> -}
> -
>   static int is31fl319x_probe(struct i2c_client *client)
>   {
>   	struct is31fl319x_chip *is31;
> @@ -515,8 +511,7 @@ static int is31fl319x_probe(struct i2c_client *client)
>   	if (!is31)
>   		return -ENOMEM;
>   
> -	mutex_init(&is31->lock);
> -	err = devm_add_action_or_reset(dev, is31f1319x_mutex_destroy, &is31->lock);
> +	err = devm_mutex_init(dev, &is31->lock);
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
> index e24fce087d80..fa0517d0352d 100644
> --- a/drivers/power/supply/mt6370-charger.c
> +++ b/drivers/power/supply/mt6370-charger.c
> @@ -766,13 +766,6 @@ static int mt6370_chg_init_psy(struct mt6370_priv *priv)
>   	return PTR_ERR_OR_ZERO(priv->psy);
>   }
>   
> -static void mt6370_chg_destroy_attach_lock(void *data)
> -{
> -	struct mutex *attach_lock = data;
> -
> -	mutex_destroy(attach_lock);
> -}
> -
>   static void mt6370_chg_destroy_wq(void *data)
>   {
>   	struct workqueue_struct *wq = data;
> @@ -900,9 +893,7 @@ static int mt6370_chg_probe(struct platform_device *pdev)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to init psy\n");
>   
> -	mutex_init(&priv->attach_lock);
> -	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_attach_lock,
> -				       &priv->attach_lock);
> +	ret = devm_mutex_init(dev, &priv->attach_lock);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to init attach lock\n");
>   
> diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
> index fdfdc83ab045..84f07c22077f 100644
> --- a/drivers/power/supply/rt9467-charger.c
> +++ b/drivers/power/supply/rt9467-charger.c
> @@ -10,6 +10,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/completion.h>
>   #include <linux/delay.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
> @@ -1149,27 +1150,6 @@ static int rt9467_reset_chip(struct rt9467_chg_data *data)
>   	return regmap_field_write(data->rm_field[F_RST], 1);
>   }
>   
> -static void rt9467_chg_destroy_adc_lock(void *data)
> -{
> -	struct mutex *adc_lock = data;
> -
> -	mutex_destroy(adc_lock);
> -}
> -
> -static void rt9467_chg_destroy_attach_lock(void *data)
> -{
> -	struct mutex *attach_lock = data;
> -
> -	mutex_destroy(attach_lock);
> -}
> -
> -static void rt9467_chg_destroy_ichg_ieoc_lock(void *data)
> -{
> -	struct mutex *ichg_ieoc_lock = data;
> -
> -	mutex_destroy(ichg_ieoc_lock);
> -}
> -
>   static void rt9467_chg_complete_aicl_done(void *data)
>   {
>   	struct completion *aicl_done = data;
> @@ -1222,21 +1202,15 @@ static int rt9467_charger_probe(struct i2c_client *i2c)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to add irq chip\n");
>   
> -	mutex_init(&data->adc_lock);
> -	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_adc_lock,
> -				       &data->adc_lock);
> +	ret = devm_mutex_init(dev, &data->adc_lock);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to init ADC lock\n");
>   
> -	mutex_init(&data->attach_lock);
> -	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_attach_lock,
> -				       &data->attach_lock);
> +	ret = devm_mutex_init(dev, &data->attach_lock);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to init attach lock\n");
>   
> -	mutex_init(&data->ichg_ieoc_lock);
> -	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_ichg_ieoc_lock,
> -				       &data->ichg_ieoc_lock);
> +	ret = devm_mutex_init(dev, &data->ichg_ieoc_lock);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to init ICHG/IEOC lock\n");
>   
> diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
> index 74891802200d..70640fb96117 100644
> --- a/include/linux/devm-helpers.h
> +++ b/include/linux/devm-helpers.h
> @@ -24,6 +24,8 @@
>    */
>   
>   #include <linux/device.h>
> +#include <linux/kconfig.h>
> +#include <linux/mutex.h>
>   #include <linux/workqueue.h>
>   
>   static inline void devm_delayed_work_drop(void *res)
> @@ -76,4 +78,34 @@ static inline int devm_work_autocancel(struct device *dev,
>   	return devm_add_action(dev, devm_work_drop, w);
>   }
>   
> +static inline void devm_mutex_drop(void *res)
> +{
> +	mutex_destroy(res);
> +}
> +
> +/**
> + * devm_mutex_init - Resource managed mutex initialization
> + * @dev:	Device which lifetime mutex is bound to
> + * @lock:	Mutex to be initialized (and automatically destroyed)
> + *
> + * Initialize mutex which is automatically destroyed when driver is detached.
> + * A few drivers initialize mutexes which they want destroyed before driver is
> + * detached, for debugging purposes.
> + * devm_mutex_init() can be used to omit the explicit mutex_destroy() call when
> + * driver is detached.
> + */
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	mutex_init(lock);
> +
> +	/*
> +	 * mutex_destroy() is an empty function if CONFIG_DEBUG_MUTEXES is
> +	 * disabled. No need to allocate an action in that case.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEBUG_MUTEXES))
> +		return devm_add_action_or_reset(dev, devm_mutex_drop, lock);
> +	else

else after return is unnecessary.

> +		return 0;
> +}
> +
>   #endif


