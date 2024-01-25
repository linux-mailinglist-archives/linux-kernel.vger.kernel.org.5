Return-Path: <linux-kernel+bounces-38056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B2E83BA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FB41F227DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5810A26;
	Thu, 25 Jan 2024 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQXvMpL/"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D11118F;
	Thu, 25 Jan 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165652; cv=none; b=oPe/SRj8z5SGfHxYUpXxpMhjN/jW+GMk08rbE4mAu6aYMRmT7LyK1FQX2BZxyub3S3cNg7X2qqAYHy/ZeHLZad4YNmwKECt7mdIwFkfLzujTfEypYnrphnXlcmdkLdYKNWq1UNLiitSI5jU+sozNwAm82h0Iq9Yhp8qDRAoBITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165652; c=relaxed/simple;
	bh=re5XjGDf5/5kNM67wjDSBeuJf2pc+Y0fVEHApMogd+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSwhMLPLSLQxGzWC5BeYXU+YJG0aVsFouviTNKq/7SRIOP5cWMNzFteHIyQ3O+eqcv13a3Xhj0bfgE6bSZNPkIBZ7s/xlOrbxHwseqvZFiKxYpnK06JHtXltUfdC3WANOFAWko09qdXQTP60ZXZWMLE09jivzgJQ4iOmaqWVZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQXvMpL/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ddcfbc569dso143794b3a.3;
        Wed, 24 Jan 2024 22:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706165649; x=1706770449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a/dD/tk5ZZP0MVQmDxuJNtWfiuXCG0ReCzTna959dS0=;
        b=QQXvMpL/+2qww7CHHaRQxQru1SNJNR+za3yM2lngKdxK7BCQhoq+8bANuoxGtEIGP0
         n6Llx30od8rm/mh85jQxnCaCckSiiuHrVwRYpS7gV/8GjkZGLdL2ffwhTAU4ozyZFtfA
         etvRJFX6T9FpnA16W0e6birqPTmFdeKXK2K/PGPR0mLIIZJBPYUpS3V/KFJw+VikxNHL
         IGubpqm8iI56W9hWrUpnAAwu1vqyHo8GMDxQ8icOFzHLYNYykRkQog4pmKJkf2u2TBSc
         +ThArnZF/fosSWSRlvJQC9YxGRzl8uff+D0Q0yx/Vhdc9YoOkeOHbPzRQkuWw4Fe6mKM
         rvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706165649; x=1706770449;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/dD/tk5ZZP0MVQmDxuJNtWfiuXCG0ReCzTna959dS0=;
        b=ojbXzMA5t66lHjMl2MNpHU+ZsEL69uCEA8WO6qlJOCzWm2U/8CrFhi9cy+YsSTbscv
         aCY+BfkCEx51iONXDe6ms5ZfZAQrgRfcs65MX6vAbn+QFz3uvIFBOBMLeqvHnhC+NE0J
         nFEL7dv7FNbBx9E30jRoYpQiVoAfteu4U95NrnTmmwsnozAa2GpsiDRNkoAiKrx5z/98
         b+hRWvsgnA4Nx87q4ZuadaYD89z+lA8EQQb/VYleXs1zavTvldW0PwyKMIsKzXNY7Krd
         Q45cCczUPd++6aHXeyWUBSpf6EOe/+8s5n5djAq+gIRxLOhMGVY5zx7l8eKXQlJH51K0
         bnkw==
X-Gm-Message-State: AOJu0Yy6JGCB9aCsAzfxfB4Eb40a7/5kenHDK3S+vgl1aChYQzc2g3DU
	dHjTR2SvLmA2Kpmx0rlp14shjEH2LrF7Qm8vXBfkGt9Lipqp2NrJFfoHgwrw
