Return-Path: <linux-kernel+bounces-121808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B03188EDF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D2E29BD66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9D1514D7;
	Wed, 27 Mar 2024 18:11:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C414F11F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563065; cv=none; b=gyVYl4mUNwVoHTi72lxl8GPGxJ5QjVIjbvI6mJSwtz/h5cS4HkxzQ5qyINZm8ulRycfcgkUXNcpXb1Baw3zUnjiCwnYJCKi/9Zu9FX/LAVFjau3XPPbp9KXAOjtD7BG5sRpwWpJl4r/8XlYwHgVHBC4CTAAsg1d9vwB2rlZETfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563065; c=relaxed/simple;
	bh=9GNTWxMSRwlXCVsa0OHVcGTRa4irJx+7RxihjbPMJYs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aB4UJ+ZVwTIYWp0nrdMyezI5u2Lh+wL5fRomrsxL4mv2AcrzJjWfFop1qUQVA3UTStN5vBo3lODfbny8YtUZChW1w0kQLZaYuEwRfDwLUYpwCIj+8yxhKUPxjY4AdcBQm0VEPwtExG6R2BKxpwYX6XufLU0FHdTnzia+5EwUOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V4ZT43cYpz6K5px;
	Thu, 28 Mar 2024 02:10:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EC530140CB9;
	Thu, 28 Mar 2024 02:10:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 27 Mar
 2024 18:10:54 +0000
Date: Wed, 27 Mar 2024 18:10:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>, Guenter Roeck
	<linux@roeck-us.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2] cpu: mark cpu_possible_mask as __ro_after_init
Message-ID: <20240327181053.0000481d@Huawei.com>
In-Reply-To: <11d7a34f-909b-4923-a15f-d32015463c35@p183>
References: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
	<11d7a34f-909b-4923-a15f-d32015463c35@p183>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 22 Feb 2024 14:19:35 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> cpu_possible_mask is by definition "cpus which could be hotplugged without
> reboot". It's a property which is fixed after kernel enumerates hardware
> configuration.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Causes a crash in this path (via CPU HP testing on qemu)
Pretending to be an AMD Genoa, but I doubt that matters.

topology_hotplug_apic()
-> topo_set_cpuids()
 --> set_cpu_possible(cpu, true);
It should be already set, but the code doesn't check that.

Various possible fixes. Probably easiest is to pass in a 
bool hotplug to topo_set_cpuids() so we don't set the 
possible value if it's coming from hotplug calls.

I can spin a patch, but it will next week probably.

Jonathan

> ---
> 
> 	v2: fix parisc compilation
> 
>  kernel/cpu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3107,10 +3107,10 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
>  EXPORT_SYMBOL(cpu_all_bits);
>  
>  #ifdef CONFIG_INIT_ALL_POSSIBLE
> -struct cpumask __cpu_possible_mask __read_mostly
> +struct cpumask __cpu_possible_mask __ro_after_init
>  	= {CPU_BITS_ALL};
>  #else
> -struct cpumask __cpu_possible_mask __read_mostly;
> +struct cpumask __cpu_possible_mask __ro_after_init;
>  #endif
>  EXPORT_SYMBOL(__cpu_possible_mask);
>  


