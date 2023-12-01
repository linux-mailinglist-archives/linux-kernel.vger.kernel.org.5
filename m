Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB25800181
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376719AbjLACR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjLACR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:17:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A89131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:18:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00b01955acso236730866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701397082; x=1702001882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExvEziVgMV2rppcyafzoU2tyP+vlRakA54EORAGR2IM=;
        b=u45dYRegUOe6P+c3Irrwa62ZRQXmRfPOU5n2Pc8c5LqxaXsFQIyDxezSfNy3wlMjE3
         MtQr3rKm39l4RXnbIHqjsD21Kvpoh7Vak+ep9lmG7/HngXioWSB5cz59GuMblefWg2Vz
         hFhZgW5L+1nOsh7gFwGNmWyGnlxORfdCgHJKx0QkMHDLNJtkbX+KUO/BIHVp12AabDaY
         C+At3bWiAItu2dPBKjevBOZGmeSDXzEJT7E07v29w+m6JJ7a37PleYVgidFkHdgUu57i
         lxqCCGZslzpM+VK7yiaG9sB/MljCmVMnCJsjvFj0h8Kznpq/HXU+P+Zv1Nq6TYP0gMa+
         dOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701397082; x=1702001882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExvEziVgMV2rppcyafzoU2tyP+vlRakA54EORAGR2IM=;
        b=spgDmCr9HgAxxDOFK2LZPmusWkA+H2AdrxQrXv/dMhMO7RSp5wcDhXB3TPFAgKSioj
         xbLyA5OO0USVM9WMede3s9U+mDed75uZBRhC9DHDK1VtZvVoK1bTOHF8rNCuvfoQA3Jm
         qtmFWDF1nPobd6XGtnhqYGtGzAR8wqnC7EZx26EkqmOorFDauU9jzQZ0fOOm61ZkuvZb
         9FTfOv63PPCke6LxmWmSLfye0lkkAubLWAjHRzMYotYd+ZzVDOwkr/WICwrzyOgRsX82
         L4bIgHeonJWp5DhFRenpiMvg026EXrxkOIIxtl5+vR1GtUv51IrTu0q43FeAxc3wVRnx
         W9rw==
X-Gm-Message-State: AOJu0Yz5nHXmqPFqrVDfkqrLaQFJOlg5neKLwoyFBv19trpwA5c8zM4t
        UHfpBxqHf/5k8ZO3xzpOdBGgTExIU7DrzB5FKI8Q4cYpKrYaix7emDY=
X-Google-Smtp-Source: AGHT+IGTvaa/G5kr3Vm3SQHjd3wAZFjGUu8xzf+Rhh/1cOzNo0lKDy+8NE4TvaiB5fL/FDEb/khG4vZO0cZUCW/9LRk=
X-Received: by 2002:a17:906:3984:b0:a04:3571:e165 with SMTP id
 h4-20020a170906398400b00a043571e165mr299359eje.52.1701397081741; Thu, 30 Nov
 2023 18:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130153658.527556-2-schatzberg.dan@gmail.com> <ec8abbff-8e17-43b3-a210-fa615e71217d@vivo.com>
 <CAJD7tkY-npqRXmwJU6kH1srG0c+suiDfffsoc44ngP4x9H0kLA@mail.gmail.com> <abc73ea8-f172-422e-bc58-7424e47636b8@vivo.com>
In-Reply-To: <abc73ea8-f172-422e-bc58-7424e47636b8@vivo.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Nov 2023 18:17:25 -0800
Message-ID: <CAJD7tkaXUsvCEkenaoBOGYaSjCW5yQNCuFiWJEDJOtKXLaYeeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
To:     Huan Yang <11133793@vivo.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 6:14=E2=80=AFPM Huan Yang <11133793@vivo.com> wrote=
:
>
>
> =E5=9C=A8 2023/12/1 10:05, Yosry Ahmed =E5=86=99=E9=81=93:
> >> @@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec=
, struct scan_control *sc,
> >>          struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> >>          struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
> >>          unsigned long anon_cost, file_cost, total_cost;
> >> -       int swappiness =3D mem_cgroup_swappiness(memcg);
> >> +       int swappiness =3D sc->swappiness ?
> >> +               *sc->swappiness : mem_cgroup_swappiness(memcg);
> >>
> >> Should we use "unlikely" here to indicate that sc->swappiness is an un=
expected behavior?
> >> Due to current use case only apply in proactive reclaim.
> > On a system that is not under memory pressure, the rate of proactive
> > reclaim could be higher than reactive reclaim. We should only use
> > likely/unlikely when it's obvious a scenario will happen most of the
> > time. I don't believe that's the case here.
> Not all vendors will use proactive interfaces, and reactive reclaim are
> a normal
> system behavior. In this regard, I think it is appropriate to add
> "unlikely".

The general guidance is not to use likely/unlikely when it's not
certain, which I believe is the case here. I think the CPU will make
better decisions on its own than if we give it hints that's wrong in
some situations. Others please correct me if I am wrong.

> >
> >>          u64 fraction[ANON_AND_FILE];
> >>          u64 denominator =3D 0;    /* gcc */
> >>          enum scan_balance scan_balance;
> >> @@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec,=
 struct scan_control *sc)
> >>              mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
> >>                  return 0;
> >>
> >> +       if (sc->swappiness)
> >> +               return *sc->swappiness;
> >>
> >> Also there.
> >>
> >> +
> >>          return mem_cgroup_swappiness(memcg);
> >>   }
> >>
> >> @@ -6433,7 +6440,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_=
cgroup *memcg,
> >>   unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >>                                             unsigned long nr_pages,
> >>                                             gfp_t gfp_mask,
> >> -                                          unsigned int reclaim_option=
s)
> >> +                                          unsigned int reclaim_option=
s,
> >> +                                          int *swappiness)
> >>   {
> >>          unsigned long nr_reclaimed;
> >>          unsigned int noreclaim_flag;
> >> @@ -6448,6 +6456,7 @@ unsigned long try_to_free_mem_cgroup_pages(struc=
t mem_cgroup *memcg,
> >>                  .may_unmap =3D 1,
> >>                  .may_swap =3D !!(reclaim_options & MEMCG_RECLAIM_MAY_=
SWAP),
> >>                  .proactive =3D !!(reclaim_options & MEMCG_RECLAIM_PRO=
ACTIVE),
> >> +               .swappiness =3D swappiness,
> >>          };
> >>          /*
> >>           * Traverse the ZONELIST_FALLBACK zonelist of the current nod=
e to put
> >> --
> >> 2.34.1
> >>
> >> My previous patch attempted to ensure fully deterministic semantics un=
der extreme swappiness.
> >> For example, when swappiness is set to 200, only anonymous pages will =
be reclaimed.
> >> Due to code in MGLRU isolate_folios will try scan anon if no scanned, =
will try other type.(We do not want
> >> it to attempt this behavior.)
> >> How do you think about extreme swappiness scenarios?
> > I think having different semantics between swappiness passed to
> > proactive reclaim and global swappiness can be confusing. If it's
> > needed to have a swappiness value that says "anon only no matter
> > what", perhaps we should introduce such a new value and make it
> > supported by both global and proactive reclaim swappiness? We could
> > support writing "max" or something similar instead of a special value
> > to mean that.
>
> Yes, use other hint more suitable for this scenario.
>
> However, from this patch, it seems that this feature is not supported.
> Do you have a demand for this scenario?

We do anonymous-only proactive reclaim in some setups, so it would be
nice to have. I am not sure if it's absolutely needed vs. just using
swappiness=3D200 and living with the possibility of reclaiming some file
pages.
