Return-Path: <linux-kernel+bounces-76768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59AE85FC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B7D28ACDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE7614C5B9;
	Thu, 22 Feb 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9NSiHAY"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3B14C5AF;
	Thu, 22 Feb 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615395; cv=none; b=B3/dQym++IkhRaVYap6WAvNNx2D3A2sgIVb+FJ1ArFpQu6sYp8pt+dDwt+Q2+6cYBqeLBTX71U+6F9jfZOw2oUQgZZUnmXR9MGFnXTws1O6S63QhawbBdbSHgMuLG1sneus5ZbScQW8MdK2z4wPtroYzXJfWB8DNqs0P0YxYBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615395; c=relaxed/simple;
	bh=+ZN8UG6yOE1/Kkd3lW/LjDTmZSDVEFOJ3z0ODzVRDng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8kEG1FHYu+TyTn3BsWv7SWTu3dEyj7pVoSPE76dmqHRu6Me7HYYlAZjeboap6X26CEFMtOflpx7uvIB5N8bOSsSUU2C89wjAYNgobUsJIt1xxn6r3A0TM+IaoHMfrGiUqh4IzDyxVioPnpldrZwq1FdLIJNOe2fyeH0fk23Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9NSiHAY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e45bd5014dso2192782b3a.1;
        Thu, 22 Feb 2024 07:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615392; x=1709220192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=18aJgkLrhUb7en6e+9IVDc7Sm8XASVYQ/8bIVIOkYlw=;
        b=J9NSiHAYWpjTK04Xn4Yq3CFxhJXY2TDEjpwNGVVGbc4ii28EFf19vT6quM+YNrzhIp
         LNvdxfEBpVuk3LyIYJIDq0cTH7PpYTsC/IqYMgMVKEOU07UiY1VEM0h7NHXrbpsqkM22
         sXmvoJij4zaXQ7WscmlnJbaDBspHG8EbAtwj712xqC36wPOkPhp+9dz+yuRX3oHvuAT7
         IYkfz8n/uviREwVnbkSPBy3aoZPhYxVFKC8vfDBdF8dF+fG/d+y0Yosj9saBxXoJdSMU
         TkjDhp39EsKTJYJXrbW0aRvrHlYlmZPqiQXZe7QsnUTM45M5kypr+N7l5oneTiHT1U9w
         gskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615392; x=1709220192;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18aJgkLrhUb7en6e+9IVDc7Sm8XASVYQ/8bIVIOkYlw=;
        b=PTyKoDjQbRBZgAdkxKs3Dh/RH5t1ggI/8kC1Wxfy+m0bDv2VlpGrQrcf7QsE1sCcP9
         A5xq+8YYLqgxQDR+hKvQv9QcViWDwE7t8vjPXUDKCS8Bvh/IvSX2ZNyl6mITshUT+CXy
         2v83rkmsNjEnkOkdEyBZnHX6OjD2i6J9S4Zvw9cHK4u7BDIwyJsRR1C5ZidB23EENM49
         K675wNJrYjF/VQtLPZ3x2O5GzFf94g8+EegVt89sRm25wFOP28O+Mq3wJbE9foMoNZ54
         EZvOAMBTueEsv4g27p5YKv3ef4+ZGMaIsiOSZG48K/6fr3LNQRkpmXcZ+d3ciQ/Fs6zQ
         +WwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMVEeD2H3AkzR+W2MMqxiDKFc+mcFGIl51uQI+BLCxZ3toOdEbTP9dCUgV0RLLZHQpnfe5lw79aFJkv3lffYqr2jJUF0hbZFKq0oOSQAcqYXKP+n6CzQKsoW7pDCOcqNP0RW5ELzRehrFM3y+Yqo0DeKamFzyIyyo76fKAFb6yu0SZ+ILDYZROVqwKzY+leLqBL4GoizwfkJPWdyiVXCZyuR/36Ok4ZQ6kj7a9PH5kZuqVbjd+fYSMkfn6iU+z
X-Gm-Message-State: AOJu0YwCzoV9cbuJ9t0vuexRX1JRkhNz5W3rx91I8ufFGCGKqlmycEzK
	OLm+S6KD44dcgdg3h6Jj5lg/CUztlM5fuEBHX5y6Q+gcXuB/dS9R
X-Google-Smtp-Source: AGHT+IFgO7x6qc0DEEnZN42M8DGEgpD5a4mxPzQSd1CZmh4j5qF92F7sS0zFuKoONna795EqP51M4g==
X-Received: by 2002:aa7:91d1:0:b0:6e0:4e7e:ef57 with SMTP id z17-20020aa791d1000000b006e04e7eef57mr19247160pfa.32.1708615392201;
        Thu, 22 Feb 2024 07:23:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78ec2000000b006e4d2cbcac8sm998069pfr.94.2024.02.22.07.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:23:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a336a642-838c-48e9-aea3-703fd0d017bc@roeck-us.net>
