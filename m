Return-Path: <linux-kernel+bounces-4972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E16D81849A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3092F1C21501
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F013AF5;
	Tue, 19 Dec 2023 09:34:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791B14F61;
	Tue, 19 Dec 2023 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9326C1FB;
	Tue, 19 Dec 2023 01:35:34 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB3D3F738;
	Tue, 19 Dec 2023 01:34:47 -0800 (PST)
Message-ID: <bd73e924-632e-421d-9dc6-55df50147759@arm.com>
Date: Tue, 19 Dec 2023 09:35:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] Documentation: EM: Update with runtime
 modification design
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com,
 linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 linux-pm@vger.kernel.org, rafael@kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-24-lukasz.luba@arm.com>
 <d21b3514-76f0-4571-b904-7b6f3e536328@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <d21b3514-76f0-4571-b904-7b6f3e536328@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 18:51, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
>> Add a new section 'Design' which covers the information about Energy
>> Model. It contains the design decisions, describes models and how they
>> reflect the reality. Remove description of the default EM. Change the
>> other section IDs. Add documentation bit for the new feature which
>> allows to modify the EM in runtime.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   Documentation/power/energy-model.rst | 206 +++++++++++++++++++++++++--
>>   1 file changed, 196 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
>> index 13225965c9a4..1f8cf36914b1 100644
>> --- a/Documentation/power/energy-model.rst
>> +++ b/Documentation/power/energy-model.rst
>> @@ -72,16 +72,48 @@ required to have the same micro-architecture. CPUs in different performance
>>   domains can have different micro-architectures.
>>   
>>   
>> -2. Core APIs
>> +2. Design
>> +-----------------
>> +
>> +2.1 Runtime modifiable EM
>> +^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> The issue I see here is that since now the EM is runtime modifiable and
> there is only one EM people might be confused in locking for a
> non-runtime modifiable EM. (which matches the design till v4).
> 
> So 'runtime modifiability' is now feature of the EM itself.

True, I can skip this, since it's now default.

> 
> There is also a figure in this document illustrating the use of
> em_get_energy(), em_cpu_get() and em_dev_register_perf_domain().
> 
> I wonder if this should be extended to cover all the new interfaces
> created for the 'runtime modifiability' feature?

That ASCI picture would be totally messy, with that many interfaces.
We can think about some other picture later, when this basic code and
basic doc is merged.

