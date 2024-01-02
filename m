Return-Path: <linux-kernel+bounces-14196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A222E8218FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD0282C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9E7492;
	Tue,  2 Jan 2024 09:39:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350679E5;
	Tue,  2 Jan 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E10F5C15;
	Tue,  2 Jan 2024 01:39:55 -0800 (PST)
Received: from [10.57.86.61] (unknown [10.57.86.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 705003F7A6;
	Tue,  2 Jan 2024 01:39:07 -0800 (PST)
Message-ID: <96dd6f75-0c3d-4dc3-a44f-144bfabd7d13@arm.com>
Date: Tue, 2 Jan 2024 09:40:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/23] PM: EM: Refactor
 em_cpufreq_update_efficiencies() arguments
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-3-lukasz.luba@arm.com>
 <20231217175812.s5vaabxtm4cgil36@airbuntu>
 <89df2982-5492-43db-8e25-d974ff19fda2@arm.com>
 <20231228165901.q4sj43wkpiy2be2t@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231228165901.q4sj43wkpiy2be2t@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/28/23 16:59, Qais Yousef wrote:
> On 12/19/23 10:30, Lukasz Luba wrote:
>>
>>
>> On 12/17/23 17:58, Qais Yousef wrote:
>>> On 11/29/23 11:08, Lukasz Luba wrote:
>>>> In order to prepare the code for the modifiable EM perf_state table,
>>>> refactor existing function em_cpufreq_update_efficiencies().
>>>
>>> nit: What is being refactored here? The description is not adding much info
>>> about the change.
>>
>> The function takes the ptr to the table now as its argument. You have
>> missed that in the code below?
> 
> I meant the commit message could be more descriptive if you care to expand on
> it.

I see, yes I will adjust the comment.

