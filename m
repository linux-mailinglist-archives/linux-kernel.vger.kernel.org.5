Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C057F0257
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjKRTXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjKRTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:23:46 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC48D130;
        Sat, 18 Nov 2023 11:23:41 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b0683ff3c8so108086139f.0;
        Sat, 18 Nov 2023 11:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700335421; x=1700940221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSzmdouSID2xTbRPYhYajoY76l2bMkXTOZH4ofTezzo=;
        b=IBRzwl6Plm4SgkudhOMTmOgLV/LEQ4Q1sWAgj44aEygX+7sqh3Xclh5g8FuG13YJQY
         MbBhfZb3M47G1j0HrwXpZU/ehiL4qHndQuOpADGnFl+SZL5hYh/jOxXnSO9PEaoD1QNb
         x9khnOrNDbC9jTmlyV/KjTjG1dPQnqx9ZPpGOYUZaAbncy8vIDnsMByTCSoLYHNENaRp
         drDLcUc/7ddIj69cpIHXJJJaeB4U+XRr1GK0C+Ze1PTc1hAeSv04GfUxD5pw/Jhjfxly
         4dgsNv75TIBlxSOxVbpeYclX9SFP0AG7YelVkSUtzdm07ffDMX6177tsDwMHP2yo0E1U
         jthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700335421; x=1700940221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSzmdouSID2xTbRPYhYajoY76l2bMkXTOZH4ofTezzo=;
        b=m8xi9mkcDq1Sp6PgfJEp758wBts8IGvoybttP0/VO8JJqAnZz92OHoeBAmBBf9q37j
         yDPuXgQJiG4JJ4ftrLbF3UXldxyQ2cDnt7VFJJA7yP/QWehHVfA0fdUPdhkp5SXiNNXP
         1IsSKq9NqhTYVU5MNbpWFRpCno0PkdPb4D1G9E0s3GI68w3uipyYIWihl3fx2bgY75SJ
         gFl3APj8t7HBUWtOHK+iv/7j/N2pqXePOqaKnA7OIpgpnMApSO+Wpgnt+MZVO5isA46W
         hxq70EMe2vktIPv4qjpy379xFlzczSwl16QPL+KQRm8T8jm5zwAudl7RpA8RKPtzVshH
         uhOg==
X-Gm-Message-State: AOJu0YwwR0jKUod5tf6TM4DiWpGRG8q0Rl7iSLNLDXi0IPXKCNjReEgC
        HBRgBAmBMzb0N+wGFrOsfbDZk76BAZ5WszSfdKs=
X-Google-Smtp-Source: AGHT+IHpzb7dJ8asxW0Os4fndLE7LbRODQgNS+NvupR/G58hHUPmd+iOIUBMKt6xhFRz3/qiquE899vke5yfQRgUs+Y=
X-Received: by 2002:a6b:f319:0:b0:7a6:8299:cc4f with SMTP id
 m25-20020a6bf319000000b007a68299cc4fmr3393064ioh.21.1700335420928; Sat, 18
 Nov 2023 11:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20231115172344.4155593-1-nphamcs@gmail.com> <CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com>
 <CAJD7tkZ1U+YuvoBAnrXFxQDiQV2hXdbMG-gbzu64R8GLAtNAPA@mail.gmail.com> <CAF8kJuPTNwQM413UdeQTkMQ8HkJFyF4OWVrxJSf7uWbege0CXQ@mail.gmail.com>
In-Reply-To: <CAF8kJuPTNwQM413UdeQTkMQ8HkJFyF4OWVrxJSf7uWbege0CXQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sat, 18 Nov 2023 14:23:28 -0500
Message-ID: <CAKEwX=O5M-vZE5YhYQ5_CbCmXovS1XECO4ROXKWo06K880M1Mg@mail.gmail.com>
Subject: Re: [PATCH v5] zswap: memcontrol: implement zswap writeback disabling
To:     Chris Li <chrisl@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
        lizefan.x@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, Hugh Dickins <hughd@google.com>,
        corbet@lwn.net, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm <linux-mm@kvack.org>, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
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

