Return-Path: <linux-kernel+bounces-151937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670728AB607
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A01C2198F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D91118B;
	Fri, 19 Apr 2024 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="MnyEiFVk";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="1hnXvVM2"
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [46.30.211.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406E1118A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558887; cv=none; b=Qpg5BQMuIuemkrW1LZ1qiyvfivE1nI0rPXASdh3RlYwRO2V+mdm7kptZ0nypqnfKXP9cCrAClNZwDAEFSgCdBCYmgUlkTVQ/RsoPW12Gau45qK3DtnTU0szN4/2DFAUXb49d0QD4iYCkF037N072W+aYJmBuJJGskHm9OmCq5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558887; c=relaxed/simple;
	bh=jsNFyX+UqakUKLcMvkHbDUM9oTRLL9cxwzpKLZBXvD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlmCTzVz0sJyj40cJCB8ywubzqNBOcY/NMRF/iIolJzF972tbI64CeZOWkoUBQb/R2zy+LtVD9RuhRC1q5WgKsDPqO38G2eZX94I+BDR4/Rzqc3GQI3Mao73f1lgQjIIhRKRF7/ALTbYKYCRL3eyrXAgbbg/Oeprna4p+gb98rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=MnyEiFVk; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=1hnXvVM2; arc=none smtp.client-ip=46.30.211.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=kFPdY1ZX/9aPR1Qd/Z+2kf2AETIJI1lTPV3LIR/f+NM=;
	b=MnyEiFVkl/n7XjywrBokadxLjQDiCZpi3Av/ovKFhvKlo3YtodWHPWCKPMIa3A/m54UaAU0ImuwXK
	 mRD1k2xl7y1DctylRMhAs8FLD3b22OuJSb2NMnOxS1xEr04HyPinYRoW5FNsloB4t0atCdhboXtDs1
	 jT8ZV4uWECiAz8L0KzUCoyAv1WfPM32ijHjRem9LXnI3mb48qlb/EpXj/oetHHpHtnKgpzbRr40Pqq
	 cyupaKK/XG6Z7VHMrtM6cpACnEtaRUBXUPgGr5yUQtZt2SAtpF7hK/2Pbp2ZyxuZS/ZBwEjEEv+Fg6
	 O3ndDj8foSDpdcl7+OwihSWnUwhxfCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=kFPdY1ZX/9aPR1Qd/Z+2kf2AETIJI1lTPV3LIR/f+NM=;
	b=1hnXvVM2/nmmAD45sl4bQAgTkVeLkDpsmz6oB3hge+57vwHI+BgflL/qwx7bf929MgCoReHCBLdbE
	 bX5GqO6DA==
X-HalOne-ID: 142855b1-fe8c-11ee-a58f-79f4c2873f57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 142855b1-fe8c-11ee-a58f-79f4c2873f57;
	Fri, 19 Apr 2024 20:33:32 +0000 (UTC)
Date: Fri, 19 Apr 2024 22:33:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH 0/5] Remove onstack cpumask var usage
Message-ID: <20240419203329.GA590733@ravnborg.org>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
 <20240419051350.GA558245@ravnborg.org>
 <A60F94A9589C8589+ZiI4yj073cgmt5Qq@centos8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A60F94A9589C8589+ZiI4yj073cgmt5Qq@centos8>

Hi Dawei,

> About this case, it's kinda tricky for:
> - dr_cpu_data() returns void, so alloc_cpumask_var() is no go.
> 
> - No idea of the calling context of dr_cpu_data(). IIUC,
>   dr_cpu_data()
>   ->dr_cpu_configure()  
>    ->kzalloc(resp_len, GFP_KERNEL)
>   So I guess it's in process context?
>   If consumption above is OK, a simple but _ugly_ solution could be:
> 
> diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
> index ffdc15588ac2..c9e4ebdccf49 100644
> --- a/arch/sparc/kernel/ds.c
> +++ b/arch/sparc/kernel/ds.c
> @@ -634,7 +634,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,
>         struct dr_cpu_tag *tag = (struct dr_cpu_tag *) (data + 1);
>         u32 *cpu_list = (u32 *) (tag + 1);
>         u64 req_num = tag->req_num;
> -       cpumask_t mask;
> +       static DEFINE_MUTEX(mask_lock);
> +       static cpumask_t mask;
>         unsigned int i;
>         int err;
> 
> @@ -651,6 +652,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,
> 
>         purge_dups(cpu_list, tag->num_records);
> 
> +       mutex_lock(&mask_lock);
> +
>         cpumask_clear(&mask);
>         for (i = 0; i < tag->num_records; i++) {
>                 if (cpu_list[i] == CPU_SENTINEL)
> @@ -665,6 +668,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,
>         else
>                 err = dr_cpu_unconfigure(dp, cp, req_num, &mask);
> 
> +       mutex_unlock(&mask_lock);
> +
>         if (err)
>                 dr_cpu_send_error(dp, cp, data);
>  }
> 
> How does it sound to you?
This introduces too much complexity to solve a potential stack issue.
If an improvement is required, then we need a simpler solution.

> 
> > kernel/leon_kernel.c:   cpumask_t mask;
> 
> It's in irqchip::irq_set_affinity(), which is in atomic context(raw spinlock(s) held),
> so dynamic allocation is not a good idea.
> 
> My proposal(*untested*) is somewhat complicated for it introduces a new helper.
> 
> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
> index 4c61da491fee..6eced7acb8bc 100644
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -104,15 +104,25 @@ unsigned long leon_get_irqmask(unsigned int irq)
>  }
> 
>  #ifdef CONFIG_SMP
> +
> +static bool cpumask_include(const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +       unsigned int cpu;
> +
> +       for_each_cpu(cpu, srcp2) {
> +               if (!cpumask_test_cpu(cpu, srcp1))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static int irq_choose_cpu(const struct cpumask *affinity)
>  {
> -       cpumask_t mask;
> +       unsigned int cpu = cpumask_first_and(affinity, cpu_online_mask);
> 
> -       cpumask_and(&mask, cpu_online_mask, affinity);
> -       if (cpumask_equal(&mask, cpu_online_mask) || cpumask_empty(&mask))
> -               return boot_cpu_id;
> -       else
> -               return cpumask_first(&mask);
> +       return cpumask_include(affinity, cpu_online_mask) || cpu >= nr_cpu_ids ?
> +              boot_cpu_id : cpu;
>  }

I think something like the following should do the trick.


	if (cpumask_equal(affinity, cpu_online_mask))
		return boot_cpu_id;

	cpuid = cpumask_first_and(affinity, cpu_online_mask);
	if (cpuid < nr_cpu_ids)
		return cpuid;
	else
		return boot_cpu_id;

If the passed affinity equals the online cpu's, then use the boot cpu.
Else, use the first online cpu in the affinity mask.
If none found use the boot cpu.



>  #else
>  #define irq_choose_cpu(affinity) boot_cpu_id
> 
> Is it OK?
> 
> [cc Yury for bitmap API]
> 
> > kernel/leon_smp.c:static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> > kernel/sun4d_smp.c:static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
Looks simple, just pass a pointer and not by value.
> 
> Actually I am awared of existence of (at least some of) them, but so far I
> have not found a _proper_ way of dealing with them(especially for case of
> ds.c).
> 
> Please lemme dig into it.
Looks forward to next iteration.

	Sam

