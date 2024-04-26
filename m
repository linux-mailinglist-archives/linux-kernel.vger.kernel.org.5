Return-Path: <linux-kernel+bounces-159679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E41B8B3214
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7073A1C2128C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B313C917;
	Fri, 26 Apr 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZTR4Q+J"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9FD13A3E7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119114; cv=none; b=WIG2R3Ram4e++g26wUHS0DL+SWdv5kCvgMYt3ULnXdVy3pe3Gy/rMOZV8ZlCL7p3sL1BmuaP9Hi9aIusjzJK6UyeNf6rXkZLr9qEU8qw/gQ6mQLnoJHiOrjBLvCAeRKn9eamzLOMnnb6Vs6mTYFPGs5nQmjqgp+e1s8yZyD+TOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119114; c=relaxed/simple;
	bh=c6GybAW5xsWBD6p5kQ/47/VKRwZV/VPW1JRrhNCmbhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbMRmTqX9RIrbWIpSEjm76gXLbFwOfHbkc7ta8qNrBJ+1Remm+WAHHkDByNcKjhuD7I+8RmuHplTsLht4tJHLHZMpWqXB7aLyE0teHsvsZua5jbyAtWVQcu1/H/GW+gxK4bCsX0yYsytCKmTmfdrElb7VUsJzUuGCHLUbhqLBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZTR4Q+J; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2352cc0b076so705099fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714119111; x=1714723911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Abckr9PsZt6M9XfZKq0N2yL1inDajc/CKDpZfe0fw6I=;
        b=CZTR4Q+JPuIZa2W+/BUGP8Y7WP96kVcGvXzJDaB86RbVHEipRbF2SFa9Yg049gwQqm
         lfDZuFkWmrDRopZV5iz2lBIVydbZ5mpS2p6cmh2WXA05oS7PCNzLKLDWeafql+Sm8Lg8
         x2O228F4k0t5HTL8CYOpAYP32V8rnf1rClWMm/JcgQlny8kSXygVxwkcyauYi4ftwO2V
         Sjs9M6GQRj4UqBohQFzjKiET85cbagIoOyxI7CaBYWHsuvn0taKCKRojuaGuoYJFV3lK
         gXin0F5OSmfiG5BZQJFgB4/5HIBS4c+jM+ubph0UiawNZ/nmmVUmXDZJ1CYgBCFOg6Ml
         OhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119111; x=1714723911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Abckr9PsZt6M9XfZKq0N2yL1inDajc/CKDpZfe0fw6I=;
        b=ZkvBsvv9ATsWBI6lCzBi+LoanZnD7IAmPQ6qeJZslIiDpINsjMq7SSQlfe+oh5qtKc
         VmTV0Shqysn6DnAAArYWYL+GQfp1MkHjI641H7zEoIwSnPw+VCtLlSiSA1PYRcHnlVEy
         Z5M6PDaXN7sucNpyeO/XoMY5syRAbMF9tjTvcTgstlx9cXRQ4/eS/8Q7HMOCYGNko4vl
         AYaOGBQOpWQwVX4Q8TeTa5R8C8OWMsQReWWt/LGSLsHNEIeJD+ROTaunO22tIsVq0IgS
         7i2toY7ZK/hH8RnO01/TljCShev5BBM30105cXoLIeQnNiNhIt8rURAVv028YziCOdvD
         t6uA==
X-Forwarded-Encrypted: i=1; AJvYcCXV0srTf9RWALKKOVu0QRK1aVBwnZm75hDLPZRX6+J/WCXrLOtkMFqr+qXDX8bb8YCYOMVw9k7X7kn+dT5j2BzZk7CtB0wWQbqSyV25
X-Gm-Message-State: AOJu0Ywght1Cy9VCLrZZUTR9blhmRsVj0nSY26ce2vT+2PZahdCysjGz
	mIwhMEKh4+kqlvTVoVCYX89IF6ZPr1YEdfnncegK8iqL4wvChEQZ
X-Google-Smtp-Source: AGHT+IFc8NisYizEOwGS51vMjf9HgMa6gMziJgQYK6WQXSlM7tU7tZ0BqCZv8yQArgnVcaI5E0okpg==
X-Received: by 2002:a05:6870:224a:b0:239:5419:bc74 with SMTP id j10-20020a056870224a00b002395419bc74mr2023347oaf.27.1714119110565;
        Fri, 26 Apr 2024 01:11:50 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id r10-20020a6560ca000000b005fd74e632f0sm8339769pgv.38.2024.04.26.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:11:50 -0700 (PDT)
Date: Fri, 26 Apr 2024 01:11:46 -0700
From: Dennis Zhou <dennisszhou@gmail.com>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, dennisszhou@gmail.com,
	shakeelb@google.com, jack@suse.cz, surenb@google.com,
	kent.overstreet@linux.dev, mhocko@suse.cz, vbabka@suse.cz,
	yuzhao@google.com, yu.ma@intel.com, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com
Subject: Re: [RFC PATCH v2 1/2] percpu_counter: introduce atomic mode for
 percpu_counter
Message-ID: <ZithwiPpjke2qbrv@snowbird>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-2-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418142008.2775308-2-zhangpeng362@huawei.com>