Date: Thu, 22 Feb 2024 07:23:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] devm-helpers: Add resource managed version of debugfs
 directory create function
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Bamvor Jian Zhang <bamv2005@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Douglas Anderson <dianders@chromium.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
 linux-crypto@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org
References: <20240222145838.12916-1-kabel@kernel.org>
 <20240222145838.12916-2-kabel@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240222145838.12916-2-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 06:58, Marek Behún wrote:
> A few drivers register a devm action to remove a debugfs directory,
> implementing a one-liner function that calls debufs_remove_recursive().
> Help drivers avoid this repeated implementations by adding managed
> version of debugfs directory create function.
> 
> Use the new function devm_debugfs_create_dir() in the following
> drivers:
>    drivers/crypto/caam/ctrl.c
>    drivers/gpu/drm/bridge/ti-sn65dsi86.c
>    drivers/hwmon/hp-wmi-sensors.c
>    drivers/hwmon/mr75203.c
>    drivers/hwmon/pmbus/pmbus_core.c
> 
> Also use the action function devm_debugfs_dir_recursive_drop() in
> drivers
>    drivers/cxl/mem.c
>    drivers/gpio/gpio-mockup.c
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>   drivers/crypto/caam/ctrl.c            | 16 +++------
>   drivers/cxl/mem.c                     |  9 ++---
>   drivers/gpio/gpio-mockup.c            | 11 ++----
>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 13 ++------
>   drivers/hwmon/hp-wmi-sensors.c        | 15 ++-------
>   drivers/hwmon/mr75203.c               | 15 +++------
>   drivers/hwmon/pmbus/pmbus_core.c      | 16 +++------
>   include/linux/devm-helpers.h          | 48 +++++++++++++++++++++++++++
>   8 files changed, 72 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
> index bdf367f3f679..ea3ed9a17f1a 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/of_address.h>
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
> @@ -604,11 +605,6 @@ static int init_clocks(struct device *dev, const struct caam_imx_data *data)
>   	return devm_add_action_or_reset(dev, disable_clocks, ctrlpriv);
>   }
>   
> -static void caam_remove_debugfs(void *root)
> -{
> -	debugfs_remove_recursive(root);
> -}
> -
>   #ifdef CONFIG_FSL_MC_BUS
>   static bool check_version(struct fsl_mc_version *mc_version, u32 major,
>   			  u32 minor, u32 revision)
> @@ -1058,13 +1054,9 @@ static int caam_probe(struct platform_device *pdev)
>   	ctrlpriv->era = caam_get_era(perfmon);
>   	ctrlpriv->domain = iommu_get_domain_for_dev(dev);
>   
> -	dfs_root = debugfs_create_dir(dev_name(dev), NULL);
> -	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> -		ret = devm_add_action_or_reset(dev, caam_remove_debugfs,
> -					       dfs_root);
> -		if (ret)
> -			return ret;
> -	}
> +	dfs_root = devm_debugfs_create_dir(dev, dev_name(dev), NULL);
> +	if (IS_ERR(dfs_root))
> +		return PTR_ERR(dfs_root);
>   
>   	caam_debugfs_init(ctrlpriv, perfmon, dfs_root);
>   
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c5c9d8e0d88d..4b38514887a4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -2,6 +2,7 @@
>   /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>   #include <linux/debugfs.h>
>   #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   
> @@ -30,11 +31,6 @@ static void enable_suspend(void *data)
>   	cxl_mem_active_dec();
>   }
>   
> -static void remove_debugfs(void *dentry)
> -{
> -	debugfs_remove_recursive(dentry);
> -}
> -
>   static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>   {
>   	struct device *dev = file->private;
> @@ -138,7 +134,8 @@ static int cxl_mem_probe(struct device *dev)
>   		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>   				    &cxl_poison_clear_fops);
>   
> -	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
> +	rc = devm_add_action_or_reset(dev, devm_debugfs_dir_recursive_drop,
> +				      dentry);
>   	if (rc)
>   		return rc;
>   
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 455eecf6380e..adbe0fe09490 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -12,6 +12,7 @@
>   #include <linux/cleanup.h>
>   #include <linux/debugfs.h>
>   #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/gpio/driver.h>
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
> @@ -390,13 +391,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
>   	}
>   }
>   
> -static void gpio_mockup_debugfs_cleanup(void *data)
> -{
> -	struct gpio_mockup_chip *chip = data;
> -
> -	debugfs_remove_recursive(chip->dbg_dir);
> -}
> -
>   static void gpio_mockup_dispose_mappings(void *data)
>   {
>   	struct gpio_mockup_chip *chip = data;
> @@ -480,7 +474,8 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>   
>   	gpio_mockup_debugfs_setup(dev, chip);
>   
> -	return devm_add_action_or_reset(dev, gpio_mockup_debugfs_cleanup, chip);
> +	return devm_add_action_or_reset(dev, devm_debugfs_dir_recursive_drop,
> +					chip->dbg_dir);
>   }
>   
>   static const struct of_device_id gpio_mockup_of_match[] = {
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 62cc3893dca5..ad0ed2459394 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -10,6 +10,7 @@
>   #include <linux/bits.h>
>   #include <linux/clk.h>
>   #include <linux/debugfs.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/gpio/driver.h>
>   #include <linux/i2c.h>
> @@ -427,18 +428,12 @@ static int status_show(struct seq_file *s, void *data)
>   
>   DEFINE_SHOW_ATTRIBUTE(status);
>   
> -static void ti_sn65dsi86_debugfs_remove(void *data)
> -{
> -	debugfs_remove_recursive(data);
> -}
> -
>   static void ti_sn65dsi86_debugfs_init(struct ti_sn65dsi86 *pdata)
>   {
>   	struct device *dev = pdata->dev;
>   	struct dentry *debugfs;
> -	int ret;
>   
> -	debugfs = debugfs_create_dir(dev_name(dev), NULL);
> +	debugfs = devm_debugfs_create_dir(dev, dev_name(dev), NULL);
>   
>   	/*
>   	 * We might get an error back if debugfs wasn't enabled in the kernel
> @@ -447,10 +442,6 @@ static void ti_sn65dsi86_debugfs_init(struct ti_sn65dsi86 *pdata)
>   	if (IS_ERR_OR_NULL(debugfs))
>   		return;
>   
> -	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_debugfs_remove, debugfs);
> -	if (ret)
> -		return;
> -
>   	debugfs_create_file("status", 0600, debugfs, pdata, &status_fops);
>   }
>   
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index b5325d0e72b9..2a7c33763ce8 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -23,6 +23,7 @@
>   
>   #include <linux/acpi.h>
>   #include <linux/debugfs.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/hwmon.h>
>   #include <linux/jiffies.h>
>   #include <linux/mutex.h>
> @@ -1304,12 +1305,6 @@ static int current_reading_show(struct seq_file *seqf, void *ignored)
>   }
>   DEFINE_SHOW_ATTRIBUTE(current_reading);
>   
> -/* hp_wmi_devm_debugfs_remove - devm callback for debugfs cleanup */
> -static void hp_wmi_devm_debugfs_remove(void *res)
> -{
> -	debugfs_remove_recursive(res);
> -}
> -
>   /* hp_wmi_debugfs_init - create and populate debugfs directory tree */
>   static void hp_wmi_debugfs_init(struct device *dev, struct hp_wmi_info *info,
>   				struct hp_wmi_platform_events *pevents,
> @@ -1320,21 +1315,15 @@ static void hp_wmi_debugfs_init(struct device *dev, struct hp_wmi_info *info,
>   	struct dentry *debugfs;
>   	struct dentry *entries;
>   	struct dentry *dir;
> -	int err;
>   	u8 i;
>   
>   	/* dev_name() gives a not-very-friendly GUID for WMI devices. */
>   	scnprintf(buf, sizeof(buf), "hp-wmi-sensors-%u", dev->id);
>   
> -	debugfs = debugfs_create_dir(buf, NULL);
> +	debugfs = devm_debugfs_create_dir(dev, buf, NULL);
>   	if (IS_ERR(debugfs))
>   		return;
>   
> -	err = devm_add_action_or_reset(dev, hp_wmi_devm_debugfs_remove,
> -				       debugfs);
> -	if (err)
> -		return;
> -
>   	entries = debugfs_create_dir("sensor", debugfs);
>   
>   	for (i = 0; i < icount; i++, info++) {
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 50a8b9c3f94d..50f348fca108 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -10,6 +10,7 @@
>   #include <linux/bits.h>
>   #include <linux/clk.h>
>   #include <linux/debugfs.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/hwmon.h>
>   #include <linux/kstrtox.h>
>   #include <linux/module.h>
> @@ -216,17 +217,11 @@ static const struct file_operations pvt_ts_coeff_j_fops = {
>   	.llseek = default_llseek,
>   };
>   
> -static void devm_pvt_ts_dbgfs_remove(void *data)
> -{
> -	struct pvt_device *pvt = (struct pvt_device *)data;
> -
> -	debugfs_remove_recursive(pvt->dbgfs_dir);
> -	pvt->dbgfs_dir = NULL;
> -}
> -
>   static int pvt_ts_dbgfs_create(struct pvt_device *pvt, struct device *dev)
>   {
> -	pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
> +	pvt->dbgfs_dir = devm_debugfs_create_dir(dev, dev_name(dev), NULL);
> +	if (IS_ERR(pvt->dbgfs_dir))
> +		return PTR_ERR(pvt->dbgfs_dir);
>   
>   	debugfs_create_u32("ts_coeff_h", 0644, pvt->dbgfs_dir,
>   			   &pvt->ts_coeff.h);
> @@ -237,7 +232,7 @@ static int pvt_ts_dbgfs_create(struct pvt_device *pvt, struct device *dev)
>   	debugfs_create_file("ts_coeff_j", 0644, pvt->dbgfs_dir, pvt,
>   			    &pvt_ts_coeff_j_fops);
>   
> -	return devm_add_action_or_reset(dev, devm_pvt_ts_dbgfs_remove, pvt);
> +	return 0;
>   }
>   
>   static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 1363d9f89181..e0f956a21125 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/debugfs.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/kernel.h>
>   #include <linux/math64.h>
>   #include <linux/module.h>
> @@ -3336,13 +3337,6 @@ static const struct file_operations pmbus_debugfs_ops_mfr = {
>   	.open = simple_open,
>   };
>   
> -static void pmbus_remove_debugfs(void *data)
> -{
> -	struct dentry *entry = data;
> -
> -	debugfs_remove_recursive(entry);
> -}
> -
>   static int pmbus_init_debugfs(struct i2c_client *client,
>   			      struct pmbus_data *data)
>   {
> @@ -3357,8 +3351,9 @@ static int pmbus_init_debugfs(struct i2c_client *client,
>   	 * Create the debugfs directory for this device. Use the hwmon device
>   	 * name to avoid conflicts (hwmon numbers are globally unique).
>   	 */
> -	data->debugfs = debugfs_create_dir(dev_name(data->hwmon_dev),
> -					   pmbus_debugfs_dir);
> +	data->debugfs = devm_debugfs_create_dir(data->dev,
> +						dev_name(data->hwmon_dev),
> +						pmbus_debugfs_dir);
>   	if (IS_ERR_OR_NULL(data->debugfs)) {
>   		data->debugfs = NULL;
>   		return -ENODEV;
> @@ -3542,8 +3537,7 @@ static int pmbus_init_debugfs(struct i2c_client *client,
>   		}
>   	}
>   
> -	return devm_add_action_or_reset(data->dev,
> -					pmbus_remove_debugfs, data->debugfs);
> +	return 0;
>   }
>   #else
>   static int pmbus_init_debugfs(struct i2c_client *client,
> diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
> index 70640fb96117..39d743175ec4 100644
> --- a/include/linux/devm-helpers.h
> +++ b/include/linux/devm-helpers.h
> @@ -23,6 +23,7 @@
>    * already ran.
>    */
>   
> +#include <linux/debugfs.h>
>   #include <linux/device.h>
>   #include <linux/kconfig.h>
>   #include <linux/mutex.h>
> @@ -108,4 +109,51 @@ static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
>   		return 0;
>   }
>   
> +static inline void devm_debugfs_dir_recursive_drop(void *res)
> +{
> +	debugfs_remove_recursive(res);
> +}
> +
> +/**
> + * devm_debugfs_create_dir - Resource managed debugfs directory creation
> + * @dev:	Device which lifetime the directory is bound to
> + * @name:	a pointer to a string containing the name of the directory to
> + *		create
> + * @parent:	a pointer to the parent dentry for this file.  This should be a
> + *		directory dentry if set.  If this parameter is NULL, then the
> + *		directory will be created in the root of the debugfs filesystem.
> + *
> + * Create a debugfs directory which is automatically recursively removed when
> + * the driver is detached. A few drivers create debugfs directories which they
> + * want removed before driver is detached.
> + * devm_debugfs_create_dir() can be used to omit the explicit
> + * debugfs_remove_recursive() call when driver is detached.
> + */
> +static inline struct dentry *
> +devm_debugfs_create_dir(struct device *dev, const char *name,
> +			struct dentry *parent)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = debugfs_create_dir(name, parent);
> +	if (IS_ERR(dentry))
> +		return dentry;
> +
> +	/*
> +	 * debugfs_remove_recursive() is an empty function if CONFIG_DEBUG_FS is
> +	 * disabled. No need to register an action in that case.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEBUG_FS)) {


This conditional seems unnecessary since in that case debugfs_create_dir()
would return -ENODEV, and the code below would never be executed to start with.

Guenter

> +		int err;
> +
> +		err = devm_add_action_or_reset(dev,
> +					       devm_debugfs_dir_recursive_drop,
> +					       dentry);
> +		if (err < 0)
> +			return ERR_PTR(err);
> +	}
> +
> +	return dentry;
> +}
> +
>   #endif


