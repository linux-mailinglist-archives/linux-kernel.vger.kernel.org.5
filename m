Return-Path: <linux-kernel+bounces-20785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E01828538
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39112859DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B13237168;
	Tue,  9 Jan 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQAOuCRm"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980837149
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5336986cso37071975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704800188; x=1705404988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYLT0qvMtDb9bGOL70/rSJQJuAA1NaKrZmALayFAo1A=;
        b=RQAOuCRm4cK4wQmxvZ7gSfiGHbjHLqqJIu+kC33pnM7gZiUcsr6zMFCTb5hLd1uH0+
         7yoX6kGvrAFNQ8XZ0oCBm6b9Nxd/DMoKSJRK9JriUtHPo/oMyLlJieWh+cjdmVhmraXP
         gx8srF/GWY/H1q12s5Gxw5IFjbH7FdaerG9nx7oVypiWdOsh6vawi/tNwrHEIXuEimTk
         gT98IzPQSm1BKiXeBYqSb7WxLDeugedEPdp6oHU7o2Blhs4nu+hHo5b4OCXAqwVylivB
         gLHOrG09NbCQebU3A//CQZzCoemMfrLh5ZS70Yk0pziRPzysbqePqSfLgBoqQOaWuErd
         1ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704800188; x=1705404988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYLT0qvMtDb9bGOL70/rSJQJuAA1NaKrZmALayFAo1A=;
        b=TfS9RNpFzNjISlWmabGH7BBm3gEXTZab0xKvgltsiDXBQ98Bi01XUwRYlmmMVXqaip
         z89KftkuR0B/H7mSmBBfPuHHwIO0lXorvgZYumLZ6xWDjnNsmMY6mxsilIEfc/iGbCOo
         vMIUtj9iR8LLXMV7WgjMY8VuDGUi98MzMh1dRVfTyk/YOyIEIJamR+dr9Q8hLeo1Fnpr
         NS5uJ2h4a94B0IcETQME5zJEH+skPaTLCYMCmr7BuZGz51EDl3b5ePsgYwBjIKGhc0Lr
         0KsSrHGrlwJPlD3a081/5lF43MvE58ZPAD9J9r0Py5P6pNNaoeVEK2aXqbSpNCypJ+/I
         E9cg==
X-Gm-Message-State: AOJu0YxURddRCRuowjBaM3QXQFZiUsPL4fWocqcAKaPrMe4V7ISqTE6V
	TkY5OzqBGw/MkRVUS7SIDDxeQF+laVvOgeb61/ltjhtsvu0=
X-Google-Smtp-Source: AGHT+IFSPhpyusi1ZKlZPcBaodbOmS1T4I7Mjupyw3EOBnP6C6PUY8mH7c0OaJT6q2W4wdk1ECphQw==
X-Received: by 2002:a05:600c:3ac6:b0:40e:4733:a932 with SMTP id d6-20020a05600c3ac600b0040e4733a932mr1399070wms.88.1704800187907;
        Tue, 09 Jan 2024 03:36:27 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m21-20020a05600c3b1500b0040d5c58c41dsm3291188wms.24.2024.01.09.03.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:36:27 -0800 (PST)
Message-ID: <13835e24-1042-41e4-9a3c-dd0adf3462ca@linaro.org>
Date: Tue, 9 Jan 2024 12:36:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] thermal: netlink: Rework cdev-related notify API
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4556052.LvFx2qVVIh@kreacher> <7628882.EvYhyI6sBW@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7628882.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/12/2023 21:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only actually used thermal netlink notification routine related
> to cooling devices is thermal_notify_cdev_state_update().  The other
> two, thermal_notify_cdev_add() and thermal_notify_cdev_delete(), are
> never used.

I think it is an oversight. These should be called in 
thermal_cooling_device_[un]register()


