Return-Path: <linux-kernel+bounces-31004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD083275B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE7C1C21140
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E223CF47;
	Fri, 19 Jan 2024 10:07:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B53C087
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658872; cv=none; b=B/BgzzsS+u68pEdy0TV914urYhSRlbAganBWmW2xUqZ3Ictw6Xy2sx78PINs7kuNrUq/7otVeqKD7jS1PoNMCCjJOQfpLd9rCkJjK1p/bJdg+ng0dwqljXbbSGfGB4xkEHc4KiTTdTBpol3ap60+5dFYQilptb0TIL2PvAXR4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658872; c=relaxed/simple;
	bh=Z8SBMIkxuHo0nr1CRCCR/KAj0F4wPTWY/y+en285gUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aX+WgcV1mnl8KbpfV/Tr3p2jhm+IDTt14afL0WrRpJRkZQdOQEmuMmrs409IWub/rYALYxTGu13LX6fGSKLfmwUOsdBnXMF0rRXmR6zz9gh6gDf7wK52nrp1YTK5cPyp1+R+UGU3gYMLD9qZR8riAsc8flBf/+vn8+DIYxKjIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F965DA7;
	Fri, 19 Jan 2024 02:08:34 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 057BD3F73F;
	Fri, 19 Jan 2024 02:07:45 -0800 (PST)
Message-ID: <52631d2d-a2bb-4e86-af59-ff67bbf0b32a@arm.com>
Date: Fri, 19 Jan 2024 10:07:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] coresight: Remove the 'enable' field.
Content-Language: en-US
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc: Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Tao Zhang
 <quic_taozha@quicinc.com>, Mao Jinlong <quic_jinlmao@quicinc.com>
References: <20231212155407.1429121-1-james.clark@arm.com>
 <20231212155407.1429121-6-james.clark@arm.com>
 <82e9dbed-281c-4a87-8c0b-a2b1cb0a2247@arm.com>
 <cb65b58f-5c6a-ad99-095c-70b9f013b3e5@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <cb65b58f-5c6a-ad99-095c-70b9f013b3e5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2024 09:59, James Clark wrote:
> 
> 
> On 08/01/2024 14:42, Suzuki K Poulose wrote:
>> Hi James
>>
>> +Cc: Tao Zhang <quic_taozha@quicinc.com>
>> +Cc: Mao Jinlong <quic_jinlmao@quicinc.com>
>>
>> On 12/12/2023 15:54, James Clark wrote:
>>> 'enable', which probably should have been 'enabled', is only ever read
>>> in the core code in relation to controlling sources, and specifically
>>> only sources in sysfs mode. Confusingly it's not labelled as such and
>>> relying on it can be a source of bugs like the one fixed by
>>> commit 078dbba3f0c9 ("coresight: Fix crash when Perf and sysfs modes are
>>> used concurrently").
>>>
>>> Most importantly, it can only be used when the coresight_mutex is held
>>> which is only done when enabling and disabling paths in sysfs mode, and
>>> not Perf mode.
>>
>>
>> I think we may be able to relax this a bit for the syfs. The sole reason
>> for holding the mutex is for the "build_path" (and get_enabled_sink)
>> where we need to make sure that no devices are removed/added. We hold
>> necessary refcount on the device and the module (via
>> coresight_grab_device()). After which, we should be able to release the
>> mutex and perform the rest without it in coresight_enable()
>>
> 
> After looking at the per-sink trace ID maps a bit more, I'm not sure if
> it will be worth the mental effort and risk to relax the sysfs locking
> right now.
> 
> We also currently have other things like writing to the global
> tracer_path which are outside of build_path/get_enabled_sink. But for
> the per-sink maps change we'll also have some tracking for sysfs mode
> about which sink map was used for each source and sink. And this state
> will be accessed across multiple sources, and after building the path,
> so it makes sense to leave the locking as-is for now IMO.
> 
> I also can't see a realistic gain from doing it, most sysfs use cases
> would be done from a single threaded script. Maybe in the future we
> could do the change to move the per-device locks into struct
> coresight_device, and then the core code can use them for things that
> need to be locked, but don't need the full coresight_mutex. And then
> that would also work for the per-sink case. But at the moment each
> device has its own lock so that's difficult.

Ok, we could come back to this after the per-sink trace id pool work.
My observation was about the inconsistency between the perf vs sysfs 
mode as you mentioned in the above code.

Suzuki



