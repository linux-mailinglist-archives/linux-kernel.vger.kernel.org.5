Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36AB7E096D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjKCTYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKCTYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:24:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A017D55;
        Fri,  3 Nov 2023 12:24:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79f82b26abfso81297139f.1;
        Fri, 03 Nov 2023 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699039479; x=1699644279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZgFmOX3ULsBcBCYJS8Q2oH6cz5Ye/aK91vNIaxZApU=;
        b=Ltwkd8gxZTnKeBzJyjdjh0DWmStdLbLEfIHOXu9QBL8Uf6tDhhnULHEhGJRd++ACJg
         Uldd7miNdjrtG9vMRzalg09lE0xFwB4Tv+Fd9lbrfH937l9swNt7KP70xM+yFFL2QKde
         ff6TffWH7E79CD/asdwCXh0TNfEv8a2NzOX3aijJYCSzDCnnoy8ropxsDbkqrMd/0BRw
         f09d8sWrKIKoDSdmf1VqSISLanTfFeilEWUOusnYi4zkY5nJlObxmgV6dyM90cxHLUmt
         q6m/qOxJZ6twD/Ql4JkmxDRW14iBwoSSVuwgk/no2CTHR31TRXs4o3I1tUEKYQ3k1uEp
         jKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039479; x=1699644279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZgFmOX3ULsBcBCYJS8Q2oH6cz5Ye/aK91vNIaxZApU=;
        b=q5VlDgDwfblimmCBwExHHHAZLw90Bevq7CCPaEMp6WJI6SeZCu+4QTJl+doT0DuXFV
         +6I6BuFz4exrN66RQJcq02JtL1U814s3AU88RbB1gG4ZEKgbCYocmmHMwcUT3nKYqYcd
         q7gKmVzhfRZIoqGl/I91dCfJMSuVaqOfgnZgj98VkV87+y/qHoIL1nzeZMuXS2rj4cNF
         EOYjImdL05qoGoXljpA3BHnX0RuDT9YcOKsAtBQze9Y8KYBHELZCalt5wlwzKiyR9DjW
         NpwwDzrbZZ0CQkW1dTHkiSujJooCQ8El9GlZyVbyzfq+fQnIZl1nlcP5O1PwKMX+Uezr
         bhAg==
X-Gm-Message-State: AOJu0YyAqlRdzb43zAxkg7eDN8wZK3puxAXFSrWthLXtPlCF0NIL422T
        szrYciZOn/EeU7ynu9jP/kgRyeqVGS4CE+N9c/I=
X-Google-Smtp-Source: AGHT+IFSnD4V/LX6mRlu0PCTUa5qHRWWBa4S7AVEVw8WDTLWp95ndc+LdBPX4HP7r7C+1b3tL92MStshFm3nZszw5PY=
X-Received: by 2002:a05:6602:2cc5:b0:790:cb89:44eb with SMTP id
 j5-20020a0566022cc500b00790cb8944ebmr28825006iow.1.1699039479485; Fri, 03 Nov
 2023 12:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231102234236.1784543-1-nphamcs@gmail.com> <CAJD7tkapfHVvF1KCm4iUDWGP0n5zV3GBcNAGDiYNHrpuODPPqQ@mail.gmail.com>
In-Reply-To: <CAJD7tkapfHVvF1KCm4iUDWGP0n5zV3GBcNAGDiYNHrpuODPPqQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 3 Nov 2023 12:24:27 -0700
Message-ID: <CAKEwX=MunYMKQXsV58vBXROKnJFDhViCpQgC7RnrLExa_U=n2g@mail.gmail.com>
Subject: Re: [RFC PATCH v3] zswap: memcontrol: implement zswap writeback disabling
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 6:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Nov 2, 2023 at 4:42=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > During our experiment with zswap, we sometimes observe swap IOs due to
> > occasional zswap store failures and writebacks-to-swap. These swapping
> > IOs prevent many users who cannot tolerate swapping from adopting zswap
> > to save memory and improve performance where possible.
> >
> > This patch adds the option to disable this behavior entirely: do not
> > writeback to backing swapping device when a zswap store attempt fail,
> > and do not write pages in the zswap pool back to the backing swap
> > device (both when the pool is full, and when the new zswap shrinker is
> > called).
> >
> > This new behavior can be opted-in/out on a per-cgroup basis via a new
> > cgroup file. By default, writebacks to swap device is enabled, which is
> > the previous behavior.
> >
> > Note that this is subtly different from setting memory.swap.max to 0, a=
s
> > it still allows for pages to be stored in the zswap pool (which itself
> > consumes swap space in its current form).
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 11 +++++++
> >  Documentation/admin-guide/mm/zswap.rst  |  6 ++++
> >  include/linux/memcontrol.h              | 12 ++++++++
> >  include/linux/zswap.h                   |  6 ++++
> >  mm/memcontrol.c                         | 38 +++++++++++++++++++++++++
> >  mm/page_io.c                            |  6 ++++
> >  mm/shmem.c                              |  3 +-
> >  mm/zswap.c                              | 14 +++++++++
> >  8 files changed, 94 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 606b2e0eac4b..18c4171392ea 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1672,6 +1672,17 @@ PAGE_SIZE multiple when read back.
> >         limit, it will refuse to take any more stores before existing
> >         entries fault back in or are written out to disk.
> >
> > +  memory.zswap.writeback
> > +       A read-write single value file which exists on non-root
> > +       cgroups.  The default value is "1".
> > +
> > +       When this is set to 0, all swapping attempts to swapping device=
s
> > +       are disabled. This included both zswap writebacks, and swapping=
 due
