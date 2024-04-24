Return-Path: <linux-kernel+bounces-156885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAA8B09E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877611F22F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441F143878;
	Wed, 24 Apr 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT72zjen"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC733989
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962541; cv=none; b=N7PkzB3u6H+dT2TBRh3TT9L7+aOdOqeHhFJnuivhemryz3JvyTrTmP24EVq2R88iT4hmv2OcmtNzU5DPVu7h85hmY1fYDG1z20R9g+N3oKkstJ4U5E48yPub9ztNQmYwiWnxtD0MT18qZW7PLQmyhURdTVedaza1cZ3XSuZJxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962541; c=relaxed/simple;
	bh=WjPnRgUoJqlBUscc7pwhQkggwrqjiHR7iRXGSKeaOX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lkm3PfaJnMQ00mp95v/kHRLYK3lrrGgxoYrMjty7fHLB470IMEr1xkoSYxXULocEJwj/bCPfB6+dibMYRIoclN60EX99cG0yF/147LJI92WYnm3cJ8+lFJuAMO7obOB224JZcNKlxDH7DHEP08tREe4zH6DZVicM/YLWUBSD784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT72zjen; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572040691c9so1637261a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713962538; x=1714567338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G35Udwj9Bz+VcheWu2qe8n0792VGi8vidupqbamOdkI=;
        b=DT72zjenKuQCyw25i3+leH4Eg8c01onO9WAAx4vaagi4e+t9nuJnT+MRWxTnjI8aYW
         8t4NKuyBUUM5/1MUQgOfSj+ojhZPfq7f5SRnWgxDTvjs5RJZPbblW7xvzYll/W/HRRtV
         dYY7xwxrvbi60UHr5A8FikiDXXUcfZELffMMDVcFZ3f6WKXk8o2KiEaGeRDhDZMKJqCR
         QQQXTAWsnzLHNLNnVNd7Qc1pk+6QodkR30Wi9dIKEAP6fbVv9GkiZfONzuPQeEgW9V9z
         46WXtxwzGlyjzkHFgyFApU84KlGNAtei+PZb0S8jzBnUJXZlCeWfX6CADWcijGnBHdeb
         45Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713962538; x=1714567338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G35Udwj9Bz+VcheWu2qe8n0792VGi8vidupqbamOdkI=;
        b=snVkjjdoQL8k0Iyngravd6Bnm+iX2AaaU6OTqv5HmNGU1nsH8snPMV4yehi1hUDg50
         mZZgzp0JAskm4/LWA9tl2fAswElK2kErrIQWVL8qR7Ga7ZWtvok5rfyVg6MbECJspLL/
         URVSMnSa62l5d89LefzSld+1dI5HLOjURHGyWM3B4FZgLxzxAgJgGUjvfI24YRY3sTVQ
         UQ56IMilxiU0Me6JC2fGiVuIIAGqV3rfVNMpFMhEi4Gq0+HN9nRLp12AwbiencAqX56x
         B7G9cC11VYPGTZ5rf2wK8qU1+JlYy/GptmcSsFFEbTzhNghCt8KWg3IMgor1yKVQSt1v
         k7ow==
X-Forwarded-Encrypted: i=1; AJvYcCWuMRURtvFRaS3G+vguP4/zdub6oLbqI1VIx4aEjYKACtEWkYKtxHm06hfY0pt0DfFOFpALUPDqnAO0sH535HokMntEXWTY6/yrM2wZ
X-Gm-Message-State: AOJu0YyPq/R+UZbUi0E7GndIsKGM/7UdSwXtl97hfy0aLEcTDhLz5B0C
	rMUdh+2q7OFxa8m+jvVbFnkScQantgX4/VR586z5VxdiZ55Qfceg
X-Google-Smtp-Source: AGHT+IHXown7Dwzxvo38ijbB7FDQJm/wYLtASKk41/aZbgUXY840vrw4+5Rj5H+COMI/OSBuvZbPww==
X-Received: by 2002:a50:c358:0:b0:572:1fb7:2a77 with SMTP id q24-20020a50c358000000b005721fb72a77mr2262994edb.6.1713962538295;
        Wed, 24 Apr 2024 05:42:18 -0700 (PDT)
Received: from [192.168.97.201] ([62.19.103.108])
        by smtp.gmail.com with ESMTPSA id d6-20020a50fb06000000b005705e7ee65esm7819699edq.56.2024.04.24.05.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:42:18 -0700 (PDT)
