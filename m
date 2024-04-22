Return-Path: <linux-kernel+bounces-152775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4278AC416
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21FDFB22171
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0DA3FB9A;
	Mon, 22 Apr 2024 06:20:38 +0000 (UTC)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4315DDA3;
	Mon, 22 Apr 2024 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766838; cv=none; b=IaW7B21tq2aE9K26lnsYjJOO4qjMvGOc7SBqsYMh75Ln2Dw3C7IQ5xzwlTLJzOqR4Rajltmnjv2i5zxFsGzCf0RuYh59iSKFlhDSzxd8uOcMpLx8aZPJrRu5gMAi1JCXuffa0BxNLZwt9VwTkaTJbeBBtv96c7zRoxT7SyDR/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766838; c=relaxed/simple;
	bh=ev1fujw2HMmz1ucwstdI0EgqPVqyFN5F90+AMv08+SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjmXO7K+xE+Zxyg4x3DOY98gR04WZPjZsr0hUobuDgqDfBiYb8YqYTnLXeMvUaXyK2ntVQlpbr0ePPA+M9IFI/90Vl/O4ruXgiW2nqNIcZWnHcH3Zt8SNZ19Bw4FHCyDck4b9quQMvGUzmrnNc4675CcSla6WkbuqBe0NttZnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp88t1713766777t92ce605
X-QQ-Originating-IP: qXDDljJZwUI/DW+V7t/Bd06Bt+HyYYzFIoNHQEwgvL0=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Apr 2024 14:19:36 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: kVQIgyp2XbWp3t8brrM48uGHBYuIE19BZ/7UF7ASRyUErxG3HgNr78IkhDMJk
	g3e6Tacitx3rqOUKpAzOgpH7RDfc4C5mKFkP8+Je24kbuaHJWbfzH3WLW9CCkIvbL2dnLJT
	ysf7cf0zGYrilEl5Menff79hE/QSKpG8h9dBhon0nr86RbU/D/h/HKg+7F0fSWCG4Jx/XIm
	yyue/S3ubHIFFqp5C7C1aaV1qjDgCYawt0wbA4yMj3KuWiM1RBC3JoML2Dfl8uSE2PZe6nQ
	bJcSu8f2Hw/QeObFU9jQOvfF4SgGgtiahS9Npf+hXVSlK6Kv4hIWG88qR8G1iJXdhEt7HEf
	rdwX9aDuqe+3S3gGmsh1RNuG9Z9c4kfU1j5FetikaPL9DDHVO6hV9L+mN+T93aR+juJr9rh
	l9A6z+VmT1Ey2CuwZDGc/A==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2980677701840836628
Date: Mon, 22 Apr 2024 14:19:36 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] sparc/smp: Remove on-stack cpumask var
Message-ID: <6610C2D76CEF5BEC+ZiYBeEqxXjzbrmJ/@centos8>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-8-dawei.li@shingroup.cn>
 <20240420114207.GG614130@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420114207.GG614130@ravnborg.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Sam,

Thanks for review.

On Sat, Apr 20, 2024 at 01:42:07PM +0200, Sam Ravnborg wrote:
> Hi Dawei
> 
> On Sat, Apr 20, 2024 at 01:15:47PM +0800, Dawei Li wrote:
> > In general it's preferable to avoid placing cpumasks on the stack, as
> > for large values of NR_CPUS these can consume significant amounts of
> > stack space and make stack overflows more likely.
> > 
> > - Change prototype of sparc32_ipi_ops::cross_call() so that it takes
> >   const cpumask * arg and all its callers accordingly.
> > 
> > - As for all cross_call() implementations, divide cpumask_test_cpu() call
> >   into several sub calls to avoid on-stack cpumask var.
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> 
> The code changes looks ok from a quick look.
> But we have a bunch of patches pending touching or removing the same
> files. On top of this, the right approach would be to take a
> look at code from a higher level.
> 
> In other words - I advise to drop this, and maybe re-visit in a few
> months after the pending patches has hit -next.
> 
> Sorry for asking you to look as this.

It's OK :), I will drop this commit until your patch series are applied. 

Thanks,

    Dawei