> So as to get rid of dead code, drop thermal_notify_cdev_add/delete(),
> which can be added back if they turn out to be ever needed, along with
> the related code.
> 
> In analogy with the previous thermal netlink API changes, redefine
> thermal_notify_cdev_state_update() to take a const cdev pointer as its
> first argument and let it extract the requisite information from there
> by itself.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_helpers.c |    2 -
>   drivers/thermal/thermal_netlink.c |   43 ++------------------------------------
>   drivers/thermal/thermal_netlink.h |   19 +++-------------
>   3 files changed, 8 insertions(+), 56 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_netlink.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.h
> +++ linux-pm/drivers/thermal/thermal_netlink.h
> @@ -24,9 +24,8 @@ int thermal_notify_tz_trip_up(const stru
>   			      const struct thermal_trip *trip);
>   int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
>   				  const struct thermal_trip *trip);
> -int thermal_notify_cdev_state_update(int cdev_id, int state);
> -int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
> -int thermal_notify_cdev_delete(int cdev_id);
> +int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
> +				     int state);
>   int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
>   				 const char *name);
>   int thermal_genl_sampling_temp(int id, int temp);
> @@ -76,18 +75,8 @@ static inline int thermal_notify_tz_trip
>   	return 0;
>   }
>   
> -static inline int thermal_notify_cdev_state_update(int cdev_id, int state)
> -{
> -	return 0;
> -}
> -
> -static inline int thermal_notify_cdev_add(int cdev_id, const char *name,
> -					  int max_state)
> -{
> -	return 0;
> -}
> -
> -static inline int thermal_notify_cdev_delete(int cdev_id)
> +static inline int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
> +						   int state)
>   {
>   	return 0;
>   }
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -152,7 +152,7 @@ static void thermal_cdev_set_cur_state(s
>   	if (cdev->ops->set_cur_state(cdev, target))
>   		return;
>   
> -	thermal_notify_cdev_state_update(cdev->id, target);
> +	thermal_notify_cdev_state_update(cdev, target);
>   	thermal_cooling_device_stats_update(cdev, target);
>   }
>   
> Index: linux-pm/drivers/thermal/thermal_netlink.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> +++ linux-pm/drivers/thermal/thermal_netlink.c
> @@ -147,27 +147,6 @@ static int thermal_genl_event_tz_trip_ch
>   	return 0;
>   }
>   
> -static int thermal_genl_event_cdev_add(struct param *p)
> -{
> -	if (nla_put_string(p->msg, THERMAL_GENL_ATTR_CDEV_NAME,
> -			   p->name) ||
> -	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
> -			p->cdev_id) ||
> -	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_MAX_STATE,
> -			p->cdev_max_state))
> -		return -EMSGSIZE;
> -
> -	return 0;
> -}
> -
> -static int thermal_genl_event_cdev_delete(struct param *p)
> -{
> -	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID, p->cdev_id))
> -		return -EMSGSIZE;
> -
> -	return 0;
> -}
> -
>   static int thermal_genl_event_cdev_state_update(struct param *p)
>   {
>   	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
> @@ -244,8 +223,6 @@ static cb_t event_cb[] = {
>   	[THERMAL_GENL_EVENT_TZ_TRIP_UP]		= thermal_genl_event_tz_trip_up,
>   	[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]	= thermal_genl_event_tz_trip_down,
>   	[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= thermal_genl_event_tz_trip_change,
> -	[THERMAL_GENL_EVENT_CDEV_ADD]		= thermal_genl_event_cdev_add,
> -	[THERMAL_GENL_EVENT_CDEV_DELETE]	= thermal_genl_event_cdev_delete,
>   	[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]	= thermal_genl_event_cdev_state_update,
>   	[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]	= thermal_genl_event_gov_change,
>   	[THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE] = thermal_genl_event_cpu_capability_change,
> @@ -348,28 +325,14 @@ int thermal_notify_tz_trip_change(const
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_CHANGE, &p);
>   }
>   
> -int thermal_notify_cdev_state_update(int cdev_id, int cdev_state)
> +int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
> +				     int state)
>   {
> -	struct param p = { .cdev_id = cdev_id, .cdev_state = cdev_state };
> +	struct param p = { .cdev_id = cdev->id, .cdev_state = state };
>   
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_STATE_UPDATE, &p);
>   }
>   
> -int thermal_notify_cdev_add(int cdev_id, const char *name, int cdev_max_state)
> -{
> -	struct param p = { .cdev_id = cdev_id, .name = name,
> -			   .cdev_max_state = cdev_max_state };
> -
> -	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_ADD, &p);
> -}
> -
> -int thermal_notify_cdev_delete(int cdev_id)
> -{
> -	struct param p = { .cdev_id = cdev_id };
> -
> -	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_DELETE, &p);
> -}
> -
>   int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
>   				 const char *name)
>   {
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