Message-ID: <d677360a-0f97-412c-8563-1def406061bd@gmail.com>
Date: Wed, 24 Apr 2024 14:42:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: use __free attribute instead of of_node_put()
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 julia.lawall@inria.fr, linux-kernel@vger.kernel.org, rafael@kernel.org,
 skhan@linuxfoundation.org
References: <20240419140106.3mkayxriqjt2cz5i@bogus>
 <20240422130931.176635-1-vincenzo.mezzela@gmail.com>
 <20240424103756.jhloae3fcyinyba4@bogus>
Content-Language: en-US
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
In-Reply-To: <20240424103756.jhloae3fcyinyba4@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/24 12:37, Sudeep Holla wrote:
> On Mon, Apr 22, 2024 at 03:09:31PM +0200, Vincenzo Mezzela wrote:
>> Introduce the __free attribute for scope-based resource management.
>> Resources allocated with __free are automatically released at the end of
>> the scope. This enhancement aims to mitigate memory management issues
>> associated with forgetting to release resources by utilizing __free
>> instead of of_node_put().
>>
>> The declaration of the device_node used within the do-while loops is
>> moved directly within the loop so that the resource is automatically
>> freed at the end of each iteration.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
>> ---
>> changes in v2:
>>      - check loop exit condition within the loop
>>      - add cleanup.h header
>>
>>   drivers/base/arch_topology.c | 150 +++++++++++++++++------------------
>>   1 file changed, 73 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 024b78a0cfc1..c9c4af55953e 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/rcupdate.h>
>>   #include <linux/sched.h>
>>   #include <linux/units.h>
>> +#include <linux/cleanup.h>
>>
> Keep it alphabetical. Also since <linux/of.h> does define kfree for
> of_node_get(), may not be needed strictly. Sorry for not noticing those
> details earlier. I am fine either way, it is good to keep it IMO.
>
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/thermal_pressure.h>
>> @@ -513,10 +514,10 @@ core_initcall(free_raw_capacity);
>>    */
>>   static int __init get_cpu_for_node(struct device_node *node)
>>   {
>> -	struct device_node *cpu_node;
>>   	int cpu;
>>
>> -	cpu_node = of_parse_phandle(node, "cpu", 0);
>> +	struct device_node *cpu_node __free(device_node) =
>> +		of_parse_phandle(node, "cpu", 0);
>>   	if (!cpu_node)
>>   		return -1;
>>
>> @@ -527,7 +528,6 @@ static int __init get_cpu_for_node(struct device_node *node)
>>   		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
>>   			cpu_node, cpumask_pr_args(cpu_possible_mask));
>>
>> -	of_node_put(cpu_node);
>>   	return cpu;
>>   }
>>
>> @@ -538,28 +538,27 @@ static int __init parse_core(struct device_node *core, int package_id,
>>   	bool leaf = true;
>>   	int i = 0;
>>   	int cpu;
>> -	struct device_node *t;
>>
>> -	do {
>> +	for(;;) {
> Did you run checkpatch.pl on this ? It should have complained here and 3 other
> places below.
It does indeed, I'll fix this.
>
>> -			if (leaf) {
>> -				ret = parse_core(c, package_id, cluster_id,
>> -						 core_id++);
>> -			} else {
>> -				pr_err("%pOF: Non-leaf cluster with core %s\n",
>> -				       cluster, name);
>> -				ret = -EINVAL;
>> -			}
>> +		has_cores = true;
>>
>> -			of_node_put(c);
>> -			if (ret != 0)
>> -				return ret;
>> +		if (depth == 0) {
>> +			pr_err("%pOF: cpu-map children should be clusters\n", c);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (leaf) {
>> +			ret = parse_core(c, package_id, cluster_id, core_id++);
>> +		} else {
>> +			pr_err("%pOF: Non-leaf cluster with core %s\n",
>> +					cluster, name);
> Missing alignment here.
>
> --
> Regards,
> Sudeep

I'll fix the misalignment and the checkpatch.pl warnings and send an 
updated version.

Furthermore, would you like to see this patch split in two patches where:

- patch 1 reorganizes the content of the loop using "if(!t) break;" 
instead of having the "if(t) { all for body }";

- patch 2 gets rid of of_node_put;

This might be better than having both the reorganizations in the same patch.

Please let me know what would you prefer.

Thanks,

Vincenzo


