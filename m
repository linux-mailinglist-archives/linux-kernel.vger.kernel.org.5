Return-Path: <linux-kernel+bounces-30694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE4832323
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014AA1C225B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C5020E8;
	Fri, 19 Jan 2024 01:49:45 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAE1C30
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628985; cv=none; b=LP+I4OeNGv9+j++65VYLGtcw3FSDsPPtZS9+ezqM1tbBO8rdQB+VErr4LohENrboudtLIWHVU2GbQwJMAVgqm4Oa4CtOADFya2TyGmjUZ0nhuIPvg9u3CwcqIBwsxkzcqwZky62NsbyHJ4/gLDz3POUT0WIMjkiVkTMs8Q6iUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628985; c=relaxed/simple;
	bh=T86wVEWIFt2hySqd2k7s7zDxzFY9oLKJqje1Rbam5oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGw/zn3S7pRoZxlZwMzaoA8Ne67xeWBGE5Vd0nNZafpS6QGv8pl5OxFP6A2yr0MFvG0M6ZqFajiXwFYuODQ1XduHiHNJrsw+IS65efvBIJ4OmabedMLyA9hECRAWPl1mKijkekkrQWVQ7ls2wv4HR3IfEb6FwI2uzAxq4Qa5CLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1705628947tj4q10jx
X-QQ-Originating-IP: j27BpN+p7rOsbd3ZNiDoHJmA3RCz0FD/Ud+l+7UNIYk=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Jan 2024 09:49:06 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: 1eRl5/SlfYPzYDWzAzOoN3fvsYciMkk4LPFMnXBW6M4C5F+GLp+GrljY2IaW2
	uRPKsOdp4F3vT6wzGqPYwbFG7Erdvkm+UG6Gn0MlNZig+djbzibMlup3u5b6kBD75ZlR5SP
	cTO0/IwyZd4D2+C5DDtjK9ktRlaHD2wGCk4iGFUeGyuvXxVeBgxiBlRJmxOuD4mBM0qe2TG
	35HWC/O8PRhzvYzD+BSir6mZ8zsbEE16WCaMtJEWykIHb/we+Vc55vJOg5qIgOFwCVTRl9D
	BP4Fa6bRgLBp4bnW+mqf9YSHCjDi+OWC37ywc7afTctTXtrdTRP2tz6URg/srZXcm5+Yg5j
	EcsDi0X3PgO/K2sxUyXQonMNpH3XHEXlPbgDdQYPAY5nmTlu+U1kEEcrBvH53xIOKZ0uhdM
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7786004939020553288
Date: Fri, 19 Jan 2024 09:49:06 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Marc Zyngier <maz@kernel.org>
Cc: tglx@linutronix.de, sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH 1/4] irqchip/gic-v3: Implement read polling with
 dedicated API
Message-ID: <D59B0C29D27B99CF+ZanVEqqcRSYt8f5F@centos8>
References: <20240118112739.2000497-1-dawei.li@shingroup.cn>
 <20240118112739.2000497-2-dawei.li@shingroup.cn>
 <871qaeyc5s.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qaeyc5s.wl-maz@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Marc,

Thanks for the quick review.

On Thu, Jan 18, 2024 at 02:00:15PM +0000, Marc Zyngier wrote:
> On Thu, 18 Jan 2024 11:27:36 +0000,
> Dawei Li <dawei.li@shingroup.cn> wrote:
> > 
> > Kernel provide read*_poll_* API family to support looping based polling
> > code pattern like below:
> > while (...)
> > {
> > 	val = op(addr);
> > 	condition = cond(val);
> > 	if (condition)
> > 		break;
> > 
> > 	/* Maybe some timeout handling stuff */
> > 
> > 	cpu_relax();
> > 	udelay();
> > }
> > 
> > As such, use readl_relaxed_poll_timeout_atomic() to implement atomic
> > register polling logic in gic-v3.
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 27 ++++++++-------------------
> >  1 file changed, 8 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 98b0329b7154..b9d9375a3434 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/refcount.h>
> >  #include <linux/slab.h>
> > +#include <linux/iopoll.h>
> >  
> >  #include <linux/irqchip.h>
> >  #include <linux/irqchip/arm-gic-common.h>
> > @@ -251,17 +252,11 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
> >  
> >  static void gic_do_wait_for_rwp(void __iomem *base, u32 bit)
> >  {
> > -	u32 count = 1000000;	/* 1s! */
> > +	u32 val;
> >  
> > -	while (readl_relaxed(base + GICD_CTLR) & bit) {
> > -		count--;
> > -		if (!count) {
> > -			pr_err_ratelimited("RWP timeout, gone fishing\n");
> > -			return;
> > -		}
> > -		cpu_relax();
> > -		udelay(1);
> > -	}
> > +	if (readl_relaxed_poll_timeout_atomic(base + GICD_CTLR,
> > +		val, !(val & bit), 1, 1000000) == -ETIMEDOUT)
> 
> If you are doing this, please use a constant such as USEC_PER_SEC for
> the timeout. And fix the alignment of the second line so that the
> parameters are aligned vertically.

Agreed, well defined constant is always preferable than magic number;

And yes, alignment is for better readability.

> 
> > +		pr_err_ratelimited("RWP timeout, gone fishing\n");
> >  }
> >  
> >  /* Wait for completion of a distributor change */
> > @@ -279,7 +274,6 @@ static void gic_redist_wait_for_rwp(void)
> >  static void gic_enable_redist(bool enable)
> >  {
> >  	void __iomem *rbase;
> > -	u32 count = 1000000;	/* 1s! */
> >  	u32 val;
> >  
> >  	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
> > @@ -301,14 +295,9 @@ static void gic_enable_redist(bool enable)
> >  			return;	/* No PM support in this redistributor */
> >  	}
> >  
> > -	while (--count) {
> > -		val = readl_relaxed(rbase + GICR_WAKER);
> > -		if (enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep))
> > -			break;
> > -		cpu_relax();
> > -		udelay(1);
> > -	}
> > -	if (!count)
> > +	if (readl_relaxed_poll_timeout_atomic(rbase + GICR_WAKER,
> > +		val, enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep),
> > +		1, 1000000) == -ETIMEDOUT)
> >  		pr_err_ratelimited("redistributor failed to %s...\n",
> >  				   enable ? "wakeup" : "sleep");
> >  }
> 
> Same thing here.

Ack.

I will address two issues above and send respin of V2.

Thanks,
	Dawei

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 

