Return-Path: <linux-kernel+bounces-143682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA08A3C42
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0221F21A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C220DFC;
	Sat, 13 Apr 2024 10:38:05 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBF3D977
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004684; cv=none; b=ITho63arfytwDCQ/bs/XZjhTSIebyElF/M5E2yotWHeRC31PtBWTUazSjOeHzXVrOJXMH/HF1bx7xvYN+wT0yXqZjZcCXhLIxKYjlU9PkrPKQTNlE9Ul+faVDWDg0AnIufjFXGJcA+7d9hfl3sOBIh7rbCQH6JWTI+p750GROIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004684; c=relaxed/simple;
	bh=d5furmS1pq1wFFg1paSHtjqBQPAM3IJaVtZhOQFfNJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F++6yw0LaIXcDRrU9LwYa0siU77Cl31+Yuc9l/caBy61QcovDstRyCsa7LSbv3QaWCyMM7OyfXg5cEEE2f2f1fVVHdjsXNAqCOfG5Syx9ZHWIiOecFz2hvdrF4rpyfLdRfL7f+xVWQV2ieZKCIqpKrUXERrBSgxX//9t+TVm7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz1t1713004662ty78y06
X-QQ-Originating-IP: tgrM3jlQGygBOluqjLsoE4ZL5i0fo68aVOKlWGdx0Sk=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 13 Apr 2024 18:37:40 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: LrCnY+iDm+NgXtWeGYp7hKVOOGauFHtIT65JPyis+DR/7tkTjrebGFSDMRPDJ
	rpGFDG1rwf+PCQwe/Tj4CHkgGs34GwNsglTuen9NNcoaiyXUtB4sxJ8UI2Eoo7PorvDw02l
	fPZb4cq0ohUyJGfaYl5eezwESi+w52oj6vXdVvN/QHAVu0BOnRix8y1PZOx2G3WJa5plSQB
	bQEuBxUeQy6gHoqh6KZpiNbbIQL9c8Zp5HJFDCMBpkdQ9XNmlFBXNRnndiEmEQl9XQnJYkd
	VNrZaWgLOvyBYKchFgpmVCyJbW8kMA/U36euSxE6iMdiRDuH8+V5zvufVIXOg/ajnDQ3jZz
	e9WxAW+irOq+J1JLo3wtphNucU3rtHz8UY+HZ1Ik+pLHOJSgczri45pub5yXYHZSRGD5KI5
	0V4dDWB8gO44dK83HTSvZQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2616944406899746370
Date: Sat, 13 Apr 2024 18:37:40 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Yury Norov <yury.norov@gmail.com>
Cc: tglx@linutronix.de, akpm@linux-foundation.org, maz@kernel.org,
	florian.fainelli@broadcom.com, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, anup@brainfault.org, palmer@dabbelt.com,
	samuel.holland@sifive.com, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] cpumask: introduce cpumask_first_and_and()
Message-ID: <801BE872BDBCD4A1+ZhpgdItKViCouyN+@centos8>
References: <20240412105839.2896281-1-dawei.li@shingroup.cn>
 <20240412105839.2896281-2-dawei.li@shingroup.cn>
 <CAAH8bW_97sChHOMCEY22jG0jvxZO-qa8syfotz9sF9T6oCr_4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH8bW_97sChHOMCEY22jG0jvxZO-qa8syfotz9sF9T6oCr_4Q@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Yury,

Thanks for the review.

On Fri, Apr 12, 2024 at 07:40:30AM -0700, Yury Norov wrote:
> On Fri, Apr 12, 2024 at 3:59 AM Dawei Li <dawei.li@shingroup.cn> wrote:
> >
> > For some cases, it's required to make intersection between 3 cpumasks
> > and return possible cpu bit. Current implementation for these cases are
> 
> /s/possible cpu bit/set cpu/
> 
> And sometimes you just need an intersection cpumask, and don't need to return
> any set cpu. This patch introduces new API, so description should be as
> common as possible.
> 
> We've already have some 3-bitmap functions. Can you look at commit messages
> there and align your wording?
> 
> I'll be OK if you just skip this part and go straight to "Introduce
> ... to get rid of"

Ack.