X-Google-Smtp-Source: AGHT+IEzuLgcrz1uXfTaEt2uHe5s8JlBf6NsJpUSWQOXaoqz4yS4BAHVNmNJVXDZFDrkFeyzyvQmbw==
X-Received: by 2002:a05:6a00:98b:b0:6dd:82b0:1bed with SMTP id u11-20020a056a00098b00b006dd82b01bedmr334564pfg.11.1706165649363;
        Wed, 24 Jan 2024 22:54:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2-20020a62f802000000b006dd6bb57a2asm4773499pfh.114.2024.01.24.22.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 22:54:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b839f83f-c8c7-4fa8-8597-bdde1b40168a@roeck-us.net>
Date: Wed, 24 Jan 2024 22:54:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal
 zones
Content-Language: en-US
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, groeck7@gmail.com,
 sudeep.holla@arm.com, cristian.marussi@arm.com, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20240125064422.347002-1-peng.fan@oss.nxp.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240125064422.347002-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/24 22:44, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The thermal sensors maybe disabled before kernel boot, so add change_mode
> for thermal zones to support configuring the thermal sensor to enabled
> state. If reading the temperature when the sensor is disabled, there will
> be error reported.
> 
> The cost is an extra config_get all to SCMI firmware to get the status
> of the thermal sensor. No function level impact.
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>   Update commit log to show it only applys to thermal
>   Add comments in code
>   Add R-b from Cristian
> 

You didn't address my question regarding the behavior of hwmon
attributes if a sensor is disabled.

>   Guenter, I Cced linux@roeck-us.net when sending V1/V2
>   Let me Cc Guenter Roeck <groeck7@gmail.com> in V3, hope you not mind
> 
This time I received it twice ;-).

> V2:
>   Use SCMI_SENS_CFG_IS_ENABLED & clear BIT[31:9] before update config(Thanks Cristian)
> 
>   drivers/hwmon/scmi-hwmon.c | 39 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 364199b332c0..af2267fea5f0 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -151,7 +151,46 @@ static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
>   	return ret;
>   }
>   
> +static int scmi_hwmon_thermal_change_mode(struct thermal_zone_device *tz,
> +					  enum thermal_device_mode new_mode)
> +{
> +	int ret;
> +	u32 config;
> +	enum thermal_device_mode cur_mode = THERMAL_DEVICE_DISABLED;
> +	struct scmi_thermal_sensor *th_sensor = thermal_zone_device_priv(tz);
> +
> +	ret = sensor_ops->config_get(th_sensor->ph, th_sensor->info->id,
> +				     &config);
> +	if (ret)
> +		return ret;
> +
> +	if (SCMI_SENS_CFG_IS_ENABLED(config))
> +		cur_mode = THERMAL_DEVICE_ENABLED;
> +
> +	if (cur_mode == new_mode)
> +		return 0;
> +
> +	/*
> +	 * Per SENSOR_CONFIG_SET sensor_config description:
> +	 * BIT[31:11] should be set to 0 if the sensor update interval does
> +	 * not need to be updated, so clear them.
> +	 * And SENSOR_CONFIG_GET does not return round up/down, so also clear
> +	 * BIT[10:9] round up/down.

What does "clear" mean ? Is it going to round up ? Round down ? And why would it
be necessary to clear those bits if SENSOR_CONFIG_GET does not return the
current setting in the first place ?

Thanks,
Guenter

> +	 */
> +	config &= ~(SCMI_SENS_CFG_UPDATE_SECS_MASK |
> +		    SCMI_SENS_CFG_UPDATE_EXP_MASK |
> +		    SCMI_SENS_CFG_ROUND_MASK);
> +	if (new_mode == THERMAL_DEVICE_ENABLED)
> +		config |= SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> +	else
> +		config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
> +
> +	return sensor_ops->config_set(th_sensor->ph, th_sensor->info->id,
> +				      config);
> +}
> +
>   static const struct thermal_zone_device_ops scmi_hwmon_thermal_ops = {
> +	.change_mode = scmi_hwmon_thermal_change_mode,
>   	.get_temp = scmi_hwmon_thermal_get_temp,
>   };
>   


