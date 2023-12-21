Return-Path: <linux-kernel+bounces-9102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89B81C078
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3540C286F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738FD7764A;
	Thu, 21 Dec 2023 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heiNHdew"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A276DB6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso12985ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703195447; x=1703800247; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7yfxJvsikJZhOKTjSLdY1JkJCkAjTZJo6HtEDGAXes=;
        b=heiNHdewuwzG0tUe/dRF5wofzriBYZ1Echhu2gQpsqiZybjrQEYYDA8QUxwonB71xf
         Y1G+kLY9h7U4C/taujP8CCKjXU/ZNWr/rfbvAJwASxEgBo6GGufvYUCiVb8Q0ZA/bGTj
         FPOeO6EIp9jP1CiJUYh5wniP0Q6On6edyehAF8h05G7eqaefgr0ZokGVfEce4Z1I1ybn
         bZpXYKRhnTU2HG17IoYqMdlP7PN1/h/G4pH1mdBhtox8Vm6XBBadk4VhL/gAvlILKYQZ
         x98ufoEHo397yIzl0K6lGOvTBfShelAUTPgMu7ql4Gf1oe7NxacLH8dQNoCHNjolB58n
         UkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195447; x=1703800247;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7yfxJvsikJZhOKTjSLdY1JkJCkAjTZJo6HtEDGAXes=;
        b=vwtpiHxc0mPWXBn6kqs1TKrMIdoC3gkcLCM+N0w2zevEzl3d0cQl0+m6ddWljzFJxS
         zJMXRY5UbwrNuL4kryam3WBFOK2I4T839wUuQEhvO3sItL0hxkp/EK0RJS8CGRy2lGQj
         dlHByMKDKuu34HlrP1qdFP1BWdPEDLYBAC6kQraJO2egEWSnyGhCjSRSZO/38odcsqp/
         /QsU2GnZwzZOrToSAvR7ih4/l6zVfXEa3kdZGNVzJcGzQM1w8+Q/R6/2XQiiYhkbGzeK
         Ww4bVjJ15fXscHxyFAGrKK+MYMcj5CwKd2+5z6n6oRcekz7ZsMtxt8XChoIR85PECptt
         9Cvw==
X-Gm-Message-State: AOJu0YzUSLY0neNreN+HxnW4HK47sLrmCKlz14q7j7306MSi6cvlmG9i
	Bnoau3U9RYD96PjbCEL+OpUhuImn7zXr
X-Google-Smtp-Source: AGHT+IH8TYaFbKwqTHpivSlxCp0sRH5qnfypD/tJasoimExGcqAbIjC4MsxNEHoSwa/ktrfqq/E/uA==
X-Received: by 2002:a17:903:2310:b0:1d3:ddf9:df92 with SMTP id d16-20020a170903231000b001d3ddf9df92mr7401plh.3.1703195446557;
        Thu, 21 Dec 2023 13:50:46 -0800 (PST)
Received: from [2620:0:1008:15:184:1476:510:6ea1] ([2620:0:1008:15:184:1476:510:6ea1])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902700600b001d0ca40158dsm2101132plk.280.2023.12.21.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:50:45 -0800 (PST)
Date: Thu, 21 Dec 2023 13:50:44 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ruipeng Qi <ruipengqi7@gmail.com>
cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    qiruipeng <qiruipeng@lixiang.com>
Subject: Re: [RFC PATCH 6/7] mm/slub: make slab data more observable
In-Reply-To: <20231221133717.882-1-ruipengqi7@gmail.com>
Message-ID: <9cb6a9a3-25fb-22ca-8b62-52c60519bee2@google.com>
References: <20231221133717.882-1-ruipengqi7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 21 Dec 2023, Ruipeng Qi wrote:

> From: qiruipeng <qiruipeng@lixiang.com>
> 
> Osdump is interested in data stored within slab subsystem. Add full list
> back into corresponding struct, and record full list within respective
> functions instead of enabling SLUB_DEBUG directly, which will intruduce
> sensible overhead.
> 
> Signed-off-by: qiruipeng <qiruipeng@lixiang.com>

Hi Ruipeng, please make sure to send your patch sets as a single email 
thread (all patches 1-7 should be a reply to your 0/7 cover letter).

