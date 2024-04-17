Return-Path: <linux-kernel+bounces-147828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614648A7A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83ED91C215A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E46FA8;
	Wed, 17 Apr 2024 01:35:53 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B56AAD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317752; cv=none; b=llCcBzsvl0iOFD+byH3aDzCAJUclHyNmAlHj//okk8Qd0GXxvK0rROJrSqt5TAhmSayg0gXA+H3+R48GCOpVMVZ29CZbSiFSu8N/DCn5BiohmENRqMAT8JDsoUBXGqcyC3VSADn/xNkLwfyyABTcJ7FPap48qk10Ud1T9JZxrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317752; c=relaxed/simple;
	bh=UT7C0B7hVdfyXkyBHhAYK+UghxAUXhgU54EEJiffytM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfJXx6UsiKwc7/2DNo0CiB3q1pcbTaylqGoIRC9sTGvnP7ePofV0ngxUcNszzIPpZvHas3/Y57Y9PYn4w6JiQEDkUZu3rB+AUZMB1hj5PNQZwQinrXSgtMqUhWOFkST82zHwtda5EnnUT785EsiTAcB1uzXbqjXwuSTZOWPr3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp81t1713317703tuw8e22g
X-QQ-Originating-IP: +nqw7dJ0NDFwZ3OW+bE42xuiEyAVg0Ur49g+O0jmjYo=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Apr 2024 09:35:01 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: FaQY97jFVS0UNAvFee7Yda6TgBzzoIIWlSXFcwDYV92Cx6bAZFSKbYnY5WDuk
	e/EtcDzYviGSwJZnYPfCAA3vgcgAhXApXhbWG+SEqajNY1eYmml66BeQ54WGjyPnEHJVfWr
	2e7oK3/Z/s7b91fOYsXYN484uN6W5jXsHl1ytwoGuoui7rHn1bTxJw4/kcPgF52mBkcF04j
	HHL5b/XDMOVZVRIcojnP8Ju+rtOp6uG7BJUJn958anFqio0qfui7OsK3i/XVTJ5WCnEd0SI
	DHd7RzzYBpCIq8ubdYJMm+ZAirtAiRWnI2Q5CwW3PWT3Mul3wX+PeYHrgXYU7HAjbUyftbb
	ZyLOGU41UWUvvplcGS18xUnpjFNnLwZumB9Jnqw4AU6Wv/dHU/DEp/5rZThMnKCPXc+jeRq
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17220191635959748820
Date: Wed, 17 Apr 2024 09:35:01 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Yury Norov <yury.norov@gmail.com>
Cc: tglx@linutronix.de, rafael@kernel.org, akpm@linux-foundation.org,
	maz@kernel.org, florian.fainelli@broadcom.com,
	chenhuacai@kernel.org, jiaxun.yang@flygoat.com, anup@brainfault.org,
	palmer@dabbelt.com, samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk, daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] cpumask: introduce cpumask_first_and_and()
Message-ID: <43E7802C61525AF3+Zh8nRcAcOdR6EK5P@centos8>
References: <20240416085454.3547175-1-dawei.li@shingroup.cn>
 <20240416085454.3547175-2-dawei.li@shingroup.cn>
 <Zh65Uf3oWPS1/kyC@yury-ThinkPad>
 <Zh66OpVlYL2p0Jbn@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh66OpVlYL2p0Jbn@yury-ThinkPad>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Yury,

Thanks for review.

On Tue, Apr 16, 2024 at 10:49:46AM -0700, Yury Norov wrote:
> On Tue, Apr 16, 2024 at 10:45:54AM -0700, Yury Norov wrote:
> > On Tue, Apr 16, 2024 at 04:54:48PM +0800, Dawei Li wrote:
> > > Introduce cpumask_first_and_and() to get intersection between 3 cpumasks,
> > > free of any intermediate cpumask variable. Instead, cpumask_first_and_and()
> > > works in-place with all inputs and produce desired output directly.
> 
> Still there: s/produce/produces

Oops, sorry for that. If it's needed I will respin v3. 

> 
> But whatever. Also, I think this patch would better go with the rest
> of the series, right?

I suppose so, this series should be applied as a whole.

