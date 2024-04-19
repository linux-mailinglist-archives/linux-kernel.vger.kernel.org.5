Return-Path: <linux-kernel+bounces-151369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2698AADB1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670E81F218E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE77F489;
	Fri, 19 Apr 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bfEaM6pq"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCED8172F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526144; cv=none; b=Km7rHADXNah8dfs3T+RQ8MtENs1dkT73af/spd/MN7sTfhIInLkTT2wKyZDv5ly7vvvtjFXFlzW+jEZZZL3RfYZscfsdGZqepGw7H+lA4ojOWXk8Z0B1xGgB6pkCcX4+XwU0KGSczonJmL9ukdNn+IsdrH6QzeocXf3jafOrk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526144; c=relaxed/simple;
	bh=O5B1/wlKwjA0GI/EhPTBQW9UxA60IBmd+z5UJowJ5iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8f6oHge9k3n3Mb7Umt7b3kPT29uhahvpYMQjTmdrZlw0ri4HF+qZ2ZdtzN6jtHNWE77TdWOvlCXgxkpZVaUS6cLxpYB8gd0QCbubvOcvbfreGY82pqle128J+90mRF7fCOKwTSdif2AAd/VWd+Xobun0slAGU9a5R5LF9hueJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=bfEaM6pq; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3007360C73;
	Fri, 19 Apr 2024 14:26:56 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b65b::1:3] (unknown [2a02:6b8:b081:b65b::1:3])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id rQEsnb0Ih8c0-xeySooUW;
	Fri, 19 Apr 2024 14:26:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1713526015;
	bh=I3liX7sdTUPgP4kFmk6qBL8XLFKOBUGTFRAgA6Sf5aE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=bfEaM6pqH5LSVXQve+Tn/+pDGiOvGrW3W7poSiAAGq9b0McSZf8qB+GRXmzNPvsg1
	 anzNivVWBuZbSFNQQ3Q8mR6cp6GJfn/kurSCNOZeJUlrLD+tb/CNVdpeatpoluuo33
	 ei0JECYCUBi1iApLNzyqdl3HjBAKBkojtlcxT340=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru>
Date: Fri, 19 Apr 2024 14:26:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/split_lock: fix delayed detection enabling
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: den-plotnikov@yandex-team.ru, x86@kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
References: <20240321195522.24830-1-davydov-max@yandex-team.ru>
 <7c8c6f7c-7476-d73d-4df1-9dea0aa4ecf2@igalia.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <7c8c6f7c-7476-d73d-4df1-9dea0aa4ecf2@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/31/24 20:07, Guilherme G. Piccoli wrote:
> On 21/03/2024 16:55, Maksim Davydov wrote:
>> If the warn mode with disabled mitigation mode is used, then on each cpu
>> where the split lock occurred detection will be disabled in order to make
>> progress and delayed work will be scheduled, which then will enable
>> detection back. Now it turns out that all CPUs use one global delayed
>> work structure. This leads to the fact that if a split lock occurs on
>> several CPUs at the same time (within 2 jiffies), only one cpu will
>> schedule delayed work, but the rest will not. The return value of
>> schedule_delayed_work_on() would have shown this, but it is not checked
>> in the code
>> In order to fix the warn mode with disabled mitigation mode, delayed work
>> has to be a per-cpu.
>>
>> Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
> 
> Thanks Maksim! I confess I (think I) understand the theory behind the
> possible problem, but I'm not seeing how it happens - probably just me
> being silly , but can you help me to understand it clearly?
> 
> Let's say we have 2 CPUs, CPU0 and CPU1 and we're running with
> sld_mitigate = 0, meaning we don't have "the misery".
> 
> If the code running in CPU0 reaches split_lock_warn(), my understanding
> is that it warns the user, schedule the sld reenable [via and
> schedule_delayed_work_on()] and disables the feature with
> sld_update_msr(false), correct? So, does this disabling happens only at
> core level, or it disables for the whole CPU including all cores?
> 
> But back to our example, if CPU1 detects the split lock, it'll run the
> same procedure as CPU0 did - so are you saying we have a race there if
> CPU1 face a split lock before CPU0 disabled the MSR?
> 
> Maybe a more clear example of the issue would be even helpful in the
> commit message, showing the path both CPUs would take and how the
> problem happens exactly.
> 
> Thanks in advance,
> 
> 
> Guilherme



Resend with fixed formatting

Sorry for a late reply.

I made a diagram to explain how this bug occurs. If it makes it
clearer, then I will include the diagram in the commit
description.

Some information that should be taken into account:
* sld_update_msr() enables/disables SLD on both CPUs on the same core
* schedule_delayed_work_on() internally checks WORK_STRUCT_PENDING_BIT.
   If a work has the 'pending' status, then schedule_delayed_work_on()
   will return an error code and, most importantly, the work will not
   be placed in the workqueue.

Let's say we have a multicore system on which split_lock_mitigate=0 and
a multithreaded application is running that calls splitlock in multiple
threads. Due to the fact that sld_update_msr() affects the entire core
(both CPUs), we will consider 2 CPUs from different cores. Let the 2
threads of this application schedule to CPU0 (core 0) and to CPU 2
(core 1), then:

|                                 ||                                   |
|             CPU 0 (core 0)      ||          CPU 2 (core 1)           |
|_________________________________||___________________________________|
|                                 ||                                   |
| 1) SPLIT LOCK occured           ||                                   |
|                                 ||                                   |
| 2) split_lock_warn()            ||                                   |
|                                 ||                                   |
| 3) sysctl_sld_mitigate == 0     ||                                   |
|    (work = &sl_reenable)        ||                                   |
|                                 ||                                   |
| 4) schedule_delayed_work_on()   ||                                   |
|    (reenable will be called     ||                                   |
|     after 2 jiffies on CPU 0)   ||                                   |
|                                 ||                                   |
| 5) disable SLD for core 0       ||                                   |
|                                 ||                                   |
|    -------------------------    ||                                   |
|                                 ||                                   |
|                                 || 6) SPLIT LOCK occured             |
|                                 ||                                   |
|                                 || 7) split_lock_warn()              |
|                                 ||                                   |
|                                 || 8) sysctl_sld_mitigate == 0       |
|                                 ||    (work = &sl_reenable,          |
|                                 ||     the same address as in 3) )   |
|                                 ||                                   |
|            2 jiffies            || 9) schedule_delayed_work_on()     |
|                                 ||    fials because the work is in   | 

|                                 ||    the pending state since 4).    |
|                                 ||    The work wasn't placed to the  |
|                                 ||    workqueue. reenable won't be   |
|                                 ||    called on CPU 2                |
|                                 ||                                   |
|                                 || 10) disable SLD for core 0        |
|                                 ||                                   |
|                                 ||     From now on SLD will          |
|                                 ||     never be reenabled on core 1  |
|                                 ||                                   |
|    -------------------------    ||                                   |
|                                 ||                                   |
|    11) enable SLD for core 0 by ||                                   |
|        __split_lock_reenable    ||                                   |
|                                 ||                                   |


If the application threads can be scheduled to all processor cores,
then over time there will be only one core left, on which SLD will be
enabled and split lock will be able to be detected; and on all other
cores SLD will be disabled all the time.
Most likely, this bug has not been noticed for so long because
sysctl_sld_mitigate default value is 1, and in this case a semaphore
is used that does not allow 2 different cores to have SLD disabled at
the same time, that is, strictly only one work is placed in the
workqueue.

-- 
Best regards,
Maksim Davydov

