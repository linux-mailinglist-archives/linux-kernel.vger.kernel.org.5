Return-Path: <linux-kernel+bounces-30700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059B832338
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843ACB21F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6423D0;
	Fri, 19 Jan 2024 02:03:01 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4E20E8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629780; cv=none; b=Zx4aGL7msYlv9oIOwt1zpV24m3gGAygFDHHfESWF25BXzd0dbyEla/OG2ggUfGD4aipu/jR0+8kMein5wT+2Zj6X8dLet/gMcOiW4x6GodkzkQCJwRcTywW9xZSE2eJJZr2gXZH5ZbPGNnkesbQ8GLfsgCftb1vnc92oW1v7rhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629780; c=relaxed/simple;
	bh=ICGqdJ31VjPR8uHAzBeSS3If4DhbSAcW6Jv8J+A+Whk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR0KTOQMGk3KCah8fhEKvS+/tbu8hXaQUXw4qV+v5U3ctZm9O/EpZ40kfZXoQ9ILg/ZJY+vyGRrOjZQp9B9W4iIGqtX6Po8PgSfCKRbTWUAALBzhEQRrifgpApy3PgDcs8D7BNkFWDXydWBITMmbxFyXL1En9+qYwv+aOGRspiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp84t1705629755tlp4mzkp
X-QQ-Originating-IP: /8ayjq+Nkw6x6q5GnjTruT1152L3RVrCOKJ5aW2HuWM=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Jan 2024 10:02:34 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: tSQw27OYC23AQknwRbGq6+oPUA9k4bIqDXKu7hduNtZrm3QVBMo/caVQ6weR0
	I7EssFZG1LfNXpBoBPyKz+1svjRaH8+4+f09oZILb2GdYQM1nRh+dMxZE+OQu8BAH/wLfpV
	Wj3YF8soKdxszSisFqMhMrdwe2128bf0MKX8fM8hPo7Kg3sSUqcUK2trsYiQNuyOUM1E2Nu
	MG8BveBUQQAUVorsoEXBpzse26VUk53S4UgXhpXKshshEakNPaQYKTYYYVeXPjoBjtMXEL8
	El06KMwfDlys5p8I1nJ+BBeDzZbb0MJik7wR0lXjCHHz9TCcicKaLtU0DWmqR3kxzUAM77K
	IN0elUSvuaKN7HJkyl67sTuFr2tX4KU7CyrRFKPxjB1gNpsHJt/aA9m8YH62cDyEGwCRgcd
	Kb6t4FK89Nc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2826556967009872931
Date: Fri, 19 Jan 2024 10:02:33 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Marc Zyngier <maz@kernel.org>
Cc: tglx@linutronix.de, sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH 2/4] irqchip/gic: Implement generic gic_irq() API for GIC
 & GIC-v3
Message-ID: <0021C3C0D197C59F+ZanYOXvAxIT1pF0h@centos8>
References: <20240118112739.2000497-1-dawei.li@shingroup.cn>
 <20240118112739.2000497-3-dawei.li@shingroup.cn>
 <87zfx2wxgj.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfx2wxgj.wl-maz@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Marc,
Thanks for the review.

On Thu, Jan 18, 2024 at 02:03:08PM +0000, Marc Zyngier wrote:
> On Thu, 18 Jan 2024 11:27:37 +0000,
> Dawei Li <dawei.li@shingroup.cn> wrote:
> > 
> > GIC & GIC-v3 share same gic_irq() implementations, unify them into a
> > generic API.
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  drivers/irqchip/irq-gic-common.h | 5 +++++
> >  drivers/irqchip/irq-gic-v3.c     | 5 -----
> >  drivers/irqchip/irq-gic.c        | 5 -----
> >  3 files changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> > index f407cce9ecaa..ed18db4ab2c5 100644
> > --- a/drivers/irqchip/irq-gic-common.h
> > +++ b/drivers/irqchip/irq-gic-common.h
> > @@ -19,6 +19,11 @@ struct gic_quirk {
> >  	u32 mask;
> >  };
> >  
> > +static inline unsigned int gic_irq(struct irq_data *d)
> > +{
> > +	return d->hwirq;
> > +}
> > +
> >  int gic_configure_irq(unsigned int irq, unsigned int type,
> >                         void __iomem *base, void (*sync_access)(void));
> >  void gic_dist_config(void __iomem *base, int gic_irqs,
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index b9d9375a3434..474a498a521e 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -181,11 +181,6 @@ static enum gic_intid_range get_intid_range(struct irq_data *d)
> >  	return __get_intid_range(d->hwirq);
> >  }
> >  
> > -static inline unsigned int gic_irq(struct irq_data *d)
> > -{
> > -	return d->hwirq;
> > -}
> > -
> 
> I'd rather not do that. If anything, I'd get rid of the helper
> altogether, as we have irqd_to_hwirq() that does the same job, and
> actually preserves the typing.

Yes, your solution is much better for it's truly generic, independent of
irq chip.

I will send respin of V2 as you suggested, and if I may, add your
suggested-by?

Thanks,
	Dawei

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 