> 
> 	Sam
> 
> > ---
> >  arch/sparc/include/asm/smp_32.h | 12 ++++++------
> >  arch/sparc/kernel/kernel.h      | 11 +++++++++++
> >  arch/sparc/kernel/leon_smp.c    | 11 ++++-------
> >  arch/sparc/kernel/sun4d_smp.c   | 10 ++++------
> >  arch/sparc/kernel/sun4m_smp.c   | 10 ++++------
> >  5 files changed, 29 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
> > index 2cf7971d7f6c..9b6a166f6a57 100644
> > --- a/arch/sparc/include/asm/smp_32.h
> > +++ b/arch/sparc/include/asm/smp_32.h
> > @@ -54,7 +54,7 @@ void smp_bogo(struct seq_file *);
> >  void smp_info(struct seq_file *);
> >  
> >  struct sparc32_ipi_ops {
> > -	void (*cross_call)(void *func, cpumask_t mask, unsigned long arg1,
> > +	void (*cross_call)(void *func, const cpumask_t *mask, unsigned long arg1,
> >  			   unsigned long arg2, unsigned long arg3,
> >  			   unsigned long arg4);
> >  	void (*resched)(int cpu);
> > @@ -65,29 +65,29 @@ extern const struct sparc32_ipi_ops *sparc32_ipi_ops;
> >  
> >  static inline void xc0(void *func)
> >  {
> > -	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, 0, 0, 0, 0);
> > +	sparc32_ipi_ops->cross_call(func, cpu_online_mask, 0, 0, 0, 0);
> >  }
> >  
> >  static inline void xc1(void *func, unsigned long arg1)
> >  {
> > -	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, 0, 0, 0);
> > +	sparc32_ipi_ops->cross_call(func, cpu_online_mask, arg1, 0, 0, 0);
> >  }
> >  static inline void xc2(void *func, unsigned long arg1, unsigned long arg2)
> >  {
> > -	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, arg2, 0, 0);
> > +	sparc32_ipi_ops->cross_call(func, cpu_online_mask, arg1, arg2, 0, 0);
> >  }
> >  
> >  static inline void xc3(void *func, unsigned long arg1, unsigned long arg2,
> >  		       unsigned long arg3)
> >  {
> > -	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
> > +	sparc32_ipi_ops->cross_call(func, cpu_online_mask,
> >  				    arg1, arg2, arg3, 0);
> >  }
> >  
> >  static inline void xc4(void *func, unsigned long arg1, unsigned long arg2,
> >  		       unsigned long arg3, unsigned long arg4)
> >  {
> > -	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
> > +	sparc32_ipi_ops->cross_call(func, cpu_online_mask,
> >  				    arg1, arg2, arg3, arg4);
> >  }
> >  
> > diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
> > index a8fb7c0bf053..36747e8f7e36 100644
> > --- a/arch/sparc/kernel/kernel.h
> > +++ b/arch/sparc/kernel/kernel.h
> > @@ -4,6 +4,7 @@
> >  
> >  #include <linux/interrupt.h>
> >  #include <linux/ftrace.h>
> > +#include <linux/smp.h>
> >  
> >  #include <asm/traps.h>
> >  #include <asm/head.h>
> > @@ -75,6 +76,16 @@ int sparc32_classify_syscall(unsigned int syscall);
> >  #endif
> >  
> >  #ifdef CONFIG_SPARC32
> > +
> > +#ifdef CONFIG_SMP
> > +static inline bool cpu_for_ipi(const cpumask_t *mask, unsigned int cpu)
> > +{
> > +	return cpumask_test_cpu(cpu, mask) &&
> > +	       cpumask_test_cpu(cpu, cpu_online_mask) &&
> > +	       cpu != smp_processor_id();
> > +}
> > +#endif /* CONFIG_SMP */
> > +
> >  /* setup_32.c */
> >  struct linux_romvec;
> >  void sparc32_start_kernel(struct linux_romvec *rp);
> > diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
> > index 1ee393abc463..291884c8d82a 100644
> > --- a/arch/sparc/kernel/leon_smp.c
> > +++ b/arch/sparc/kernel/leon_smp.c
> > @@ -372,7 +372,7 @@ static struct smp_funcall {
> >  static DEFINE_SPINLOCK(cross_call_lock);
> >  
> >  /* Cross calls must be serialized, at least currently. */
> > -static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> > +static void leon_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
> >  			    unsigned long arg2, unsigned long arg3,
> >  			    unsigned long arg4)
> >  {
> > @@ -403,14 +403,11 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  		{
> >  			register int i;
> >  
> > -			cpumask_clear_cpu(smp_processor_id(), &mask);
> > -			cpumask_and(&mask, cpu_online_mask, &mask);
> >  			for (i = 0; i <= high; i++) {
> > -				if (cpumask_test_cpu(i, &mask)) {
> > +				if (cpu_for_ipi(mask, i)) {
> >  					ccall_info.processors_in[i] = 0;
> >  					ccall_info.processors_out[i] = 0;
> >  					leon_send_ipi(i, LEON3_IRQ_CROSS_CALL);
> > -
> >  				}
> >  			}
> >  		}
> > @@ -420,7 +417,7 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  
> >  			i = 0;
> >  			do {
> > -				if (!cpumask_test_cpu(i, &mask))
> > +				if (!cpu_for_ipi(mask, i))
> >  					continue;
> >  
> >  				while (!ccall_info.processors_in[i])
> > @@ -429,7 +426,7 @@ static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  
> >  			i = 0;
> >  			do {
> > -				if (!cpumask_test_cpu(i, &mask))
> > +				if (!cpu_for_ipi(mask, i))
> >  					continue;
> >  
> >  				while (!ccall_info.processors_out[i])
> > diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
> > index 9a62a5cf3337..7dc57ca05728 100644
> > --- a/arch/sparc/kernel/sun4d_smp.c
> > +++ b/arch/sparc/kernel/sun4d_smp.c
> > @@ -281,7 +281,7 @@ static struct smp_funcall {
> >  static DEFINE_SPINLOCK(cross_call_lock);
> >  
> >  /* Cross calls must be serialized, at least currently. */
> > -static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> > +static void sun4d_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
> >  			     unsigned long arg2, unsigned long arg3,
> >  			     unsigned long arg4)
> >  {
> > @@ -315,10 +315,8 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  		{
> >  			register int i;
> >  
> > -			cpumask_clear_cpu(smp_processor_id(), &mask);
> > -			cpumask_and(&mask, cpu_online_mask, &mask);
> >  			for (i = 0; i <= high; i++) {
> > -				if (cpumask_test_cpu(i, &mask)) {
> > +				if (cpu_for_ipi(mask, i)) {
> >  					ccall_info.processors_in[i] = 0;
> >  					ccall_info.processors_out[i] = 0;
> >  					sun4d_send_ipi(i, IRQ_CROSS_CALL);
> > @@ -331,7 +329,7 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  
> >  			i = 0;
> >  			do {
> > -				if (!cpumask_test_cpu(i, &mask))
> > +				if (!cpu_for_ipi(mask, i))
> >  					continue;
> >  				while (!ccall_info.processors_in[i])
> >  					barrier();
> > @@ -339,7 +337,7 @@ static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  
> >  			i = 0;
> >  			do {
> > -				if (!cpumask_test_cpu(i, &mask))
> > +				if (!cpu_for_ipi(mask, i))
> >  					continue;
> >  				while (!ccall_info.processors_out[i])
> >  					barrier();
> > diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
> > index 056df034e79e..3f43f64e3489 100644
> > --- a/arch/sparc/kernel/sun4m_smp.c
> > +++ b/arch/sparc/kernel/sun4m_smp.c
> > @@ -170,7 +170,7 @@ static struct smp_funcall {
> >  static DEFINE_SPINLOCK(cross_call_lock);
> >  
> >  /* Cross calls must be serialized, at least currently. */
> > -static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> > +static void sun4m_cross_call(void *func, const cpumask_t *mask, unsigned long arg1,
> >  			     unsigned long arg2, unsigned long arg3,
> >  			     unsigned long arg4)
> >  {
> > @@ -191,10 +191,8 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  		{
> >  			register int i;
> >  
> > -			cpumask_clear_cpu(smp_processor_id(), &mask);
> > -			cpumask_and(&mask, cpu_online_mask, &mask);
> >  			for (i = 0; i < ncpus; i++) {
> > -				if (cpumask_test_cpu(i, &mask)) {
> > +				if (cpu_for_ipi(mask, i)) {
> >  					ccall_info.processors_in[i] = 0;
> >  					ccall_info.processors_out[i] = 0;
> >  					sun4m_send_ipi(i, IRQ_CROSS_CALL);
> > @@ -210,7 +208,7 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  
> >  			i = 0;
> >  			do {
> > -				if (!cpumask_test_cpu(i, &mask))
> > +				if (!cpu_for_ipi(mask, i))
> >  					continue;
> >  				while (!ccall_info.processors_in[i])
> >  					barrier();
> > @@ -218,7 +216,7 @@ static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> >  
> >  			i = 0;
> >  			do {
> > -				if (!cpumask_test_cpu(i, &mask))
> > +				if (!cpu_for_ipi(mask, i))
> >  					continue;
> >  				while (!ccall_info.processors_out[i])
> >  					barrier();
> > -- 
> > 2.27.0
> 

