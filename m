Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC387DA1BD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbjJ0U1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjJ0U1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:27:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752091AA;
        Fri, 27 Oct 2023 13:27:14 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35742cbb670so7632045ab.2;
        Fri, 27 Oct 2023 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698438434; x=1699043234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6udusXCthzKh/xAvdY+MxJ5CxBrtxgKmZLklvEHKreY=;
        b=TvaCu++QadIEefAivduJtWt3qAWThBYlNdjFDmmmiKICso29YHZLaFDTDu5AvhGyOL
         F59RyHAQW/XiyROZTJHi9EVrV1K2AyzxobU053bgB34J8CqA/7J3zvuQwOQMT3jbNnsc
         ajlZRipdb+EEr8Wi34ES685ZFk9U9nuesLnqdq1e6QKc+8+TtgfzZv4YBAQ+SE+1UYB2
         sG79PJVK68vUYUkfkWrLZ4jc/6brfMMhqvOU7Qmvg4XjL0NdjqIbPL68jZVhaK1Haj5N
         SAWTDf2qpPecqLCoVKb5qxfnUfdzAj41aLQtqkSdtEFQ4sFku42VG31Nw/oCeqaF/3Wv
         NJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438434; x=1699043234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6udusXCthzKh/xAvdY+MxJ5CxBrtxgKmZLklvEHKreY=;
        b=Hx3htKWGyFivhLV5ubUCh4yQDBtlp4NjO4fVWqurlN+vYt+EL5b1hD021I6hctsduk
         Xkw5H1V2iVxI8Rb7dNDg0QhAgSqDrDqalPEb8gD0DGucJdD3DtbHT6rPMfqAN+PaJeZz
         NMWXeHx/YAEkArX7DmF9y2JXPdOxKzKn9tN2Xdby6I/20OfL+yOPvvR0ejEw2Chld1DU
         kxsyzCJTlYpV+wGD8dC9+GYiv4pv2IH8kF55jHz6J+m1nG2mOnUQSQPKSA3zgYiK/So5
         T1SXXha3T38Oku4/1Zvmcnfuywx4EZMge7TWN/6JRV3EYlU7hVl9MK/t50vVQ5WW0gcy
         MJDw==
X-Gm-Message-State: AOJu0YxkOiM0L8stGiaXJ7CoFohrA2oJyPzbRDAdAIJ7aD4Pkjjj8JUn
        1ayqbtCDDkk5eA5IL16pJ2orZrg10EZuTz9N004oFss4/2U=
X-Google-Smtp-Source: AGHT+IEFpLy8SJBDp44d/an0TRAg0bypeWeXDvFpnPzwghK5xpqvJZe5LBHGfMbO7xUYmiOC0cF4vEGJBhDmPGVngbQ=
X-Received: by 2002:a05:6e02:1d92:b0:357:4621:10eb with SMTP id
 h18-20020a056e021d9200b00357462110ebmr5144204ila.4.1698438433628; Fri, 27 Oct
 2023 13:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231024233501.2639043-1-nphamcs@gmail.com> <CAJD7tkZMn6x9Y2DZiNzSuM0TCvEGSoMp1q15=T3ENAFBtz1WuA@mail.gmail.com>
In-Reply-To: <CAJD7tkZMn6x9Y2DZiNzSuM0TCvEGSoMp1q15=T3ENAFBtz1WuA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 27 Oct 2023 13:27:02 -0700
Message-ID: <CAKEwX=PjGeqa_zLf6FV24iQLaH8EQ81HfKy3=e0fGrjZTvLiKw@mail.gmail.com>
Subject: Re: [RFC PATCH] memcontrol: implement swap bypassing
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 7:09=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Oct 24, 2023 at 4:35=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > During our experiment with zswap, we sometimes observe swap IOs due to
> > occasional zswap store failures and writebacks. These swapping IOs
> > prevent many users who cannot tolerate swapping from adopting zswap to
> > save memory and improve performance where possible.
> >
> > This patch adds the option to bypass swap entirely: do not swap when an
> > zswap store attempt fail, and do not write pages in the zswap pool back
> > to swap. The feature is disabled by default (to preserve the existing
> > behavior), and can be enabled on a cgroup-basis via a new cgroup file.
>
> I think the word "bypass" here is fairly confusing because zswap is
> considered as swap for all purposes, so we are not really bypassing
> swap. I think it should be something like memory.swap.disk or
> memory.swap.writeback or whatever the correct terminology is for
> non-zswap swap (which I honestly don't know). Writing 0 to such an
> interface would give the desired effect.

I'm honestly not very good at naming things... especially a novel
name that I cannot steal from a precedent...

I want something that means "going to zswap is acceptable, but please
don't go to slow swap". Hence, swap bypassing (swap in my mental
model is the slow thing that is under zswap).

