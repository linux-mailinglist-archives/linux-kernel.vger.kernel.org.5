Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2727F889F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 07:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjKYGgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 01:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYGgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 01:36:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69470D62
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 22:36:18 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so2407134b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 22:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700894178; x=1701498978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHiMIvLDO2ZbTxHRaxuFBOG4CVORHQwJmWn9Lh3DRLs=;
        b=hR1VHQh+B4bHUwzPilr4XxlN1jPBOpi/tShwGHkhRZNu5q4086Mc5pJ7wKyv2ldl7v
         SBNmriM4yynuxrr1rmUOk/nbK6oVb/u7TqVHOt+umPopvmm9o7n+PChBZx9LGE9EVPRR
         8XmnckfqHBT2QCVk0CKNHoQXrMjOOhNTR67/hWs9wB49/wlMaAhaHqD5i8jsy9yTY044
         rsJRazZpjy6H4tLpyAGRbqzwp7XWOH2rqnAwpFP7bt/wdjMJ67c5f1lvVfeY+MhMdAN1
         J5U75TwJWJl9wgZKxKFu8x7ptUz3+Y+TN0vw9jh+lC/dh6jVTtN1AyrBjazQIe/v0sTe
         n9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700894178; x=1701498978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHiMIvLDO2ZbTxHRaxuFBOG4CVORHQwJmWn9Lh3DRLs=;
        b=r5OrSgsmxQBrMMW+UHWjvJWeKxhQB8FcGDjKBxuNa3Jz9WhbrFtVqJRgaDbLckLxir
         muXGvJ33q0lP3E/2pmbak1lQTzNbni0C/MIXcWw36yBHr2EGAoxm1sQk4EWPEZ0hnC9O
         LsFE4BdgqDEwC8/72noC33E4E7kOWw93ZGXzrUupUXcb7h+dkJVgtkY+H+Rq5HVFOQYj
         5nuD45Vp4vFnCzmTGJMNXansaW/5131CpcFOYLY7ULdPeSyWKmjaF0P/8kCjMUYhifoX
         UiWgN+TlVf0134AkCPQjVJUO2Vwbp51nn1fm1Ywo7lJV+E1c4Fbe47U/ybPRUsK63pHY
         A0lA==
X-Gm-Message-State: AOJu0YxUBNsZUnQnph4uY8CQUYMmjFV05rQGcT1GHCqGztReUX2Y77U4
        jXkhyh+RCgW59mxSk+wz96WQuqNsiRjAZw==
X-Google-Smtp-Source: AGHT+IFEMYx3CqBGnCWlwYY4bVdXcUnsPkqsCWtL/TYoIO2IX3aE391QWTtWkOI6qF6uKFt1r3x4l95P4Fjhsw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:8911:b0:68e:3053:14b9 with SMTP
 id hw17-20020a056a00891100b0068e305314b9mr1864932pfb.2.1700894177861; Fri, 24
 Nov 2023 22:36:17 -0800 (PST)
Date:   Sat, 25 Nov 2023 06:36:16 +0000
In-Reply-To: <20231123193937.11628-3-ddrokosov@salutedevices.com>
Mime-Version: 1.0
References: <20231123193937.11628-1-ddrokosov@salutedevices.com> <20231123193937.11628-3-ddrokosov@salutedevices.com>
Message-ID: <20231125063616.dex3kh3ea43ceyu3@google.com>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace shrink_memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        mhocko@suse.com, akpm@linux-foundation.org, kernel@sberdevices.ru,
        rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:39:37PM +0300, Dmitry Rokosov wrote:
> The shrink_memcg flow plays a crucial role in memcg reclamation.
> Currently, it is not possible to trace this point from non-direct
> reclaim paths. However, direct reclaim has its own tracepoint, so there
> is no issue there. In certain cases, when debugging memcg pressure,
> developers may need to identify all potential requests for memcg
> reclamation including kswapd(). The patchset introduces the tracepoints
> mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> 
> Example of output in the kswapd context (non-direct reclaim):
>     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
>     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
>     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
>     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
>     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
>     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  include/trace/events/vmscan.h | 22 ++++++++++++++++++++++
>  mm/vmscan.c                   |  7 +++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index e9093fa1c924..a4686afe571d 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -180,6 +180,17 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_softlimit_r
>  	TP_ARGS(order, gfp_flags, memcg)
>  );
>  
> +DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_shrink_begin,
> +
> +	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
> +
> +	TP_ARGS(order, gfp_flags, memcg)
> +);
> +
> +#else
> +
> +#define trace_mm_vmscan_memcg_shrink_begin(...)
> +
>  #endif /* CONFIG_MEMCG */
>  
>  DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
> @@ -243,6 +254,17 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_softlimit_rec
>  	TP_ARGS(nr_reclaimed, memcg)
>  );
>  
> +DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_shrink_end,
> +
> +	TP_PROTO(unsigned long nr_reclaimed, const struct mem_cgroup *memcg),
> +
> +	TP_ARGS(nr_reclaimed, memcg)
> +);
> +
> +#else
> +
> +#define trace_mm_vmscan_memcg_shrink_end(...)
> +
>  #endif /* CONFIG_MEMCG */
>  
>  TRACE_EVENT(mm_shrink_slab_start,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 45780952f4b5..f7e3ddc5a7ad 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6461,6 +6461,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  		 */
>  		cond_resched();
>  
> +		trace_mm_vmscan_memcg_shrink_begin(sc->order,
> +						   sc->gfp_mask,
> +						   memcg);
> +

If you place the start of the trace here, you may have only the begin
trace for memcgs whose usage are below their min or low limits. Is that
fine? Otherwise you can put it just before shrink_lruvec() call.

>  		mem_cgroup_calculate_protection(target_memcg, memcg);
>  
>  		if (mem_cgroup_below_min(target_memcg, memcg)) {
> @@ -6491,6 +6495,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>  			    sc->priority);
>  
> +		trace_mm_vmscan_memcg_shrink_end(sc->nr_reclaimed - reclaimed,
> +						 memcg);
> +
>  		/* Record the group's reclaim efficiency */
>  		if (!sc->proactive)
>  			vmpressure(sc->gfp_mask, memcg, false,
> -- 
> 2.36.0
> 
