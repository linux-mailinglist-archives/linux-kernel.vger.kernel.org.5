Return-Path: <linux-kernel+bounces-117471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFE88ABC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46101F29049
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296D143C5F;
	Mon, 25 Mar 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjgBPD8/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914C62A02;
	Mon, 25 Mar 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384273; cv=none; b=Tim97l+1S3RmCUswqspVD8TBN6thyc7SQKWA0cv3jOewJREv7P4h0QSjKh2wK4pxUqqIJgi2Mli7bMmySA9jCvB/Wpk0yZTw94btrmrDuUYqYtZu0iBZXaA6DN5u4DlVjHaBfOpwX0IczRn9tBPQ5JSt6A89w38W9TRl/oAYiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384273; c=relaxed/simple;
	bh=4AhRLHi5FsdkeOwcKf7hiFrcj4u4gkn7opXrw4MgmEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpi6MPDACE5HYGlJ5Wn6fZSXxV7FwUGZJuxuIOuf4gWifZoYkO6qu8IHovJx4YilH4gUFlhuF4LVC9kObYaVwc3PwZKrhGVBHj6F10n3sJJxAMidb4hUDxwZ2UaE3Tjo69goGFnLjlDBEW/dCFkFC9oDs/yFD4RlBiHFo5Q8gk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjgBPD8/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e034607879so35436215ad.0;
        Mon, 25 Mar 2024 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384270; x=1711989070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clo3yF81Vj2RfgwFQxOy7+YAcdOTIVGOtBCkE2iaxz4=;
        b=LjgBPD8/QPh+WlK9x8ORavretSgELcnR1zevOmDtF+I9WVK5/zJyodRUZXcnq6NegT
         12Ixd+gCo+awCFjqOWfIBBEmu1gq6wsFcHXcTYZACxveRPQEWX5JkGjh/XVamf6w8G0y
         j3w15/yydYvJHNvbUREdZNrHkw/h42GlSVQfDz07dRzuyXzInErDwYX+RAP4vgWcRLzL
         fucXWz90BSkzi1vpBYOJLknL0TByhGDulUGjuWnwphSIgbVhUFHLYEw2oYb8vmjPk57U
         2HKZFBnsPOIteQwPC3KalW6sR+PaF7wJL4ISFeEKHNdLUcM8oDwmMFRfdfnYtXye3DAg
         A1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384270; x=1711989070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clo3yF81Vj2RfgwFQxOy7+YAcdOTIVGOtBCkE2iaxz4=;
        b=V5dn7DQLDl+L2ypi6nO/mJl7Xcj4U39GPT/wzTg8NAmU4QZv+XNptp1aIIB8Nzp+RP
         fV+1geZoN4wiq5tCUECD92wQwIICDOUXqeaw9lyNd/K1uqH4UjlIe8Y/neh4EaxIpdfA
         kL+QBhFQ8bVjTfknP97pH6bEj9YwbkfqA/Bt18E+yDAgE/h0gHFhwevYgOpvKyY6OkRp
         OMReBJ2y5EeGFWqY+6QLmpXv1lp5nCLI3AORR90oXm5wVkY47zglifgVO90qYok/YbJy
         ETSLR+W01TC7BlqaM8sK4F/5hH6ibyQzgNRbPoxSrAa4Z6+x5qYS9ZoXPQBnSvngqtiN
         ojFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6oinn6EmiHW80CZfThqyetxlavYETjyEroOpZf76UWagCMlO0m9QvNy90qtnPonhJCHcInQJXJS21pb7FXbAkZkeAYFaHPSB6hWgvM8cPre5BqF6HwVAXlL+CKCgw7/y+r0QY5KnHBOY=
X-Gm-Message-State: AOJu0Yy7uXf5rl6Nub04eT6KMnxsRRHTXLrkipaYnwQlzsjyOKbXjWVL
	SopmhlGDAIGf6wCTDtl3h/jz6zi3dd3G04AP/nNnbHgquxwat1qw
X-Google-Smtp-Source: AGHT+IHMlpZN+3UEsNypbiPdTOny3jujp/fULyesxvQxLPfkaigHI5i/mjirNgY5hk7z4wBhx+EQUQ==
X-Received: by 2002:a17:902:ecc4:b0:1e0:185d:16c3 with SMTP id a4-20020a170902ecc400b001e0185d16c3mr10264923plh.12.1711384270418;
        Mon, 25 Mar 2024 09:31:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b001defa98b03fsm4974882pla.101.2024.03.25.09.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:31:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Mar 2024 09:31:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 3/3] hwmon: (pmbus/mp2975) Use i2c_get_match_data()
Message-ID: <f874c321-16b9-43f6-95c3-c94b7c9d3cb6@roeck-us.net>
References: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
 <20240325120952.3019767-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325120952.3019767-4-andriy.shevchenko@linux.intel.com>

