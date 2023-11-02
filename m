Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2747DFBAA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKBUpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKBUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:45:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B48188;
        Thu,  2 Nov 2023 13:44:55 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7a996357550so52764939f.2;
        Thu, 02 Nov 2023 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698957895; x=1699562695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50vKYsztxFi6Mu/k6Ov5uTZGfMFZ7mgYO8Srlxulih8=;
        b=M08d1MmMg3JC0vk3sof4mqihTZI/O+wwwN4SSDBzReBpXaya4/6GtsgpQnLgV5B3Hk
         8og7GlH2dzymgzmOCeiYZeIoi7FF4/jhijNsgRF9wRNlFuKU/jW+83ODFUOfYpdZkbyd
         R1uhCtDtwwTMXrY81250MjT9M94DshiJ9mub61zEdrfNLaZUvQEMVtISWCYyLLWva2SU
         GmBgqddFJ7jTOoe1ep4TRArMsNELPBNO1v48Rd5yNlvaJBO6dbW2S3snBnmzTb8VPayB
         nwPTfxI8LXZW63/usF/Z6n10oidcNcV26u7sW9/LeSrI5iYSWjReLJVJd1Ag9SWSTsP3
         7iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698957895; x=1699562695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50vKYsztxFi6Mu/k6Ov5uTZGfMFZ7mgYO8Srlxulih8=;
        b=M7uLBhmfYH4ChO4ER+Ma8fLHBFVvRr8G2thSoiFEYaXvcprnia7yodPjVoPbdcqy0S
         0XnfvmSJ+pcbPP8DKCoL5ao0auu6ikuSi9+btBNgp2d8ZSHeamXNdDLvWdjqsWv9ZAKb
         kgg7WDoHPRUd8MWCULZq4o5J6oiBi8Hx9yLSa7fQLg2ZKVOmoHWe4phzxXMBugvDazwv
         //cxkQNp09YM8Ahj0P/J6T9HD+avv0enk/7dSTe9nmbq+Y3VSSF5CCZME5rIivcV9epF
         U8NI5OM0GjLb5RkgJgO4ewIa+YeF6nZ8YSSxCdAV7fC/woKB2hqHLvWrHnje0QN9sBWh
         uTcQ==
X-Gm-Message-State: AOJu0YzXB/Ew6r2v4DJJen1pu3/ipTDarN8YlZ8ukpFQgJeBrdpIabFF
        d4KPhzVjuNMDs60nOSw0hj+FY/2xLed6PxozdBo=
X-Google-Smtp-Source: AGHT+IFAaLeg+L9fCsZTKxjttd/6BsMumGduEW/vGZR1p4PkntwveknDBT/+BlWpB0N18+W8vK4RHenQP7tCJZ4Ak3k=
X-Received: by 2002:a05:6602:1655:b0:7a9:4090:b7d5 with SMTP id
 y21-20020a056602165500b007a94090b7d5mr27227266iow.13.1698957894818; Thu, 02
 Nov 2023 13:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231102200202.920461-1-nphamcs@gmail.com> <CAJD7tkY8iPBo99+1gdsSRMNDu4jkVKz8rb=W+xk9=GE0y=kSuw@mail.gmail.com>
In-Reply-To: <CAJD7tkY8iPBo99+1gdsSRMNDu4jkVKz8rb=W+xk9=GE0y=kSuw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 2 Nov 2023 13:44:43 -0700
Message-ID: <CAKEwX=MV-Rpq9K9+ddZES_kE_5WM6ri-wk1QRQ4Jv5SFMqhXgw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] zswap: memcontrol: implement zswap writeback disabling
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 1:28=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Nov 2, 2023 at 1:02=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
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
> >  include/linux/memcontrol.h              | 17 +++++++++++
> >  mm/memcontrol.c                         | 38 +++++++++++++++++++++++++
> >  mm/page_io.c                            |  6 ++++
> >  mm/shmem.c                              |  3 +-
> >  mm/zswap.c                              |  9 ++++++
> >  7 files changed, 88 insertions(+), 2 deletions(-)
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
> > index 95f6c9e60ed1..e3a3a06727dc 100644
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
> > @@ -1615,6 +1621,12 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_d=
ata_t *pgdat, int order,
> >  {
> >         return 0;
> >  }
> > +
> > +static inline bool mem_cgroup_swap_disk_enabled(struct mem_cgroup *mem=
cg)
> > +{
> > +       return false;
> > +}
> > +
>
> This seems to be a leftover from a prior version.

100%! Thanks for picking that up. Not sure why I didn't see it with my
grep and ctrl F. I'll send a fixlet/new version to remove this later.

It nominally depends on the shrinker series (which is currently under
cleanups - thanks for the suggestions over there too, Yosry) so no rush
in merging this in. Just wanna send this out early to hear people's
feedback about the implementation + naming.

>
> >  #endif /* CONFIG_MEMCG */
> >
> >  static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_ite=
m idx)
> > @@ -1931,6 +1943,7 @@ static inline void count_objcg_event(struct obj_c=
group *objcg,
> >  bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
> >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> > +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
> >  #else
> >  static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> >  {
> > @@ -1944,6 +1957,10 @@ static inline void obj_cgroup_uncharge_zswap(str=
uct obj_cgroup *objcg,
> >                                              size_t size)
> >  {
> >  }
> > +static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgrou=
p *memcg)
> > +{
> > +       return false;
> > +}
> >  #endif
> >
> >  #endif /* _LINUX_MEMCONTROL_H */
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e43b5aba8efc..b68c613c23a9 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5545,6 +5545,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *=
parent_css)
> >         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> >         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> > +       WRITE_ONCE(memcg->zswap_writeback, true);
> >  #endif
> >         page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> >         if (parent) {
> > @@ -8177,6 +8178,12 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup=
 *objcg, size_t size)
