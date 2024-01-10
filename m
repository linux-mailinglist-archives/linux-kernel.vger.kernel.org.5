Return-Path: <linux-kernel+bounces-22294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9796829BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6BC2898D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D231495EB;
	Wed, 10 Jan 2024 14:00:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD745495F1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E5CE2F4;
	Wed, 10 Jan 2024 06:01:41 -0800 (PST)
Received: from [10.57.46.83] (unknown [10.57.46.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 230AE3F5A1;
	Wed, 10 Jan 2024 06:00:54 -0800 (PST)
Message-ID: <4eef0b8d-3702-429b-bf9b-50e176498833@arm.com>
Date: Wed, 10 Jan 2024 14:00:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] coresight: Remove unused stubs
Content-Language: en-GB
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc: Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231212155407.1429121-1-james.clark@arm.com>
 <20231212155407.1429121-9-james.clark@arm.com>
 <01c15dbe-57d3-4aa1-9d68-81a01ec2a3a7@arm.com>
 <ebdc7d87-c0c4-9ee3-83a9-6c93e6fcea78@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ebdc7d87-c0c4-9ee3-83a9-6c93e6fcea78@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2024 16:48, James Clark wrote:
> 
> 
> On 09/01/2024 10:38, Suzuki K Poulose wrote:
>> Hi James
>>
>> On 12/12/2023 15:54, James Clark wrote:
>>> These are a bit annoying to keep up to date when the function signatures
>>> change. But if CONFIG_CORESIGHT isn't enabled, then they're not used
>>> anyway so just delete them.
>>>
>>
>> Have you tried building an arm32 kernel with this change in ? Looks like
>> arch/arm/kernel/hw_breakpoint.c includes linux/coresight.h and a build
>> with CONFIG_CORSIGHT=n might break the build ? So is
> 
> arm32 and CONFIG_CORESIGHT=n works because hw_breakpoint.c doesn't use
> any of those symbols, only #defines that were outside the #if
> IS_ENABLED(CONFIG_CORESIGHT), specifically CORESIGHT_UNLOCK.
> 
>> drivers/accel/habanalabs/common/habanalabs.h. Now, I am not sure if they
> 
> habanalabs is interesting, it depends on X86_64, but CONFIG_CORESIGHT
> depends on ARM || ARM64, so I think we can assume it's also only looking
> for #defines and inlines, and not actual code.
> 
> Either way I can't find any build config that actually ever built this,
> meaning it's always been dead code. I would have expected some build
> robot to have flagged an error by now as I've seen that on other
> coresight patches.
> 
>> really need it (even if they do, we may be able to remove the dependency
>> on the header file.
>>
> 
> They do really need it, also for the CORESIGHT_UNLOCK definition, but
> not any functions.

Thanks for checking this.

Suzuki