On Thu, Nov 16, 2023 at 7:39=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
>
> I think we are in agreement here. I am already Acked on the previous
> version of this patch.
> Consider this version as well because the change suggestion is from me.
> I am fine with merging the zswap.writeback.
>
> It is also good to get some discussion on the more general ABI as
> well. Just like you said, we can also explore the zswap + swapfile
> using the more general API. Because obsoleting user-visible ABI is
> much harder.
>
> Chris

Hmm how about this - in the future, we support the following
options:

1. zswap.writeback =3D=3D 1: no limitation to zswap writeback.
All backing swap devices (sorted by priorities?) are fair game.

2. zswap.writeback =3D=3D 0: disable all forms of zswap writeback.

3. zswap.writeback =3D=3D <tiers description>:  attempt to write to each
tier, one at a time.

The first two are basically what we have for this patch.
The last one will be added in a future patch.

This is from the userspace perspective. Internally, we can modify
memcg->writeback to be a pointer or a struct instead of this bool.
(as you suggested).

This way, the API remains intact and backward compatible
(and FWIW, I think there are still a lot of values in having simple
options for the users who have simple memory hierarchies).

>
> On Thu, Nov 16, 2023 at 1:01=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Nov 16, 2023 at 12:53=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > Hi Nhat,
> > >
> > > As we discussed, I just want to bounce some alternative ideas related
> > > to this write back disabled feature.
> > >
> > > Currently, the common usage case is zswap alone or zswap + SSD. We
> > > treat zswap and
> > > SSD as two different tiers with different swap in performance charact=
eristics.
> > > If we make it more generic, we can also have more than two swap tiers=
.
> > > e.g. we can have zswap, SSD, network swap or HDD swap.
> > > The disable flag is just one bit of information, it can't describe
> > > what is the next tier.if it is not the current swap file
> > > implementation .
> > >
> > > One idea is that we can have a more general swap_tier_list object to
> > > describe the order of the swap device, The system can have more than
> > > one such list to describe different combinations of the tier
> > > selection.
> > >
> > > Each memcg can have a pointer point to one of such swap_tier_list
> > > objects, replacing the disabled write back flag in this patch.
> > > When you swap out, it will just go through each tier in the list, try
> > > to swap it out.
> > >  This has some implications for the zswap shrink as well. It becomes =
a
> > > more generic "move swap out data to another tier". Generally need to
> > > load into the swap cache then write to another tier.
> > >
> > > Open question is how we deal with the swap cache index across
> > > different tiers. The zswap.writeback_disable will not be needed if we
> > > have a more generic swap tier framework.
> >
> > I agree that this should be the long-term goal, and I suggested that
> > we make the interface more future-proof by making it more generic to
> > accept the types or tiers of swap allowed by the memcg:
> >
> > https://lore.kernel.org/lkml/CAJD7tkY8iPBo99+1gdsSRMNDu4jkVKz8rb=3DW+xk=
9=3DGE0y=3DkSuw@mail.gmail.com/
> >
> > Since we only have swap and zswap now, the implementation can be
> > similar to this code and basically just disable writeback if zswap is
> > the only allowed swapping mechanism. So we don't necessarily need to
> > have a full swap tiering implementation, but I agree with Chris that
> > at least having a future-proof interface to work with generic swap
> > tiering is preferrable.
> >
> >
> >
> > >
> > > Chris
> > >
> > >
> > > On Wed, Nov 15, 2023 at 9:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com>=
 wrote:
> > > >
> > > > During our experiment with zswap, we sometimes observe swap IOs due=
 to
> > > > occasional zswap store failures and writebacks-to-swap. These swapp=
ing
> > > > IOs prevent many users who cannot tolerate swapping from adopting z=
swap
> > > > to save memory and improve performance where possible.
> > > >
> > > > This patch adds the option to disable this behavior entirely: do no=
t
> > > > writeback to backing swapping device when a zswap store attempt fai=
l,
> > > > and do not write pages in the zswap pool back to the backing swap
> > > > device (both when the pool is full, and when the new zswap shrinker=
 is
> > > > called).
> > > >
> > > > This new behavior can be opted-in/out on a per-cgroup basis via a n=
ew
> > > > cgroup file. By default, writebacks to swap device is enabled, whic=
h is
> > > > the previous behavior. Initially, writeback is enabled for the root
> > > > cgroup, and a newly created cgroup will inherit the current setting=
 of