On Thu, Apr 18, 2024 at 10:20:07PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Depending on whether counters is NULL, we can support two modes:
> atomic mode and perpcu mode. We implement both modes by grouping
> the s64 count and atomic64_t count_atomic in a union. At the same time,
> we create the interface for adding and reading in atomic mode and for
> switching atomic mode to percpu mode.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/percpu_counter.h | 43 +++++++++++++++++++++++++++++++---
>  lib/percpu_counter.c           | 31 ++++++++++++++++++++++--
>  2 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 3a44dd1e33d2..160f9734c0bb 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -21,7 +21,13 @@
>  
>  struct percpu_counter {
>  	raw_spinlock_t lock;
> -	s64 count;
> +	/* Depending on whether counters is NULL, we can support two modes,
> +	 * atomic mode using count_atomic and perpcu mode using count.
> +	 */
> +	union {
> +		s64 count;
> +		atomic64_t count_atomic;
> +	};
>  #ifdef CONFIG_HOTPLUG_CPU
>  	struct list_head list;	/* All percpu_counters are on a list */
>  #endif
> @@ -32,14 +38,14 @@ extern int percpu_counter_batch;
>  
>  int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
>  			       gfp_t gfp, u32 nr_counters,
> -			       struct lock_class_key *key);
> +			       struct lock_class_key *key, bool switch_mode);

Nit: the lock_class_key at the end.
>  
>  #define percpu_counter_init_many(fbc, value, gfp, nr_counters)		\
>  	({								\
>  		static struct lock_class_key __key;			\
>  									\
>  		__percpu_counter_init_many(fbc, value, gfp, nr_counters,\
> -					   &__key);			\
> +					   &__key, false);		\
>  	})
>  
>  
> @@ -130,6 +136,20 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
>  	return (fbc->counters != NULL);
>  }
>  
> +static inline s64 percpu_counter_atomic_read(struct percpu_counter *fbc)
> +{
> +	return atomic64_read(&fbc->count_atomic);
> +}
> +
> +static inline void percpu_counter_atomic_add(struct percpu_counter *fbc,
> +					     s64 amount)
> +{
> +	atomic64_add(amount, &fbc->count_atomic);
> +}
> +
> +int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
> +				       u32 nr_counters);
> +
>  #else /* !CONFIG_SMP */
>  
>  struct percpu_counter {
> @@ -260,6 +280,23 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
>  static inline void percpu_counter_sync(struct percpu_counter *fbc)
>  {
>  }
> +
> +static inline s64 percpu_counter_atomic_read(struct percpu_counter *fbc)
> +{
> +	return fbc->count;
> +}
> +
> +static inline void percpu_counter_atomic_add(struct percpu_counter *fbc,
> +					     s64 amount)
> +{
> +	percpu_counter_add(fbc, amount);
> +}
> +
> +static inline int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
> +						     u32 nr_counters)
> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_SMP */
>  
>  static inline void percpu_counter_inc(struct percpu_counter *fbc)
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 44dd133594d4..95c4e038051a 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -153,7 +153,7 @@ EXPORT_SYMBOL(__percpu_counter_sum);
>  
>  int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
>  			       gfp_t gfp, u32 nr_counters,
> -			       struct lock_class_key *key)
> +			       struct lock_class_key *key, bool switch_mode)
>  {
>  	unsigned long flags __maybe_unused;
>  	size_t counter_size;
> @@ -174,7 +174,8 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
>  #ifdef CONFIG_HOTPLUG_CPU
>  		INIT_LIST_HEAD(&fbc[i].list);
>  #endif
> -		fbc[i].count = amount;
> +		if (likely(!switch_mode))
> +			fbc[i].count = amount;
>  		fbc[i].counters = (void *)counters + (i * counter_size);
>  
>  		debug_percpu_counter_activate(&fbc[i]);
> @@ -357,6 +358,32 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
>  	return good;
>  }
>  
> +/*
> + * percpu_counter_switch_to_pcpu_many: Converts struct percpu_counters from
> + * atomic mode to percpu mode.
> + */
> +int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
> +				       u32 nr_counters)
> +{
> +	static struct lock_class_key __key;

This is an improper use of lockdep. Now all of the percpu_counters
initialized on this path will key off of this lock_class_key.

> +	unsigned long flags;
> +	bool ret = 0;
> +
> +	if (percpu_counter_initialized(fbc))
> +		return 0;
> +
> +	preempt_disable();
> +	local_irq_save(flags);
> +	if (likely(!percpu_counter_initialized(fbc)))
> +		ret = __percpu_counter_init_many(fbc, 0,
> +					GFP_ATOMIC|__GFP_NOWARN|__GFP_ZERO,
> +					nr_counters, &__key, true);
> +	local_irq_restore(flags);
> +	preempt_enable();
> +
> +	return ret;
> +}

I'm staring at this API and I'm not in love with it. I think it hinges 
on that there's one user of mm_stats prior hence it's safe. Generically
though, I can't see why this is safe.

I need to give this a little more thought, but my gut reaction is I'd
rather this look like percpu_refcount where we can init dead minus the
percpu allocation. Maybe that's not quite right, but I'd feel better
about it than requiring external synchronization on a percpu_counter to
ensure that it's correct.

> +
>  static int __init percpu_counter_startup(void)
>  {
>  	int ret;
> -- 
> 2.25.1
> 

Thanks,
Dennis

