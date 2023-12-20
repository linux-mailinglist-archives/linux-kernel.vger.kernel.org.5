Return-Path: <linux-kernel+bounces-6921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1CA819F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04741C22E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69B2554D;
	Wed, 20 Dec 2023 12:53:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6F25543;
	Wed, 20 Dec 2023 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 479591FB;
	Wed, 20 Dec 2023 04:54:34 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9124D3F738;
	Wed, 20 Dec 2023 04:53:48 -0800 (PST)
Message-ID: <b2f9db3f-96a4-4e1e-9be0-32f19948c489@arm.com>
Date: Wed, 20 Dec 2023 12:54:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Add callback for cooling list update to speed-up
 IPA
Content-Language: en-US
To: daniel.lezcano@linaro.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com,
 linux-kernel@vger.kernel.org
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231212134844.1213381-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel, Rafael,

On 12/12/23 13:48, Lukasz Luba wrote:
> Hi all,
> 
> The patch set a new callback for thermal governors and implementation for
> Intelligent Power Allocator.
> 
> The goal is to move some heavy operarions like the memory allocations and heavy
> computations (multiplications) out of throttle() callback hot path.
> 
> The new callback is generic enough to handle other imporants update events.
> It re-uses existing thermal_notify_event definitions.
> 
> In addition there are some small clean-ups for IPA code.
> 
> changes:
> v2:
> - change callback name to update_tz() and add parameter (Rafael)
> - added new event to trigger this callback - instance 'weight' update
> 
> Regards,
> Lukasz
> 
> Lukasz Luba (8):
>    thermal: core: Add governor callback for thermal zone change
>    thermal: gov_power_allocator: Refactor check_power_actors()
>    thermal: gov_power_allocator: Move memory allocation out of throttle()
>    thermal: gov_power_allocator: Simplify checks for valid power actor
>    thermal: gov_power_allocator: Refactor checks in divvy_up_power()
>    thermal/sysfs: Update instance->weight under tz lock
>    thermal/sysfs: Update governors when the 'weight' has changed
>    thermal: gov_power_allocator: Support new update callback of weights
> 
>   drivers/thermal/gov_power_allocator.c | 216 ++++++++++++++++++--------
>   drivers/thermal/thermal_core.c        |  13 ++
>   drivers/thermal/thermal_sysfs.c       |  15 ++
>   include/linux/thermal.h               |   6 +
>   4 files changed, 182 insertions(+), 68 deletions(-)
> 

I know it's a bit late in time period...
You probably missed that patch set in your mailbox.
This patch set can probably just wait to the next window, or
should I resend it later in 2024?

Regards,
Lukasz

