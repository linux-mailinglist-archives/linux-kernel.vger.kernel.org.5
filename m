Return-Path: <linux-kernel+bounces-14201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC48821906
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22082B21CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C2D2E5;
	Tue,  2 Jan 2024 09:41:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FCBD298;
	Tue,  2 Jan 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08204C15;
	Tue,  2 Jan 2024 01:42:36 -0800 (PST)
Received: from [10.57.86.61] (unknown [10.57.86.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80FFA3F7A6;
	Tue,  2 Jan 2024 01:41:47 -0800 (PST)
Message-ID: <58b0f68f-80bc-411f-9c41-c751d353687b@arm.com>
Date: Tue, 2 Jan 2024 09:43:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/23] PM: EM: Refactor a new function
 em_compute_costs()
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-6-lukasz.luba@arm.com>
 <20231217175845.2jdeqaz62mmcjuwu@airbuntu>
 <5f7f52a4-4f0a-4694-a743-478c5e4e4079@arm.com>
 <20231228171441.jgyjtp3knbtcqgf7@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231228171441.jgyjtp3knbtcqgf7@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/28/23 17:14, Qais Yousef wrote:
> On 12/19/23 10:59, Lukasz Luba wrote:
>>
>>
>> On 12/17/23 17:58, Qais Yousef wrote:
>>> On 11/29/23 11:08, Lukasz Luba wrote:
>>>> Refactor a dedicated function which will be easier to maintain and re-use
>>>> in future. The upcoming changes for the modifiable EM perf_state table
>>>> will use it (instead of duplicating the code).
>>>
>>> nit: What is being refactored? Looks like you took em_compute_cost() out of
>>> em_create_perf_table().
>>
>> Yes, it's going to be re-used later for also update code path, not only
>> register code path.
> 
> Sorry I was terse. I meant the commit message could be clearer to require less
> effort untangling what is actually being changed.

OK, I will rephrase that description. Thanks.