> >         rcu_read_unlock();
> >  }
> >
> > +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > +{
> > +       return cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg
> > +                       && READ_ONCE(memcg->zswap_writeback);
> > +}
> > +
> >  static u64 zswap_current_read(struct cgroup_subsys_state *css,
> >                               struct cftype *cft)
> >  {
> > @@ -8209,6 +8216,31 @@ static ssize_t zswap_max_write(struct kernfs_ope=
n_file *of,
> >         return nbytes;
> >  }
> >
> > +static int zswap_writeback_show(struct seq_file *m, void *v)
> > +{
> > +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> > +
> > +       seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
> > +       return 0;
> > +}
> > +
> > +static ssize_t zswap_writeback_write(struct kernfs_open_file *of,
> > +                               char *buf, size_t nbytes, loff_t off)
> > +{
> > +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> > +       int zswap_writeback;
> > +       ssize_t parse_ret =3D kstrtoint(strstrip(buf), 0, &zswap_writeb=
ack);
> > +
> > +       if (parse_ret)
> > +               return parse_ret;
> > +
> > +       if (zswap_writeback !=3D 0 && zswap_writeback !=3D 1)
> > +               return -EINVAL;
> > +
> > +       WRITE_ONCE(memcg->zswap_writeback, zswap_writeback);
> > +       return nbytes;
> > +}
> > +
> >  static struct cftype zswap_files[] =3D {
> >         {
> >                 .name =3D "zswap.current",
> > @@ -8221,6 +8253,12 @@ static struct cftype zswap_files[] =3D {
> >                 .seq_show =3D zswap_max_show,
> >                 .write =3D zswap_max_write,
> >         },
> > +       {
> > +               .name =3D "zswap.writeback",
> > +               .flags =3D CFTYPE_NOT_ON_ROOT,
> > +               .seq_show =3D zswap_writeback_show,
> > +               .write =3D zswap_writeback_write,
> > +       },
> >         { }     /* terminate */
> >  };
> >  #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index cb559ae324c6..5e606f1aa2f6 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct write=
back_control *wbc)
> >                 folio_end_writeback(folio);
> >                 return 0;
> >         }
> > +
> > +       if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
> > +               folio_mark_dirty(folio);
> > +               return AOP_WRITEPAGE_ACTIVATE;
> > +       }
> > +
>
> I am not a fan of this, because it will disable using disk swap if
> "zswap_writeback" is disabled, even if zswap is disabled or the page
> was never in zswap. The term zswap_writeback makes no sense here tbh.
>
> I am still hoping someone else will suggest better semantics, because
> honestly I can't think of anything. Perhaps something like
> memory.swap.zswap_only or memory.swap.types which accepts a string
> (e.g. "zswap"/"all",..).
>
> Don't take my suggestions strongly because I am not very fond of them.
>
> Can anyone else come back with better naming/semantics for "use zswap
> but nothing else when swapping"?

I discussed this a little bit with Johannes, and decided to go with
memory.zswap.writeback because zswap store failure is quite rare in practic=
e
(and will become even rarer once I have the time to get the storing
compressed objects to happen).

But still, I'm happy to hear any other naming suggestions! This (+ the shri=
nker
dependency) is why I send this as an RFC anyway.

>
> >         __swap_writepage(&folio->page, wbc);
> >         return 0;
> >  }
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index cab053831fea..e5044678de8b 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1514,8 +1514,7 @@ static int shmem_writepage(struct page *page, str=
uct writeback_control *wbc)
> >
> >                 mutex_unlock(&shmem_swaplist_mutex);
> >                 BUG_ON(folio_mapped(folio));
> > -               swap_writepage(&folio->page, wbc);
> > -               return 0;
> > +               return swap_writepage(&folio->page, wbc);
> >         }
> >
> >         mutex_unlock(&shmem_swaplist_mutex);
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 260e01180ee0..42a478d1a21f 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -590,6 +590,9 @@ static unsigned long zswap_shrinker_scan(struct shr=
inker *shrinker,
> >         struct zswap_pool *pool =3D shrinker->private_data;
> >         bool encountered_page_in_swapcache =3D false;
> >
> > +       if (!mem_cgroup_zswap_writeback_enabled(sc->memcg))
> > +               return SHRINK_STOP;
> > +
> >         nr_protected =3D
> >                 atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_p=
rotected);
> >         lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> > @@ -620,6 +623,9 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
> >         struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc=
->nid));
> >         unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> >
> > +       if (!mem_cgroup_zswap_writeback_enabled(memcg))
> > +               return 0;
> > +
> >  #ifdef CONFIG_MEMCG_KMEM
> >         cgroup_rstat_flush(memcg->css.cgroup);
> >         nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_S=
HIFT;
> > @@ -935,6 +941,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
> >         struct zswap_pool *pool;
> >         int nid, shrunk =3D 0;
> >
> > +       if (!mem_cgroup_zswap_writeback_enabled(memcg))
> > +               return -EINVAL;
> > +
> >         /*
> >          * Skip zombies because their LRUs are reparented and we would =
be
> >          * reclaiming from the parent instead of the dead memcg.
> > --
> > 2.34.1
