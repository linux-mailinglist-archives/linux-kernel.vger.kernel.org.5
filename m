Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE827628B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGZCUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjGZCUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:20:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5170211F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:20:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5221f3affe4so4768430a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690338039; x=1690942839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8i3sOYpsPz/5z4EGZvbSWnvU6I/qPCguplntjXR3Gg=;
        b=zX/ucMGvp64UIN2TBRjHmtg4M1ZyQus/V7XJMJabp2TI34u8ATIOzuXKNEbYJ4Kq/U
         BAKXhx0djH/AEVYojD9/E4xeO9cMvEt4Q7FJdKvT/iBZvjqMfcCHxyLLyXzoN1kfmn4y
         +WGwrX73lXIInJs01RyhmihamNPtRWXfO6l/9EqNC7Bn9C7HpLP6V0FecaFlvFhFMg1G
         TwvkTuXVRcGhPlxOZWecmoB+yoxr1xdd3xW1gu0iQ7xZm8D4YKSmaEReUGBk8cK4mHc9
         zFsF57XxKoiFxStRGmlWBI1QeUWI0d0uElU3pVrr/lweOwaFdKbRTCg0PV9S8jpXHqy/
         wbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690338039; x=1690942839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8i3sOYpsPz/5z4EGZvbSWnvU6I/qPCguplntjXR3Gg=;
        b=gVn4dnS3/6cAoitZoOG1Tsj9YKxs3OZ8eeQJDA/t/NgwzoxiyFuvZw+Y1Mw3vGQFb0
         +3L9haRou/YGRLytClsgpy996y4p2O/FbTGbBlZ9wCepfZDyfSiHMXrj8/zMsWAKCs9R
         cYRtyppY6btu4QFhwcLNEcVgXsLWSt6A4DsPHvfth5BRa/6A5160QONSy1VGfz435VrY
         JykWdBh2zkv7YF2/3rWaja9A8L7AKZI2BlCbSN18DB2eqQnM81ij397ka2NBxaR/QeiJ
         +3ewz3E4mcUhVt/BigHdzSJz9bOCWc/sIoVtI7qkNv4axPqrOlA8F62aayMsotWmciBC
         3okQ==
X-Gm-Message-State: ABy/qLZn+dMLXA8D45mZlbVZJnAsTddAnq7VCDwvHNrjg2YjziiwSkYN
        rxtTsDubxAWZEj8AYgnKNEqys4eE/oLo+Kjzml9kBw==
X-Google-Smtp-Source: APBJJlEQuwhLPIu14E9peivaXaRzQlmhXN55cVKlqo4UZApLvL+uxAR3Uz6etPHfSZbMZPgJMZHAk4/Q4Oh2svg8Y94=
X-Received: by 2002:a17:906:20d6:b0:99b:5abb:8caf with SMTP id
 c22-20020a17090620d600b0099b5abb8cafmr438454ejc.44.1690338038873; Tue, 25 Jul
 2023 19:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230726002904.655377-1-yosryahmed@google.com>
 <20230726002904.655377-2-yosryahmed@google.com> <ZMCBzUH7qIdc3Y2X@P9FQF9L96D>
In-Reply-To: <ZMCBzUH7qIdc3Y2X@P9FQF9L96D>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Jul 2023 19:20:02 -0700
Message-ID: <CAJD7tkZDpni+VM61i-jUgvn=TkZ5CySotTmUAFQPwMSjDfOEWQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 7:15=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Jul 26, 2023 at 12:29:04AM +0000, Yosry Ahmed wrote:
> > Currently, memcg uses rstat to maintain hierarchical stats. Counters ar=
e
> > maintained for hierarchical stats at each memcg. Rstat tracks which
> > cgroups have updates on which cpus to keep those counters fresh on the
> > read-side.
> >
> > For non-hierarchical stats, we do not maintain counters. Instead, the
>                                                 global?

Do you mean "we do not maintain global counters"? I think "global" is
confusing, because it can be thought of as all cpus or as including
the subtree (as opposed to local for non-hierarchical stats).

> > percpu counters for a given stat need to be summed to get the
> > non-hierarchical stat value. The original implementation did the same.
> > At some point before rstat, non-hierarchical counters were introduced b=
y
> > commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
> > memory.stat reporting"). However, those counters were updated on the
> > performance critical write-side, which caused regressions, so they were
> > later removed by commit 815744d75152 ("mm: memcontrol: don't batch
> > updates of local VM stats and events"). See [1] for more detailed
> > history.
> >
> > Kernel versions in between a983b5ebee57 & 815744d75152 (a year and a
> > half) enjoyed cheap reads of non-hierarchical stats, specifically on
> > cgroup v1. When moving to more recent kernels, a performance regression
> > for reading non-hierarchical stats is observed.
> >
> > Now that we have rstat, we know exactly which percpu counters have
> > updates for each stat. We can maintain non-hierarchical counters again,
> > making reads much more efficient, without affecting the performance
> > critical write-side. Hence, add non-hierarchical (i.e local) counters
> > for the stats, and extend rstat flushing to keep those up-to-date.
> >
> > A caveat is that we now a stats flush before reading
>                          need?

Ah yes. I am hoping Andrew can amend this but I am happy to send a v3 as we=
ll.

> > local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
> > or memcg_events_local(), where we previously only needed a flush to
> > read hierarchical stats. Most contexts reading non-hierarchical stats
> > are already doing a flush, add a flush to the only missing context in
> > count_shadow_nodes().
> >
> > With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
> > machine with 256 cpus on cgroup v1:
> >  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
> >  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
> >  real  0m0.125s
> >  user  0m0.005s
> >  sys   0m0.120s
> >
> > After:
> >  real  0m0.032s
> >  user  0m0.005s
> >  sys   0m0.027s
> >
> > [1]https://lore.kernel.org/lkml/20230725201811.GA1231514@cmpxchg.org/
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

>
> Thank you!