> > +       to zswap store failure.
> > +
> > +       Note that this is subtly different from setting memory.swap.max=
 to
> > +       0, as it still allows for pages to be written to the zswap pool=
.
> > +
> >    memory.pressure
> >         A read-only nested-keyed file.
> >
> > diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/adm=
in-guide/mm/zswap.rst
> > index 522ae22ccb84..b987e58edb70 100644
> > --- a/Documentation/admin-guide/mm/zswap.rst
> > +++ b/Documentation/admin-guide/mm/zswap.rst
> > @@ -153,6 +153,12 @@ attribute, e. g.::
> >
> >  Setting this parameter to 100 will disable the hysteresis.
> >
> > +Some users cannot tolerate the swapping that comes with zswap store fa=
ilures
> > +and zswap writebacks. Swapping can be disabled entirely (without disab=
ling
> > +zswap itself) on a cgroup-basis as follows:
> > +
> > +       echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writeback
> > +
> >  When there is a sizable amount of cold memory residing in the zswap po=
ol, it
> >  can be advantageous to proactively write these cold pages to swap and =
reclaim
> >  the memory for other use cases. By default, the zswap shrinker is disa=
bled.
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 95f6c9e60ed1..e51eafdf2a15 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -219,6 +219,12 @@ struct mem_cgroup {
> >
> >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> >         unsigned long zswap_max;
> > +
> > +       /*
> > +        * Prevent pages from this memcg from being written back from z=
swap to
> > +        * swap, and from being swapped out on zswap store failures.
> > +        */
> > +       bool zswap_writeback;
> >  #endif
> >
> >         unsigned long soft_limit;
> > @@ -1931,6 +1937,7 @@ static inline void count_objcg_event(struct obj_c=
group *objcg,
> >  bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
> >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> > +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
> >  #else
> >  static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> >  {
> > @@ -1944,6 +1951,11 @@ static inline void obj_cgroup_uncharge_zswap(str=
uct obj_cgroup *objcg,
> >                                              size_t size)
> >  {
> >  }
> > +static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgrou=
p *memcg)
> > +{
> > +       /* if zswap is disabled, do not block pages going to the swappi=
ng device */
> > +       return true;
> > +}
> >  #endif
> >
> >  #endif /* _LINUX_MEMCONTROL_H */
> > diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> > index cbd373ba88d2..b4997e27a74b 100644
> > --- a/include/linux/zswap.h
> > +++ b/include/linux/zswap.h
> > @@ -35,6 +35,7 @@ void zswap_swapoff(int type);
> >  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
> >  void zswap_lruvec_state_init(struct lruvec *lruvec);
> >  void zswap_lruvec_swapin(struct page *page);
> > +bool is_zswap_enabled(void);
> >  #else
> >
> >  struct zswap_lruvec_state {};
> > @@ -55,6 +56,11 @@ static inline void zswap_swapoff(int type) {}
> >  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memc=
g) {}
> >  static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
> >  static inline void zswap_lruvec_swapin(struct page *page) {}
> > +
> > +static inline bool is_zswap_enabled(void)
> > +{
> > +       return false;
> > +}
> >  #endif
> >
> >  #endif /* _LINUX_ZSWAP_H */
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e43b5aba8efc..8a6aadcc103c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5545,6 +5545,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *=
parent_css)
> >         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> >         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> > +       WRITE_ONCE(memcg->zswap_writeback, true);
>
> Generally LGTM, just one question.
>
> Would it be more convenient if the initial value is inherited from the
> parent (the root starts with true)?
>
> I can see this being useful if we want to set it to false on the
> entire machine or one a parent cgroup, we can set it before creating
> any children instead of setting it to 0 every time we create a new
> cgroup.

I'm not 100% sure about the benefit or have a strong opinion one way
or another, but this sounds like a nice-to-have detail to me, and a relativ=
ely
low cost one (both in effort and at runtime) at that too.

Propagating the change everytime we modify the memory.zswap.writeback
value of the ancestor might be data race-prone (and costly, depending on
how big the cgroup subtree is), but this is just a one-time-per-cgroup
propagation (at the new cgroup creation time).

Can anyone come up with a failure case for this change, or why it might be
a bad idea?

Thanks for the suggestion, Yosry!