> 
> > > 
> > > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

> > 
> > Acked-by: Yury Norov <yury.norov@gmail.com>

Thanks!

    Dawei
> > 
> > > ---
> > >  include/linux/cpumask.h | 17 +++++++++++++++++
> > >  include/linux/find.h    | 27 +++++++++++++++++++++++++++
> > >  lib/find_bit.c          | 12 ++++++++++++
> > >  3 files changed, 56 insertions(+)
> > > 
> > > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > > index 1c29947db848..c46f9e9e1d66 100644
> > > --- a/include/linux/cpumask.h
> > > +++ b/include/linux/cpumask.h
> > > @@ -187,6 +187,23 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
> > >  	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
> > >  }
> > >  
> > > +/**
> > > + * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
> > > + * @srcp1: the first input
> > > + * @srcp2: the second input
> > > + * @srcp3: the third input
> > > + *
> > > + * Return: >= nr_cpu_ids if no cpus set in all.
> > > + */
> > > +static inline
> > > +unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
> > > +				   const struct cpumask *srcp2,
> > > +				   const struct cpumask *srcp3)
> > > +{
> > > +	return find_first_and_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
> > > +				      cpumask_bits(srcp3), small_cpumask_bits);
> > > +}
> > > +
> > >  /**
> > >   * cpumask_last - get the last CPU in a cpumask
> > >   * @srcp:	- the cpumask pointer
> > > diff --git a/include/linux/find.h b/include/linux/find.h
> > > index c69598e383c1..28ec5a03393a 100644
> > > --- a/include/linux/find.h
> > > +++ b/include/linux/find.h
> > > @@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsign
> > >  					unsigned long n);
> > >  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
> > >  					 const unsigned long *addr2, unsigned long size);
> > > +unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
> > > +				      const unsigned long *addr3, unsigned long size);
> > >  extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
> > >  extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
> > >  
> > > @@ -345,6 +347,31 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
> > >  }
> > >  #endif
> > >  
> > > +/**
> > > + * find_first_and_and_bit - find the first set bit in 3 memory regions
> > > + * @addr1: The first address to base the search on
> > > + * @addr2: The second address to base the search on
> > > + * @addr3: The third address to base the search on
> > > + * @size: The bitmap size in bits
> > > + *
> > > + * Returns the bit number for the first set bit
> > > + * If no bits are set, returns @size.
> > > + */
> > > +static inline
> > > +unsigned long find_first_and_and_bit(const unsigned long *addr1,
> > > +				     const unsigned long *addr2,
> > > +				     const unsigned long *addr3,
> > > +				     unsigned long size)
> > > +{
> > > +	if (small_const_nbits(size)) {
> > > +		unsigned long val = *addr1 & *addr2 & *addr3 & GENMASK(size - 1, 0);
> > > +
> > > +		return val ? __ffs(val) : size;
> > > +	}
> > > +
> > > +	return _find_first_and_and_bit(addr1, addr2, addr3, size);
> > > +}
> > > +
> > >  #ifndef find_first_zero_bit
> > >  /**
> > >   * find_first_zero_bit - find the first cleared bit in a memory region
> > > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > > index 32f99e9a670e..dacadd904250 100644
> > > --- a/lib/find_bit.c
> > > +++ b/lib/find_bit.c
> > > @@ -116,6 +116,18 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
> > >  EXPORT_SYMBOL(_find_first_and_bit);
> > >  #endif
> > >  
> > > +/*
> > > + * Find the first set bit in three memory regions.
> > > + */
> > > +unsigned long _find_first_and_and_bit(const unsigned long *addr1,
> > > +				      const unsigned long *addr2,
> > > +				      const unsigned long *addr3,
> > > +				      unsigned long size)
> > > +{
> > > +	return FIND_FIRST_BIT(addr1[idx] & addr2[idx] & addr3[idx], /* nop */, size);
> > > +}
> > > +EXPORT_SYMBOL(_find_first_and_and_bit);
> > > +
> > >  #ifndef find_first_zero_bit
> > >  /*
> > >   * Find the first cleared bit in a memory region.
> > > -- 
> > > 2.27.0
> 

