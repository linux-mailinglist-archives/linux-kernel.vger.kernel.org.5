Return-Path: <linux-kernel+bounces-123294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD2890631
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A711F27EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C64446A9;
	Thu, 28 Mar 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="dCkSlng1"
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7933BBC7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644213; cv=pass; b=hQ0I/+AB6yrWBK26AMPlEZDKBQxjwzaF5WjG90Ctu6Mnsd6mLDH5sw40hMOPdIfyo+QJdCRobGyeNUylyNiAduz3lBsv3v+p34Tfaf8WB72L2/3VxQPy2I8Z1GTJ1MMBfVlbzjhKi/xTob5CHQN8TYEdbsMlGdhToKluuZKGYpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644213; c=relaxed/simple;
	bh=ThSUXMdatxvpjU2QGueJ8/SqQuARra+OPPY/dbMcAbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8sruYlbt0VebrQjNVThZ5U3y/QxNz1sbgiLuXV9z58dYhMAJnac2vbKs8no/XGYGPIJRDGnEIXbSa9eWZmNCUcnbl0FEdv2cF+L2ooHj6je/kQ8q7W1k0HEsAqaoRUvwqu7ZlPrZQuba5ErigTqmeUiHt83IjSXmUcGH/X/ZzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=dCkSlng1; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711643243; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iX5zktIm6T0kZ0oEMLlVRtyQLhcpmn3B3tqo3Dsi3UJTBjAzVztwme0WiaFsasBRYqRca7gs85hV6vFy+tzALuWMmowSzdRGIxv3wP0G6YIBCGpj6H6oAA/lZPdxjUzj2v6yk64eQt1NVNyWSVy4MDEYj3rTzkDH5nPh+Yxhq2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711643243; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZrmTjx49fAq8rKhZo8YvG5M9+jGO/DdMGOrFSqOW59U=; 
	b=K9QcXdOGyu2X0fh6zgzdo028Tcbp7OvkP165BuBdwHb2/YNxPaCVF2nS9PX8gbixjkAMVQXvhIq7cb0mcBfYybZ3529+65y7VrihOQpkX/uBf774ULAwM9M8DoH9avAwqXM2ezTp2WvggiNZMDS55L1N/vvjbsfx3DWqjS73gZs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711643243;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZrmTjx49fAq8rKhZo8YvG5M9+jGO/DdMGOrFSqOW59U=;
	b=dCkSlng12lPtxOX6UWWaXNAO7uK5DvseZYVpwmZDq5n9+Ecv4+P750MQVhrAQwzP
	KXo/sYY3tCeuDEyxUfXJd77ajuHTBJDhwynfzQWQPzLDMhjwON81CfhRvcGlFRX1WWM
	WMBAnxmwgX2dgEOkLmjXcKWM/wa8fUzgZ+h8qeH0=
Received: from [192.168.11.99] (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1711643241986211.21433792250969; Thu, 28 Mar 2024 17:27:21 +0100 (CET)
Message-ID: <1679cb16-a4a1-4a5f-9742-3523555d33f9@bursov.com>
Date: Thu, 28 Mar 2024 18:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: allow disabling newidle_balance with
 sched_relax_domain_level
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <cover.1711584739.git.vitaly@bursov.com>
 <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
 <CAKfTPtCux6diCArXcF11w+D1VMKLwj-eWUeXQq3d=2=2Xfe8uw@mail.gmail.com>
Content-Language: en-US, ru-RU, uk-UA
From: Vitalii Bursov <vitaly@bursov.com>
In-Reply-To: <CAKfTPtCux6diCArXcF11w+D1VMKLwj-eWUeXQq3d=2=2Xfe8uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 28.03.24 16:43, Vincent Guittot wrote:
> On Thu, 28 Mar 2024 at 01:31, Vitalii Bursov <vitaly@bursov.com> wrote:
>>
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
> 
> I was about to say that max+1 is useless because it's the same as -1
> but it's not exactly the same because it can supersede the system wide
> default_relax_domain_level. I wonder if one should be able to enable
> more levels than what the system has set by default.

I don't know is such systems exist, but cpusets.rst suggests that
increasing it beyoud the default value is possible:
> If your situation is:
> 
>  - The migration costs between each cpu can be assumed considerably
>    small(for you) due to your special application's behavior or
>    special hardware support for CPU cache etc.
>  - The searching cost doesn't have impact(for you) or you can make
>    the searching cost enough small by managing cpuset to compact etc.
>  - The latency is required even it sacrifices cache hit rate etc.
>    then increasing 'sched_relax_domain_level' would benefit you.


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
>> -       if (val < -1 || val >= sched_domain_level_max)
>> +       if (val < -1 || val > sched_domain_level_max + 1)
>>                 return -EINVAL;
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
>> +       debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
> 
> IMO, this should be a separate patch as it's not part of the fix

Thanks, I'll split it.

>>         debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
>>         debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
>>  }
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 99ea5986038..3127c9b30af 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1468,7 +1468,7 @@ static void set_domain_attribute(struct sched_domain *sd,
>>         } else
>>                 request = attr->relax_domain_level;
>>
>> -       if (sd->level > request) {
>> +       if (sd->level >= request) {
> 
> good catch and worth :
> Fixes: 9ae7ab20b483 ("sched/topology: Don't set SD_BALANCE_WAKE on
> cpuset domain relax")
> 
Will add this.
Thanks.

> 
>>                 /* Turn off idle balance on this domain: */
>>                 sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
>>         }
>> --
>> 2.20.1
>>

