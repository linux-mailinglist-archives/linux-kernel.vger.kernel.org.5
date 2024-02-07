Return-Path: <linux-kernel+bounces-55857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA52284C289
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355831F253F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11857F9FE;
	Wed,  7 Feb 2024 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7b+k26d"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BEEF9DB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273372; cv=none; b=CLfQOWAAvIGJ99UszOEFv7QtBtt1odiguppF1pFh1D2NcbEu2RJtK0z7OV3rNxBBtxWUfzEPzHiw8mM+x5DKMGW2Hc+vNxmqu3Jani98L4R+Sr1/TNEtlegkv58HQ6AF7JkORC4tas1jmVTkx8pSm24o1t4sQZuWSdFtCb65WT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273372; c=relaxed/simple;
	bh=BgmTIDYhApr7t658kOUy/dfCBEOiuMVK+mba6UzxJ+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVVwjJiEMMAqztPdGOBNqK5ND9yggZrm2WsBFjar5JgPFnFxYDIOcsdaenNDSzE7GRqqXEzNlDvbbo9GAD+1BSfkIKnkLiZuRAjkOvFyFaAjATkwFfmjnQldZdWRGgNYHeZega40+WSBS0icws5QsBntenJb8sbKXpA/Ain8oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7b+k26d; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93ddd76adso1498975ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 18:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707273369; x=1707878169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwxolyREjF67jzSSaauA/VDxxaD5yCgP5g5FjzvKU9Q=;
        b=c7b+k26dbbh3t1zRZgbG2aWjqq9SaTseN/ahGsVOtjlmGzwHHKTXY8svsuE/DQftKC
         /nLtThdPHgjZlovon1N4VO8+Ne0eJWo4mKqXr49Dmf3xzl06chcgq9rFLgjzj3g/0DI5
         oEqp/MmqXhgFe13dzogaipdwgkaflozvGiqd8VbjCI+Lj1pp6sRY9xtZMpi2kCXRRe17
         AEIg3HPXlYEurhrFUjJjfZin3vanwac23Th5tuida8fKe73c6O6UjEUeWMGNfRMwI+eJ
         zhZQCAylsTOC2bq8BI8SVjeqbr3Oz1rh3qyN8EmggLm0PEhx4lsrP6ldD3c775lfvVJR
         EkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707273369; x=1707878169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwxolyREjF67jzSSaauA/VDxxaD5yCgP5g5FjzvKU9Q=;
        b=Onqxtth/qIyR81uWBS8eTjYc88eCSxjGQXXGzAGfjOn5TyWENMPnuTcDW43hYTaNeB
         jIWi7kLuO9ArJeOahM1xbt4Kj2XZrVNQrWXaVjoCfwoSoFjnBgarBEGSzabHPg2PEMuD
         bhyxGy+sbsAHuZSyXoiDggHwIECAc2rxeZ2eIWGiLT/bG2ftzSon4huCM42AYQn/jiQ+
         7I2e6ekMJVSFe8jPccizJSvrM3/YwVQ2qd4aWmaD/m6fE1WD82ZM/wlLBkiFgQ1Syt7H
         15smLqYKSstwtBxjK/AfuA+41oSKxObapNUzxJblOlt6UsFrqFumY6Yh7wpxInJrtUpi
         VYCA==
X-Gm-Message-State: AOJu0YxgE+8kufVArERPMRuYBq2x5gGVimfadTSWZbAZRzUyMTOoGCkB
	xW4KLCIFPCqT0mkYoISug2XlgEBCQZpfp0G0lQpWZ/i80XsTXP7O
X-Google-Smtp-Source: AGHT+IEC+Vct4yXqnBo96WLWFBF2WqKSpwfn3rydCBY7P4VB7chyt5JfCp3RURceryj2mTha+QILmg==
X-Received: by 2002:a17:902:f7c2:b0:1d9:751f:3746 with SMTP id h2-20020a170902f7c200b001d9751f3746mr3171564plw.49.1707273368998;
        Tue, 06 Feb 2024 18:36:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+h4ClVry6Fn8FMz2g2GHSRIUlMUw0uI1A1Mhz2Y31zIsRh1Z3vsqzs2DqbfOYSeimWY34TaHypag48hNMfTrOFo4kL3jjHZJlX3pV6+ZjxY0yRT7gemriSADdg6ff9KkSx8xCRnRNF8haQy9us+k6P0rY1808j9dATfOuz3Mid6trz8okYY9yCf515qm9zBbslZHMSwqOJbYOO8pCDbiXcGng56W9MWxx+SRy94U1kfi9gZfIXs34EQnwyZ/w6iCBkkW9Wdf28i2YxBLnbg4uGtE3fyYI2yUEc4VsOt+ys07zUxdCxqki1/fKcYAfLhwxtVaEUzNImEsR6MVnID8tKLKqQGc3ylxAjB24Kp0SEHZxSIjmW35IeLiifEoeHWdaIP0d6YpeQV0X