> > > > its parent.
> > > >
> > > > Note that this is subtly different from setting memory.swap.max to =
0, as
> > > > it still allows for pages to be stored in the zswap pool (which its=
elf
> > > > consumes swap space in its current form).
> > > >
> > > > This patch should be applied on top of the zswap shrinker series:
> > > >
> > > > https://lore.kernel.org/lkml/20231106183159.3562879-1-nphamcs@gmail=
.com/
> > > >
> > > > as it also disables the zswap shrinker, a major source of zswap
> > > > writebacks.
> > > >
> > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > ---
> > > >  Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++
> > > >  Documentation/admin-guide/mm/zswap.rst  |  6 ++++
> > > >  include/linux/memcontrol.h              | 12 ++++++++
> > > >  include/linux/zswap.h                   |  6 ++++
> > > >  mm/memcontrol.c                         | 38 +++++++++++++++++++++=
++++
> > > >  mm/page_io.c                            |  6 ++++
> > > >  mm/shmem.c                              |  3 +-
> > > >  mm/zswap.c                              | 14 +++++++++
> > > >  8 files changed, 95 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentatio=
n/admin-guide/cgroup-v2.rst
> > > > index 3f85254f3cef..2b4ac43efdc8 100644
> > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > @@ -1679,6 +1679,18 @@ PAGE_SIZE multiple when read back.
> > > >         limit, it will refuse to take any more stores before existi=
ng
> > > >         entries fault back in or are written out to disk.
> > > >
> > > > +  memory.zswap.writeback
> > > > +       A read-write single value file. The default value is "1". T=
he
> > > > +       initial value of the root cgroup is 1, and when a new cgrou=
p is
> > > > +       created, it inherits the current value of its parent.
> > > > +
> > > > +       When this is set to 0, all swapping attempts to swapping de=
vices
> > > > +       are disabled. This included both zswap writebacks, and swap=
ping due
> > > > +       to zswap store failure.
> > > > +
> > > > +       Note that this is subtly different from setting memory.swap=
.max to
> > > > +       0, as it still allows for pages to be written to the zswap =
pool.
> > > > +
> > > >    memory.pressure
> > > >         A read-only nested-keyed file.
> > > >
> > > > diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation=
/admin-guide/mm/zswap.rst
> > > > index 522ae22ccb84..b987e58edb70 100644
> > > > --- a/Documentation/admin-guide/mm/zswap.rst
> > > > +++ b/Documentation/admin-guide/mm/zswap.rst
> > > > @@ -153,6 +153,12 @@ attribute, e. g.::
> > > >
> > > >  Setting this parameter to 100 will disable the hysteresis.
> > > >
> > > > +Some users cannot tolerate the swapping that comes with zswap stor=
e failures
> > > > +and zswap writebacks. Swapping can be disabled entirely (without d=
isabling
> > > > +zswap itself) on a cgroup-basis as follows:
> > > > +
> > > > +       echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writebac=
k
> > > > +
> > > >  When there is a sizable amount of cold memory residing in the zswa=
p pool, it
> > > >  can be advantageous to proactively write these cold pages to swap =
and reclaim
> > > >  the memory for other use cases. By default, the zswap shrinker is =
disabled.
> > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.=
h
> > > > index 83590fd0d6d1..3901ff4dae63 100644
> > > > --- a/include/linux/memcontrol.h
> > > > +++ b/include/linux/memcontrol.h
> > > > @@ -219,6 +219,12 @@ struct mem_cgroup {
> > > >
> > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > >         unsigned long zswap_max;
> > > > +
> > > > +       /*
> > > > +        * Prevent pages from this memcg from being written back fr=
om zswap to
> > > > +        * swap, and from being swapped out on zswap store failures=
.
> > > > +        */
> > > > +       bool zswap_writeback;
> > > >  #endif
> > > >
> > > >         unsigned long soft_limit;
> > > > @@ -1931,6 +1937,7 @@ static inline void count_objcg_event(struct o=
bj_cgroup *objcg,
> > > >  bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size=
);
> > > >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t si=
ze);
> > > > +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
> > > >  #else
> > > >  static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > >  {
> > > > @@ -1944,6 +1951,11 @@ static inline void obj_cgroup_uncharge_zswap=
(struct obj_cgroup *objcg,
> > > >                                              size_t size)
> > > >  {
> > > >  }
> > > > +static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_c=
group *memcg)
> > > > +{
> > > > +       /* if zswap is disabled, do not block pages going to the sw=
apping device */
> > > > +       return true;
> > > > +}
> > > >  #endif
> > > >
> > > >  #endif /* _LINUX_MEMCONTROL_H */
> > > > diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> > > > index cbd373ba88d2..b4997e27a74b 100644
> > > > --- a/include/linux/zswap.h
> > > > +++ b/include/linux/zswap.h
> > > > @@ -35,6 +35,7 @@ void zswap_swapoff(int type);
> > > >  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
> > > >  void zswap_lruvec_state_init(struct lruvec *lruvec);
> > > >  void zswap_lruvec_swapin(struct page *page);
> > > > +bool is_zswap_enabled(void);
> > > >  #else
> > > >
> > > >  struct zswap_lruvec_state {};
> > > > @@ -55,6 +56,11 @@ static inline void zswap_swapoff(int type) {}
> > > >  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *=
memcg) {}
> > > >  static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
> > > >  static inline void zswap_lruvec_swapin(struct page *page) {}
> > > > +
> > > > +static inline bool is_zswap_enabled(void)
> > > > +{
> > > > +       return false;
> > > > +}
> > > >  #endif
> > > >
> > > >  #endif /* _LINUX_ZSWAP_H */
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 786c7edf5836..5ad71ce31c74 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -5522,6 +5522,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_sta=
te *parent_css)
> > > >         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > >         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> > > > +       WRITE_ONCE(memcg->zswap_writeback,
> > > > +               !parent || READ_ONCE(parent->zswap_writeback));
> > > >  #endif
> > > >         page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> > > >         if (parent) {
> > > > @@ -8146,6 +8148,12 @@ void obj_cgroup_uncharge_zswap(struct obj_cg=
roup *objcg, size_t size)
> > > >         rcu_read_unlock();
> > > >  }
> > > >
> > > > +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > > > +{
> > > > +       /* if zswap is disabled, do not block pages going to the sw=
apping device */
> > > > +       return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zs=
wap_writeback);
> > > > +}
> > > > +
> > > >  static u64 zswap_current_read(struct cgroup_subsys_state *css,
> > > >                               struct cftype *cft)
> > > >  {
> > > > @@ -8176,6 +8184,31 @@ static ssize_t zswap_max_write(struct kernfs=
_open_file *of,
> > > >         return nbytes;
> > > >  }
> > > >
> > > > +static int zswap_writeback_show(struct seq_file *m, void *v)
> > > > +{
> > > > +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> > > > +
> > > > +       seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static ssize_t zswap_writeback_write(struct kernfs_open_file *of,
> > > > +                               char *buf, size_t nbytes, loff_t of=
f)
> > > > +{
> > > > +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of)=
);
> > > > +       int zswap_writeback;
> > > > +       ssize_t parse_ret =3D kstrtoint(strstrip(buf), 0, &zswap_wr=
iteback);
> > > > +
> > > > +       if (parse_ret)
> > > > +               return parse_ret;
> > > > +
> > > > +       if (zswap_writeback !=3D 0 && zswap_writeback !=3D 1)
> > > > +               return -EINVAL;
> > > > +
> > > > +       WRITE_ONCE(memcg->zswap_writeback, zswap_writeback);
> > > > +       return nbytes;
> > > > +}
> > > > +
> > > >  static struct cftype zswap_files[] =3D {
> > > >         {
> > > >                 .name =3D "zswap.current",
> > > > @@ -8188,6 +8221,11 @@ static struct cftype zswap_files[] =3D {
> > > >                 .seq_show =3D zswap_max_show,
> > > >                 .write =3D zswap_max_write,
> > > >         },
> > > > +       {
> > > > +               .name =3D "zswap.writeback",
> > > > +               .seq_show =3D zswap_writeback_show,
> > > > +               .write =3D zswap_writeback_write,
> > > > +       },
> > > >         { }     /* terminate */
> > > >  };
> > > >  #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
> > > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > > index cb559ae324c6..5e606f1aa2f6 100644
> > > > --- a/mm/page_io.c
> > > > +++ b/mm/page_io.c
> > > > @@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct w=
riteback_control *wbc)
> > > >                 folio_end_writeback(folio);
> > > >                 return 0;
> > > >         }
> > > > +
> > > > +       if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))=
) {
> > > > +               folio_mark_dirty(folio);
> > > > +               return AOP_WRITEPAGE_ACTIVATE;
> > > > +       }
> > > > +
> > > >         __swap_writepage(&folio->page, wbc);
> > > >         return 0;
> > > >  }
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index 0d1ce70bce38..ccbaaa5f1c16 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -1514,8 +1514,7 @@ static int shmem_writepage(struct page *page,=
 struct writeback_control *wbc)
