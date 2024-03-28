Return-Path: <linux-kernel+bounces-123259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68CB89055B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A81F2661F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D593BB27;
	Thu, 28 Mar 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="J1KF93Iy"
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE923A1C4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643722; cv=pass; b=bV+havZLQ8WVpjEE0cpQkFY9mGt5Ai7OqdqDPsD8AZYkEzexRsGr2cPFpLCf8H8D7asBaghtxrfkawQ77HtzDgIs0xhV/JO4QaxeuH+3ebldchBVlLHwBTUGlslLI5obmozcGf3Ivqm6xPlVbRSmtjoxN74Obt3/5dq5A7HrzDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643722; c=relaxed/simple;
	bh=jWm9h4bEyRjCM9yo1TuiTy0WnYH+mWXWfvuJwWCVK+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqtAlLddSMmNLEOKuB2tM3o3t6hSPkXMjXaCQHM9FiMhxxzR2+ulaybu1ZZ0YUdu81jQlrzmjVDmkjpzXSnxoz2C0OU1aalcpJlBTEBwzxJUzIKXDnZfNxDbEhEIlwDMUIB/lCvpCfAFeDJZN51zU6Im5/vWuAOCDvNC/Ml61ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=J1KF93Iy; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711642777; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Vg2MDAWErE3CnQQcUPVvzZSCgDcKi02Xk5ejr8GnC5+5yABp70FOO2Tv1qaOxVYx+El8xebnVXaPHd7nijvAaYkCcDaeWWUT7MXeuVLRC8rb8PQonnIdw2IqIk2VMMnrgekGhFtZpJV7uNpgTDGoPWTPB8oWN2+/P3Or18PmIdU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711642777; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cED9Awhfc1vCla8jeiZzKgUEOIEF9249yC2TVR3tHtI=; 
	b=Vr5wc3KYzC6MMBpSmSxyJ0DpwwephWIL5hUEmP8oSyMAklXIP4W8mxmAdx3PRXeIjN7FAr2J8tuaNhPCkDvJ08e7A3kF3dsquyvHnmcOt1E84GSj/Di8olPu59zHNJP/IjZU2NXpgA5SStoFOraeSxnf4qgjNuGxC0zOqJ03d14=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711642777;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cED9Awhfc1vCla8jeiZzKgUEOIEF9249yC2TVR3tHtI=;
	b=J1KF93IyyzirxQiTaeSUuqLKfj7mYD45CQ1qBCfMcvZYVSOt6TQ1DuFtu0Gzs86r
	dVfsxfQfX3N2kCK7xfjID8cvwv3zLvyIbXq0MxKSKtcF50U4ES35QSsUU/JJESOnoMp
	Y9I3YzkWfdxQIqVycYapVYu+S0RwTo6l8CqUwU48=
Received: from [192.168.11.99] (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1711642776065691.1973913101963; Thu, 28 Mar 2024 17:19:36 +0100 (CET)
Message-ID: <9a27094a-bcde-4226-8559-86bfae290895@bursov.com>
Date: Thu, 28 Mar 2024 18:19:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: allow disabling newidle_balance with
 sched_relax_domain_level
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <cover.1711584739.git.vitaly@bursov.com>
 <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
 <f6bd6617-b8fb-4760-a90b-ceeca6d4e415@linux.ibm.com>
Content-Language: en-US, ru-RU, uk-UA
From: Vitalii Bursov <vitaly@bursov.com>
In-Reply-To: <f6bd6617-b8fb-4760-a90b-ceeca6d4e415@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 28.03.24 07:51, Shrikanth Hegde wrote:
> 
> 
> On 3/28/24 6:00 AM, Vitalii Bursov wrote:
>> Change relax_domain_level checks so that it would be possible
>> to exclude all domains from newidle balancing.
>>
>> This matches the behavior described in the documentation:
>>   -1   no request. use system default or follow request of others.
>>    0   no search.
>>    1   search siblings (hyperthreads in a core).
>>
>> "2" enables levels 0 and 1, level_max excludes the last (level_max)
>> level, and level_max+1 includes all levels.
>>
>> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
>> ---
>>  kernel/cgroup/cpuset.c  | 2 +-
>>  kernel/sched/debug.c    | 1 +
>>  kernel/sched/topology.c | 2 +-
>>  3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 4237c874871..da24187c4e0 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2948,7 +2948,7 @@ bool current_cpuset_is_being_rebound(void)
>>  static int update_relax_domain_level(struct cpuset *cs, s64 val)
>>  {
>>  #ifdef CONFIG_SMP
>> -	if (val < -1 || val >= sched_domain_level_max)
>> +	if (val < -1 || val > sched_domain_level_max + 1)
>>  		return -EINVAL;
>>  #endif
>>  
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 8d5d98a5834..8454cd4e5e1 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -423,6 +423,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
>>  
>>  #undef SDM
>>  
>> +	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
> 
> It would be better if the level can be after group_flags since its a new addition?

I'll change the order.
Thanks

>>  	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
>>  	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
>>  }
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 99ea5986038..3127c9b30af 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1468,7 +1468,7 @@ static void set_domain_attribute(struct sched_domain *sd,
>>  	} else
>>  		request = attr->relax_domain_level;
>>  
>> -	if (sd->level > request) {
>> +	if (sd->level >= request) {
>>  		/* Turn off idle balance on this domain: */
>>  		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
>>  	}
> 
> Other than the above change looks good. 

