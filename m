Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB707D6196
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjJYGXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJYGXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:23:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F75211F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:23:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so8612453a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698214989; x=1698819789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQbB4bwPVZ7SBi8C6gh7OCcW70kLdzSL7ZqDE/GfPyM=;
        b=3EIfQ8Q4agjREw7dsBKeVsgGhZAh8XS/imDV9OXU/jBhqlV5hvC7VontRQwGY6DIoI
         jBNvjjx6LUoBsJWNyd4IoSfXXJX+oa/RMeALEC93Su0BoTVa1SlLNJr+DkzpGmKgnXhK
         gvtn07Ea9XMVDaHbbrzlE2F1hU2IAeU6jTY3Pb1I2lgKKysOjFmpwqPdFdOSyHzN07zg
         rurpvm7pJJGTZAzniFhe5w3T386Hk9/UufBVDee+co99fnrKy+SbyRE1LG5uJpWCuR0u
         sT8wOtdPrZYQOlu7Aci93RnEvU3yMNxO4jIPYbt0rp/NgEaU8sX87L4vqrpuTfe4KT+i
         QZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698214989; x=1698819789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQbB4bwPVZ7SBi8C6gh7OCcW70kLdzSL7ZqDE/GfPyM=;
        b=NSK1E8dvxnzXPPkKUf/lxz59Kz+PKJ7ulJzLJX6Uxp4ecFYxhHCyQkLrz6S+CklGfe
         cQRp4M2mLsSEGm1k7YOXQWKmaVUEwL4N4s/WS7e2j/lPGyCPDxmrWBEi81LQOg2ATO49
         vLfWFFra/f4ubK0AuC45pdsaClsjlSlx9Bjl1vX0kAZtmvkgzKes/xcI8xs5y1dQl2GI
         /ALtpkHcKceF+qx3KmafzFroYvUVb9Zer35QdHxJFfFecGWUC6+jhGPDrh11jKqnuxu2
         V16vL/YWUurna8W1SjiNacS4m9Lg3LJhye8gptjTVsnR/4070KENgfD1bv3zy1GsREY6
         0JZw==
X-Gm-Message-State: AOJu0YzrA7rQt0RKM+Svnp1FvUFdlt3KWW+n6hRo3j/xXD2H6KeCznAy
        XvGmcedgeOXxN57JSM19zWL/4MJShcEpp1w0WH/lSw==
X-Google-Smtp-Source: AGHT+IE4wzVGyva3F8aqQ4UNl8uI27Tc9h8knuHkhSOuPmZWNO6sz2hREqb1zMTmRAyOKxNKYEU65LWTXFGRf0nH6wU=
X-Received: by 2002:a17:907:9342:b0:9be:40ba:5f1 with SMTP id
 bv2-20020a170907934200b009be40ba05f1mr12127756ejc.60.1698214989310; Tue, 24
 Oct 2023 23:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com> <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
 <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
 <ZTXLeAAI1chMamkU@feng-clx> <CAJD7tka5UnHBz=eX1LtynAjJ+O_oredMKBBL3kFNfG7PHjuMCw@mail.gmail.com>
 <CAJD7tkYXJ3vcGvteNH98tB_C7OTo718XSxL=mFsUa7kO8vzFzA@mail.gmail.com>
 <ZTdqpcDFVHhFwWMc@xsang-OptiPlex-9020> <CAJD7tka7hmOD6KPmJBJa+TscbYEMmTjS+Jh2utPfTbKkfvwD9A@mail.gmail.com>
 <ZTiw/iIb0SbvN7vh@xsang-OptiPlex-9020>
In-Reply-To: <ZTiw/iIb0SbvN7vh@xsang-OptiPlex-9020>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 24 Oct 2023 23:22:30 -0700
Message-ID: <CAJD7tkaBnSwarz8yHu9RL_3DtaLRfjrcZ7m0YZZgHJsJdtHaZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Oliver Sang <oliver.sang@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Feng Tang <feng.tang@intel.com>,
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

