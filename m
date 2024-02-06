Return-Path: <linux-kernel+bounces-54538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BDE84B077
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB89B280F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3246512C7E9;
	Tue,  6 Feb 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxA8KO68"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4042E3F0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209769; cv=none; b=KxguPsIh1c0AJwDtotwaRKmuL/BQJ6UU39VigQUoLJqqWCD4S8NbJhMymuJOIwTjGQj4sYolcpxqg0VG24gDFBa+BIbfc8iJsGserAzpvqwa+2AvWn45XN4Kx1Wohp3FKO1T7tuZ4xqUIlhl9B3d3bMA/TyyPl6+qzat5i1bZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209769; c=relaxed/simple;
	bh=LbIzFpWvezThBH1cplk4wwF3hF+yCXbHXDj3e/TAAQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXGy56sReI69E2M9pr3FmX7oKRJ+EgTBqi4OvOy/cznSuT2DdAXnlVXxeiAswQ4gYjtYzgAYQER8IPZ8B8/i87qxyRgpg+vNbWUzYWj11i3fTJtGvZZvWfLIUg9bYfMMPLJfwaM1A0+nvfCSfgx7zBhAO/Tj1yj/1YbOyLxpJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxA8KO68; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d72f71f222so43184785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707209767; x=1707814567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEXZKbhbrHoTiwVMMa4yTBLdv8gLq/MCuU1qinu7mqE=;
        b=lxA8KO68x/V6Cki+Eio/qtyE9/xo/853hlh8iwTLrvrJzBeDqXSPnQPwcsF3tvQsa4
         fAneTM5oW6VGwzK5XItvE4g6lVn1V+p1WfiL/RGSh5857mAnnriXkxqeHEYuoRuC4Qca
         s34HEx4Pup/XH76FcWEAG+cMK2V1UbxNgIeYaWNtVJFU+waE4/SImH8gSRFtJIZWK03h
         nMZKxTDl7tL7glUdfbW//Cwxh/Y5OsXpSvyKqemlnSM65lgG1/VuwS27oVASwuI+hIRZ
         yYsF9f+nT1CEcjJ6WDb/Etw0Djr8FDQslu8aGiy2kyrfUGBnYuoKgnR/728By2ZypHiQ
         x4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209767; x=1707814567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEXZKbhbrHoTiwVMMa4yTBLdv8gLq/MCuU1qinu7mqE=;
        b=gCqkXVErYPHH34Wp1ud0T+hFm4tOTYZOEQUGpqy8PwVQ5D5mXUX7+rT6vkN/51wmU+
         XiwtRvfsShb+Jy0l6r8TbmdWzLONIclH8hqkBpSYLX2rBofMDeeHN0BPSo9byZf1ZI8o
         rq6w6yGb0FlUbRS5JbD2DSS08m8t+2F373vICyYYoq+6GNqUg5Fa79sZ/iFMLFzJEf5W
         6AIUbGT2t87ajB0GCsmUymt3SHfkPh1XAEbCsqaMxVL2JyS9NO5l2yKdDT6y0BozVEAD
         Usb1v93jVYgFlJxGvLxalCsgTeKXY/53XT9Ijh/UGZPZZ1N2SCcVUDfdnvXEfn87m1F1
         CcGA==
X-Gm-Message-State: AOJu0Yzbc2Whi5XnScCLuipwAAkmRXQ1pPtGBYYwbVHGAesA0rEND7DU
	nxhbO/n42bWyje3Ow5UBDnCtCXeYxqeYf7J4N9w85i50oXy2D0li
X-Google-Smtp-Source: AGHT+IEgpSXcY0QUO2vOIwbtvPf6234Ts1FJVUl2tgY8Y35fgoIJBBYpHOkPaXpweaKIKMMwIoT3cg==
X-Received: by 2002:a17:902:ec8c:b0:1d9:a647:5579 with SMTP id x12-20020a170902ec8c00b001d9a6475579mr1157305plg.1.1707209767070;
        Tue, 06 Feb 2024 00:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXeO9PuDMVDnfm9CRkiLWbROnaADMSxPqvk+ziATDDW+Bb3W/n1VfZ85G5kHgQzl2RkrEN9HqgyD0122WeEjhaRjhGtClUW/Yt1tavkEP6VtMbFZQxaiGMhlUnc8Q1Y3e1uQNNgPjgXtAPwjz4WTZASM0Ceg48b4tOsGper4Y1fScDW/dk35+BK4rjdKSZYF0vTRgQU9RIf/HPqghtMNudnhnCLqUSy5AJY2asfFo4BsMILb18srVZPakOW6ZGlkx04Vj6uJMfv3X7nRy50wX7ZYQSjWFhSfPiKhkjdO1JRBHHV0XqKhDGo7TxQSmLm2e9lyEaAEpz456niU8InxtvavuSUyxUFnPAHZgMzOIVEr62u0i+b2gq966mv5fz2EgHS8fUpc6t+dMyl
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c14b00b001d74dd065e5sm1311193plj.136.2024.02.06.00.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:56:06 -0800 (PST)
Message-ID: <b19487fe-cc9b-412d-8b70-c0be6ad224ae@gmail.com>
Date: Tue, 6 Feb 2024 16:56:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
Content-Language: en-US
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
References: <20240201115447.522627-1-alexs@kernel.org>
 <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240206024633.GD17602@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240206024633.GD17602@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 10:46 AM, Ricardo Neri wrote:
> On Fri, Feb 02, 2024 at 03:27:32PM +0100, Valentin Schneider wrote:
>>
>> Subject nit: the prefix should be sched/topology
>>
>> On 01/02/24 19:54, alexs@kernel.org wrote:
>>> From: Alex Shi <alexs@kernel.org>
>>>
>>> The description of SD_CLUSTER is missing. Add it.
>>>
>>> Signed-off-by: Alex Shi <alexs@kernel.org>
>>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>>> To: Valentin Schneider <vschneid@redhat.com>
>>> To: Vincent Guittot <vincent.guittot@linaro.org>
>>> To: Juri Lelli <juri.lelli@redhat.com>
>>> To: Peter Zijlstra <peterz@infradead.org>
>>> To: Ingo Molnar <mingo@redhat.com>
>>> ---
>>>  kernel/sched/topology.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index 10d1391e7416..8b45f16a1890 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>>>   * function:
>>>   *
>>>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
>>> + *   SD_CLUSTER             - describes CPU Cluster topologies
>>
>> So I know this is the naming we've gone for the "Cluster" naming, but this
>> comment isn't really explaining anything.
>>
>> include/linux/sched/sd_flags.h has a bit more info already:
>>  * Domain members share CPU cluster (LLC tags or L2 cache)
> 
> I also thought of this, but I didn't want to suggest to repeat in topolog.c
> what is described in sd_flags.h.
> 
> Maybe it is better to remove the descriptions of all flags here and instead
> direct the reader to sd_flags.h?

yes, good idea for getting their meaning directly from the header file. 
So is it fine for next sending?

    sched/fair: remove duplicate comments for SD_ flags
    
    Originally, it missed SD_CLUSTER flag description, but comparing to copy
    the flags meaning from sd_flags.h, reader is better to get info from
    there.
    
    Keep SD_ASYM_PACKING unchange for a point from another way.
    
    Signed-off-by: Alex Shi <alexs@kernel.org>
    To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    To: Valentin Schneider <vschneid@redhat.com>
    To: Vincent Guittot <vincent.guittot@linaro.org>
    To: Juri Lelli <juri.lelli@redhat.com>
    To: Peter Zijlstra <peterz@infradead.org>
    To: Ingo Molnar <mingo@redhat.com>

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..96a24bf954ad 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1551,11 +1551,7 @@ static struct cpumask            ***sched_domains_numa_masks;
  *
  * These flags are purely descriptive of the topology and do not prescribe
  * behaviour. Behaviour is artificial and mapped in the below sd_init()
- * function:
- *
- *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
- *   SD_SHARE_PKG_RESOURCES - describes shared caches
- *   SD_NUMA                - describes NUMA topologies
+ * function, for details in include/linux/sched/sd_flags.h:
  *
  * Odd one out, which beside describing the topology has a quirk also
  * prescribes the desired behaviour that goes along with it:
> 
>>
>> I had to go through a bit of git history to remember what the CLUSTER thing
>> was about, how about this:
>>
>> * SD_CLUSTER             - describes shared shared caches, cache tags or busses
> 
> AFAIK, this describes a subset of CPUs in the package that share a
> resource, likely L2 cache.
> 
>> * SD_SHARE_PKG_RESOURCES - describes shared LLC cache
>>
>> And looking at this it would make sense to:
>>   rename SD_CLUSTER into SD_SHARE_PKG_RESOURCES
> 
> but not all CPUs in the package share the resource
> 
>>   rename SD_SHARE_PKG_RESOURCES into SD_SHARE_LLC
>> but that's another topic...
>>