(but I imagined memory.please.don't.go.to.slow.swap won't be very
popular either...)

memory.swap.disk is... acceptable, I guess? It technically could still be
wrong, as there's still zram, but we can sort of ignore that special case.
I still prefer memory.swap.bypass,  but I wouldn't be opposed to this
renaming.

Anyone with better naming suggestions should absolutely speak up!
Otherwise, I'll send a v2 renaming this to "memory.swap.disk" or
"memory.swap.disk_used"

>
> Same goes for the usage of the term in the code.
>
> >
> > Note that this is subtly different from setting memory.swap.max to 0, a=
s
> > it still allows for pages to be stored in the zswap pool (which itself
> > consumes swap space in its current form).
> >
> > This is the second attempt (spiritual successor) of the following patch=
:
> >
> > https://lore.kernel.org/linux-mm/20231017003519.1426574-2-nphamcs@gmail=
.com/
> >
> > and should be applied on top of the zswap shrinker series:
> >
> > https://lore.kernel.org/linux-mm/20231024203302.1920362-1-nphamcs@gmail=
.com/
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 11 +++++
> >  Documentation/admin-guide/mm/zswap.rst  |  6 +++
> >  include/linux/memcontrol.h              | 20 ++++++++++
> >  mm/memcontrol.c                         | 53 +++++++++++++++++++++++++
> >  mm/page_io.c                            |  6 +++
> >  mm/shmem.c                              |  8 +++-
> >  mm/zswap.c                              |  9 +++++
> >  7 files changed, 111 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 606b2e0eac4b..34306d70b3f7 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1657,6 +1657,17 @@ PAGE_SIZE multiple when read back.
> >         higher than the limit for an extended period of time.  This
> >         reduces the impact on the workload and memory management.
> >
> > +  memory.swap.bypass.enabled
> > +       A read-write single value file which exists on non-root
> > +       cgroups.  The default value is "0".
> > +
> > +       When this is set to 1, all swapping attempts are disabled.
> > +       Note that this is subtly different from setting memory.swap.max=
 to
