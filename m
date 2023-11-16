Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB197EE899
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKPVBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPVBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:01:07 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957CA4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:01:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso18364171fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700168459; x=1700773259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K89DjoItu0NFtmP3vFbUuL2XyCgLh5nq3+EJlwGIFi4=;
        b=hsKh2hfrzLu+pGubxD8Ve4+Ba7zh9mbJoD37vHOpr21gldSmoWDTG6AMp6+PPxkNHr
         ST8nhPRik83ShRBnOB2DLC0/36oWCXOe5ojfm4PNaJ+NZ/OnnGJqoNTlChrszmrh+TyS
         PzkOYkXKu8wW31vpT+KYp4JH1MpHfGis6U3podSRjNni3BoB8uUnUVpH/yIDqDKRAxsE
         raYCrQvGdjkMJAKtCgJo0R/vjeArC7u+1+8BTWxcDrsBPjmZPBIs81eGrlSHWqStHSFk
         crYchwQHk1Osf8rdg7v+1XFc70ukhF05NH6JBKDfJ/TMyvCjHl+It2kcRPANI55abPaM
         btyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700168459; x=1700773259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K89DjoItu0NFtmP3vFbUuL2XyCgLh5nq3+EJlwGIFi4=;
        b=RX/uJ/POYIjkKMWbt6ybKRfBbk+R2IrLGVOqoW3RtR71r6l39FoC8SzuPdRkbACzMz
         D0Oe5hQO7hcykbj6P21qkaUZ/71OAYMbIEJNwkhGfkeMymQFHkZlfvZX6vicXOjvzbsq
         vG2KcuUu2o1XzxMgKHEOx2u5qiVfByG5Bjb/hZAQ7pH9hyUjKj2uk60aQEt0isUtYxv6
         eE54yFKY4JM1vDROR5je0HIbLVdrVGAVHUX8PJ5Zy17CZEk2N9KS4EZ0mmZk4Pf64aUX
         hysikpUZETI9rFjB0pqSnSpW1M4GfW4atjiMRqL8UtwBePdvEc1TyIK+ujf1pfHcckpT
         m2Rw==
X-Gm-Message-State: AOJu0YwL4jFmEqrVVqdxsw3XZKUAE14hrJop+SCaJI6yL+P8MpGTHWzs
        YAtteP3rzO0Q33BePyOZby5g8CjCbIeW2j+h5CgLWA==
X-Google-Smtp-Source: AGHT+IF+fWvo19DQWMzO+SFobwi11le9ffLaHN6z6Q3H4khI9IetbxUJMF/iIEHzRoQontmfzBd9uCHZXht+80O1Yz8=
X-Received: by 2002:a2e:6f03:0:b0:2c4:fe14:a85 with SMTP id
 k3-20020a2e6f03000000b002c4fe140a85mr9397387ljc.18.1700168459066; Thu, 16 Nov
 2023 13:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20231115172344.4155593-1-nphamcs@gmail.com> <CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com>
In-Reply-To: <CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 16 Nov 2023 13:00:22 -0800
Message-ID: <CAJD7tkZ1U+YuvoBAnrXFxQDiQV2hXdbMG-gbzu64R8GLAtNAPA@mail.gmail.com>
Subject: Re: [PATCH v5] zswap: memcontrol: implement zswap writeback disabling
To:     Chris Li <chrisl@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:53=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> Hi Nhat,
>
> As we discussed, I just want to bounce some alternative ideas related
> to this write back disabled feature.
>
> Currently, the common usage case is zswap alone or zswap + SSD. We
> treat zswap and
> SSD as two different tiers with different swap in performance characteris=
tics.
> If we make it more generic, we can also have more than two swap tiers.
> e.g. we can have zswap, SSD, network swap or HDD swap.
> The disable flag is just one bit of information, it can't describe
> what is the next tier.if it is not the current swap file
> implementation .
>
> One idea is that we can have a more general swap_tier_list object to
> describe the order of the swap device, The system can have more than
> one such list to describe different combinations of the tier
> selection.
>
> Each memcg can have a pointer point to one of such swap_tier_list
> objects, replacing the disabled write back flag in this patch.
> When you swap out, it will just go through each tier in the list, try
> to swap it out.
>  This has some implications for the zswap shrink as well. It becomes a
> more generic "move swap out data to another tier". Generally need to
> load into the swap cache then write to another tier.
>
> Open question is how we deal with the swap cache index across
> different tiers. The zswap.writeback_disable will not be needed if we
> have a more generic swap tier framework.

