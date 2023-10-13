Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90E7C7F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjJMIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJMIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:04:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0E2AD6;
        Fri, 13 Oct 2023 01:04:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0018E11FB;
        Fri, 13 Oct 2023 01:05:21 -0700 (PDT)
Received: from [10.57.80.116] (unknown [10.57.80.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F73E3F7A6;
        Fri, 13 Oct 2023 01:04:40 -0700 (PDT)
Message-ID: <763f1d6d-28f0-43a7-b537-1a3229987ea3@arm.com>
Date:   Fri, 13 Oct 2023 09:05:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal/core: Reorder the headers inclusion
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, rafael@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL/POWER_ALLOCATOR" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
 <20231012102700.2858952-2-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231012102700.2858952-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/23 11:26, Daniel Lezcano wrote:
> The next changes will move the thermal device structure inside the
> thermal core code. Consequently, the traces must be included after
> thermal_core.h as this one contains the thermal zone device structure
> definition the traces need.
> 
> Reorder the inclusions.
> 
> No functional changes intended.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/gov_power_allocator.c | 6 +++---
>   drivers/thermal/thermal_core.c        | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index d1c6ad92e5b4..6056ed15460b 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -11,12 +11,12 @@
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   
> -#define CREATE_TRACE_POINTS
> -#include "thermal_trace_ipa.h"
> -
>   #define THERMAL_CORE_SUBSYS
>   #include "thermal_core.h"
>   
> +#define CREATE_TRACE_POINTS
> +#include "thermal_trace_ipa.h"


There is a small issue here to fix:

Applying: thermal/core: Reorder the headers inclusion
.git/rebase-apply/patch:21: trailing whitespace.
#include "thermal_trace_ipa.h"
warning: 1 line adds whitespace errors.

Other than that LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
