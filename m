Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739BC7AC779
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjIXKMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjIXKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:12:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045A103
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:12:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so5390147a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695550358; x=1696155158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7EbfklJOHAT6VS7URBc22mn46gMxt5c5h+c3ThYaKM=;
        b=JOJMuFqUhQsWNAZM10UFZvFtn0csLO9d5CkBsCEJhGcCoCrgCHzaSqSiYwBh5t2+WK
         ZZoCB6Npcl1e5w7E8hPPUD93XoEWjt8i057/6EIkAsu991khu/gGPmXXGAp+n0dff1bU
         2eGEFoBjliMyhIFrzT+OzuWi1RJpex6OI7pxrJwsrRfkoHIZ5lerlUT4+lMje4M+cBpD
         z+zTmgwYi2nru42nARj/xRmR8e7UgGe2nk9q72FTWy1pY31WcDTFJgVHJ8vT3Ty/zJNH
         J9uH7sBbsGeNBo0EzQJLexm4+g2/Zdtu7sDw5KOl2ZvURwmAGRYKtzcriM+192tH7bs/
         CC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695550358; x=1696155158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7EbfklJOHAT6VS7URBc22mn46gMxt5c5h+c3ThYaKM=;
        b=RHpwHFxeLGRNRjtKVid3cWtEikCvJg6bpqHPKqaMJ6wTOaUd2RdHQIiREi/tNxcyxF
         u23Q7Siz8TJHcYKW9ZILZ+N7JNjEl2QL9nNgxiId/4jj0jUs4t6OzVFGftgshdZkueWj
         AcgDO72yW1qtVe11RjcqbaUzHokMk7jkylz+47eHvjhYc+8k64M8SLmx46cymC3k0BZa
         EdGO1cagRmAUrxSTpw7dkFnOqqa0H0OGZfXPHPtjZ4e5vw6j39Y88Wzj23A1J66qpB1L
         oJ/kQRXXni2OPUPsP6mwUUHeUMDqvtLW4RbK/XkFe+GHoB2zAgT538XyFvDie52e9Qxf
         GqEg==
X-Gm-Message-State: AOJu0Ywy6ZiWsZxZN+hBzW9LYefwHWyCGjk88ffER6ta6EJ3sOpLlABd
        s7izR48/qUmU3y5+92L4V2s=
X-Google-Smtp-Source: AGHT+IF3PmcZt4kv2o+Q3Yd3fALXDc9uC5KIzQsSjojwDPgLiBi8R8+3spUVVXMMM/y945xIiTbmgQ==
X-Received: by 2002:a17:906:2d4:b0:9a2:143e:a071 with SMTP id 20-20020a17090602d400b009a2143ea071mr3799973ejk.17.1695550357787;
        Sun, 24 Sep 2023 03:12:37 -0700 (PDT)
Received: from gmail.com (195-38-113-94.pool.digikabel.hu. [195.38.113.94])
        by smtp.gmail.com with ESMTPSA id sd6-20020a170906ce2600b0098e34446464sm4892349ejb.25.2023.09.24.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 03:12:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 24 Sep 2023 12:12:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched: fix warning in bandwidth distribution
Message-ID: <ZRALk+fMpW5895fF@gmail.com>
References: <20230922230535.296350-1-joshdon@google.com>
 <20230922230535.296350-2-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922230535.296350-2-joshdon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Don <joshdon@google.com> wrote:

> We've observed the following warning being hit in
> distribute_cfs_runtime():
> 	SCHED_WARN_ON(cfs_rq->runtime_remaining > 0)
> 
> We have the following race:
> 
> - cpu0: running bandwidth distribution (distribute_cfs_runtime).
>   Inspects the local cfs_rq and makes its runtime_remaining positive.
>   However, we defer unthrottling the local cfs_rq until after
>   considering all remote cfs_rq's.
> - cpu1: starts running bandwidth distribution from the slack timer. When
>   it finds the cfs_rq for cpu 0 on the throttled list, it observers the
>   that the cfs_rq is throttled, yet is not on the CSD list, and has a
>   positive runtime_remaining, thus triggering the warning in
>   distribute_cfs_runtime.
> 
> To fix this, we can rework the local unthrottling logic to put the local
> cfs_rq on a local list, so that any future bandwidth distributions will
> realize that the cfs_rq is about to be unthrottled.
> 
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8f4e63fc8900..de002dab28cf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5743,13 +5743,13 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
>  
>  static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>  {
> -	struct cfs_rq *local_unthrottle = NULL;
>  	int this_cpu = smp_processor_id();
>  	u64 runtime, remaining = 1;
>  	bool throttled = false;
> -	struct cfs_rq *cfs_rq;
> +	struct cfs_rq *cfs_rq, *tmp;
>  	struct rq_flags rf;
>  	struct rq *rq;
> +	LIST_HEAD(local_unthrottle);
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
> @@ -5784,11 +5784,17 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>  
>  		/* we check whether we're throttled above */
>  		if (cfs_rq->runtime_remaining > 0) {
> -			if (cpu_of(rq) != this_cpu ||
> -			    SCHED_WARN_ON(local_unthrottle))
> +			if (cpu_of(rq) != this_cpu) {
>  				unthrottle_cfs_rq_async(cfs_rq);
> -			else
> -				local_unthrottle = cfs_rq;
> +			} else {
> +				/*
> +				 * We currently only expect to be unthrottling
> +				 * a single cfs_rq locally.
> +				 */
> +				SCHED_WARN_ON(!list_empty(&local_unthrottle));
> +				list_add_tail(&cfs_rq->throttled_csd_list,
> +					      &local_unthrottle);
> +			}
>  		} else {
>  			throttled = true;
>  		}
> @@ -5796,15 +5802,23 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>  next:
>  		rq_unlock_irqrestore(rq, &rf);
>  	}
> -	rcu_read_unlock();
>  
> -	if (local_unthrottle) {
> -		rq = cpu_rq(this_cpu);
> +	list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
> +				 throttled_csd_list) {
> +		struct rq *rq = rq_of(cfs_rq);
> +
>  		rq_lock_irqsave(rq, &rf);
> -		if (cfs_rq_throttled(local_unthrottle))
> -			unthrottle_cfs_rq(local_unthrottle);
> +
> +		list_del_init(&cfs_rq->throttled_csd_list);
> +
> +		if (cfs_rq_throttled(cfs_rq))
> +			unthrottle_cfs_rq(cfs_rq);
> +
>  		rq_unlock_irqrestore(rq, &rf);
>  	}
> +	SCHED_WARN_ON(!list_empty(&local_unthrottle));
> +
> +	rcu_read_unlock();

Thanks, this looks much cleaner.

When the warning hits, we don't have any other side-effects,
such as bad behavior or data corruption, correct?

Under that assumption I've queued your fix in tip:sched/core,
for a v6.7 merge, and not in tip:sched/urgent for a v6.6 merge,
but let me know if I'm reading the code wrong...

Thanks,

	Ingo
