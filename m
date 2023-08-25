Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919F97885C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbjHYLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbjHYLcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:32:04 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20089211E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:31:48 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bcade59b24so614622a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692963104; x=1693567904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMuG3+5wnp6MIFCRUgkS+PGVmcZqLz7qWs+Xkt9OeGc=;
        b=r7wL2+JLsI7N6ZT9DovW8tkHDLD3Cth/CBCFdZJis91xtXgijpPP1AqS/UrWEWpJlr
         gZbW3ok8pj3EUNuGH9EC38s0V2WjdL3tPXTI9ZPZQc32Kz4OA7h3Dy8UdBQkbUY37Ejp
         7bdRy+tFCNBkOqED1A7Uk0tCfhX/gpfGbvXmuzSStHfvhj9nmZrcWzn0b57k5sV5j6uj
         VnU6K3T7T4MAcM5AGlQSJSyv3vqzdRusJ2muwYjYahrInyBbBtTLgReMH/Cy2JiSAVxM
         4ogTSyJWvoYFoBB8dkHcz/OBrH80ftrnTAwKGN5pJZ9UoOPdbDNbE4U1clwdiwWGuIJv
         T1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692963104; x=1693567904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMuG3+5wnp6MIFCRUgkS+PGVmcZqLz7qWs+Xkt9OeGc=;
        b=OUdXs0/tujo1ciKsjoGSJLn6U+yHJD3HRwIigPC58KS8Bikt9boRnekF1IlD3iQJ6n
         XhN7nRgx1wORD2G5nKCIAt8+jVaRblPVFHX500HFo90w7iBRZ50h7zOfzdIWu+p10ADI
         xcgS59irR/1K4Dzs7Q9BEEXmOLhQawFyRzt+YNhCVYBtsp2qpEUEP63NwuRZAZl3Yax2
         vrbZldBgZ6Qpo7WOjRBqw+/rUlRC6R7mK4ifhQiQixpiEegvhbyL3QUAEN0a7AUXLNnh
         8p0E9GbgOvRiZ5b3mBVRYvcfHzFzzMgxkBDbLKNsUVwtrcF2Uj0PhdgxEf0vECJfog9P
         9EbQ==
X-Gm-Message-State: AOJu0YyJI5IRC1hm+nXcU185FNdpXieLsFiiOAAfinXb/6YAR5Oyoar6
        I+6FGnvTntK8IuQ6QfX9uZLtN68RXKM=
X-Google-Smtp-Source: AGHT+IGvvPw+emvnNMcdiA4jwZOkjyIfI9fgwNBTnCMIaSSu4+BL2N7tvQjvISlfJCTwMgIZfduAbA==
X-Received: by 2002:a05:6830:614:b0:6bd:844:69d5 with SMTP id w20-20020a056830061400b006bd084469d5mr5322051oti.4.1692963104018;
        Fri, 25 Aug 2023 04:31:44 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:f0e0:f41c:263f:97b3])
        by smtp.gmail.com with ESMTPSA id h8-20020a9d6408000000b006b96a4287d4sm733501otl.5.2023.08.25.04.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:31:43 -0700 (PDT)
Date:   Fri, 25 Aug 2023 04:31:40 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 0/6] sched fixes
Message-ID: <ZOiRHPvVfB8Q7TLv@yury-ThinkPad>
References: <20230819141239.287290-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819141239.287290-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Sat, Aug 19, 2023 at 07:12:32AM -0700, Yury Norov wrote:
> Fixes for recently introduced sched_numa_find_nth_cpu(), and minor
> improvements in sched/fair.
> 
> v1: https://lore.kernel.org/lkml/20230810162442.9863-1-yury.norov@gmail.com/T/
> v2:
>  - fix wording in commit messages;
>  - move nearest node search inside rcu lock section in
>    sched_numa_find_nth_cpu();
>  - move NUMA_NO_NODE handling inside sched_numa_find_nth_cpu();
>  - rewrite comment for sched_numa_find_nth_cpu().
>  - add review tag from Yicong Yang.
> 
> Yury Norov (6):
>   numa: generalize numa_map_to_online_node()
>   sched/fair: fix opencoded numa_nearest_node()
>   sched: fix sched_numa_find_nth_cpu() in CPU-less case
>   sched: fix sched_numa_find_nth_cpu() in non-NUMA case
>   sched: handle NUMA_NO_NODE in sched_numa_find_nth_cpu()
>   sched: fix sched_numa_find_nth_cpu() comment
> 
>  include/linux/numa.h     |  7 +++++--
>  include/linux/topology.h |  2 +-
>  kernel/sched/fair.c      | 14 +-------------
>  kernel/sched/topology.c  | 25 +++++++++++++++++--------
>  lib/cpumask.c            |  4 +---
>  mm/mempolicy.c           | 18 +++++++++++-------
>  6 files changed, 36 insertions(+), 34 deletions(-)
> 
> -- 
> 2.39.2