> > +       0, as it still allows for pages to be written to the zswap pool
> > +       (which also consumes swap space in its current form). However,
> > +       zswap store failure will not lead to swapping, and zswap writeb=
acks
> > +       will be disabled altogether.
> > +
> >    memory.zswap.current
> >         A read-only single value file which exists on non-root
> >         cgroups.
> > diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/adm=
in-guide/mm/zswap.rst
> > index 522ae22ccb84..b7bf481a3e25 100644
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
> > +       echo 1 > /sys/fs/cgroup/<cgroup-name>/memory.swap.bypass.enable=
d
> > +
> >  When there is a sizable amount of cold memory residing in the zswap po=
ol, it
> >  can be advantageous to proactively write these cold pages to swap and =
reclaim
> >  the memory for other use cases. By default, the zswap shrinker is disa=
bled.
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index c1846e57011b..e481c5c609f2 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -221,6 +221,9 @@ struct mem_cgroup {
> >         unsigned long zswap_max;
> >  #endif
> >
> > +       /* bypass swap (on zswap failure and writebacks) */
> > +       bool swap_bypass_enabled;
> > +
> >         unsigned long soft_limit;
> >
> >         /* vmpressure notifications */
> > @@ -1157,6 +1160,13 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_d=
ata_t *pgdat, int order,
> >                                                 gfp_t gfp_mask,
> >                                                 unsigned long *total_sc=
anned);
> >
> > +static inline bool mem_cgroup_swap_bypass_enabled(struct mem_cgroup *m=
emcg)
> > +{
> > +       return memcg && READ_ONCE(memcg->swap_bypass_enabled);
> > +}
> > +
> > +bool mem_cgroup_swap_bypass_folio(struct folio *folio);
> > +
> >  #else /* CONFIG_MEMCG */
> >
> >  #define MEM_CGROUP_ID_SHIFT    0
> > @@ -1615,6 +1625,16 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_d=
ata_t *pgdat, int order,
> >  {
> >         return 0;
> >  }
> > +
> > +static inline bool mem_cgroup_swap_bypass_enabled(struct mem_cgroup *m=
emcg)
> > +{
> > +       return false;
> > +}
> > +
> > +static inline bool mem_cgroup_swap_bypass_folio(struct folio *folio)
> > +{
> > +       return false;
> > +}
> >  #endif /* CONFIG_MEMCG */
> >
> >  static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_ite=
m idx)
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 568d9d037a59..f231cf2f745b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7928,6 +7928,28 @@ bool mem_cgroup_swap_full(struct folio *folio)
> >         return false;
> >  }
> >
> > +bool mem_cgroup_swap_bypass_folio(struct folio *folio)
> > +{
> > +       struct obj_cgroup *objcg =3D get_obj_cgroup_from_folio(folio);
>
> This is a swapbacked LRU folio, which means that it will have a memcg,
> not an objcg, in folio->memcg_data (unless this changed recently and I
> missed it).
>
> This function will get the memcg from the folio, then get its objcg,
> then get its memcg again. I think this can be much simpler and no refs
> need to be acquired. I think the folio will always be isolated and
> locked here (but please do check). We can have a VM_BUG_ON() to ensure
> that. The comment above folio_memcg() states that isolated or locked
> folios should have stable memcgs.
>
> We might as well inline a call to folio_memcg() and use the memcg
> version directly, or keep a separate helper to put the VM_BUG_ON()'s.
> I don't feel strongly.

Oh right I forgot that there's a direct link from the folio to its memcg.
I'll fix this in the next version.

>
> > +       struct mem_cgroup *memcg;
> > +       bool ret;
> > +
> > +       if (!objcg)
> > +               return false;
> > +
> > +       if (mem_cgroup_disabled()) {
> > +               obj_cgroup_put(objcg);
> > +               return false;
> > +       }
> > +
> > +       memcg =3D get_mem_cgroup_from_objcg(objcg);
> > +       ret =3D mem_cgroup_swap_bypass_enabled(memcg);
> > +
> > +       mem_cgroup_put(memcg);
> > +       obj_cgroup_put(objcg);
> > +       return ret;
> > +}
> > +
> >  static int __init setup_swap_account(char *s)
> >  {
> >         pr_warn_once("The swapaccount=3D commandline option is deprecat=
ed. "
> > @@ -8013,6 +8035,31 @@ static int swap_events_show(struct seq_file *m, =
void *v)
> >         return 0;
> >  }
> >
> > +static int swap_bypass_enabled_show(struct seq_file *m, void *v)
> > +{
> > +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> > +
> > +       seq_printf(m, "%d\n", READ_ONCE(memcg->swap_bypass_enabled));
> > +       return 0;
> > +}
> > +
> > +static ssize_t swap_bypass_enabled_write(struct kernfs_open_file *of,
> > +                               char *buf, size_t nbytes, loff_t off)
> > +{
> > +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> > +       int swap_bypass_enabled;
> > +       ssize_t parse_ret =3D kstrtoint(strstrip(buf), 0, &swap_bypass_=
enabled);
> > +
> > +       if (parse_ret)
> > +               return parse_ret;
> > +
> > +       if (swap_bypass_enabled !=3D 0 && swap_bypass_enabled !=3D 1)
> > +               return -ERANGE;
>
> I don't think ERANGE is appropriate here. EINVAL should be used here
> AFACIT (and looking at other write handlers for memcg interfaces).

Oh I think I just copied this from another cgroup file. The idea was
that the range
of acceptable values is [0, 1]. But yeah, -EINVAL fits better here.

Will be fixed in v2.

>
> > +
> > +       WRITE_ONCE(memcg->swap_bypass_enabled, swap_bypass_enabled);
> > +       return nbytes;
> > +}
> > +
> >  static struct cftype swap_files[] =3D {
> >         {
> >                 .name =3D "swap.current",
> > @@ -8042,6 +8089,12 @@ static struct cftype swap_files[] =3D {
> >                 .file_offset =3D offsetof(struct mem_cgroup, swap_event=
s_file),
> >                 .seq_show =3D swap_events_show,
> >         },
> > +       {
> > +               .name =3D "swap.bypass.enabled",
> > +               .flags =3D CFTYPE_NOT_ON_ROOT,
> > +               .seq_show =3D swap_bypass_enabled_show,
> > +               .write =3D swap_bypass_enabled_write,
> > +       },
> >         { }     /* terminate */
> >  };
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index cb559ae324c6..0c84e1592c39 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct write=
back_control *wbc)
> >                 folio_end_writeback(folio);
> >                 return 0;
> >         }
> > +
> > +       if (mem_cgroup_swap_bypass_folio(folio)) {
> > +               folio_mark_dirty(folio);
> > +               return AOP_WRITEPAGE_ACTIVATE;
> > +       }
> > +
> >         __swap_writepage(&folio->page, wbc);
> >         return 0;
> >  }
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index cab053831fea..6ce1d4a7a48b 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1514,8 +1514,12 @@ static int shmem_writepage(struct page *page, st=
ruct writeback_control *wbc)
> >
> >                 mutex_unlock(&shmem_swaplist_mutex);
> >                 BUG_ON(folio_mapped(folio));
> > -               swap_writepage(&folio->page, wbc);
> > -               return 0;
> > +               /*
> > +                * Seeing AOP_WRITEPAGE_ACTIVATE here indicates swappin=
g is disabled on
> > +                * zswap store failure. Note that in that case the foli=
o is already
>
> The interface semantics is "bypassing" swap, or not writing to disk
> for swap. Let's keep it consistent and not mention zswap here.

This is leftover from an older iteration of the patch I think. Will be fixe=
d.

>
> > +                * re-marked dirty by swap_writepage()
> > +                */
> > +               return swap_writepage(&folio->page, wbc);
> >         }
> >
> >         mutex_unlock(&shmem_swaplist_mutex);
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index c40697f07ba3..f19e26d647a3 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -535,6 +535,9 @@ static unsigned long zswap_shrinker_scan(struct shr=
inker *shrinker,
> >         struct zswap_pool *pool =3D shrinker->private_data;
> >         bool encountered_page_in_swapcache =3D false;
> >
> > +       if (mem_cgroup_swap_bypass_enabled(sc->memcg))
> > +               return SHRINK_STOP;
> > +
> >         nr_protected =3D
> >                 atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_p=
rotected);
> >         lru_size =3D list_lru_shrink_count(&pool->list_lru, sc);
> > @@ -565,6 +568,9 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
> >         struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc=
->nid));
> >         unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> >
> > +       if (mem_cgroup_swap_bypass_enabled(memcg))
> > +               return 0;
> > +
> >  #ifdef CONFIG_MEMCG_KMEM
> >         cgroup_rstat_flush(memcg->css.cgroup);
> >         nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_S=
HIFT;
> > @@ -890,6 +896,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
> >         struct zswap_pool *pool;
> >         int nid, shrunk =3D 0;
> >
> > +       if (mem_cgroup_swap_bypass_enabled(memcg))
> > +               return -EINVAL;
> > +
> >         /*
> >          * Skip zombies because their LRUs are reparented and we would =
be
> >          * reclaiming from the parent instead of the dead memcg.
> > --
> > 2.34.1