On Tue, Oct 24, 2023 at 11:09=E2=80=AFPM Oliver Sang <oliver.sang@intel.com=
> wrote:
>
> hi, Yosry Ahmed,
>
> On Tue, Oct 24, 2023 at 12:14:42AM -0700, Yosry Ahmed wrote:
> > On Mon, Oct 23, 2023 at 11:56=E2=80=AFPM Oliver Sang <oliver.sang@intel=
.com> wrote:
> > >
> > > hi, Yosry Ahmed,
> > >
> > > On Mon, Oct 23, 2023 at 07:13:50PM -0700, Yosry Ahmed wrote:
> > >
> > > ...
> > >
> > > >
> > > > I still could not run the benchmark, but I used a version of
> > > > fallocate1.c that does 1 million iterations. I ran 100 in parallel.
> > > > This showed ~13% regression with the patch, so not the same as the
> > > > will-it-scale version, but it could be an indicator.
> > > >
> > > > With that, I did not see any improvement with the fixlet above or
> > > > ___cacheline_aligned_in_smp. So you can scratch that.
> > > >
> > > > I did, however, see some improvement with reducing the indirection
> > > > layers by moving stats_updates directly into struct mem_cgroup. The
> > > > regression in my manual testing went down to 9%. Still not great, b=
ut
> > > > I am wondering how this reflects on the benchmark. If you're able t=
o
> > > > test it that would be great, the diff is below. Meanwhile I am stil=
l
> > > > looking for other improvements that can be made.
> > >
> > > we applied previous patch-set as below:
> > >
> > > c5f50d8b23c79 (linux-review/Yosry-Ahmed/mm-memcg-change-flush_next_ti=
me-to-flush_last_time/20231010-112257) mm: memcg: restore subtree stats flu=
shing
> > > ac8a48ba9e1ca mm: workingset: move the stats flush into workingset_te=
st_recent()
> > > 51d74c18a9c61 mm: memcg: make stats flushing threshold per-memcg
> > > 130617edc1cd1 mm: memcg: move vmstats structs definition above flushi=
ng code
> > > 26d0ee342efc6 mm: memcg: change flush_next_time to flush_last_time
> > > 25478183883e6 Merge branch 'mm-nonmm-unstable' into mm-everything   <=
---- the base our tool picked for the patch set
> > >
> > > I tried to apply below patch to either 51d74c18a9c61 or c5f50d8b23c79=
,
> > > but failed. could you guide how to apply this patch?
> > > Thanks
> > >
> >
> > Thanks for looking into this. I rebased the diff on top of
> > c5f50d8b23c79. Please find it attached.
>
> from our tests, this patch has little impact.
>
> it was applied as below ac6a9444dec85:
>
> ac6a9444dec85 (linux-devel/fixup-c5f50d8b23c79) memcg: move stats_updates=
 to struct mem_cgroup
> c5f50d8b23c79 (linux-review/Yosry-Ahmed/mm-memcg-change-flush_next_time-t=
o-flush_last_time/20231010-112257) mm: memcg: restore subtree stats flushin=
g
> ac8a48ba9e1ca mm: workingset: move the stats flush into workingset_test_r=
ecent()
> 51d74c18a9c61 mm: memcg: make stats flushing threshold per-memcg
> 130617edc1cd1 mm: memcg: move vmstats structs definition above flushing c=
ode
> 26d0ee342efc6 mm: memcg: change flush_next_time to flush_last_time
> 25478183883e6 Merge branch 'mm-nonmm-unstable' into mm-everything
>
> for the first regression reported in original report, data are very close
> for 51d74c18a9c61, c5f50d8b23c79 (patch-set tip, parent of ac6a9444dec85)=
,
> and ac6a9444dec85.
> full comparison is as [1]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-11.1-x86_64-20220=
510.cgz/lkp-skl-fpga01/fallocate1/will-it-scale
>
> 130617edc1cd1ba1 51d74c18a9c61e7ee33bc90b522 c5f50d8b23c7982ac875791755b =
ac6a9444dec85dc50c6bfbc4ee7
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>      36509           -25.8%      27079           -25.2%      27305       =
    -25.0%      27383        will-it-scale.per_thread_ops
>
> for the second regression reported in origianl report, seems a small impa=
ct
> from ac6a9444dec85.
> full comparison is as [2]
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-202205=
10.cgz/lkp-skl-fpga01/fallocate1/will-it-scale
>
> 130617edc1cd1ba1 51d74c18a9c61e7ee33bc90b522 c5f50d8b23c7982ac875791755b =
ac6a9444dec85dc50c6bfbc4ee7
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>      76580           -30.0%      53575           -28.9%      54415       =
    -26.7%      56152        will-it-scale.per_thread_ops
>
> [1]
>

Thanks Oliver for running the numbers. If I understand correctly the
will-it-scale.fallocate1 microbenchmark is the only one showing
significant regression here, is this correct?

In my runs, other more representative microbenchmarks benchmarks like
netperf and will-it-scale.page_fault* show minimal regression. I would
expect practical workloads to have high concurrency of page faults or
networking, but maybe not fallocate/ftruncate.

Oliver, in your experience, how often does such a regression in such a
microbenchmark translate to a real regression that people care about?
(or how often do people dismiss it?)

I tried optimizing this further for the fallocate/ftruncate case but
without luck. I even tried moving stats_updates into cgroup core
(struct cgroup_rstat_cpu) to reuse the existing loop in
cgroup_rstat_updated() -- but it somehow made it worse.

On the other hand, we do have some machines in production running this
series together with a previous optimization for non-hierarchical
stats [1] on an older kernel, and we do see significant reduction in
cpu time spent on reading the stats. Domenico did a similar experiment
with only this series and reported similar results [2].

Shakeel, Johannes, (and other memcg folks), I personally think the
benefits here outweigh a regression in this particular benchmark, but
I am obviously biased. What do you think?

[1]https://lore.kernel.org/lkml/20230726153223.821757-2-yosryahmed@google.c=
om/
[2]https://lore.kernel.org/lkml/CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPYEL=
7nK77e2A@mail.gmail.com/