On Mon, Mar 25, 2024 at 02:07:44PM +0200, Andy Shevchenko wrote:
> Use preferred i2c_get_match_data() instead of of_device_get_match_data()
> to get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Appied, with additional change noted below.

> ---
>  drivers/hwmon/pmbus/mp2975.c | 54 +++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> index bc7558dc87ee..79b4ea325cb2 100644
> --- a/drivers/hwmon/pmbus/mp2975.c
> +++ b/drivers/hwmon/pmbus/mp2975.c
> @@ -10,8 +10,9 @@
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +
>  #include "pmbus.h"
>  
>  /* Vendor specific registers. */
> @@ -98,6 +99,11 @@ static const int mp2975_max_phases[][MP2975_PAGE_NUM] = {
>  	[mp2971] = { MP2971_MAX_PHASE_RAIL1, MP2971_MAX_PHASE_RAIL2 },
>  };
>  
> +struct mp2975_driver_info {
> +	const struct pmbus_driver_info *info;
> +	enum chips chip_id;
> +};
> +
>  struct mp2975_data {
>  	struct pmbus_driver_info info;
>  	enum chips chip_id;
> @@ -111,15 +117,6 @@ struct mp2975_data {
>  	int curr_sense_gain[MP2975_PAGE_NUM];
>  };
>  
> -static const struct i2c_device_id mp2975_id[] = {
> -	{"mp2971", mp2971},
> -	{"mp2973", mp2973},
> -	{"mp2975", mp2975},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(i2c, mp2975_id);
> -
>  static const struct regulator_desc __maybe_unused mp2975_reg_desc[] = {
>  	PMBUS_REGULATOR("vout", 0),
>  	PMBUS_REGULATOR("vout", 1),
> @@ -989,29 +986,34 @@ static const struct pmbus_driver_info mp2973_info = {
>  #endif
>  };
>  
> +static const struct mp2975_driver_info mp2975_ddinfo[] = {
> +	[mp2975] = { .info = &mp2975_info, .chip_id = mp2975 },
> +	[mp2973] = { .info = &mp2973_info, .chip_id = mp2973 },
> +	[mp2971] = { .info = &mp2973_info, .chip_id = mp2971 },
> +};
> +
>  static int mp2975_probe(struct i2c_client *client)
>  {
> +	const struct mp2975_driver_info *ddinfo;
>  	struct pmbus_driver_info *info;
>  	struct mp2975_data *data;
>  	int ret;
>  
> +	ddinfo = i2c_get_match_data(client);
> +	if (!ddinfo)
> +		return -ENODEV;
> +
>  	data = devm_kzalloc(&client->dev, sizeof(struct mp2975_data),
>  			    GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	if (client->dev.of_node)
> -		data->chip_id = (enum chips)(unsigned long)of_device_get_match_data(&client->dev);
> -	else
> -		data->chip_id = i2c_match_id(mp2975_id, client)->driver_data;
> +	data->chip_id = ddinfo->chip_id;
>  
>  	memcpy(data->max_phases, mp2975_max_phases[data->chip_id],
>  	       sizeof(data->max_phases));
>  
> -	if (data->chip_id == mp2975)
> -		memcpy(&data->info, &mp2975_info, sizeof(*info));
> -	else
> -		memcpy(&data->info, &mp2973_info, sizeof(*info));
> +	memcpy(&data->info, ddinfo->info, sizeof(data->info));
>  
>  	info = &data->info;
>  
> @@ -1070,17 +1072,25 @@ static int mp2975_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id __maybe_unused mp2975_of_match[] = {

This is no longer __maybe_unused.

Thanks,
Guenter

> -	{.compatible = "mps,mp2971", .data = (void *)mp2971},
> -	{.compatible = "mps,mp2973", .data = (void *)mp2973},
> -	{.compatible = "mps,mp2975", .data = (void *)mp2975},
> +	{.compatible = "mps,mp2971", .data = &mp2975_ddinfo[mp2971]},
> +	{.compatible = "mps,mp2973", .data = &mp2975_ddinfo[mp2973]},
> +	{.compatible = "mps,mp2975", .data = &mp2975_ddinfo[mp2975]},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, mp2975_of_match);
>  
> +static const struct i2c_device_id mp2975_id[] = {
> +	{"mp2971", (kernel_ulong_t)&mp2975_ddinfo[mp2971]},
> +	{"mp2973", (kernel_ulong_t)&mp2975_ddinfo[mp2973]},
> +	{"mp2975", (kernel_ulong_t)&mp2975_ddinfo[mp2975]},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mp2975_id);
> +
>  static struct i2c_driver mp2975_driver = {
>  	.driver = {
>  		.name = "mp2975",
> -		.of_match_table = of_match_ptr(mp2975_of_match),
> +		.of_match_table = mp2975_of_match,
>  	},
>  	.probe = mp2975_probe,
>  	.id_table = mp2975_id,

