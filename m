Return-Path: <linux-kernel+bounces-54485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0304284AFD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E79F1C23187
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3E12B14D;
	Tue,  6 Feb 2024 08:21:24 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7912AAD9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207684; cv=none; b=epJb8/uk1ix7wirQ4+a/FxPdZtzAoJ+C4gllbnVyyAZt3PuJjbe9djuKErKz81NgKSgx1vwgZlUrezssX3EXsesfTZMPvseCULkMzTYxtDK4o1nPLyygqRvI5/Hmq4BTMiCyLAIo7OP8xxpJsWq44mVCpIDnrU5MKXmMBRNNKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207684; c=relaxed/simple;
	bh=qK+6gsbdbhaMWLT2zAP4/bSvk0MWrDRejO/dlXF6JJw=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RLNvgb2fQ6ERGAewLV4elfzbHyhIOHFI/2MbDny8+66D5Yw3QLMBG+e1I3dqD6VBrcQLoBPeje9E8NLruOEjzuKhN9d+2N6W5oYS9vpGx9rl2C08AP8UL2AorMMiUdIwda//MqkcSUb7og6meXAzb2fDHxTiznOEksjTOK+oxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TTbkf6X3Qz1gy8r;
	Tue,  6 Feb 2024 16:19:22 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C7771A0172;
	Tue,  6 Feb 2024 16:21:18 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 16:21:17 +0800
CC: <yangyicong@hisilicon.com>
Subject: Re: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
To: Valentin Schneider <vschneid@redhat.com>, <alexs@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, <linux-kernel@vger.kernel.org>,
	<ricardo.neri-calderon@linux.intel.com>, <sshegde@linux.ibm.com>
References: <20240201115447.522627-1-alexs@kernel.org>
 <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <36ca372f-5f08-5c1a-e468-4db026051e17@huawei.com>
Date: Tue, 6 Feb 2024 16:21:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/2 22:27, Valentin Schneider wrote:
> 
> Subject nit: the prefix should be sched/topology
> 
> On 01/02/24 19:54, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> The description of SD_CLUSTER is missing. Add it.
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> To: Valentin Schneider <vschneid@redhat.com>
>> To: Vincent Guittot <vincent.guittot@linaro.org>
>> To: Juri Lelli <juri.lelli@redhat.com>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/sched/topology.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 10d1391e7416..8b45f16a1890 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>>   * function:
>>   *
>>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
>> + *   SD_CLUSTER             - describes CPU Cluster topologies
> 
> So I know this is the naming we've gone for the "Cluster" naming, but this
> comment isn't really explaining anything.
> 
> include/linux/sched/sd_flags.h has a bit more info already:
>  * Domain members share CPU cluster (LLC tags or L2 cache)
> 

Cluster topology in scheduler should mean CPUs beyond the SMT which are sharing
some cache resources (currently L2 on some Intel platforms or L3 Tag on our platforms)
but not the LLC.

A drawing in c5e22feffdd7 ("topology: Represent clusters of CPUs within a die") has
a good illustration and comment of cpus_share_resources() also illustrate this a bit:

/*
 * Whether CPUs are share cache resources, which means LLC on non-cluster
 * machines and LLC tag or L2 on machines with clusters.
 */
bool cpus_share_resources(int this_cpu, int that_cpu)

> I had to go through a bit of git history to remember what the CLUSTER thing
> was about, how about this:
> 
> * SD_CLUSTER             - describes shared shared caches, cache tags or busses
> * SD_SHARE_PKG_RESOURCES - describes shared LLC cache
> 
> And looking at this it would make sense to:
>   rename SD_CLUSTER into SD_SHARE_PKG_RESOURCES
>   rename SD_SHARE_PKG_RESOURCES into SD_SHARE_LLC
> but that's another topic...
> 
>>   *   SD_SHARE_PKG_RESOURCES - describes shared caches
>>   *   SD_NUMA                - describes NUMA topologies
>>   *
>> --
>> 2.43.0
> 
> 
> .
> 

