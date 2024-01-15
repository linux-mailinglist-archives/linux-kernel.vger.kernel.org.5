Return-Path: <linux-kernel+bounces-25969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1AB82D8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C2C1C21412
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8226B14293;
	Mon, 15 Jan 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3nUl17e"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D413AD4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337ae00f39dso393078f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 04:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705322399; x=1705927199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsRK/J3InpLXmD2xXZcgPy1y+ubBCpi4pYLSA0UW/z0=;
        b=E3nUl17eCD6fVnrbBfcjmbXZTkjZS00Kk1AgrcH5n2P8/2R8q7SclmL0Uj6aZU+HHp
         QjavdXYdwytltOloAhnBspshVPJy7LKpCQgSi6ID+9stLq/RxAkiK/Gdzekx/D5R9T1n
         w3LpyJXcLzR6UtgZgh3EGw+JCPOJa0c0SJkboM79QFmuAhKSmNosuSCuc8W12Eo+37E3
         t0Y5B5WkwS/t/L7ErQY+NnXZuWlKaxGU6/B5py4RfVQjoU+SJ/e7vMDTVn+8AOxKKwDQ
         uPHwJ7IQ0xQT4fxZyfYyN8Y1C7uHUUxSwxxBWEQj+hxNVl20C3h7KTj9AXNbcq9dsixv
         IZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705322399; x=1705927199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsRK/J3InpLXmD2xXZcgPy1y+ubBCpi4pYLSA0UW/z0=;
        b=wkySZmw7wBQVIyF+ixbUUrcexmIW/bXcHBEbCpKBFRsa8Z+3wQdfdmtPZwgvI2RO5s
         YMOHSywB8v7Mabg520n12pCtLjlU7/EaHu80m3MtMznXQFmsevQjsoMeCJVJkql4fQyr
         gRgCqDcYged8LcKFVBGCXlN9t4djbNH780cuYL/aIJ4vkK6Dth1mDsOATAgy0NeL8fIv
         Omki065KKgEeTo6M+qbAtnzLMWkSt9406mfLiePAvebZGsnjtPQNba069JPcxDMeMDmw
         O2i7ny4Kgo7vIeNHe5JU3lc1wbERiPN0y/nWinKOsMCFd8relZvBMrLtvc2HHLeA+xjz
         oTnA==
X-Gm-Message-State: AOJu0YwWgFxTgcLEfXONT2yF6WlLf2PM11zpNKkIGB+zO82yRXPXtmJY
	SZQxIT1vl0UNU8wKYhWC/voj0/x3J074cw==
X-Google-Smtp-Source: AGHT+IGYGK5HYJtxYf6Y8FLJOAIKJCRS7+zCNj5z68tJRI9lPpwVMXl28qGhry6DFhtrpzKbgP5iHg==
X-Received: by 2002:a5d:4a0a:0:b0:337:7b11:d63c with SMTP id m10-20020a5d4a0a000000b003377b11d63cmr3120808wrq.14.1705322399034;
        Mon, 15 Jan 2024 04:39:59 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:439d:3bc0:a764:73dc? ([2a05:6e02:1041:c10:439d:3bc0:a764:73dc])
        by smtp.googlemail.com with ESMTPSA id o14-20020adfe80e000000b0033674734a58sm11836029wrm.79.2024.01.15.04.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:39:58 -0800 (PST)
Message-ID: <7417c498-2439-485d-9f78-fbb22f9ce393@linaro.org>
Date: Mon, 15 Jan 2024 13:39:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/26] thermal: Introduce
 thermal_zone_device_register() and params structure
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
 <20231221124825.149141-2-angelogioacchino.delregno@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231221124825.149141-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/12/2023 13:48, AngeloGioacchino Del Regno wrote:
> In preparation for extending the thermal zone devices to actually have
> a name and disambiguation of thermal zone types/names, introduce a new
> thermal_zone_device_params structure which holds all of the parameters
> that are necessary to register a thermal zone device, then add a new
> function thermal_zone_device_register().
> 
> The latter takes as parameter the newly introduced structure and is
> made to eventually replace all usages of the now deprecated function
> thermal_zone_device_register_with_trips() and of
> thermal_tripless_zone_device_register().
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/thermal/thermal_core.c | 27 +++++++++++++++++++++++++++
>   include/linux/thermal.h        | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index e5434cdbf23b..6be508eb2d72 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1235,6 +1235,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>    *		   whether trip points have been crossed (0 for interrupt
>    *		   driven systems)
>    *
> + * This function is deprecated. See thermal_zone_device_register().
> + *
>    * This interface function adds a new thermal zone device (sensor) to
>    * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
>    * thermal cooling devices registered at the same time.
> @@ -1409,6 +1411,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
>   
> +/* This function is deprecated. See thermal_zone_device_register(). */
>   struct thermal_zone_device *thermal_tripless_zone_device_register(
>   					const char *type,
>   					void *devdata,
> @@ -1420,6 +1423,30 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
>   }
>   EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
>   
> +/**
> + * thermal_zone_device_register() - register a new thermal zone device
> + * @tzdp:	Parameters of the new thermal zone device
> + *		See struct thermal_zone_device_register.
> + *
> + * This interface function adds a new thermal zone device (sensor) to
> + * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
> + * thermal cooling devices registered at the same time.
> + * thermal_zone_device_unregister() must be called when the device is no
> + * longer needed. The passive cooling depends on the .get_trend() return value.
> + *
> + * Return: a pointer to the created struct thermal_zone_device or an
> + * in case of error, an ERR_PTR. Caller must check return value with
> + * IS_ERR*() helpers.
> + */
> +struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp)
> +{
> +	return thermal_zone_device_register_with_trips(tzdp->type, tzdp->trips, tzdp->num_trips,
> +						       tzdp->mask, tzdp->devdata, tzdp->ops,
> +						       &tzdp->tzp, tzdp->passive_delay,
> +						       tzdp->polling_delay);
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_register);
> +
>   void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
>   {
>   	return tzd->devdata;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 98957bae08ff..c6ed33a7e468 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -258,6 +258,33 @@ struct thermal_zone_params {
>   	int offset;
>   };
>   
> +/**
> + * struct thermal_zone_device_params - parameters for a thermal zone device
> + * @type:		the thermal zone device type
> + * @tzp:		thermal zone platform parameters
> + * @ops:		standard thermal zone device callbacks
> + * @devdata:		private device data
> + * @trips:		a pointer to an array of thermal trips, if any
> + * @num_trips:		the number of trip points the thermal zone support
> + * @mask:		a bit string indicating the writeablility of trip points
> + * @passive_delay:	number of milliseconds to wait between polls when
> + *			performing passive cooling
> + * @polling_delay:	number of milliseconds to wait between polls when checking
> + *			whether trip points have been crossed (0 for interrupt
> + *			driven systems)
> + */
> +struct thermal_zone_device_params {
> +	const char *type;
> +	struct thermal_zone_params tzp;
> +	struct thermal_zone_device_ops *ops;
> +	void *devdata;
> +	struct thermal_trip *trips;
> +	int num_trips;
> +	int mask;
> +	int passive_delay;
> +	int polling_delay;
> +};

 From my POV, this "struct thermal_zone_params" has been always a 
inadequate and catch-all structure. It will confuse with 
thermal_zone_device_params

I suggest to cleanup a bit that by sorting the parameters in the right 
structures where the result could be something like:

eg.

struct thermal_zone_params {

	const char *type;
	struct thermal_zone_device_ops *ops;
	struct thermal_trip *trips;
	int num_trips;

	int passive_delay;
	int polling_delay;
	
	void *devdata;
         bool no_hwmon;
};

struct thermal_governor_ipa_params {
         u32 sustainable_power;
         s32 k_po;
         s32 k_pu;
         s32 k_i;
         s32 k_d;
         s32 integral_cutoff;
         int slope;
         int offset;
};

struct thermal_governor_params {
	char governor_name[THERMAL_NAME_LENGTH];
	union {
		struct thermal_governor_ipa_params ipa_params;
	};
};

struct thermal_zone_device_params {
	struct thermal_zone_params *tzp;
	struct thermal_governor_params *tgp;
}

No functional changes just code reorg, being a series to be submitted 
before the rest on these RFC changes (2->26)

>   /* Function declarations */
>   #ifdef CONFIG_THERMAL_OF
>   struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
> @@ -310,6 +337,8 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
>   					struct thermal_zone_device_ops *ops,
>   					const struct thermal_zone_params *tzp);
>   
> +struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp);
> +
>   void thermal_zone_device_unregister(struct thermal_zone_device *tz);
>   
>   void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
> @@ -372,6 +401,10 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
>   					const struct thermal_zone_params *tzp)
>   { return ERR_PTR(-ENODEV); }
>   
> +static inline struct thermal_zone_device *thermal_zone_device_register(
> +					struct thermal_zone_device_params *tzdp)
> +{ return ERR_PTR(-ENODEV); }
> +
>   static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>   { }
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


