Return-Path: <linux-kernel+bounces-68446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70819857A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7F0B242F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3373F2C1B6;
	Fri, 16 Feb 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGagwFqq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912728E22
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079402; cv=none; b=k8lLJMTPfRrmiFQ+lXv/To0oO+zka09OysY+/S1N4TO+67Z45bldRMxKU92Cxaa8e/CWdE0JFkja+EBLjxZRbVoMrKw9/YTmEP18xWY3BawuE6a4JDw0FTpAovcy/+cohJsVrAhzJdvREZLBZ9Ooog8lSmkJtdequoqIjfum5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079402; c=relaxed/simple;
	bh=iS1gdFeYewTybvUGauLe0Pp6QDy5Vte0Bxj561I1+QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lr1yUxDB+g7AzT2TSyLucPcD8Y4VyQ2wGzrxNNcHBH6tdtcv6v6k/PFt7erx8vQnkGZg0XLr/qJbp4jQHvQzh18ND4gINi8Xx5JI9oSCOWhO/dAdj6Lz/LLrq8IP2ZYhoeN8ezsLivFvkM6LXacNWpeHdBZbwIIhp7+PvMhZmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGagwFqq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33aeb088324so973819f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708079399; x=1708684199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKevrJOYIycMmtJhAGuLF6g1H2Kc16hvAKk7YFtZO5A=;
        b=RGagwFqqjzoC9zqMvvWZaCAXkYHMxrYfsJ4tpxHt4w/srHGczq7ElOZL7eK8nf9zpL
         9BNn+EHpphIBdT2TsJ8I3pAzVaZlQg0poeAKLSkAllxCkzGywOUUCbLfJ1cO3f98/h/p
         BTuMWzSfSEXur/BiZ1Uv6XPFbUD7c2u0AWxiyuDrV6Pf7MwKbeOl1O6pXsAM6Mw8mx5t
         cmgIBU0lWDTiyvjnpVLIhBvR3TZ4gMUwEn9wENiLPmslEmivGv7cJA67+pbu/sNSYE59
         Ku8BmZ60z4wCtXkkfUjeTX4MAh+TByYywlVf9JuEycvQZw6OC/aPnNylQtikELDPTPbB
         nmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708079399; x=1708684199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKevrJOYIycMmtJhAGuLF6g1H2Kc16hvAKk7YFtZO5A=;
        b=TiS2lFR8uIHROljQ5UPhQevbwNl6VfgHW1SOfSCOtdglztTtovjOLMJ0Vl2ac1wo/+
         Pgq++iQd3I/6ZSdzsssVCmXkD/J8TIRwFLIcjYvl3UYSOaTavzRg+TuGXH24iYGcs0K9
         pqxeGDvnccVRi2NbOgEWrC7oaLJ9f675d3VjenQqT9IY85KUEvuwukmG8izxop6wUE3o
         Wz1+qkobMhTWUEAAlqXhE0yQ37/8Y+EWCAqfnWYG5H5CnuAibrFxKiuurLVNLwNauO/i
         Tl8Rg3VAOivvNKTyQpT94KKD8++7kdNUf/8q4Oc3pMbY1HRWwHbIX72Ff4G9q8G6O8+y
         kJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPAIAnBrabRxgpFZT6N+Jioz6BWBF4Ihm5x74cDDogWeiVzSuW+5ZUegPK/NoU1XzUgAs2hIsh5tF3xLxYiIR5oJlf76ilu4KKIRZd
X-Gm-Message-State: AOJu0YxhCSvaS6E7X6ihjrvHkFFAMBaQjrlDEnKzra8QhdlhaX/Ge8aE
	dqvsMiw5dZfpghACIuq+uTloQL5zNKAE3hgKu4R6TPXPKvYAVqEn
X-Google-Smtp-Source: AGHT+IGX25jBo8lBEAOfpYHIMUzW49tCJpni1AVlTfEoZVCupl+SQQH/VCfYoINBpYmPXgMDyXyBFg==
X-Received: by 2002:a5d:6190:0:b0:33c:e206:3517 with SMTP id j16-20020a5d6190000000b0033ce2063517mr3800297wru.43.1708079398403;
        Fri, 16 Feb 2024 02:29:58 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id x11-20020adff64b000000b0033d157bb26esm1800611wrp.32.2024.02.16.02.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 02:29:57 -0800 (PST)
Message-ID: <446bb875-7849-43b0-bb8e-be706aa3c666@gmail.com>
Date: Fri, 16 Feb 2024 11:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: add panel_power_savings sysfs entry
 to eDP connectors
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Hung <alex.hung@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240202152837.7388-1-hamza.mahfooz@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240202152837.7388-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 02.02.24 um 16:28 schrieb Hamza Mahfooz:
> We want programs besides the compositor to be able to enable or disable
> panel power saving features.

Well I don't know the full background, but that is usually a no-go.

> However, since they are currently only
> configurable through DRM properties, that isn't possible.

Maybe I'm repeating others, but I wanted to point it out explicitly: 
This is intentional and not that easily changeable.

If it's a common DRM property, e.g. something standardized among all 
drivers, then amdgpu is not allowed to circumvent that.

Regards,
Christian.

>   So, to remedy
> that issue introduce a new "panel_power_savings" sysfs attribute.
>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2: hide ABM_LEVEL_IMMEDIATE_DISABLE in the read case, force an atomic
>      commit when setting the value, call sysfs_remove_group() in
>      amdgpu_dm_connector_unregister() and add some documentation.
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 76 +++++++++++++++++++
>   1 file changed, 76 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8590c9f1dda6..3c62489d03dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6436,10 +6436,79 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
>   	return ret;
>   }
>   
> +/**
> + * DOC: panel power savings
> + *
> + * The display manager allows you to set your desired **panel power savings**
> + * level (between 0-4, with 0 representing off), e.g. using the following::
> + *
> + *   # echo 3 > /sys/class/drm/card0-eDP-1/amdgpu/panel_power_savings
> + *
> + * Modifying this value can have implications on color accuracy, so tread
> + * carefully.
> + */
> +
> +static ssize_t panel_power_savings_show(struct device *device,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct drm_connector *connector = dev_get_drvdata(device);
> +	struct drm_device *dev = connector->dev;
> +	u8 val;
> +
> +	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> +	val = to_dm_connector_state(connector->state)->abm_level ==
> +		ABM_LEVEL_IMMEDIATE_DISABLE ? 0 :
> +		to_dm_connector_state(connector->state)->abm_level;
> +	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t panel_power_savings_store(struct device *device,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct drm_connector *connector = dev_get_drvdata(device);
> +	struct drm_device *dev = connector->dev;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 0, &val);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (val < 0 || val > 4)
> +		return -EINVAL;
> +
> +	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> +	to_dm_connector_state(connector->state)->abm_level = val ?:
> +		ABM_LEVEL_IMMEDIATE_DISABLE;
> +	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +
> +	drm_kms_helper_hotplug_event(dev);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(panel_power_savings);
> +
> +static struct attribute *amdgpu_attrs[] = {
> +	&dev_attr_panel_power_savings.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group amdgpu_group = {
> +	.name = "amdgpu",
> +	.attrs = amdgpu_attrs
> +};
> +
>   static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
>   {
>   	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
>   
> +	sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
>   	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
>   }
>   
> @@ -6541,6 +6610,13 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
>   		to_amdgpu_dm_connector(connector);
>   	int r;
>   
> +	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
> +		r = sysfs_create_group(&connector->kdev->kobj,
> +				       &amdgpu_group);
> +		if (r)
> +			return r;
> +	}
> +
>   	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
>   
>   	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||