> 
> > allocating a temporary cpumask var(sometimes on stack) storing intermediate
> > calculation result.
> >
> > Introduce cpumask_first_and_and() to get rid of this intermediate orinted
> 
> what the 'orinted' is?

Good catch, typo.

> 
> > approach. Instead, cpumask_first_and_and() works in-place with all inputs
> > and produce desired output directly.
> 
> /s/produce/procuces/

/s/produce/produces/ :)

> 
> >
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  include/linux/cpumask.h | 17 +++++++++++++++++
> >  include/linux/find.h    | 29 +++++++++++++++++++++++++++++
> >  lib/find_bit.c          | 14 ++++++++++++++
> >  3 files changed, 60 insertions(+)
> >
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 1c29947db848..c46f9e9e1d66 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -187,6 +187,23 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
> >         return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
> >  }
> >
> > +/**
> > + * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
> > + * @srcp1: the first input
> > + * @srcp2: the second input
> > + * @srcp3: the third input
> > + *
> > + * Return: >= nr_cpu_ids if no cpus set in all.
> > + */
> > +static inline
> > +unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
> > +                                  const struct cpumask *srcp2,
> > +                                  const struct cpumask *srcp3)
> > +{
> > +       return find_first_and_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
> > +                                     cpumask_bits(srcp3), small_cpumask_bits);
> > +}
> > +
> >  /**
> >   * cpumask_last - get the last CPU in a cpumask
> >   * @srcp:      - the cpumask pointer
> > diff --git a/include/linux/find.h b/include/linux/find.h
> > index c69598e383c1..047081c6b9f7 100644
> > --- a/include/linux/find.h
> > +++ b/include/linux/find.h
> > @@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsign
> >                                         unsigned long n);
> >  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
> >                                          const unsigned long *addr2, unsigned long size);
> > +unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
> > +                                     const unsigned long *addr3, unsigned long size);
> >  extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
> >  extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
> >
> > @@ -345,6 +347,33 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
> >  }
> >  #endif
> >
> > +#ifndef find_first_and_and_bit
> 
> Don't need to protect new API unless you've got an actual arch implementation.

Correct. I will remove it in respin.


Thanks,

    Dawei

> 
> > +/**
> > + * find_first_and_and_bit - find the first set bit in 3 memory regions
> > + * @addr1: The first address to base the search on
> > + * @addr2: The second address to base the search on
> > + * @addr3: The third address to base the search on
> > + * @size: The bitmap size in bits
> > + *
> > + * Returns the bit number for the first set bit
> > + * If no bits are set, returns @size.
> > + */
> > +static inline
> > +unsigned long find_first_and_and_bit(const unsigned long *addr1,
> > +                                    const unsigned long *addr2,
> > +                                    const unsigned long *addr3,
> > +                                    unsigned long size)
> > +{
> > +       if (small_const_nbits(size)) {
> > +               unsigned long val = *addr1 & *addr2 & *addr3 & GENMASK(size - 1, 0);
> > +
> > +               return val ? __ffs(val) : size;
> > +       }
> > +
> > +       return _find_first_and_and_bit(addr1, addr2, addr3, size);
> > +}
> > +#endif
> > +
> >  #ifndef find_first_zero_bit
> >  /**
> >   * find_first_zero_bit - find the first cleared bit in a memory region
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index 32f99e9a670e..fdc5c4117e8b 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -116,6 +116,20 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
> >  EXPORT_SYMBOL(_find_first_and_bit);
> >  #endif
> >
> > +#ifndef find_first_and_and_bit
> > +/*
> > + * Find the first set bit in three memory regions.
> > + */
> > +unsigned long _find_first_and_and_bit(const unsigned long *addr1,
> > +                                     const unsigned long *addr2,
> > +                                     const unsigned long *addr3,
> > +                                     unsigned long size)
> > +{
> > +       return FIND_FIRST_BIT(addr1[idx] & addr2[idx] & addr3[idx], /* nop */, size);
> > +}
> > +EXPORT_SYMBOL(_find_first_and_and_bit);
> > +#endif
> > +
> >  #ifndef find_first_zero_bit
> >  /*
> >   * Find the first cleared bit in a memory region.
> > --
> > 2.27.0
> >
> 

