Return-Path: <linux-kernel+bounces-27158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2B82EB56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3561F24293
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACE12E51;
	Tue, 16 Jan 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7CykNht"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43F12E50
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e85595298so2386025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705396460; x=1706001260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPA7XmzAkRvngRCYUNDaYLWS3udbNk9qn1uLzimwrMg=;
        b=l7CykNhtBa/Njk+xaTaBaPtKKiObyTF82HWhjY3ZyuUs2tqkbzcbIlB16QvyvFvs5N
         ytqBEVNA8KsZMiIVxiYKuoCK8SKw3SIboDyjHISRWSBHQzYiVtgHyZepr/N985HsRprv
         uG050cBxg2U34h9RKRWmkizPYZG/oS6chWrDT7I2rzewXA/fC6V3idkgFaNzCQWPubzZ
         s3l1xhxPeQ73iq/rlEHUldPKqg81nW7qXj4s0lPRw/3ih3nll+7YnvpOJmS5AY5vz5Ag
         gP5I23drnfjoqiKHD0BMazmKWZbTv3WtKfHO3PnkKtjVgnrAojRjq7wexDmbKJgyF9SF
         JtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705396460; x=1706001260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPA7XmzAkRvngRCYUNDaYLWS3udbNk9qn1uLzimwrMg=;
        b=rPSNZI9vLydk5qhvJsYZYAkjg5W6BoQuus8ryfzZv4+vuVM8dsLQa5/L8vdR535f+8
         aUWUDgW54S+KWYZ92onF29EMJdFuigg0Ib5DQfbZCQTtx/a4LKGiC+RZGSS5VMqFUT81
         hSy35WM4cOmmcsSkDm4S53/YEGz5QhnIjb8OHSD6w+2X+YZ+4SwgJRZPKKXpXiIQe497
         p/V7V2E/nvRcJ3qNv/HRwTOgv6QQKEx5BlbL5wxuEKWJrwJTPn+MXEPhplwAErynRLaw
         0hVP+HdhosArbMfxS32QZblbgxzfuQr5iIGn9HGRqUF7SwNicVuzW3ftI95x43qeyIBQ
         HmJw==
X-Gm-Message-State: AOJu0YyDRofhFPIldFnWigu4D44GPzfdEd22LVbtev+BoUJ3IKdz06DI
	q7Vl0uH596JtpzcOmPcYz11fAo6brqWCjg==
X-Google-Smtp-Source: AGHT+IFSvDbhieRfsnqWc7bT9Ls52GWCQlYYeCBVcI2mMofL0a5yaUXZ0ouakP1K4DQ/kVJzgVQLoA==
X-Received: by 2002:a05:600c:1914:b0:40e:491d:ac80 with SMTP id j20-20020a05600c191400b0040e491dac80mr1896078wmq.15.1705396459832;
        Tue, 16 Jan 2024 01:14:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:439d:3bc0:a764:73dc? ([2a05:6e02:1041:c10:439d:3bc0:a764:73dc])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c0a0a00b0040e486bc0dfsm22761223wmp.27.2024.01.16.01.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 01:14:19 -0800 (PST)
Message-ID: <d824d351-b1b1-46e3-86ac-f4a6b42c89fc@linaro.org>
Date: Tue, 16 Jan 2024 10:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/26] thermal: Introduce thermal zones names
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
 <20231221124825.149141-27-angelogioacchino.delregno@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231221124825.149141-27-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/12/2023 13:48, AngeloGioacchino Del Regno wrote:
