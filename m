Return-Path: <linux-kernel+bounces-152583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25A8AC0C4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8D91F21452
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC193CF65;
	Sun, 21 Apr 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KuFHaO82"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929E2C853
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713724079; cv=none; b=qgeNmO9eK1Yt2/KCLSWUuwRFgTMtWONlQ7AnzGe6UGNmtVdUE9HXyrd9doTumE8Q/sQ+8L1BPOYLyIKXbvmzU1/XXocehT9B24G+3GdcbyGyyHqfWwRpmrZlABMU3BYlAEfpjrmQeeeyXDJjdluoYkEHxZd6Xq+6nzKAthez2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713724079; c=relaxed/simple;
	bh=gCD4yQOfks+waeEAWUR4DkrghY8gcawvHv2k4krGVsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLgE+zmmD7X74VBHLOHFnpC0VYzbU48SkKUwR3gSZQ6m/RpnDH14mDt5dJHXs1pAqr5MytE8kpks7L7pFHkQ8E1jFB4tL9HTJ5swpt7QCEAGn87SOrZfNhxGS3mIkhc7hAFBc0vNFHMCqo843cHHqlUbhMEKntLPJE9PPvhu4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KuFHaO82; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y4ghdcKYz/aIdoJmbHC4MzRUZyGs+LvLk8N5InKcBog=; b=KuFHaO828X/KBJbg1AVCyXh6N+
	AGAHPHLuO5lUD7ABxAB2PSPPzIj8rOdI6eRlwyLIxvSwH3GtpIjHFRtlbpIwdrRxYo/bFUJ94hH6Z
	hw+2UmMvjhbZMY6GF1r2+ffLCyDNgYgw8fg+d9bcwpKf6emUsnIELO1Kkz23jxDqXyARikXxCPV7H
	TwfcMzLdqtdXtcFFdHdu2vqxCSyw8OltQG4fC+qwBi1uQJ5Mo6evXTDvd4CdwjQl1UTZdSi++DgqG
	iILNhF1R2OGE15x3vPCn2IjS1jrKsRrg9N24wk0w+9rnMFuLDFv6AQHxJ6AWzVz/9DgkowbLqTmSO
	l2t7/WGA==;
Received: from [187.10.139.161] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rybuh-0070DK-NH; Sun, 21 Apr 2024 20:27:43 +0200
Message-ID: <06eb4591-7b28-b774-01d0-eb980073d1d3@igalia.com>
Date: Sun, 21 Apr 2024 15:27:37 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/split_lock: fix delayed detection enabling
Content-Language: en-US
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: den-plotnikov@yandex-team.ru, x86@kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
References: <20240321195522.24830-1-davydov-max@yandex-team.ru>
 <7c8c6f7c-7476-d73d-4df1-9dea0aa4ecf2@igalia.com>
 <2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 08:26, Maksim Davydov wrote:
> 
> [...]
> Some information that should be taken into account:
> * sld_update_msr() enables/disables SLD on both CPUs on the same core
> * schedule_delayed_work_on() internally checks WORK_STRUCT_PENDING_BIT.
>    If a work has the 'pending' status, then schedule_delayed_work_on()
>    will return an error code and, most importantly, the work will not
>    be placed in the workqueue.
> 
> Let's say we have a multicore system on which split_lock_mitigate=0 and
> a multithreaded application is running that calls splitlock in multiple
> threads. Due to the fact that sld_update_msr() affects the entire core
> (both CPUs), we will consider 2 CPUs from different cores. Let the 2
> threads of this application schedule to CPU0 (core 0) and to CPU 2
> (core 1), then:
> 
> |                                 ||                                   |
> |             CPU 0 (core 0)      ||          CPU 2 (core 1)           |
> |_________________________________||___________________________________|
> |                                 ||                                   |
> | 1) SPLIT LOCK occured           ||                                   |
> |                                 ||                                   |
> | 2) split_lock_warn()            ||                                   |
> |                                 ||                                   |
> | 3) sysctl_sld_mitigate == 0     ||                                   |
> |    (work = &sl_reenable)        ||                                   |
> |                                 ||                                   |
> | 4) schedule_delayed_work_on()   ||                                   |
> |    (reenable will be called     ||                                   |
> |     after 2 jiffies on CPU 0)   ||                                   |
> |                                 ||                                   |
> | 5) disable SLD for core 0       ||                                   |
> |                                 ||                                   |
> |    -------------------------    ||                                   |
> |                                 ||                                   |
> |                                 || 6) SPLIT LOCK occured             |
> |                                 ||                                   |
> |                                 || 7) split_lock_warn()              |
> |                                 ||                                   |
> |                                 || 8) sysctl_sld_mitigate == 0       |
> |                                 ||    (work = &sl_reenable,          |
> |                                 ||     the same address as in 3) )   |
> |                                 ||                                   |
> |            2 jiffies            || 9) schedule_delayed_work_on()     |
> |                                 ||    fials because the work is in   | 
> 
> |                                 ||    the pending state since 4).    |
> |                                 ||    The work wasn't placed to the  |
> |                                 ||    workqueue. reenable won't be   |
> |                                 ||    called on CPU 2                |
> |                                 ||                                   |
> |                                 || 10) disable SLD for core 0        |
> |                                 ||                                   |
> |                                 ||     From now on SLD will          |
> |                                 ||     never be reenabled on core 1  |
> |                                 ||                                   |
> |    -------------------------    ||                                   |
> |                                 ||                                   |
> |    11) enable SLD for core 0 by ||                                   |
> |        __split_lock_reenable    ||                                   |
> |                                 ||                                   |
> 
> 
> If the application threads can be scheduled to all processor cores,
> then over time there will be only one core left, on which SLD will be
> enabled and split lock will be able to be detected; and on all other
> cores SLD will be disabled all the time.
> Most likely, this bug has not been noticed for so long because
> sysctl_sld_mitigate default value is 1, and in this case a semaphore
> is used that does not allow 2 different cores to have SLD disabled at
> the same time, that is, strictly only one work is placed in the
> workqueue.
> 

Hi Maksim, this is awesome! Thanks a lot for the diagram, super clear now.

Well, I think you nailed it and we should get the patch merged, right?
I'm not sure if the diagram should be included or not in the commit
message - it's good but big, maybe include a lore archive mentioning the
diagram in a V2?

Cheers,


Guilherme

