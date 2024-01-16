Return-Path: <linux-kernel+bounces-27317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1B82EDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6E41C231C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6B1B808;
	Tue, 16 Jan 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJYNQ5Gm"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF01B7F3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so13612965e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705404624; x=1706009424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2o8vTaU4/pwYnm4WYdt181bSyjz4o3CN/nDAC13N2X0=;
        b=eJYNQ5Gm8xnJ3X8ONbFxs/IGpdegwOc8opUFOM2bEYBlpT3Qq+h0e6zvHuSe6j/qmc
         Q648wXc9g227vRXmosYUAf4O7PB2Xd6Dam8WBDjCg3m03JrZwhMsypbIpCKImnA49h7F
         hBciYDuYdO2SZDkiGOhj/b6mqJk2o7XgHacixZKkcRPMGMfmSkWXHwVMWdyiycODh/nN
         +J62uCUMo7tiU9HmFUIm8B6V9WUv3KSGhX/r9thFcO98Q4j0o6aUJ6FqMUIXpUCj+Qw3
         uvFkMK9WsCmqxMsOM/B2l9wMESxvlgyMu1z6Bh01DHwxf3Uqlg0brUMeCICqEj8Z3BVL
         beiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705404624; x=1706009424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2o8vTaU4/pwYnm4WYdt181bSyjz4o3CN/nDAC13N2X0=;
        b=C2gGMzer+clOfpbA5aVZc386PrqCesUqwo/qALbCtiw4dSaPJUzkU+udELVRPtzRno
         /zlo/qkYScUHMdQsTPBVbgignp0Yz43IK74v8b0gGkOkKHff9rrEyNUTIgDTOMfCbFiF
         uDVYx2LT9L+ojqRPy9GhAumWhix+imguhWSxhMB/wiLRCnIYmQ/Iqaw1WvmiS3Q/Z0OK
         4n+qBxNPGS9PMXF7Y5VmV56g4Jdexnx24W6tWve7WDCnlc/vGYZgKS0gG//7tt3zfqY1
         BuYSvqvzZWAvkbebku23O1zaMzedWUx5sQvKhXukFEKVKhiFQBQ/OAIRSLq1KhnoKAvM
         CtNw==
X-Gm-Message-State: AOJu0Yw8n2FfhTzcIaRwWfUy+gzmGD1JtxVrroN+D9qcz1Us/djsS1P6
	Gr4WAlG8d/coilh787em7jVXCUmR+QOeOg==
X-Google-Smtp-Source: AGHT+IF8hoYcNpsis8PD54DQ2N+ohdGuCSDvyQGWWERbPng2CBgOo+X7EPoiT3LQrARK8d+iwRXZ/g==
X-Received: by 2002:a05:600c:1c05:b0:40e:52f4:81bb with SMTP id j5-20020a05600c1c0500b0040e52f481bbmr3945168wms.146.1705404624092;
        Tue, 16 Jan 2024 03:30:24 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:fab3:687:ead6:5b40? ([2a05:6e02:1041:c10:fab3:687:ead6:5b40])
        by smtp.googlemail.com with ESMTPSA id iv11-20020a05600c548b00b0040d8ff79fd8sm19033463wmb.7.2024.01.16.03.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 03:30:23 -0800 (PST)
Message-ID: <3ca36f2f-1dc9-4f7e-9e83-3d3872530976@linaro.org>
Date: Tue, 16 Jan 2024 12:30:23 +0100
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
 <d824d351-b1b1-46e3-86ac-f4a6b42c89fc@linaro.org>
 <3805d11d-bbc3-4509-bb2c-ce752a65618f@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3805d11d-bbc3-4509-bb2c-ce752a65618f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/01/2024 10:45, AngeloGioacchino Del Regno wrote:
> Il 16/01/24 10:14, Daniel Lezcano ha scritto:
>> On 21/12/2023 13:48, AngeloGioacchino Del Regno wrote:
>>> Currently thermal zones have a "type" but this is often used, and
>>> referenced, as a name instead in multiple kernel drivers that are
>>> either registering a zone or grabbing a thermal zone handle and
>>> unfortunately this is a kind of abuse/misuse of the thermal zone
>>> concept of "type".
>>>
>>> In order to disambiguate name<->type and to actually provide an
>>> accepted way of giving a specific name to a thermal zone for both
>>> platform drivers and devicetree-defined zones, add a new "name"
>>> member in the main thermal_zone_device structure, and also to the
>>> thermal_zone_device_params structure which is used to register a
>>> thermal zone device.
>>>
>>> This will enforce the following constraints:
>>>   - Multiple thermal zones may be of the same "type" (no change);
>>>   - A thermal zone may have a *unique* name: trying to register
>>>     a new zone with the same name as an already present one will
>>>     produce a failure;
>>> ---
>>>   drivers/thermal/thermal_core.c  | 34 ++++++++++++++++++++++++++++++---
>>>   drivers/thermal/thermal_of.c    |  1 +
>>>   drivers/thermal/thermal_sysfs.c |  9 +++++++++
>>>   drivers/thermal/thermal_trace.h | 17 +++++++++++------
>>>   include/linux/thermal.h         |  4 ++++
>>>   5 files changed, 56 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c 
>>> b/drivers/thermal/thermal_core.c
>>> index 9eb0200a85ff..adf2ac8113e1 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -1238,8 +1238,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>>>   struct thermal_zone_device *thermal_zone_device_register(struct 
>>> thermal_zone_device_params *tzdp)
>>>   {
>>>       struct thermal_zone_device *tz;
>>> -    int id;
>>> -    int result;
>>> +    int id, tz_name_len;
>>> +    int result = 0;
>>>       struct thermal_governor *governor;
>>>       if (!tzdp->type || strlen(tzdp->type) == 0) {
>>> @@ -1248,11 +1248,36 @@ struct thermal_zone_device 
>>> *thermal_zone_device_register(struct thermal_zone_dev
>>>       }
>>>       if (strlen(tzdp->type) >= THERMAL_NAME_LENGTH) {
>>> -        pr_err("Thermal zone name (%s) too long, should be under %d 
>>> chars\n",
>>> +        pr_err("Thermal zone type (%s) too long, should be under %d 
>>> chars\n",
>>>                  tzdp->type, THERMAL_NAME_LENGTH);
>>>           return ERR_PTR(-EINVAL);
>>
>> I would keep that as is and do second round of changes to clarify the 
>> usage of ->type
>>
> 
> Problem is, if we keep this one as-is, then we'll have ambiguous error 
> messages in
> this series... unless we stop limiting the tz type string to 
> THERMAL_NAME_LENGTH
> as well as not limit the tz name to that...

I'm missing the point, how can it be more ambiguous if the message is 
unchanged ?

>>>       }
>>> +    tz_name_len = tzdp->name ? strlen(tzdp->name) : 0;
>>
>> I suggest to change to a const char * and no longer limit to 
>> THERMAL_NAME_LENGTH.
> 
> ...and to be completely honest, I actually like the THERMAL_NAME_LENGTH 
> limitation,
> because this both limits the length of the related sysfs file and avoids 
> prolonging
> error messages with very-very-very long type-strings and name-strings.
> 
> What I have in my head is:
> 
> imagine having a thermal zone named "cpu-little-bottom-right-core0" and 
> a driver
> named "qualcomm-power-controller" (which doesn't exist, but there are 
> drivers with
> pretty long names in the kernel anyway).
> 
> Kernel logging *may* have very long strings, decreasing readability:
> [ 0.0000100 ] qualcomm-power-controller: cpu-little-bottom-right-core0: 
> Failed to read thermal zone temperature -22
> 
> And sysfs would have something like
> cpu-little-top-right-core0 cpu-little-top-left-core0 
> cpu-little-bottom-right-core0
> 
> While sysfs could be ok, are we sure that allowing such long names is a 
> good idea?
> 
> It's a genuine question - I don't really have more than just cosmetic 
> reasons and
> those are just only personal perspectives....

IMO, it is up to the programmer to choose a convenient name.

If the traces are giving unreadable output, then someone will send a 
patch to change the name to something more readable.

In addition, having array in structure to be passed as parameter is not 
good because of the limited stack size in the kernel.


>>> +    if (tz_name_len) {
>>> +        struct thermal_zone_device *pos;
>>> +
>>> +        if (tz_name_len >= THERMAL_NAME_LENGTH) {
>>> +            pr_err("Thermal zone name (%s) too long, should be under 
>>> %d chars\n",
>>> +                   tzdp->name, THERMAL_NAME_LENGTH);
>>> +            return ERR_PTR(-EINVAL);
>>> +        }
>>> +
>>> +        mutex_lock(&thermal_list_lock);
>>> +        list_for_each_entry(pos, &thermal_tz_list, node)
>>> +            if (!strncasecmp(tzdp->name, pos->name, 
>>> THERMAL_NAME_LENGTH)) {
>>> +                result = -EEXIST;
>>> +                break;
>>> +            }
>>> +        mutex_unlock(&thermal_list_lock);
>>> +
>>> +        if (result) {
>>> +            pr_err("Thermal zone name (%s) already exists and must 
>>> be unique\n",
>>> +                   tzdp->name);
>>> +            return ERR_PTR(result);
>>> +        }
>>
>> Perhaps a lookup function would be more adequate. What about reusing 
>> thermal_zone_get_by_name() and search with tz->name if it is !NULL, 
>> tz->type otherwise ?
>>
> 
> Okay yes that makes a lot of sense, and also breaks some of my brain 
> loops around
> making the migration a bit less painful.
> 
> Nice one! Will do :-D
> 
>>> +    }
>>> +
>>>       /*
>>>        * Max trip count can't exceed 31 as the "mask >> num_trips" 
>>> condition.
>>>        * For example, shifting by 32 will result in compiler warning:
>>> @@ -1307,6 +1332,9 @@ struct thermal_zone_device 
>>> *thermal_zone_device_register(struct thermal_zone_dev
>>>       tz->id = id;
>>>       strscpy(tz->type, tzdp->type, sizeof(tz->type));
>>> +    if (tz_name_len)
>>> +        strscpy(tz->name, tzdp->name, sizeof(tzdp->name));
>>> +
>>>       if (!tzdp->ops->critical)
>>>           tzdp->ops->critical = thermal_zone_device_critical;
>>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>>> index 62a903ad649f..eaacc140abeb 100644
>>> --- a/drivers/thermal/thermal_of.c
>>> +++ b/drivers/thermal/thermal_of.c
>>> @@ -486,6 +486,7 @@ static struct thermal_zone_device 
>>> *thermal_of_zone_register(struct device_node *
>>>           ret = PTR_ERR(np);
>>>           goto out_kfree_of_ops;
>>>       }
>>> +    tzdp.name = np->name;
>>>       tzdp.type = np->name;
>>>       tzdp.trips = thermal_of_trips_init(np, &tzdp.num_trips);
>>> diff --git a/drivers/thermal/thermal_sysfs.c 
>>> b/drivers/thermal/thermal_sysfs.c
>>> index f52af8a3b4b5..f4002fa6caa2 100644
>>> --- a/drivers/thermal/thermal_sysfs.c
>>> +++ b/drivers/thermal/thermal_sysfs.c
>>> @@ -23,6 +23,14 @@
>>>   /* sys I/F for thermal zone */
>>> +static ssize_t
>>> +name_show(struct device *dev, struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct thermal_zone_device *tz = to_thermal_zone(dev);
>>> +
>>> +    return sprintf(buf, "%s\n", tz->name);
>>> +}
>>> +
>>>   static ssize_t
>>>   type_show(struct device *dev, struct device_attribute *attr, char 
>>> *buf)
>>>   {
>>> @@ -341,6 +349,7 @@ create_s32_tzp_attr(offset);
>>>    * All the attributes created for tzp (create_s32_tzp_attr) also 
>>> are always
>>>    * present on the sysfs interface.
>>>    */
>>> +static DEVICE_ATTR_RO(name);
>>>   static DEVICE_ATTR_RO(type);
>>>   static DEVICE_ATTR_RO(temp);
>>>   static DEVICE_ATTR_RW(policy);
>>> diff --git a/drivers/thermal/thermal_trace.h 
>>> b/drivers/thermal/thermal_trace.h
>>> index 459c8ce6cf3b..c9dbae1e3b9e 100644
>>> --- a/drivers/thermal/thermal_trace.h
>>> +++ b/drivers/thermal/thermal_trace.h
>>> @@ -28,6 +28,7 @@ TRACE_EVENT(thermal_temperature,
>>>       TP_ARGS(tz),
>>>       TP_STRUCT__entry(
>>> +        __string(thermal_zone_name, tz->name)
>>>           __string(thermal_zone, tz->type)
>>>           __field(int, id)
>>>           __field(int, temp_prev)
>>> @@ -35,15 +36,16 @@ TRACE_EVENT(thermal_temperature,
>>>       ),
>>>       TP_fast_assign(
>>> +        __assign_str(thermal_zone_name, tz->name);
>>>           __assign_str(thermal_zone, tz->type);
>>>           __entry->id = tz->id;
>>>           __entry->temp_prev = tz->last_temperature;
>>>           __entry->temp = tz->temperature;
>>>       ),
>>> -    TP_printk("thermal_zone=%s id=%d temp_prev=%d temp=%d",
>>> -        __get_str(thermal_zone), __entry->id, __entry->temp_prev,
>>> -        __entry->temp)
>>> +    TP_printk("thermal_zone=%s name=%s id=%d temp_prev=%d temp=%d",
>>> +          __get_str(thermal_zone), __get_str(thermal_zone_name),
>>> +          __entry->id, __entry->temp_prev, __entry->temp)
>>>   );
>>>   TRACE_EVENT(cdev_update,
>>> @@ -73,6 +75,7 @@ TRACE_EVENT(thermal_zone_trip,
>>>       TP_ARGS(tz, trip, trip_type),
>>>       TP_STRUCT__entry(
>>> +        __string(thermal_zone_name, tz->name)
>>>           __string(thermal_zone, tz->type)
>>>           __field(int, id)
>>>           __field(int, trip)
>>> @@ -80,15 +83,17 @@ TRACE_EVENT(thermal_zone_trip,
>>>       ),
>>>       TP_fast_assign(
>>> +        __assign_str(thermal_zone_name, tz->name);
>>>           __assign_str(thermal_zone, tz->type);
>>>           __entry->id = tz->id;
>>>           __entry->trip = trip;
>>>           __entry->trip_type = trip_type;
>>>       ),
>>> -    TP_printk("thermal_zone=%s id=%d trip=%d trip_type=%s",
>>> -        __get_str(thermal_zone), __entry->id, __entry->trip,
>>> -        show_tzt_type(__entry->trip_type))
>>> +    TP_printk("thermal_zone=%s name=%s id=%d trip=%d trip_type=%s",
>>> +          __get_str(thermal_zone), __get_str(thermal_zone_name),
>>> +          __entry->id, __entry->trip,
>>> +          show_tzt_type(__entry->trip_type))
>>>   );
>>
>> For now, I think we can keep the traces as they are and keep passing 
>> the tz->type. Then we can replace tz->type by tz->name without 
>> changing the trace format.
>>
> 
> We can but, as a personal consideration, this looks "more complete" - as 
> in - we
> are not dropping the thermal zone *type* concept anyway (even though 
> we're doing
> "something else" with it), so including both type and name in tracing is 
> useful
> to whoever is trying to debug something.
> 
> If you have strong opinions against, though, it literally takes 30 
> seconds for me
> to just remove that part and there's no problem in doing so!

Yes, just drop it for now. We will sort it out after.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


