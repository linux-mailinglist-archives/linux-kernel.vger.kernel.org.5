Return-Path: <linux-kernel+bounces-126597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8FB893A33
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E19281EDC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3A1BF3D;
	Mon,  1 Apr 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="Yc8m5U8k"
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17067171C1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967739; cv=pass; b=K9ADJgNKbhclcvWnYGueFAwV8kvzUeDk0ye5uywDReelkLH8eWO/ZoIPCqE9/zQHny2DqVzk1Y/msAzSwute4dx4/FoCyFjGT7qxXgay+kgxBnnddlcI3/T7yQ6GMULyxeUGz8YML/LItHPfH0ay8wlrf1MJht0AF8YC1dfbJX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967739; c=relaxed/simple;
	bh=T5UPnOqSN1OxMYf8MU9PBiT05JBXBdOZebD5wKyiIQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpXJAOKxZqCQU1ofqfjn/tJem38EAeMURj03CMJ9SaBViAb19us8f0KPiBufLBfC9aLda3KV/DuDLcy/N6oLsrlaVdZNQ4qyqRzD984yR0mORqHkZF4jOpf3CCy3oQdrxU8jLDA8dHWpN57yWUvG+6UsYlkU1HKcqcjv+Kc3CoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=Yc8m5U8k; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711967707; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CO0EH0ncsJDUbpWxyct58wYiBvdbKzGnrjOfHcr+tZLX+S0o79ng+Md9R4AVUjoHlOdqCPuVb8BSlYbdBrm5IyVeGG3PQoafhmf5Lev6jF2QqG9rzbkC9Cz/TMVeQe4yZRYnIZKFskU1Y6ZfaxGV1gkkDN4S6d9VJ/fGNq+4BqU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711967707; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gflFRaec5NN9RfJ4L1873iEQ3hm8EbbWvvyreqMswuE=; 
	b=YabcR4hju85qxOgOrCcwIYLk9FZL7QhhAcpjPOJQ6k2D5FmqWqqEa2oilqRcxO7ljdK45Z1yXRYLsbjrRq3Rbx2xTyz3deSi1TrPxtVg3O3OjbZU7z0bS3qX6XedN+Q8aTSxwQ10sY1Z74yO+4HbzW9nalrMGDAw3Rq2WDXBOlY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711967707;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gflFRaec5NN9RfJ4L1873iEQ3hm8EbbWvvyreqMswuE=;
	b=Yc8m5U8k1+DX9MPQLpA6umKR5pUpepTAS1FY+pz1m68TZtBzNnnbVl7Dqy6ehnXf
	REne9aN6Lt1cJbXX5dU1OjQpigijO/TepqD4LMELXavIUu+URKOyI5GFVl3yh6ft7MH
	xBi+Ozh1m7+W6z1EuNrDc5hwy6hciDMNc+uXgA4Y=
Received: from [192.168.11.99] (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 17119677050351005.7836305119542; Mon, 1 Apr 2024 12:35:05 +0200 (CEST)
Message-ID: <78c60269-5aee-45d7-8014-2c0188f972da@bursov.com>
Date: Mon, 1 Apr 2024 13:35:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs: cgroup-v1: clarify that domain levels are
 system-specific
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <cover.1711900396.git.vitaly@bursov.com>
 <af9562aac2e9208029aef1dd19c3b0e096dd42c7.1711900396.git.vitaly@bursov.com>
 <3d85926d-378a-4d5e-8303-92461bd3b100@linux.ibm.com>
Content-Language: en-US, ru-RU, uk-UA
From: Vitalii Bursov <vitaly@bursov.com>
In-Reply-To: <3d85926d-378a-4d5e-8303-92461bd3b100@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 01.04.24 07:05, Shrikanth Hegde wrote:
> 
> 
> On 3/31/24 9:31 PM, Vitalii Bursov wrote:
>> Add a clarification that domain levels are system-specific
>> and where to check for system details.
>>
>> Add CPU clusters to the scheduler domain levels table.
>>
>> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
>> ---
>>  Documentation/admin-guide/cgroup-v1/cpusets.rst | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
>> index 7d3415eea..d16a3967d 100644
>> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
>> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
>> @@ -568,19 +568,25 @@ on the next tick.  For some applications in special situation, waiting
>>  
>>  The 'cpuset.sched_relax_domain_level' file allows you to request changing
>>  this searching range as you like.  This file takes int value which
>> -indicates size of searching range in levels ideally as follows,
>> +indicates size of searching range in levels approximately as follows,
>>  otherwise initial value -1 that indicates the cpuset has no request.
>>  
>>  ====== ===========================================================
>>    -1   no request. use system default or follow request of others.
>>     0   no search.
>>     1   search siblings (hyperthreads in a core).
>> -   2   search cores in a package.
>> -   3   search cpus in a node [= system wide on non-NUMA system]
>> -   4   search nodes in a chunk of node [on NUMA system]
>> -   5   search system wide [on NUMA system]
>> +   2   search cpu clusters
>> +   3   search cores in a package.
>> +   4   search cpus in a node [= system wide on non-NUMA system]
>> +   5   search nodes in a chunk of node [on NUMA system]
>> +   6   search system wide [on NUMA system]
> 
> I think above block of documentation need not change. SD_CLUSTER is a software 
> construct, not a sched domain per se. 
> 

I added "cpu clusters" because the original table:
====== ===========================================================
  -1   no request. use system default or follow request of others.
   0   no search.
   1   search siblings (hyperthreads in a core).
   2   search cores in a package.
   3   search cpus in a node [= system wide on non-NUMA system]
   4   search nodes in a chunk of node [on NUMA system]
   5   search system wide [on NUMA system]
====== ===========================================================
does not match to what I see on a few systems I checked.

AMD Ryzen and the same dual-CPU Intel server with NUMA disabled:
  level:0 - SMT
  level:2 - MC
  level:3 - PKG

Server with NUMA enabled:
  level:0 - SMT
  level:2 - MC
  level:5 - NUMA

So, for the relax level original table:
  1 -> enables 0 SMP -> OK
  2 -> enables 1 unknown -> does not enable cores in a package
  3 -> enables 2 MC -> OK for NUMA, but not system wide on non-NUMA system
  5 -> enables 4 unknown -> does not enable system wide on NUMA

The updated table
====== ===========================================================
  -1   no request. use system default or follow request of others.
   0   no search.
   1   search siblings (hyperthreads in a core).
   2   search cpu clusters
   3   search cores in a package.
   4   search cpus in a node [= system wide on non-NUMA system]
   5   search nodes in a chunk of node [on NUMA system]
   6   search system wide [on NUMA system]
====== ===========================================================
would work like this:
  1 -> enables 0 SMP -> OK
  2 -> enables 1 unknown -> does nothing new
  3 -> enables 2 MC -> OK, cores in a package for NUMA and non-NUMA system
  4 -> enables 3 PKG -> OK on non-NUMA system
  6 -> enables 5 NUMA -> OK

I think it would look more correct on "average" systems, but anyway,
please confirm and I'll remove the table update in an updated patch.

Thanks

> IMO the next paragraph that is added is good enough and the above change can be removed.

>>  ====== ===========================================================
>>  
>> +Not all levels can be present and values can change depending on the
>> +system architecture and kernel configuration. Check
>> +/sys/kernel/debug/sched/domains/cpu*/domain*/ for system-specific
>> +details.
>> +
>>  The system default is architecture dependent.  The system default
>>  can be changed using the relax_domain_level= boot parameter.
>>  