I agree that this should be the long-term goal, and I suggested that
we make the interface more future-proof by making it more generic to
accept the types or tiers of swap allowed by the memcg:

https://lore.kernel.org/lkml/CAJD7tkY8iPBo99+1gdsSRMNDu4jkVKz8rb=3DW+xk9=3D=
GE0y=3DkSuw@mail.gmail.com/

Since we only have swap and zswap now, the implementation can be
similar to this code and basically just disable writeback if zswap is
the only allowed swapping mechanism. So we don't necessarily need to
have a full swap tiering implementation, but I agree with Chris that
at least having a future-proof interface to work with generic swap
tiering is preferrable.



>
> Chris
>
>
> On Wed, Nov 15, 2023 at 9:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
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
> > the previous behavior. Initially, writeback is enabled for the root
> > cgroup, and a newly created cgroup will inherit the current setting of
> > its parent.
> >
> > Note that this is subtly different from setting memory.swap.max to 0, a=
s
> > it still allows for pages to be stored in the zswap pool (which itself
> > consumes swap space in its current form).
> >
> > This patch should be applied on top of the zswap shrinker series:
> >
> > https://lore.kernel.org/lkml/20231106183159.3562879-1-nphamcs@gmail.com=
/
> >
> > as it also disables the zswap shrinker, a major source of zswap
> > writebacks.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++
> >  Documentation/admin-guide/mm/zswap.rst  |  6 ++++
> >  include/linux/memcontrol.h              | 12 ++++++++
> >  include/linux/zswap.h                   |  6 ++++
> >  mm/memcontrol.c                         | 38 +++++++++++++++++++++++++
> >  mm/page_io.c                            |  6 ++++
> >  mm/shmem.c                              |  3 +-
> >  mm/zswap.c                              | 14 +++++++++
> >  8 files changed, 95 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 3f85254f3cef..2b4ac43efdc8 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1679,6 +1679,18 @@ PAGE_SIZE multiple when read back.
> >         limit, it will refuse to take any more stores before existing
> >         entries fault back in or are written out to disk.
> >
> > +  memory.zswap.writeback
> > +       A read-write single value file. The default value is "1". The
> > +       initial value of the root cgroup is 1, and when a new cgroup is
> > +       created, it inherits the current value of its parent.
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
> > index 83590fd0d6d1..3901ff4dae63 100644
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
> > index 786c7edf5836..5ad71ce31c74 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5522,6 +5522,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *=
parent_css)
> >         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> >         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> > +       WRITE_ONCE(memcg->zswap_writeback,
> > +               !parent || READ_ONCE(parent->zswap_writeback));
> >  #endif
> >         page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> >         if (parent) {
> > @@ -8146,6 +8148,12 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup=
 *objcg, size_t size)
> >         rcu_read_unlock();
> >  }
> >
> > +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > +{
> > +       /* if zswap is disabled, do not block pages going to the swappi=
ng device */
> > +       return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zswap_=
writeback);
> > +}
> > +
> >  static u64 zswap_current_read(struct cgroup_subsys_state *css,
> >                               struct cftype *cft)
> >  {
> > @@ -8176,6 +8184,31 @@ static ssize_t zswap_max_write(struct kernfs_ope=
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
> > @@ -8188,6 +8221,11 @@ static struct cftype zswap_files[] =3D {
> >                 .seq_show =3D zswap_max_show,
> >                 .write =3D zswap_max_write,
> >         },
> > +       {
> > +               .name =3D "zswap.writeback",
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
> >         __swap_writepage(&folio->page, wbc);
> >         return 0;
> >  }
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 0d1ce70bce38..ccbaaa5f1c16 100644
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
> > index 943090dfe793..caa467e40009 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -152,6 +152,11 @@ module_param_named(exclusive_loads, zswap_exclusiv=
e_loads_enabled, bool, 0644);
> >  static bool zswap_shrinker_enabled;
> >  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 064=
4);
> >
> > +bool is_zswap_enabled(void)
> > +{
> > +       return zswap_enabled;
> > +}
> > +
> >  /*********************************
> >  * data structures
> >  **********************************/
> > @@ -589,6 +594,9 @@ static unsigned long zswap_shrinker_scan(struct shr=
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
> > @@ -619,6 +627,9 @@ static unsigned long zswap_shrinker_count(struct sh=
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
> > @@ -934,6 +945,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
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
