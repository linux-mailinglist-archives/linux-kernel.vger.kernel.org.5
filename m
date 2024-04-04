Return-Path: <linux-kernel+bounces-131682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E3898AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6DD1F226FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6FF12BF18;
	Thu,  4 Apr 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="aMmopZ3/"
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA812AACA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243453; cv=pass; b=gx36UxuPKPcUN0EiZkyC7Vf3knDACxcxQNDnED+kfGTb+QxkwZwgNDrf3coLDp2JFCOqaEtpOl6c5cCNmA3eOhblmiCt2k+Zw0ZaF3CB8RO7o/0UIJiteTm6pJguPjCLSinHK+hDoCVq6WbFIXwNJxKmiG6aDqxt7CcAvFkYwaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243453; c=relaxed/simple;
	bh=7WUNDIIdg+v8IieczXCbxBakhQiel4UAYpE/uW5hLg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hvl2xpEEErZwEXEUf8Y/wFn5cTpUhKLqInDjNeM2nikbKYlEifvO9UvHOcCLGIody6qgaW0E0IDOxYTgu2QTRuxE8FpLO//oeKuBXiOd6ef6Xhd4BiKJGrpYQM13re5InZhGp8ekF9gs9S5wm77mh0DJ3jiFrpj0SWagN1B6udo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=aMmopZ3/; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1712242509; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=afiOIb1CLnH8VcB/ojHN6DY8UDaGox8SmkUw0tAuZY14onWaVXeGqIg2SAqNR3bi8+5V/zmMaSR8PT2C09cNKSquOotxDNb5z1FnXvcDhHAumjgnvbjOddoZDYn02AuSF1KhfnyxKWda+M1lMO/QGefCWwb8t7LDYjMkCO2DE1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1712242509; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=L0vD5NLd5FBlKTm0CUN0J8lJX+L9XvMOvLU1lQSrKhw=; 
	b=IZZlDzPSmfdNWFfDvNfRYKLGVMfSeeSB2a/H2jgJiDdXnK7mkyW5YlCwxAkLzCDpU1p0I0A3K1pqvqzB5U5dm/v+VkYUSbgZQeCG+wGbmL+7KeoV0qVyupbIUNnC+loEZNK/hwmcgFDOJQ+Y0Z8AOnbRb7tXYY84Au/k50alcEw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712242509;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=L0vD5NLd5FBlKTm0CUN0J8lJX+L9XvMOvLU1lQSrKhw=;
	b=aMmopZ3/CzKz+sqxRV6cFZPC5lj1cYBNJCqWkGyiVWvREeR4LGIL5RkKF/ewnoHE
	VEHnBJsLOX1rH1Tme0TMOBL6o1rpRaUiRVUKC+12EkuDQ8YiLfzy/ljS4ZmSUzgtGEj
	TelOpjRh/dBK1FwvDJNTbVtzNK12pbmOCkDDVt8o=
Received: from [192.168.11.99] (92.60.179.150 [92.60.179.150]) by mx.zoho.eu
	with SMTPS id 17122425082370.5114711016825595; Thu, 4 Apr 2024 16:55:08 +0200 (CEST)
Message-ID: <9a27afea-046d-45f3-9ac4-98ccfd637068@bursov.com>
Date: Thu, 4 Apr 2024 17:55:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] sched/debug: dump domains' level
To: Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, linux-kernel@vger.kernel.org
References: <cover.1712147341.git.vitaly@bursov.com>
 <d9af90271748e6035c5f8bfc03b7bacdde357766.1712147341.git.vitaly@bursov.com>
 <xhsmh34s1b43e.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US, ru-RU, uk-UA
From: Vitalii Bursov <vitaly@bursov.com>
In-Reply-To: <xhsmh34s1b43e.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 04.04.24 17:21, Valentin Schneider wrote:
> On 03/04/24 16:28, Vitalii Bursov wrote:
>> Knowing domain's level exactly can be useful when setting
>> relax_domain_level or cpuset.sched_relax_domain_level
>>
>> Usage:
>> cat /debug/sched/domains/cpu0/domain1/level
>> to dump cpu0 domain1's level.
>>
>> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
>> ---
>>  kernel/sched/debug.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 8d5d98a5834d..c1eb9a1afd13 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -425,6 +425,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
>>
>>       debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
>>       debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
>> +	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
> 
> How about reusing the SDM macro? ->flags and ->groups_flags get special
> treatment for pretty printing, but the others don't need that.
> ---
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index c1eb9a1afd13e..f97902208b34d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -419,13 +419,13 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
>  	SDM(u32,   0644, busy_factor);
>  	SDM(u32,   0644, imbalance_pct);
>  	SDM(u32,   0644, cache_nice_tries);
> +	SDM(u32,   0444, level);
>  	SDM(str,   0444, name);
>  
>  #undef SDM
>  
>  	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
>  	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
> -	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
>  }
>  
>  void update_sched_domain_debugfs(void)
> 

This worked when I tried it. The reason why I chose an explicit implementation
with debugfs_create_u32() is because "level" is "int" and there's no
debugfs_create_{s32,int}(). While casting is not the best option either, it
hints that types mismatch.

In a few other cases when types do not match, casting is usually used. e.g.
mod_debug_add_ulong macro in kernel/module/stats.c:
#define mod_debug_add_ulong(name) debugfs_create_ulong(#name, 0400, mod_debugfs_root, (unsigned long *) &name.counter)
where "counter" can be s64 from the atomic64.

Thanks

