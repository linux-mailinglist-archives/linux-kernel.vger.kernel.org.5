Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7857D7209
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjJYRGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjJYRGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:06:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D869137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:06:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9c145bb5bso5115ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698253610; x=1698858410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BLyhOS6DaA3Azb/y3i+aSNsSqvELymfgVFVzC4E2iU=;
        b=EmbYoF2cRtIaD4jboEb/NkjayqFcqtPyG7xJcY7OVPXgN48UyOyykCrIFvXIlaQJID
         KDzMW16DS8YHJ3BDA8DCn1rOJXue5JAAW8WkmzYWf2+1zzScR6E+C0CJDHp9w+if9B5U
         WEL8e7hn4PCGimiw7nEQHfvWnRReFatmNtkh/IPPEZI6pHolocrZ4bOU7xxLrFg5olkE
         ak/O77dadKD715EtH33j8/ZcPPXf1WZgk1sl2uc9nWkFObWlMDzGCzUmIG10tvgZE9dh
         aUzMxaOjtbdXN+KAFMZkptanURDD3V2Os135o2Q2B1fLqoakyBZymiO4Me03r+3Cmwt3
         kLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698253610; x=1698858410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BLyhOS6DaA3Azb/y3i+aSNsSqvELymfgVFVzC4E2iU=;
        b=sPu/mFlBUnf6/H4/X29l1I8PP7EI59EqoBN4eEu3JV1SG6jLizflrch85xXHCSxjZz
         YhjXYY29xlI1LZlQ0Gl8K0cgA5hIMKH59yNrRosflv/grWymmRjvF7T4uoPy+rGw/6MJ
         vRt8yUbEO+b/3mmgG/aKESeZr17hy/HcxFdAADgdiiDP4Eh8A6hxRD8yLosio2389PyJ
         OxIQCxtiZkjlH/WyefAAQcjpJko6qGD39PQ1XzfafB8YFnCFEt9Lj+AYLqSYYU0EmlTH
         w3enhDdDB4+si/+AvOgZ3Z/sTWIhmOaJxmyYnj9rLarBP5atl6nyKNqe3wQPsISFUFo1
         LFKg==
X-Gm-Message-State: AOJu0YyvjSIuQpNXghyGQcBJDmgHymFrBgwDqAAUstbfKxB1Cq79gi0d
        0aBGfGZHJhBB0P9tzHbKAk/VccZmPCZ7tjPXiT5wpA==
X-Google-Smtp-Source: AGHT+IHTm3Fl1nDGBKuyZQng/G9O2lKwSEtDCNTvLWku+yOpMLnEMFF3diKUa2ikj5TXXEN2m6Iuk1tLQYL8Awlf64s=
X-Received: by 2002:a17:903:144b:b0:1ca:42a:1773 with SMTP id
 lq11-20020a170903144b00b001ca042a1773mr241841plb.12.1698253609714; Wed, 25
 Oct 2023 10:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com> <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
 <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
 <ZTXLeAAI1chMamkU@feng-clx> <CAJD7tka5UnHBz=eX1LtynAjJ+O_oredMKBBL3kFNfG7PHjuMCw@mail.gmail.com>
 <CAJD7tkYXJ3vcGvteNH98tB_C7OTo718XSxL=mFsUa7kO8vzFzA@mail.gmail.com>
 <ZTdqpcDFVHhFwWMc@xsang-OptiPlex-9020> <CAJD7tka7hmOD6KPmJBJa+TscbYEMmTjS+Jh2utPfTbKkfvwD9A@mail.gmail.com>
 <ZTiw/iIb0SbvN7vh@xsang-OptiPlex-9020> <CAJD7tkaBnSwarz8yHu9RL_3DtaLRfjrcZ7m0YZZgHJsJdtHaZw@mail.gmail.com>
In-Reply-To: <CAJD7tkaBnSwarz8yHu9RL_3DtaLRfjrcZ7m0YZZgHJsJdtHaZw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 25 Oct 2023 10:06:37 -0700
Message-ID: <CALvZod5V-Ag5avAewE2nFp8__J6b_WqHuQw5=F70OPQrGNjfVw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Feng Tang <feng.tang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:23=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
[...]
>
> Thanks Oliver for running the numbers. If I understand correctly the
> will-it-scale.fallocate1 microbenchmark is the only one showing
> significant regression here, is this correct?
>
> In my runs, other more representative microbenchmarks benchmarks like
> netperf and will-it-scale.page_fault* show minimal regression. I would
> expect practical workloads to have high concurrency of page faults or
> networking, but maybe not fallocate/ftruncate.
>
> Oliver, in your experience, how often does such a regression in such a
> microbenchmark translate to a real regression that people care about?
> (or how often do people dismiss it?)
>
> I tried optimizing this further for the fallocate/ftruncate case but
> without luck. I even tried moving stats_updates into cgroup core
> (struct cgroup_rstat_cpu) to reuse the existing loop in
> cgroup_rstat_updated() -- but it somehow made it worse.
>
> On the other hand, we do have some machines in production running this
> series together with a previous optimization for non-hierarchical
> stats [1] on an older kernel, and we do see significant reduction in
> cpu time spent on reading the stats. Domenico did a similar experiment
> with only this series and reported similar results [2].
>
> Shakeel, Johannes, (and other memcg folks), I personally think the
> benefits here outweigh a regression in this particular benchmark, but
> I am obviously biased. What do you think?
>
> [1]https://lore.kernel.org/lkml/20230726153223.821757-2-yosryahmed@google=
.com/
> [2]https://lore.kernel.org/lkml/CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPY=
EL7nK77e2A@mail.gmail.com/

I still am not convinced of the benefits outweighing the regression
but I would not block this. So, let's do this, skip this open window,
get the patch series reviewed and hopefully we can work together on
fixing that regression and we can make an informed decision of
accepting the regression for this series for the next cycle.