There is some other feedback on previous patches in this series which 
refers to alternatives, so I think the cover letter to the patch series 
will need to spell out why we need a brand new solution to this.

That said, from the slab perspective, this is basically splitting out a 
part of SLUB_DEBUG into a single feature.  Likely best to propose it as a 
feature that SLUB_DEBUG would then directly enable itself rather than 
duplicating code in definitions.

That is, assuming the question about why we need a new solution for this 
can be resolved in the cover letter of a v2.

> ---
>  mm/slab.h |  2 ++
>  mm/slub.c | 38 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 3d07fb428393..a42a54c9c5de 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -799,6 +799,8 @@ struct kmem_cache_node {
>  	atomic_long_t nr_slabs;
>  	atomic_long_t total_objects;
>  	struct list_head full;
> +#elif defined(CONFIG_OS_MINIDUMP)
> +	struct list_head full;
>  #endif
>  #endif
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..1a496ec945b6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1730,10 +1730,26 @@ static inline int check_object(struct kmem_cache *s, struct slab *slab,
>  static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
>  static inline void set_track(struct kmem_cache *s, void *object,
>  			     enum track_item alloc, unsigned long addr) {}
> +#ifndef CONFIG_OS_MINIDUMP
>  static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
>  					struct slab *slab) {}
>  static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
>  					struct slab *slab) {}
> +#else
> +static inline void add_full(struct kmem_cache *s,
> +	struct kmem_cache_node *n, struct slab *slab)
> +{
> +	lockdep_assert_held(&n->list_lock);
> +	list_add(&slab->slab_list, &n->full);
> +}
> +
> +static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct slab *slab)
> +{
> +	lockdep_assert_held(&n->list_lock);
> +	list_del(&slab->slab_list);
> +}
> +#endif
> +
>  slab_flags_t kmem_cache_flags(unsigned int object_size,
>  	slab_flags_t flags, const char *name)
>  {
> @@ -2570,6 +2586,14 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  		spin_lock_irqsave(&n->list_lock, flags);
>  	} else {
>  		mode = M_FULL_NOLIST;
> +#ifdef CONFIG_OS_MINIDUMP
> +		/*
> +		 * Taking the spinlock removes the possibility that
> +		 * acquire_slab() will see a slab that is frozen
> +		 */
> +		spin_lock_irqsave(&n->list_lock, flags);
> +
> +#endif
>  	}
>  
>  
> @@ -2577,7 +2601,11 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  				old.freelist, old.counters,
>  				new.freelist, new.counters,
>  				"unfreezing slab")) {
> +#ifndef CONFIG_OS_MINIDUMP
>  		if (mode == M_PARTIAL)
> +#else
> +		if (mode != M_FREE)
> +#endif
>  			spin_unlock_irqrestore(&n->list_lock, flags);
>  		goto redo;
>  	}
> @@ -2592,6 +2620,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  		discard_slab(s, slab);
>  		stat(s, FREE_SLAB);
>  	} else if (mode == M_FULL_NOLIST) {
> +#ifdef CONFIG_OS_MINIDUMP
> +		add_full(s, n, slab);
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +#endif
>  		stat(s, DEACTIVATE_FULL);
>  	}
>  }
> @@ -4202,6 +4234,9 @@ init_kmem_cache_node(struct kmem_cache_node *n)
>  	atomic_long_set(&n->nr_slabs, 0);
>  	atomic_long_set(&n->total_objects, 0);
>  	INIT_LIST_HEAD(&n->full);
> +#elif defined(CONFIG_OS_MINIDUMP)
> +	INIT_LIST_HEAD(&n->full);
> +
>  #endif
>  }
>  
> @@ -5009,7 +5044,8 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
>  		list_for_each_entry(p, &n->partial, slab_list)
>  			p->slab_cache = s;
>  
> -#ifdef CONFIG_SLUB_DEBUG
> +#if defined(CONFIG_SLUB_DEBUG) || \
> +	defined(CONFIG_OS_MINIDUMP)
>  		list_for_each_entry(p, &n->full, slab_list)
>  			p->slab_cache = s;
>  #endif
> -- 
> 2.17.1
> 
> 

