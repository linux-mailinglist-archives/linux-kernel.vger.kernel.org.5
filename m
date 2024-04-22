Return-Path: <linux-kernel+bounces-153278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594508ACBD6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC011C22B96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69911465B7;
	Mon, 22 Apr 2024 11:15:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34530146595;
	Mon, 22 Apr 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784527; cv=none; b=u4ubhDQmyR2+X64vgd2KV/WP4gFLNwM/1dKpRkry8WD+XsYbvnQ9tALy7CSYBJPXPDDjnTmRzxKWt1r4tgvR2B5V52vZ0OWlpWrypJ9eDVfDNziIOJ2/uRbaYdirdEQkJQ4ASKnLFH0vTQyt28KS1lhz6UHJ+qJVmqBGZ6riOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784527; c=relaxed/simple;
	bh=NRjxtz/01zaNwXC4ygXZ+GEc92RrPS3zV8ZqSZi7wKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXzCOTy/ApcToCT3kzHU7iMGJRwnTwhdxlg1nx2ucDsFgho52qTvYJ5IRlhq5FgGgaD5troLaUCjNLiNZ41A6Ab/EEeP9nqnWqGkJfbNobPbr1zZdr95YCdZSl2fYv4dQA8uuAxdaOZyWvJHgbo7FizGC5aXLpRoirNE9Hk1qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D6BB339;
	Mon, 22 Apr 2024 04:15:54 -0700 (PDT)
Received: from [10.57.75.149] (unknown [10.57.75.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4B963F7BD;
	Mon, 22 Apr 2024 04:15:24 -0700 (PDT)
Message-ID: <748f5ec4-fa84-4ac8-bb3b-b452741fd786@arm.com>
Date: Mon, 22 Apr 2024 12:15:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal/debugfs: Rename
 thermal_debug_update_temp() to thermal_debug_update_trip_stats()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <4918025.31r3eYUQgx@kreacher> <2937506.e9J7NaK4W3@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2937506.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 14:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rename thermal_debug_update_temp() to thermal_debug_update_trip_stats()
> which is a better match for the purpose of the function.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c    |    2 +-
>   drivers/thermal/thermal_debugfs.c |    2 +-
>   drivers/thermal/thermal_debugfs.h |    4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -504,7 +504,7 @@ void __thermal_zone_device_update(struct
>   	if (governor->manage)
>   		governor->manage(tz);
>   
> -	thermal_debug_update_temp(tz);
> +	thermal_debug_update_trip_stats(tz);
>   
>   	monitor_thermal_zone(tz);
>   }
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -676,7 +676,7 @@ out:
>   	mutex_unlock(&thermal_dbg->lock);
>   }
>   
> -void thermal_debug_update_temp(struct thermal_zone_device *tz)
> +void thermal_debug_update_trip_stats(struct thermal_zone_device *tz)
>   {
>   	struct thermal_debugfs *thermal_dbg = tz->debugfs;
>   	struct tz_debugfs *tz_dbg;
> Index: linux-pm/drivers/thermal/thermal_debugfs.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.h
> +++ linux-pm/drivers/thermal/thermal_debugfs.h
> @@ -11,7 +11,7 @@ void thermal_debug_tz_trip_up(struct the
>   			      const struct thermal_trip *trip);
>   void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
>   				const struct thermal_trip *trip);
> -void thermal_debug_update_temp(struct thermal_zone_device *tz);
> +void thermal_debug_update_trip_stats(struct thermal_zone_device *tz);
>   #else
>   static inline void thermal_debug_init(void) {}
>   static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
> @@ -24,5 +24,5 @@ static inline void thermal_debug_tz_trip
>   					    const struct thermal_trip *trip) {};
>   static inline void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
>   					      const struct thermal_trip *trip) {}
> -static inline void thermal_debug_update_temp(struct thermal_zone_device *tz) {}
> +static inline void thermal_debug_update_trip_stats(struct thermal_zone_device *tz) {}
>   #endif /* CONFIG_THERMAL_DEBUGFS */
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

