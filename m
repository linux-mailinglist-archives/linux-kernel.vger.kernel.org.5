Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7258784E11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjHWBOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHWBOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:14:48 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF4E59
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:14:36 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-570e88ee36aso1241254eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692753276; x=1693358076;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crWxE8XOEcCvVLdDxfeVx0+++iwdu7eHz9mdifeWTUk=;
        b=P6GEHetF/kKHFyRe0mUZSg7SdmhzPs46vBYIZhsIW/iOqsi81hjMj59eodVPDInTiS
         gcyP+ovHSs9riPzkL26OqY6gT8OBakvCb5jHCpOFEu9GNs0uo0SwFndMJX3NAUgQNfmp
         EtG0G/doO5uIT4CO68SLBTxeob29tWzlzkJrqDekXwUQru5heXYfJsxQSvIDDYH1n1dU
         oJ6IAbcDbv21/AUD5tduA79hm1TRBBiJ9bx126b2a7X668YqHaP5MN1y9ZC0A9Y92bul
         uzcNCpdG3+56TuLKQ6j+vAs3X4K/ZS7RrECDfzWsK3Kk6+emWMgtHUv7iNhU0g1JXJDR
         5J7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692753276; x=1693358076;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crWxE8XOEcCvVLdDxfeVx0+++iwdu7eHz9mdifeWTUk=;
        b=eSpTKP0FCruDOxciev0I2Xp9Pgd8XpaV9xv8wd6klKyn5ai8y6wHW19OB0O29EC5CT
         zZTQRzs4ZI8a+UTRcVe8WteSjhOaVJOZNhWS9rxVqTMgM/eiPxtqRfDxRKGceOFPX/NJ
         CxmQz+6GP5mFs5GbFg+AJJ0tFxWIDh+ajq7mk/UfWnY75eQIyZRY/81GFZUXNjP7pZAn
         pbyIUP3/XXYbWyUWAoJw396iEfpfplI+Rl7Qp0A6Jdp5UTP+jKMLWSvXnIKVy8DyMMJs
         KoAaWikQM148XMZJorNhYaf/aFICQbgEXoW8Quq+2jLUdq5l/2yTgYYo7WXEu+4KQPDi
         et6Q==
X-Gm-Message-State: AOJu0YwlyL1LKU7g9XnQ43g4EP5Jg0rERuOaW7u3hT+EabtHGKlQ2qXk
        FNBBIwc08wxvFWkhvJelx9rYHhoZoGZk/J0+cU0sjIEjuYU=
X-Google-Smtp-Source: AGHT+IEGOpp4iDxWPtESK4MPJRKZRNumCpbWWRQfzijm8v4Ib7IdbLo6M3zGWsWhkucbY4T61zR78xXloz+nt+nS1rA=
X-Received: by 2002:a4a:624c:0:b0:566:f8ee:fa67 with SMTP id
 y12-20020a4a624c000000b00566f8eefa67mr11236070oog.0.1692753276042; Tue, 22
 Aug 2023 18:14:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5797:0:b0:4f0:1250:dd51 with HTTP; Tue, 22 Aug 2023
 18:14:35 -0700 (PDT)
In-Reply-To: <20230822184152.2194558-2-mjguzik@gmail.com>
References: <20230822184152.2194558-1-mjguzik@gmail.com> <20230822184152.2194558-2-mjguzik@gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 23 Aug 2023 03:14:35 +0200
Message-ID: <CAGudoHE5iCbMzZ-N65RhQvdVygP7rcHKEqn90pif0M9DCZUm7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pcpcntr: add group allocation/free
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> Allocations and frees are globally serialized on the pcpu lock (and the
> CPU hotplug lock if enabled, which is the case on Debian).
>
> At least one frequent consumer allocates 4 back-to-back counters (and
> frees them in the same manner), exacerbating the problem.
>
> While this does not fully remedy scalability issues, it is a step
> towards that goal and provides immediate relief.
>

I just found I'm going to have to send a v3 to handle !CONFIG_SMP.
Temporarily I can't even compile-test that, so for now I'm just asking
if this v2 looks fine (modulo the !smp problem).

Sorry for the spam.

> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  include/linux/percpu_counter.h | 20 ++++++++---
>  lib/percpu_counter.c           | 61 +++++++++++++++++++++++-----------
>  2 files changed, 57 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/percpu_counter.h
> b/include/linux/percpu_counter.h
> index 75b73c83bc9d..518a4088b964 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -30,17 +30,27 @@ struct percpu_counter {
>
>  extern int percpu_counter_batch;
>
> -int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t
> gfp,
> -			  struct lock_class_key *key);
> +int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
> gfp_t gfp,
> +			  u32 nr_counters, struct lock_class_key *key);
>
> -#define percpu_counter_init(fbc, value, gfp)				\
> +#define percpu_counter_init_many(fbc, value, gfp, nr_counters)		\
>  	({								\
>  		static struct lock_class_key __key;			\
>  									\
> -		__percpu_counter_init(fbc, value, gfp, &__key);		\
> +		__percpu_counter_init_many(fbc, value, gfp, nr_counters,\
> +					   &__key);			\
>  	})
>
> -void percpu_counter_destroy(struct percpu_counter *fbc);
> +
> +#define percpu_counter_init(fbc, value, gfp)				\
> +	percpu_counter_init_many(fbc, value, gfp, 1)
> +
> +void percpu_counter_destroy_many(struct percpu_counter *fbc, u32
> nr_counters);
> +static inline void percpu_counter_destroy(struct percpu_counter *fbc)
> +{
> +	percpu_counter_destroy_many(fbc, 1);
> +}
> +
>  void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
>  void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
>  			      s32 batch);
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 5004463c4f9f..9338b27f1cdd 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -151,48 +151,71 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
>  }
>  EXPORT_SYMBOL(__percpu_counter_sum);
>
> -int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t
> gfp,
> -			  struct lock_class_key *key)
> +int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
> gfp_t gfp,
> +			  u32 nr_counters, struct lock_class_key *key)
>  {
>  	unsigned long flags __maybe_unused;
> -
> -	raw_spin_lock_init(&fbc->lock);
> -	lockdep_set_class(&fbc->lock, key);
> -	fbc->count = amount;
> -	fbc->counters = alloc_percpu_gfp(s32, gfp);
> -	if (!fbc->counters)
> +	size_t counter_size;
> +	s32 __percpu *counters;
> +	u32 i;
> +
> +	counter_size = ALIGN(sizeof(*counters), __alignof__(*counters));
> +	counters = __alloc_percpu_gfp(nr_counters * counter_size,
> +				      __alignof__(*counters), gfp);
> +	if (!counters) {
> +		fbc[0].counters = NULL;
>  		return -ENOMEM;
> +	}
>
> -	debug_percpu_counter_activate(fbc);
> +	for (i = 0; i < nr_counters; i++) {
> +		raw_spin_lock_init(&fbc[i].lock);
> +		lockdep_set_class(&fbc[i].lock, key);
> +#ifdef CONFIG_HOTPLUG_CPU
> +		INIT_LIST_HEAD(&fbc[i].list);
> +#endif
> +		fbc[i].count = amount;
> +		fbc[i].counters = (void *)counters + (i * counter_size);
> +
> +		debug_percpu_counter_activate(&fbc[i]);
> +	}
>
>  #ifdef CONFIG_HOTPLUG_CPU
> -	INIT_LIST_HEAD(&fbc->list);
>  	spin_lock_irqsave(&percpu_counters_lock, flags);
> -	list_add(&fbc->list, &percpu_counters);
> +	for (i = 0; i < nr_counters; i++)
> +		list_add(&fbc[i].list, &percpu_counters);
>  	spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
>  	return 0;
>  }
> -EXPORT_SYMBOL(__percpu_counter_init);
> +EXPORT_SYMBOL(__percpu_counter_init_many);
>
> -void percpu_counter_destroy(struct percpu_counter *fbc)
> +void percpu_counter_destroy_many(struct percpu_counter *fbc, u32
> nr_counters)
>  {
>  	unsigned long flags __maybe_unused;
> +	u32 i;
> +
> +	if (WARN_ON_ONCE(!fbc))
> +		return;
>
> -	if (!fbc->counters)
> +	if (!fbc[0].counters)
>  		return;
>
> -	debug_percpu_counter_deactivate(fbc);
> +	for (i = 0; i < nr_counters; i++)
> +		debug_percpu_counter_deactivate(&fbc[i]);
>
>  #ifdef CONFIG_HOTPLUG_CPU
>  	spin_lock_irqsave(&percpu_counters_lock, flags);
> -	list_del(&fbc->list);
> +	for (i = 0; i < nr_counters; i++)
> +		list_del(&fbc[i].list);
>  	spin_unlock_irqrestore(&percpu_counters_lock, flags);
>  #endif
> -	free_percpu(fbc->counters);
> -	fbc->counters = NULL;
> +
> +	free_percpu(fbc[0].counters);
> +
> +	for (i = 0; i < nr_counters; i++)
> +		fbc[i].counters = NULL;
>  }
> -EXPORT_SYMBOL(percpu_counter_destroy);
> +EXPORT_SYMBOL(percpu_counter_destroy_many);
>
>  int percpu_counter_batch __read_mostly = 32;
>  EXPORT_SYMBOL(percpu_counter_batch);
> --
> 2.39.2
>
>


-- 
Mateusz Guzik <mjguzik gmail.com>
