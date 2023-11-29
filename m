Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E020E7FDB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjK2PZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjK2PZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:05 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5CD6E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:11 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-423a459d616so24912421cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701271511; x=1701876311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ggscuLXdkbtAnynY3GdTzeA07chUPA8WGR1vy9vM7w=;
        b=cH3ZXWk2/oyUnIX75QcNokzfI3D4H2OzhpG16aUIyRI1ilDvEcXdf02UICEXQNmIUI
         FWxTLLy3hDpaNy+ClQPKo1xMP3VkQolaiKPK5mRLtzfT9fTtgk1fGwBlymMihVNujVN2
         nrNVvRotEGDL9/Cpf/fpIa+FVp0Xd1Vfo2Fzm7256RPvBmK2cX8AIYD2XZBx0bmWLlfD
         pZsE2fBA7lh/epk+zywODUzH0FQELz/sMfnyICM5RuebgTeIB0xeIGB61JJttvJ/y6V9
         SQL+AqIZNS/aWObRe9LZONObWrppjFF91e3V+kMNWvpzrOL3uobeg7BCzbxO9OACqYJm
         toXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271511; x=1701876311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ggscuLXdkbtAnynY3GdTzeA07chUPA8WGR1vy9vM7w=;
        b=HcBidEqnfTxdtghh5aU2pR9ICBcIAeWlSqB/wy2Rci8GiOnGMs8jBBrN7B2Qq8K5vt
         UfFCi78lMtgcuge8Zg7O/37nWP2yHsa5XbYY5ulJD6g5x33VQhXIVA/3zVN6TbveaFYY
         fy/gn4yHCdSMVgNAMMnM3+muDzd/ru1XoJaNfZYL7S1FhH0aVjuF0+4Mt4RLE0APd2Hd
         /XLD8xvwSnG4fg4tQC4DIQQlJQSSduffnktOKvEfVM0Pt0vzu9smBa2NbubYzU07qq7M
         DeYts1ygxBe+VzvnrfpP/XU7Ma/vT+CYUYSZbyuUO7qKeN6Fung15t+pwdntXKsN2RT/
         7jaQ==
X-Gm-Message-State: AOJu0YyS5HA4Om00GYzTVTMaR4kJ3dDyWIqoF3nqQ8/7S3qTxaIm2es4
        Jj/HvjaVgm8C6CXSqtGka998/w==
X-Google-Smtp-Source: AGHT+IERC5rUROsi60YXkNf8/r1k/+JDGDC0OGY/HyxD3a7Iu2Iwryw3L5ZWy48uExK2aTbpmhx8CQ==
X-Received: by 2002:ac8:60b:0:b0:423:b632:eaea with SMTP id d11-20020ac8060b000000b00423b632eaeamr11778830qth.8.1701271510969;
        Wed, 29 Nov 2023 07:25:10 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id t22-20020ac86a16000000b004196d75d79csm5633606qtr.46.2023.11.29.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:25:10 -0800 (PST)
Date:   Wed, 29 Nov 2023 10:25:09 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 4/6] mm: memcg: add per-memcg zswap writeback stat
Message-ID: <20231129152509.GD135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:45:58PM -0800, Nhat Pham wrote:
> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> 
> Since zswap now writes back pages from memcg-specific LRUs, we now need a
> new stat to show writebacks count for each memcg.
> 
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/vm_event_item.h | 1 +
>  mm/memcontrol.c               | 1 +
>  mm/vmstat.c                   | 1 +
>  mm/zswap.c                    | 3 +++
>  4 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index d1b847502f09..f4569ad98edf 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -142,6 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_ZSWAP
>  		ZSWPIN,
>  		ZSWPOUT,
> +		ZSWP_WB,
>  #endif
>  #ifdef CONFIG_X86
>  		DIRECT_MAP_LEVEL2_SPLIT,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c0f3f971179..f88c8fd03689 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -703,6 +703,7 @@ static const unsigned int memcg_vm_event_stat[] = {
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>  	ZSWPIN,
>  	ZSWPOUT,
> +	ZSWP_WB,
>  #endif
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	THP_FAULT_ALLOC,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index afa5a38fcc9c..2249f85e4a87 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1401,6 +1401,7 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_ZSWAP
>  	"zswpin",
>  	"zswpout",
> +	"zswp_wb",

ZSWPWB and "zswpwb" would match the existing naming scheme a bit
better.

>  #endif
>  #ifdef CONFIG_X86
>  	"direct_map_level2_splits",
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 5e397fc1f375..6a761753f979 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -754,6 +754,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>  	}
>  	zswap_written_back_pages++;
>  
> +	if (entry->objcg)
> +		count_objcg_event(entry->objcg, ZSWP_WB);
> +

You need to call count_vm_event() as well, otherwise the /proc/vmstat
counter will stay zero.
