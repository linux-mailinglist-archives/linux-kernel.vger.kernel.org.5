Return-Path: <linux-kernel+bounces-132186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDD899111
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A631C21022
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E0113C3F0;
	Thu,  4 Apr 2024 22:14:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCEA82D90;
	Thu,  4 Apr 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268889; cv=none; b=bhrl8k4JY/q3dlODo2igab/LtjNISWPLLauVTybgqJwPC4sPMZyFvku+gyqNxWDyzPPGjV5bpF7Y+JE5iTRzGeDxAKmU0QouBSg77YCXH2kvIGLqYA20lui5hmff52ehez/Uxi+9bxE1gyuTkKfJnSdCwDHM4GjXWuoGxdndS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268889; c=relaxed/simple;
	bh=sqwEMUA1os7FpliAUQKZwHxa5Em6p+iIL1ahkh4NK78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuSCiDSpL/5hMRdVAUlZ55cH0SAt4QQojcmcvp3IbZHtT5hoj1WmBQw/u8gkzgpjGW0SaCVB2GNJzZEFXudUEnY1U+6xw6rQUG8zV7RKQx+cCb5CliKYaXiqkI0tpHqbTU2kV62X6P6QEIWMlxs8bcIgpzW3qPsndn4Uiuq4HSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 360F8FEC;
	Thu,  4 Apr 2024 15:15:17 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F6BE3F64C;
	Thu,  4 Apr 2024 15:14:45 -0700 (PDT)
Message-ID: <20cf2a27-9a54-4bbb-bf5f-6a0b82a2a05f@arm.com>
Date: Thu, 4 Apr 2024 23:14:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] thermal: core: Rewrite comments in
 handle_thermal_trip()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <3284691.aeNJFYEL58@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3284691.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/24 19:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the comments regarding trip crossing and threshold updates in
> handle_thermal_trip() slightly more clear.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: New patch
> 
> ---
>   drivers/thermal/thermal_core.c |   26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -368,6 +368,13 @@ static void handle_thermal_trip(struct t
>   	if (trip->temperature == THERMAL_TEMP_INVALID)
>   		return;
>   
> +	/*
> +	 * If the trip temperature or hysteresis has been updated recently,
> +	 * the threshold needs to be computed again using the new values.
> +	 * However, its initial value still reflects the old ones and that
> +	 * is what needs to be compared with the previous zone temperature
> +	 * to decide which action to take.
> +	 */
>   	if (tz->last_temperature == THERMAL_TEMP_INVALID) {
>   		/* Initialization. */
>   		td->threshold = trip->temperature;
> @@ -375,11 +382,9 @@ static void handle_thermal_trip(struct t
>   			td->threshold -= trip->hysteresis;
>   	} else if (tz->last_temperature < td->threshold) {
>   		/*
> -		 * The trip threshold is equal to the trip temperature, unless
> -		 * the latter has changed in the meantime.  In either case,
> -		 * the trip is crossed if the current zone temperature is at
> -		 * least equal to its temperature, but otherwise ensure that
> -		 * the threshold and the trip temperature will be equal.
> +		 * There is no mitigation under way, so it needs to be started
> +		 * if the zone temperature exceeds the trip one.  The new
> +		 * threshold is then set to the low temperature of the trip.
>   		 */
>   		if (tz->temperature >= trip->temperature) {
>   			thermal_notify_tz_trip_up(tz, trip);
> @@ -390,14 +395,9 @@ static void handle_thermal_trip(struct t
>   		}
>   	} else {
>   		/*
> -		 * The previous zone temperature was above or equal to the trip
> -		 * threshold, which would be equal to the "low temperature" of
> -		 * the trip (its temperature minus its hysteresis), unless the
> -		 * trip temperature or hysteresis had changed.  In either case,
> -		 * the trip is crossed if the current zone temperature is below
> -		 * the low temperature of the trip, but otherwise ensure that
> -		 * the trip threshold will be equal to the low temperature of
> -		 * the trip.
> +		 * Mitigation is under way, so it needs to stop if the zone
> +		 * temperature falls below the low temperature of the trip.
> +		 * In that case, the trip temperature becomes the new threshold.
>   		 */
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
>   			thermal_notify_tz_trip_down(tz, trip);
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

