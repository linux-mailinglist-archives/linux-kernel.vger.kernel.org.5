Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F447D1515
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377936AbjJTRnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377895AbjJTRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:43:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF871FA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:43:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b9faf05f51so164508266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697823818; x=1698428618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1heveFnCrEJOdM4DCy3MHM1wUBeG4YS6MC7cDodL18=;
        b=pUxKaGf5wpCD7/kJ27jTnuN0Euwx0Do5wm+7X8G7e6zOjxqnFkMATNAmOEcaNBntvY
         4OWJTRDkbwYw2Ui9rFXYAyT4IDyVYpcGx+Z7Rmojz8qDoELRORMMe8hcjnR/jCFNuJW3
         +Guc6SSnSweosgQrC2K0O0FcDYkc3RCOeTmPF+s9u042HY8XhT+MA8lgMsSwnZek17v3
         VQm1Nnrt60AJqV9t2OoorZtCneuCj5IUFqJM3Frbp5qOA1NdIypa2Rcda45Sv2om7F5O
         lRW0NNo+jQ+98/DUGYXcYYyYCWW2Bz1f4lIkS8sPyyB1FUzrveUQDKqSXtbaNDoAPjUM
         OHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823818; x=1698428618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1heveFnCrEJOdM4DCy3MHM1wUBeG4YS6MC7cDodL18=;
        b=wYdfH6w52vbDWismutSQRfRfuvNl1lV/tYJhZeYdvARcQZH5B87lGbYWOTEh+tOQT1
         yTdpZ7Y6OnvCHLjquS7WlWrNRxetUMq8HjegaZuksxXM5TiiV1Ucevy++NFBNs2Hezav
         o1rLDNE+Er0tA/QlyF2dZw4hGNNLIcpFb5uhrhhm29/mvzglWFfXnKNjRidvptr7L7hs
         /QCaor3rDCRSz6h+1zqpReo4geEWMwqGtaT9bX+zU80a/3jtGquZ+AyOqLigeULm+7V6
         X8fOUv/u8KdF1z7KTr2i+9FPlc78O5+1V//NacuSWxtRutlhWZ1Q4+Cykk5c3Vd6iHiT
         6D/g==
X-Gm-Message-State: AOJu0YyXAYtvCG784USeMzHo25mTvktrXzBKMl+QD6xrWEU0QvAWEyx9
        N96jkD6HOAneOnbBs+CuC3H00OGRnyrsrEkcqWCKcA==
X-Google-Smtp-Source: AGHT+IEXZwXYQoD3qalHsmHbpcJqzZ7tmC/iIYPTkqCHECXMuZkRt9k/MgXunNY1rLGD07LOxsOxhXyUsPRzCRi/Qag=
X-Received: by 2002:a17:906:da8c:b0:9ae:52fb:2202 with SMTP id
 xh12-20020a170906da8c00b009ae52fb2202mr1823652ejb.40.1697823818063; Fri, 20
 Oct 2023 10:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com> <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
In-Reply-To: <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 20 Oct 2023 10:42:58 -0700
Message-ID: <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 20, 2023 at 10:23=E2=80=AFAM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> On Fri, Oct 20, 2023 at 9:18=E2=80=AFAM kernel test robot <oliver.sang@in=
tel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed a -25.8% regression of will-it-scale.per_thre=
ad_ops on:
> >
> >
> > commit: 51d74c18a9c61e7ee33bc90b522dd7f6e5b80bb5 ("[PATCH v2 3/5] mm: m=
emcg: make stats flushing threshold per-memcg")
> > url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memc=
g-change-flush_next_time-to-flush_last_time/20231010-112257
> > base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-every=
thing
> > patch link: https://lore.kernel.org/all/20231010032117.1577496-4-yosrya=
hmed@google.com/
> > patch subject: [PATCH v2 3/5] mm: memcg: make stats flushing threshold =
per-memcg
> >
> > testcase: will-it-scale
> > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > parameters:
> >
> >         nr_task: 100%
> >         mode: thread
> >         test: fallocate1
> >         cpufreq_governor: performance
> >
> >
> > In addition to that, the commit also has significant impact on the foll=
owing tests:
> >
> > +------------------+---------------------------------------------------=
------------+
> > | testcase: change | will-it-scale: will-it-scale.per_thread_ops -30.0%=
 regression |
> > | test machine     | 104 threads 2 sockets (Skylake) with 192G memory  =
            |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
              |
> > |                  | mode=3Dthread                                     =
              |
> > |                  | nr_task=3D50%                                     =
              |
> > |                  | test=3Dfallocate1                                 =
              |
> > +------------------+---------------------------------------------------=
------------+
> >
>
> Yosry, I don't think 25% to 30% regression can be ignored. Unless
> there is a quick fix, IMO this series should be skipped for the
> upcoming kernel open window.

I am currently looking into it. It's reasonable to skip the next merge
window if a quick fix isn't found soon.

I am surprised by the size of the regression given the following:
      1.12 =C4=85  5%      +1.4        2.50 =C4=85  2%
perf-profile.self.cycles-pp.__mod_memcg_lruvec_state

IIUC we are only spending 1% more time in __mod_memcg_lruvec_state().