Received: from [192.168.255.10] ([43.132.141.26])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b001d956e84582sm237320pld.91.2024.02.06.18.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 18:36:08 -0800 (PST)
Message-ID: <b2d1ceb8-4cce-4249-a282-619e6564fbf5@gmail.com>
Date: Wed, 7 Feb 2024 10:36:04 +0800
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
 <xhsmheddphgx5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240206215702.GB19695@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240206215702.GB19695@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 5:57 AM, Ricardo Neri wrote:
> On Tue, Feb 06, 2024 at 02:16:06PM +0100, Valentin Schneider wrote:
>> On 05/02/24 18:46, Ricardo Neri wrote:
>>> On Fri, Feb 02, 2024 at 03:27:32PM +0100, Valentin Schneider wrote:
>>>>
>>>> Subject nit: the prefix should be sched/topology
>>>>
>>>> On 01/02/24 19:54, alexs@kernel.org wrote:
>>>>> From: Alex Shi <alexs@kernel.org>
>>>>>
>>>>> The description of SD_CLUSTER is missing. Add it.
>>>>>
>>>>> Signed-off-by: Alex Shi <alexs@kernel.org>
>>>>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>>>>> To: Valentin Schneider <vschneid@redhat.com>
>>>>> To: Vincent Guittot <vincent.guittot@linaro.org>
>>>>> To: Juri Lelli <juri.lelli@redhat.com>
>>>>> To: Peter Zijlstra <peterz@infradead.org>
>>>>> To: Ingo Molnar <mingo@redhat.com>
>>>>> ---
>>>>>  kernel/sched/topology.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>>> index 10d1391e7416..8b45f16a1890 100644
>>>>> --- a/kernel/sched/topology.c
>>>>> +++ b/kernel/sched/topology.c
>>>>> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>>>>>   * function:
>>>>>   *
>>>>>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
>>>>> + *   SD_CLUSTER             - describes CPU Cluster topologies
>>>>
>>>> So I know this is the naming we've gone for the "Cluster" naming, but this
>>>> comment isn't really explaining anything.
>>>>
>>>> include/linux/sched/sd_flags.h has a bit more info already:
>>>>  * Domain members share CPU cluster (LLC tags or L2 cache)
>>>
>>> I also thought of this, but I didn't want to suggest to repeat in topolog.c
>>> what is described in sd_flags.h.
>>>
>>> Maybe it is better to remove the descriptions of all flags here and instead
>>> direct the reader to sd_flags.h?
>>>
>>
>> Yeah I agree on less duplication.
>>
>>>>
>>>> I had to go through a bit of git history to remember what the CLUSTER thing
>>>> was about, how about this:
>>>>
>>>> * SD_CLUSTER             - describes shared shared caches, cache tags or busses
>>>
>>> AFAIK, this describes a subset of CPUs in the package that share a
>>> resource, likely L2 cache.
>>>
>>>> * SD_SHARE_PKG_RESOURCES - describes shared LLC cache
>>>>
>>>> And looking at this it would make sense to:
>>>>   rename SD_CLUSTER into SD_SHARE_PKG_RESOURCES
>>>
>>> but not all CPUs in the package share the resource
>>
>> But SD_CLUSTER never expands beyond the package, right?
> 
> Correct.
> 
>>
>> Regardless, my main point is that having both SD_CLUSTER and
>> SD_SHARE_PKG_RESOURCES is a source of confusion (at the very least for
>> myself),
> 
> Agreed!
> 
>> and given SD_SHARE_PKG_RESOURCES is really used to mean "shares
>> LLC" (see update_top_cache_domain()), we could make that flag more explicit
>> and lift some ambiguity with SD_CLUSTER.
> 
> As Yicong stated, cluster topology should mean CPUs beyond SMT that share
> some resource but not LLC.
> 
> It makes sense to me to keep SD_CLUSTER name as it is today and rename
> SD_SHARE_PKG_RESOURCES as SD_SHARE_LLC.

yes, agree with his.


