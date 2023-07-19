Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C0759A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjGSQAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGSQAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:00:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEFE10B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:00:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76571dae5feso649250885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689782401; x=1690387201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TG3Fx2HDwdT5VIY+8ksx4k9tVmfy9dSBQGuLdTbqwF4=;
        b=mzENXglN9Q0tsAvQBzRyiQ8JMHlq4nMJhcA42k9UQhKJ6cXQOxG3PQs/HCpvs0yF6B
         uPSoKk7J+lSOJfYbz8HA7ANMjT5r43X+BtMapGJtzctJ37DQKW9dMf6bGlAK/rJ4dIUP
         xDVRns5b0AYrtZpi3GNjO70AWXtIk6THB9xqAh2mTfZlBUjGS5znA2P3vFh8u284wOVr
         fFKjtbin+5nxq4vlGQuYCT8saLzPVM5ob+3Ovtw6KcaFdoxzNs3TeaMCmveNg4z35klH
         y3eNPO1V9pX3L8PfFrEWFMgcvsvEW0HbzzxPY+Bl4Q6tnaOhaVyD4yQlZ8ZwcTDR0gaZ
         Zgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689782401; x=1690387201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3Fx2HDwdT5VIY+8ksx4k9tVmfy9dSBQGuLdTbqwF4=;
        b=c6I0w/QtPNI/98QH1sPO9eAV68wTnz6/k7prTTtRYlk1BbM1jwhcpv7mojvGT8cCvh
         hfkrkmWXHdARLdLF325bZXxJhYRKuTPf7n48wtkC72lhtMgzh37YX1aS6eIGU29X09sP
         EFjXdun3/P1pTX0rKQicpOZFFzFjYvTL88ML+dcolkwXOinlDjXOBNBLq9iAG4ILAIlJ
         jZUKXcrCisvaemknhQPXUAR7+gwitxQ784BLv+M3xW+WUJ7i8a+QKOpLr51+v8gKnVEI
         k8n0GWJhZ6hx+0sltukZi+/9CC0OpSPWnV+rCVwHN9961OqUXAFzlA2CtTpeyyZHpSff
         v2jg==
X-Gm-Message-State: ABy/qLZnuD7PJznaUK2ElfzrYr8xz227I9cE4E7SDzZJqpvHHD9nMHWD
        9cB0fqVzSaUMdFWhEkYeZ2E=
X-Google-Smtp-Source: APBJJlHpInDfduRzB4c9Pct+WwqmoCj4DcJ8koNReOkFizQS6ZEshmNmZnG70VXy9ku3nCaYpexltw==
X-Received: by 2002:a0c:b21c:0:b0:63c:6d10:8659 with SMTP id x28-20020a0cb21c000000b0063c6d108659mr2911176qvd.46.1689782401242;
        Wed, 19 Jul 2023 09:00:01 -0700 (PDT)
Received: from localhost ([2607:fb90:c962:e4e:a95a:f227:cb36:2520])
        by smtp.gmail.com with ESMTPSA id fh9-20020a0562141a0900b006300ff90e71sm1533973qvb.122.2023.07.19.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:00:00 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:59:57 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Lu <aaron.lu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        rppt@kernel.org
Subject: Re: [RFC PATCH 2/4] sched/fair: Make tg->load_avg per node
Message-ID: <ZLgIIo/Q0UzA4ROr@yury-ThinkPad>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-3-aaron.lu@intel.com>
 <20230719115358.GB3529734@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719115358.GB3529734@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:53:58PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 18, 2023 at 09:41:18PM +0800, Aaron Lu wrote:
> > +#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
> > +static inline long tg_load_avg(struct task_group *tg)
> > +{
> > +	long load_avg = 0;
> > +	int i;
> > +
> > +	/*
> > +	 * The only path that can give us a root_task_group
> > +	 * here is from print_cfs_rq() thus unlikely.
> > +	 */
> > +	if (unlikely(tg == &root_task_group))
> > +		return 0;
> > +
> > +	for_each_node(i)
> > +		load_avg += atomic_long_read(&tg->node_info[i]->load_avg);
> > +
> > +	return load_avg;
> > +}
> > +#endif
> 
> So I was working on something else numa and noticed that for_each_node()
> (and most of the nodemask stuff) is quite moronic, afaict we should do
> something like the below.
> 
> I now see Mike added the nr_node_ids thing fairly recent, but given
> distros have NODES_SHIFT=10 and actual machines typically only have <=4
> nodes, this would save a factor of 256 scanning.
> 
> Specifically, your for_each_node() would scan the full 1024 bit bitmap
> looking for more bits that would never be there.
> 
> ---
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 8d07116caaf1..c23c0889b8cf 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -109,7 +109,7 @@ extern nodemask_t _unused_nodemask_arg_;
>  				__nodemask_pr_bits(maskp)
>  static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
>  {
> -	return m ? MAX_NUMNODES : 0;
> +	return m ? nr_node_ids : 0;
>  }
>  static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
>  {
> @@ -137,13 +137,13 @@ static inline void __node_clear(int node, volatile nodemask_t *dstp)
>  	clear_bit(node, dstp->bits);
>  }
>  
> -#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
> +#define nodes_setall(dst) __nodes_setall(&(dst), nr_node_ids)
>  static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
>  {
>  	bitmap_fill(dstp->bits, nbits);
>  }
>  
> -#define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
> +#define nodes_clear(dst) __nodes_clear(&(dst), nr_node_ids)
>  static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
>  {
>  	bitmap_zero(dstp->bits, nbits);
> @@ -160,7 +160,7 @@ static inline bool __node_test_and_set(int node, nodemask_t *addr)
>  }
>  
>  #define nodes_and(dst, src1, src2) \
> -			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_and(&(dst), &(src1), &(src2), nr_node_ids)
>  static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {

This would break small_const_nbits() optimization for those configuring
their kernels properly. This is very similar to cpumasks and nr_cpu_ids
problem.

See 596ff4a09b8 ("cpumask: re-introduce constant-sized cpumask optimizations")

Thanks,
Yury