> Currently thermal zones have a "type" but this is often used, and
> referenced, as a name instead in multiple kernel drivers that are
> either registering a zone or grabbing a thermal zone handle and
> unfortunately this is a kind of abuse/misuse of the thermal zone
> concept of "type".
> 
> In order to disambiguate name<->type and to actually provide an
> accepted way of giving a specific name to a thermal zone for both
> platform drivers and devicetree-defined zones, add a new "name"
> member in the main thermal_zone_device structure, and also to the
> thermal_zone_device_params structure which is used to register a
> thermal zone device.
> 
> This will enforce the following constraints:
>   - Multiple thermal zones may be of the same "type" (no change);
>   - A thermal zone may have a *unique* name: trying to register
>     a new zone with the same name as an already present one will
>     produce a failure;
> ---
>   drivers/thermal/thermal_core.c  | 34 ++++++++++++++++++++++++++++++---
>   drivers/thermal/thermal_of.c    |  1 +
>   drivers/thermal/thermal_sysfs.c |  9 +++++++++
>   drivers/thermal/thermal_trace.h | 17 +++++++++++------
>   include/linux/thermal.h         |  4 ++++
>   5 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9eb0200a85ff..adf2ac8113e1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1238,8 +1238,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>   struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp)
>   {
>   	struct thermal_zone_device *tz;
> -	int id;
> -	int result;
> +	int id, tz_name_len;
> +	int result = 0;
>   	struct thermal_governor *governor;
>   
>   	if (!tzdp->type || strlen(tzdp->type) == 0) {
> @@ -1248,11 +1248,36 @@ struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_dev
>   	}
>   
>   	if (strlen(tzdp->type) >= THERMAL_NAME_LENGTH) {
> -		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
> +		pr_err("Thermal zone type (%s) too long, should be under %d chars\n",
>   		       tzdp->type, THERMAL_NAME_LENGTH);
>   		return ERR_PTR(-EINVAL);

I would keep that as is and do second round of changes to clarify the 
usage of ->type

>   	}
>   
> +	tz_name_len = tzdp->name ? strlen(tzdp->name) : 0;

I suggest to change to a const char * and no longer limit to 
THERMAL_NAME_LENGTH.

> +	if (tz_name_len) {
> +		struct thermal_zone_device *pos;
> +
> +		if (tz_name_len >= THERMAL_NAME_LENGTH) {
> +			pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
> +			       tzdp->name, THERMAL_NAME_LENGTH);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		mutex_lock(&thermal_list_lock);
> +		list_for_each_entry(pos, &thermal_tz_list, node)
> +			if (!strncasecmp(tzdp->name, pos->name, THERMAL_NAME_LENGTH)) {
> +				result = -EEXIST;
> +				break;
> +			}
> +		mutex_unlock(&thermal_list_lock);
> +
> +		if (result) {
> +			pr_err("Thermal zone name (%s) already exists and must be unique\n",
> +			       tzdp->name);
> +			return ERR_PTR(result);
> +		}

Perhaps a lookup function would be more adequate. What about reusing 
thermal_zone_get_by_name() and search with tz->name if it is !NULL, 
tz->type otherwise ?

> +	}
> +
>   	/*
>   	 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
>   	 * For example, shifting by 32 will result in compiler warning:
> @@ -1307,6 +1332,9 @@ struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_dev
>   	tz->id = id;
>   	strscpy(tz->type, tzdp->type, sizeof(tz->type));
>   
> +	if (tz_name_len)
> +		strscpy(tz->name, tzdp->name, sizeof(tzdp->name));
> +
>   	if (!tzdp->ops->critical)
>   		tzdp->ops->critical = thermal_zone_device_critical;
>   
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 62a903ad649f..eaacc140abeb 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -486,6 +486,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   		ret = PTR_ERR(np);
>   		goto out_kfree_of_ops;
>   	}
> +	tzdp.name = np->name;
>   	tzdp.type = np->name;
>   
>   	tzdp.trips = thermal_of_trips_init(np, &tzdp.num_trips);
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index f52af8a3b4b5..f4002fa6caa2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -23,6 +23,14 @@
>   
>   /* sys I/F for thermal zone */
>   
> +static ssize_t
> +name_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +
> +	return sprintf(buf, "%s\n", tz->name);
> +}
> +
>   static ssize_t
>   type_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
> @@ -341,6 +349,7 @@ create_s32_tzp_attr(offset);
>    * All the attributes created for tzp (create_s32_tzp_attr) also are always
>    * present on the sysfs interface.
>    */
> +static DEVICE_ATTR_RO(name);
>   static DEVICE_ATTR_RO(type);
>   static DEVICE_ATTR_RO(temp);
>   static DEVICE_ATTR_RW(policy);
> diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
> index 459c8ce6cf3b..c9dbae1e3b9e 100644
> --- a/drivers/thermal/thermal_trace.h
> +++ b/drivers/thermal/thermal_trace.h
> @@ -28,6 +28,7 @@ TRACE_EVENT(thermal_temperature,
>   	TP_ARGS(tz),
>   
>   	TP_STRUCT__entry(
> +		__string(thermal_zone_name, tz->name)
>   		__string(thermal_zone, tz->type)
>   		__field(int, id)
>   		__field(int, temp_prev)
> @@ -35,15 +36,16 @@ TRACE_EVENT(thermal_temperature,
>   	),
>   
>   	TP_fast_assign(
> +		__assign_str(thermal_zone_name, tz->name);
>   		__assign_str(thermal_zone, tz->type);
>   		__entry->id = tz->id;
>   		__entry->temp_prev = tz->last_temperature;
>   		__entry->temp = tz->temperature;
>   	),
>   
> -	TP_printk("thermal_zone=%s id=%d temp_prev=%d temp=%d",
> -		__get_str(thermal_zone), __entry->id, __entry->temp_prev,
> -		__entry->temp)
> +	TP_printk("thermal_zone=%s name=%s id=%d temp_prev=%d temp=%d",
> +		  __get_str(thermal_zone), __get_str(thermal_zone_name),
> +		  __entry->id, __entry->temp_prev, __entry->temp)
>   );
>   
>   TRACE_EVENT(cdev_update,
> @@ -73,6 +75,7 @@ TRACE_EVENT(thermal_zone_trip,
>   	TP_ARGS(tz, trip, trip_type),
>   
>   	TP_STRUCT__entry(
> +		__string(thermal_zone_name, tz->name)
>   		__string(thermal_zone, tz->type)
>   		__field(int, id)
>   		__field(int, trip)
> @@ -80,15 +83,17 @@ TRACE_EVENT(thermal_zone_trip,
>   	),
>   
>   	TP_fast_assign(
> +		__assign_str(thermal_zone_name, tz->name);
>   		__assign_str(thermal_zone, tz->type);
>   		__entry->id = tz->id;
>   		__entry->trip = trip;
>   		__entry->trip_type = trip_type;
>   	),
>   
> -	TP_printk("thermal_zone=%s id=%d trip=%d trip_type=%s",
> -		__get_str(thermal_zone), __entry->id, __entry->trip,
> -		show_tzt_type(__entry->trip_type))
> +	TP_printk("thermal_zone=%s name=%s id=%d trip=%d trip_type=%s",
> +		  __get_str(thermal_zone), __get_str(thermal_zone_name),
> +		  __entry->id, __entry->trip,
> +		  show_tzt_type(__entry->trip_type))
>   );

For now, I think we can keep the traces as they are and keep passing the 
tz->type. Then we can replace tz->type by tz->name without changing the 
trace format.

>   #ifdef CONFIG_CPU_THERMAL
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 84b62575d93a..a06521eda162 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -115,6 +115,7 @@ struct thermal_cooling_device {
>   /**
>    * struct thermal_zone_device - structure for a thermal zone
>    * @id:		unique id number for each thermal zone
> + * @name:       name of the thermal zone device
>    * @type:	the thermal zone device type
>    * @device:	&struct device for this thermal zone
>    * @removal:	removal completion
> @@ -155,6 +156,7 @@ struct thermal_cooling_device {
>    */
>   struct thermal_zone_device {
>   	int id;
> +	char name[THERMAL_NAME_LENGTH];
>   	char type[THERMAL_NAME_LENGTH];
>   	struct device device;
>   	struct completion removal;
> @@ -260,6 +262,7 @@ struct thermal_zone_params {
>   
>   /**
>    * struct thermal_zone_device_params - parameters for a thermal zone device
> + * @name:		name of the thermal zone device
>    * @type:		the thermal zone device type
>    * @tzp:		thermal zone platform parameters
>    * @ops:		standard thermal zone device callbacks
> @@ -274,6 +277,7 @@ struct thermal_zone_params {
>    *			driven systems)
>    */
>   struct thermal_zone_device_params {
> +	const char *name;
>   	const char *type;
>   	struct thermal_zone_params tzp;
>   	struct thermal_zone_device_ops *ops;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


