Return-Path: <linux-kernel+bounces-56597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D4C84CC54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D5B21F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543B7A73C;
	Wed,  7 Feb 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GsYPl0XL"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC8E77645;
	Wed,  7 Feb 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314880; cv=none; b=UyaBIuDeDH2GLh62rWbaMT6IzGiwjGebLmLqD7lnqamhfj8RFiAYAPZ6qbW0lT7tT/mK6b4nPYQQ5QUb249onKxZgtawuM58VdWmPOW0XjP2r2LVtOdaLLoRruaxMc6gfN6Z7GkoQQ0AB9MOitskduxkrX4eY58BLOtWN/nw0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314880; c=relaxed/simple;
	bh=+p+eU04ku7I4pP82TK3gqGixe/qQLG+9fDNRE7WoiOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxIB0spKhnMOOltWlcMdHX6oLPFy1E12BczHeO5PXO3uhg4mKt7lpAEBoFkKhb7wDXhWQ5rPrltsCHtnyYENEk1njOMsmGaYIaeztRXyGBXk4Q9x5wjmyB4Qnq9jiQQQlTezQ1pGkT9IfOwKIGbRViF6t0IHYjCxWTCg5GufppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GsYPl0XL; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TVMQL60wxz9sQ8;
	Wed,  7 Feb 2024 15:07:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1707314875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mygFW8DQNLN8N1VOj6Z0gWqKQwdsT62VxC3nQxPrsFI=;
	b=GsYPl0XL+YrzBNZz/J2WxYh0ac5D7QtikEIGxSjr8KUcf3kYg6hGFlfu1F+Zo67Yz1Zozx
	yPQFuP+1Zatd23HPH2jSOYcYHpn32QjxnoypHZyUJRZUgNY0TSoDW3voUceGb6qZo/hWqe
	BAJLdULxXAJT5o1NpPUyFik0fGlg5Q+xiCjJBHU7KRdfnJkywE8uNbXg0JgYDWRTFbmCnc
	/KEuptF2Y7knP3GG8yf6E56+23QLKtqnQBJ+/ElLiwLtYXzh7WFPC+CkGgTrVKwFrmwetB
	ymy7G5oWSnTeMenpC8emM02DRrlwxQa+YAL5w/59pxgCrvzb21qOoYzit+R82Q==
Message-ID: <a639ec29-2941-470a-8027-7ec6246a4c7d@mailbox.org>
Date: Wed, 7 Feb 2024 15:07:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] cpufreq: amd-pstate: Fix min_perf assignment in
 amd_pstate_adjust_perf()
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <41f82085-8ea9-4ffa-a93a-8e39ce0f4c27@mailbox.org>
 <CYYPR12MB86558F397CA052AAAB772FDB9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Language: en-US
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <CYYPR12MB86558F397CA052AAAB772FDB9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d90a85803f43d76dbcf
X-MBO-RS-META: fw9gmeojrw86kzuuzgzgqezcu4xjg95o



On 2/7/24 14:54, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
>   Hi Tor,
> 
>> -----Original Message-----
>> From: Tor Vic <torvic9@mailbox.org>
>> Sent: Wednesday, February 7, 2024 9:09 PM
>> To: Huang, Ray <Ray.Huang@amd.com>; Yuan, Perry
>> <Perry.Yuan@amd.com>; rafael@kernel.org
>> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-
>> pm@vger.kernel.org; Oleksandr Natalenko <oleksandr@natalenko.name>
>> Subject: [PATCH][next] cpufreq: amd-pstate: Fix min_perf assignment in
>> amd_pstate_adjust_perf()
>>
>> In the function amd_pstate_adjust_perf(), the 'min_perf' variable is set to
>> 'highest_perf' instead of 'lowest_perf'.
>>
>> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD
>> P-State")
>> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>> Signed-off-by: Tor Vic <torvic9@mailbox.org>
>> ---
>> IIRC, this was first reported by Oleksandr, hence the 'Reported-by' tag.
>> ---
>>    drivers/cpufreq/amd-pstate.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 08e112444c27..aa5e57e27d2b 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -577,7 +577,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>        if (target_perf < capacity)
>>                des_perf = DIV_ROUND_UP(cap_perf * target_perf,
>> capacity);
>>
>> -     min_perf = READ_ONCE(cpudata->highest_perf);
>> +     min_perf = READ_ONCE(cpudata->lowest_perf);
>>        if (_min_perf < capacity)
>>                min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
>>
>> --
>> 2.43.0
> 
> Thanks for the fix!

I think this is actually for stable and mainline too, not only for -next.
Should I resend with 'Cc: stable' tag and your Reviewed-by?

> 
> Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>

