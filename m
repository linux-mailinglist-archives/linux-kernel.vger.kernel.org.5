Return-Path: <linux-kernel+bounces-22290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA7829BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8011F245A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726CF495D5;
	Wed, 10 Jan 2024 13:57:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA604A997;
	Wed, 10 Jan 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DB272F4;
	Wed, 10 Jan 2024 05:58:08 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C1F3F5A1;
	Wed, 10 Jan 2024 05:57:20 -0800 (PST)
Message-ID: <f405ad09-cfae-40b9-b73a-a194d39090ed@arm.com>
Date: Wed, 10 Jan 2024 13:58:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/23] PM: EM: Refactor how the EM table is allocated
 and populated
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
 <20240104171553.2080674-8-lukasz.luba@arm.com>
 <CAJZ5v0jETcdATvjgULoGmr_g+cGA3=XWyCTjO1vkBZURCsGuLw@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jETcdATvjgULoGmr_g+cGA3=XWyCTjO1vkBZURCsGuLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/4/24 19:18, Rafael J. Wysocki wrote:
> The changelog actually sets what happens here, so why don't you put
> that into the changelog too?  Something like: "Split the allocation
> and initialization of the EM table"

OK I will do that.

> 
> On Thu, Jan 4, 2024 at 6:15 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Split the process of allocation and data initialization for the EM table.
>> The upcoming changes for modifiable EM will use it.
>>
>> This change is not expected to alter the general functionality.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/power/energy_model.c | 55 ++++++++++++++++++++++---------------
>>   1 file changed, 33 insertions(+), 22 deletions(-)

[snip]

>> --
> 
> The code changes LGTM.

Thanks

