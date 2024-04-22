Return-Path: <linux-kernel+bounces-152772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055458AC410
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BB6281493
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B93FB3B;
	Mon, 22 Apr 2024 06:16:39 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E6210EE;
	Mon, 22 Apr 2024 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766598; cv=none; b=eM4CvuWKvd6Z6Cs8IiwATGlRZ12he6QPcJk/qECy9E9YWbToWNIcR9mypOUycN1tVoWFtm7BxYj7ywOcl1R9xP+u+ajeAguYC/UM/Vyd6pBnPq4PcT4/Ywb0ynvNLqyLRT56kmIgg7C2/f4qszpa95XotzXc2O0s00f4K6VySPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766598; c=relaxed/simple;
	bh=ZFAPFb9v3r9Jj+1ZKcy/V27G3vVzS1LZRpZTP0OnOlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFa/uocPlXRkQFWglvVi0XThfyYSa1E/uMtUP3VFrf/tMfKDjWDSSdnnRdETFHDoxtz6ddF2dlEV+/xr4Jea94HoSELB2Jdu4bYS8Ifz22wF/c9ClLcgDdI9gXfjYi/FDbz5C4EWdmoad1NwRQuyeH0vjZZxz3TpOG4eskwOQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz14t1713766551thckmz
X-QQ-Originating-IP: TBnoSNMmUGPLjFmw26QudvkS4tzMwnZXfvDbZXVQWvo=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Apr 2024 14:15:50 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: mssce+Xd5ZSt4hqBV3k9G7swjdtVc8nUUAzTxeEDygVovzjttSSqf8KxKPSNx
	usftZNtDfhuvYhDhNUf+qRHIRQRyA8f+dUfzHkdPaUxBCCUgigGXODXRAoLpNfWXe8Gyk8b
	hgHoNB1PYPIFzS2E3/LexKT22oF25JAumPJlcWMhtxG6FyBINAYXPwUPa287n9X70SugsZv
	Q7C/F6B8qCaUfR9t7TZfhpcVMe3XooF9C6VUqU90aSt3iWxif/8/Lw7APIi0NVg42Glomp0
	k4faZq7jNr++LyWn2fpzC8kbb2Yfm+CvMQzdTAYgnP3SnQFWMNH8UavVlTPlz3/XdwQA8fy
	VHR64kAJZeaIuyYj2Py4vN6HNd12Al9G/7QvfVNrT7i5/JqkXSGUUc2tIPU0GTZZts69iJx
	U5gSwwacCf0=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12347863902776195272
Date: Mon, 22 Apr 2024 14:15:50 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] sparc/leon: Remove on-stack cpumask var
Message-ID: <77CD3A300783E010+ZiYAllmOeXQ9GJkf@centos8>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-7-dawei.li@shingroup.cn>
 <20240420083202.GF614130@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420083202.GF614130@ravnborg.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Sam,

Thanks for review.

On Sat, Apr 20, 2024 at 10:32:02AM +0200, Sam Ravnborg wrote:
> On Sat, Apr 20, 2024 at 01:15:46PM +0800, Dawei Li wrote:
> > In general it's preferable to avoid placing cpumasks on the stack, as
> > for large values of NR_CPUS these can consume significant amounts of
> > stack space and make stack overflows more likely.
> > 
> > Use cpumask_subset() and cpumask_first_and() to avoid the need for a
> > temporary cpumask on the stack.
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  arch/sparc/kernel/leon_kernel.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
> > index 4c61da491fee..0070655041bb 100644
> > --- a/arch/sparc/kernel/leon_kernel.c
> > +++ b/arch/sparc/kernel/leon_kernel.c
> > @@ -106,13 +106,10 @@ unsigned long leon_get_irqmask(unsigned int irq)
> >  #ifdef CONFIG_SMP
> >  static int irq_choose_cpu(const struct cpumask *affinity)
> >  {
> > -	cpumask_t mask;
> > +	unsigned int cpu = cpumask_first_and(affinity, cpu_online_mask);
> >  
> > -	cpumask_and(&mask, cpu_online_mask, affinity);
> > -	if (cpumask_equal(&mask, cpu_online_mask) || cpumask_empty(&mask))
> > -		return boot_cpu_id;
> > -	else
> > -		return cpumask_first(&mask);
> > +	return cpumask_subset(cpu_online_mask, affinity) || cpu >= nr_cpu_ids ?
> > +	       boot_cpu_id : cpu;
> 
> This looks wrong - or if it is correct is is hard to parse.
> Drop ?: and use an if so the code is more readable.

I am confused a bit here, about its correctness(not coding style).

Per my understanding:

A & B = A <-> For every set bit in A, it's set for B; <-> B is superset
of A. <-> A is subset of B.

-	cpumask_and(&mask, cpu_online_mask, affinity);
-	if (cpumask_equal(&mask, cpu_online_mask))

So, codes above is equivalent to:
	if (cpumask_subset(cpu_online_mask, affinity))

Am I missing something?

About the ?:, I will restore original "if else" style. 

> 
> 	Sam
> 

Thanks,

    Dawei

