Return-Path: <linux-kernel+bounces-151231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8178AAB75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E8B219E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2478286;
	Fri, 19 Apr 2024 09:27:37 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC37350E;
	Fri, 19 Apr 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518857; cv=none; b=LNeFzBYLfyk1WVJ/1FEKmPfutqBZnbVGEdvaqAZxHYf838XRf29A3xtAi6ZJ/SEhjE5RiNUsfRVBv7c4V+7rdpfekQIwIiYZme3uLZFlb5omPG8Dtv0eV1fwKRGBgkabx/r4KCqry9vrXDrJyj1cWZWAKEMV+eVhSOCGbw+99PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518857; c=relaxed/simple;
	bh=Qmc9EhkIIpbFeNtP0amEmcND1IWo5a+HNUEfwXlCQEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtqVZ3bg43iV6Jq0/iSn8cvF1483kOv+xgbTCUaRgPyu4Lh2ym7QOOThQEBtT1/lgznI7/IEuEwhhN5Fth0MXEZP/zz4tlqP2GhJVRCGJp3y7Xw6MUtQ6kk8TRUH/v2QIzqBszjN9DQlonGQxgy1ZeHGBWCMsT/ilouxVyjXiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp81t1713518795t5jgjnqm
X-QQ-Originating-IP: jXEkGEh+B+S0nZ2C29fIOx9NXHavu5sUQaHThL7wZlM=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Apr 2024 17:26:34 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: Q2yP8jvsZ988yftLcKE2iBRbKi+JY8eZPdsG5w93SH/6DQ9/iMXbEg+46jVVC
	l+GQZzrrXkNmvOfoMTTCLABJDCtD2La/UFlrrhOsmsxsmRTEudlYdmBa4CMesDAfiM/pvKl
	wxG/PTwMbaFF6G9YyYH14Kx2koU18EJT6nNO6CAl5zB/lurQ9E0IdoTr13MR2adKPEsvHA2
	7Nqn9sLcuFZc6bTGkYfeISu62VfoRqQczjhG5LwkpQqQvQdJoAMw/8QtaPwsu4y1rQHrpBd
	qoy0JLLW5F+OxR3CmhFALqw7O6+ugbKhvSxTJBPCywjGjrxYaP8UPDiuS3dKt6uwOx2Ynq6
	UTakw+RyFprKhG85cfk5agnJZGOHWCb0Ki2IZy5Jo8h4nD0KZqrL6tpM6U2awK0OMwJdEND
	2AHAzPhqbqA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9083245040578109237
Date: Fri, 19 Apr 2024 17:26:34 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH 0/5] Remove onstack cpumask var usage
Message-ID: <A60F94A9589C8589+ZiI4yj073cgmt5Qq@centos8>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
 <20240419051350.GA558245@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419051350.GA558245@ravnborg.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Sam,

Thanks for the review.

On Fri, Apr 19, 2024 at 07:13:50AM +0200, Sam Ravnborg wrote:
> Hi Dawei,
> 
> On Thu, Apr 18, 2024 at 06:49:44PM +0800, Dawei Li wrote:
> > Hi,
> > 
> > This series aims at removing on-stack cpumask var usage for sparc arch.
> > 
> > Generally it's preferable to avoid placing cpumasks on the stack, as
> > for large values of NR_CPUS these can consume significant amounts of
> > stack space and make stack overflows more likely.
> 
> Took a quick look at the patches, looks good except the one the bot
> already complained about.

I will fix this building warning in respinning.

> A quick grep shows a few more cases where we have an on-stack cpumask
> in sparc code.
> 
> kernel/ds.c:    cpumask_t mask;

About this case, it's kinda tricky for:
- dr_cpu_data() returns void, so alloc_cpumask_var() is no go.

- No idea of the calling context of dr_cpu_data(). IIUC,
  dr_cpu_data()
  ->dr_cpu_configure()  
   ->kzalloc(resp_len, GFP_KERNEL)
  So I guess it's in process context?
  If consumption above is OK, a simple but _ugly_ solution could be:

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index ffdc15588ac2..c9e4ebdccf49 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -634,7 +634,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,
        struct dr_cpu_tag *tag = (struct dr_cpu_tag *) (data + 1);
        u32 *cpu_list = (u32 *) (tag + 1);
        u64 req_num = tag->req_num;
-       cpumask_t mask;
+       static DEFINE_MUTEX(mask_lock);
+       static cpumask_t mask;
        unsigned int i;
        int err;

@@ -651,6 +652,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,

        purge_dups(cpu_list, tag->num_records);

+       mutex_lock(&mask_lock);
+
        cpumask_clear(&mask);
        for (i = 0; i < tag->num_records; i++) {
                if (cpu_list[i] == CPU_SENTINEL)
@@ -665,6 +668,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,
        else
                err = dr_cpu_unconfigure(dp, cp, req_num, &mask);

+       mutex_unlock(&mask_lock);
+
        if (err)
                dr_cpu_send_error(dp, cp, data);
 }

How does it sound to you?

> kernel/leon_kernel.c:   cpumask_t mask;

It's in irqchip::irq_set_affinity(), which is in atomic context(raw spinlock(s) held),
so dynamic allocation is not a good idea.

My proposal(*untested*) is somewhat complicated for it introduces a new helper.

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 4c61da491fee..6eced7acb8bc 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -104,15 +104,25 @@ unsigned long leon_get_irqmask(unsigned int irq)
 }

 #ifdef CONFIG_SMP
+
+static bool cpumask_include(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+       unsigned int cpu;
+
+       for_each_cpu(cpu, srcp2) {
+               if (!cpumask_test_cpu(cpu, srcp1))
+                       return false;
+       }
+
+       return true;
+}
+
 static int irq_choose_cpu(const struct cpumask *affinity)
 {
-       cpumask_t mask;
+       unsigned int cpu = cpumask_first_and(affinity, cpu_online_mask);

-       cpumask_and(&mask, cpu_online_mask, affinity);
-       if (cpumask_equal(&mask, cpu_online_mask) || cpumask_empty(&mask))
-               return boot_cpu_id;
-       else
-               return cpumask_first(&mask);
+       return cpumask_include(affinity, cpu_online_mask) || cpu >= nr_cpu_ids ?
+              boot_cpu_id : cpu;
 }
 #else
 #define irq_choose_cpu(affinity) boot_cpu_id

Is it OK?

[cc Yury for bitmap API]

> kernel/leon_smp.c:static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> kernel/sun4d_smp.c:static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,

Actually I am awared of existence of (at least some of) them, but so far I
have not found a _proper_ way of dealing with them(especially for case of
ds.c).

Please lemme dig into it.

Thanks,

    Dawei

> 
> Do you plan to look at the other on-stack users too?
> It would be nice to see them all gone in one patch-set.
> 
> 	Sam
> 