> > > >
> > > >                 mutex_unlock(&shmem_swaplist_mutex);
> > > >                 BUG_ON(folio_mapped(folio));
> > > > -               swap_writepage(&folio->page, wbc);
> > > > -               return 0;
> > > > +               return swap_writepage(&folio->page, wbc);
> > > >         }
> > > >
> > > >         mutex_unlock(&shmem_swaplist_mutex);
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 943090dfe793..caa467e40009 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -152,6 +152,11 @@ module_param_named(exclusive_loads, zswap_excl=
usive_loads_enabled, bool, 0644);
> > > >  static bool zswap_shrinker_enabled;
> > > >  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool,=
 0644);
> > > >
> > > > +bool is_zswap_enabled(void)
> > > > +{
> > > > +       return zswap_enabled;
> > > > +}
> > > > +
> > > >  /*********************************
> > > >  * data structures
> > > >  **********************************/
> > > > @@ -589,6 +594,9 @@ static unsigned long zswap_shrinker_scan(struct=
 shrinker *shrinker,
> > > >         struct zswap_pool *pool =3D shrinker->private_data;
> > > >         bool encountered_page_in_swapcache =3D false;
> > > >
> > > > +       if (!mem_cgroup_zswap_writeback_enabled(sc->memcg))
> > > > +               return SHRINK_STOP;
> > > > +
> > > >         nr_protected =3D
> > > >                 atomic_long_read(&lruvec->zswap_lruvec_state.nr_zsw=
ap_protected);
> > > >         lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> > > > @@ -619,6 +627,9 @@ static unsigned long zswap_shrinker_count(struc=
t shrinker *shrinker,
> > > >         struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DAT=
A(sc->nid));
> > > >         unsigned long nr_backing, nr_stored, nr_freeable, nr_protec=
ted;
> > > >
> > > > +       if (!mem_cgroup_zswap_writeback_enabled(memcg))
> > > > +               return 0;
> > > > +
> > > >  #ifdef CONFIG_MEMCG_KMEM
> > > >         cgroup_rstat_flush(memcg->css.cgroup);
> > > >         nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PA=
GE_SHIFT;
> > > > @@ -934,6 +945,9 @@ static int shrink_memcg(struct mem_cgroup *memc=
g)
> > > >         struct zswap_pool *pool;
> > > >         int nid, shrunk =3D 0;
> > > >
> > > > +       if (!mem_cgroup_zswap_writeback_enabled(memcg))
> > > > +               return -EINVAL;
> > > > +
> > > >         /*
> > > >          * Skip zombies because their LRUs are reparented and we wo=
uld be
> > > >          * reclaiming from the parent instead of the dead memcg.
> > > > --
> > > > 2.34.1
> >
