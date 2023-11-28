Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A237FC87F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbjK1VnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjK1Vm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:42:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1153BD;
        Tue, 28 Nov 2023 13:43:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F198C1FB;
        Tue, 28 Nov 2023 13:43:51 -0800 (PST)
Received: from [10.57.2.117] (unknown [10.57.2.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC6F3F73F;
        Tue, 28 Nov 2023 13:43:03 -0800 (PST)
Message-ID: <23b21239-4268-43e2-acc3-4ebc454944e7@arm.com>
Date:   Tue, 28 Nov 2023 21:44:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: trip: Drop a redundant check from
 thermal_zone_set_trip()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <6010559.lOV4Wx5bFT@kreacher> <4544904.LvFx2qVVIh@kreacher>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4544904.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 13:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes in the thermal framework, a trip points array is
> required for registering a thermal zone that is not tripless, so the
> tz->trips pointer in thermal_zone_set_trip() is never NULL and the
> check involving it is redundant.  Drop that check.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> New patch in v2.
> 
> ---
>   drivers/thermal/thermal_trip.c |    3 ---
>   1 file changed, 3 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -153,9 +153,6 @@ int thermal_zone_set_trip(struct thermal
>   	struct thermal_trip t;
>   	int ret;
>   
> -	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
> -		return -EINVAL;
> -
>   	ret = __thermal_zone_get_trip(tz, trip_id, &t);
>   	if (ret)
>   		return ret;
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
