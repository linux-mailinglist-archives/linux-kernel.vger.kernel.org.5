Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B310783B35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjHVHyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjHVHyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:54:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C012C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:54:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68781a69befso727251b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692690876; x=1693295676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4jgfORi8SmWQDQbZiOec8xn7xqyqjppzAhLAq8G/jM=;
        b=SOneL3NtXO9oBFlq98JcoX4t3EnesJboldSnWumz5DiUkBnpG7CqEL1eKt5K9rqcA2
         U3RRuLkwT/GCIUVInlzMYcDj50xv/uxs2qyBQzzhPTYMtkXg2PqKFlKcIAWegMjhGkJZ
         +fKZaiHC6mfcqYHxcipesaABAxYak2/MZ+QrJr3V6cvvZyagkXZ1QARSjdPbn3ezO8GR
         DM/xTyQvFqdpZfQWlB4kjX8ZI5jxXRK08bUzQm7S1Pr0J54SUbds0ZKp7eHCmdt5Dn0n
         NGugvmaAkNnFAW1NpNnaUcyir+eJIXKp9n7vk7+IuTaAiuOSGyKdmnu+jJCHneFWcinO
         cGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692690876; x=1693295676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4jgfORi8SmWQDQbZiOec8xn7xqyqjppzAhLAq8G/jM=;
        b=GynZRGUzVKuHje/+Pu/n8UF9nZZDkUlHyUoNJZyst76kcX5jMAwn8wtqABrhFDt1EI
         1pJyyQW8A4CrXzyDNVcxP+0GBhygFEw3ZeVxU60BmV2vOJ35VL5QCFxSQ0ShM+z7WIPe
         HM2f+YQRSlIDjZtfWTX4aP9/9GH0jkkBPFDmUdYcYGoShbUXlwZcVUrk8uG10N1VAnjJ
         DaB0BkyOL8hPkCD7667F+xpWWk+ECoqZr8yMJTuwAu5wVvzfua2U55PZmb4fu9nXLk++
         4WEMQuAF4kg4wNpVvUPNxW4hi1Q5nDf3+tZH4PA0Wn/my7llCO1RLvDr8QA7s0XrYYqu
         2Krw==
X-Gm-Message-State: AOJu0YwsdHxX2H1CAqLEK0i2p1aSMRwWC40fkUZYq1HaZQAPd82IvCYx
        /m3KKtCf6SMqCudSioMNSWtteA==
X-Google-Smtp-Source: AGHT+IGcQ/Vaoo9QWtXIDxo0cmgc5wb+yjqs29/LxRS2cKLFil77dp/RF48DaAlmNeNv2ExX4nw11A==
X-Received: by 2002:a05:6a21:788a:b0:13a:3649:dc1a with SMTP id bf10-20020a056a21788a00b0013a3649dc1amr12492491pzc.0.1692690875899;
        Tue, 22 Aug 2023 00:54:35 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001bbdd44bbb6sm8506831plb.136.2023.08.22.00.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 00:54:35 -0700 (PDT)
Message-ID: <c6f933ee-751f-def1-31f6-0940e2ee0108@bytedance.com>
Date:   Tue, 22 Aug 2023 15:54:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/5] use refcount+RCU method to implement lockless slab
 shrink (part 1)
Content-Language: en-US
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230817112402.77010-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230817112402.77010-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/17 19:23, Qi Zheng wrote:
> Hi all,
> 
> To make reviewing and updating easier, I've chosen to split the previous
> patchset[1] into the following three parts:
> 
> part 1: some cleanups and preparations
> part 2: introduce new APIs and convert all shrinnkers to use these
> part 3: implement lockless slab shrink
> 
> This series is the part 1 and is based on the next-20230815.
> 
> Comments and suggestions are welcome.
> 
> [1]. https://lore.kernel.org/lkml/20230807110936.21819-1-zhengqi.arch@bytedance.com/
> 
> Thanks,
> Qi
> 
> Changlog in part 1 v1 -> part 1 v2:
>   - fix compilation warning in [PATCH 1/5]
>   - rename synchronize_shrinkers() to ttm_pool_synchronize_shrinkers()
>     (pointed by Christian König)
>   - collect Reviewed-by
> 
> Changlog in v4 -> part 1 v1:
>   - split from the previous large patchset
>   - fix comment format in [PATCH v4 01/48] (pointed by Muchun Song)
>   - change to use kzalloc_node() and fix typo in [PATCH v4 44/48]
>     (pointed by Dave Chinner)
>   - collect Reviewed-bys
>   - rebase onto the next-20230815

Hi all,

Any more comments and suggestions for this part 1? Or can this part
be merged first (just some cleanups and preparations)? Or should I
post the part 2 and part 3 first for everyone to review together?

Either one is fine for me. :)

Thanks,
Qi

> 
> Qi Zheng (5):
>    mm: move some shrinker-related function declarations to mm/internal.h
>    mm: vmscan: move shrinker-related code into a separate file
>    mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
>    drm/ttm: introduce pool_shrink_rwsem
>    mm: shrinker: add a secondary array for shrinker_info::{map,
>      nr_deferred}
> 
>   drivers/gpu/drm/ttm/ttm_pool.c |  17 +-
>   include/linux/memcontrol.h     |  12 +-
>   include/linux/shrinker.h       |  37 +-
>   mm/Makefile                    |   4 +-
>   mm/internal.h                  |  28 ++
>   mm/shrinker.c                  | 751 +++++++++++++++++++++++++++++++++
>   mm/shrinker_debug.c            |  18 +-
>   mm/vmscan.c                    | 701 ------------------------------
>   8 files changed, 818 insertions(+), 750 deletions(-)
>   create mode 100644 mm/shrinker.c
> 
