Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF50782CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjHUPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbjHUPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:12:12 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF355BC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:12:09 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-48d1412c5c5so458842e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692630729; x=1693235529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9B1WPg720c/UQRGbMagsKGeB4rOW/mtgVsxIYWp3tA=;
        b=fxUNbRDhpRpYCBSAiHqbwRz6bNhKuhdlw2QIcmURMGxdCR1bZ+YSXFWUzOynutlUC6
         WywY3pVpEXrT4OgvY/IhfHUFfSBPlOIK+PGVQESGGum2M1RPHF5yTH4MjwAT/kDVhQK4
         6y44lbQG8h4Xcgwh6Csm+E6D8rge1E2WgXefVV7bqphsnvUDYUbCp4xuK2v4hUsrriTr
         HXEKp93CbMWvVcOdnFJwE1ezTcPWr4o4F7SAePWC53OSe9JY4lj7uqT5Xi+pzCW6decP
         LPho8MYH98fCJgCf4cNRlyMyI9V4IFhWuTEYlrwi+VnZtqI23CeivMIDIWoSvF6aAuuk
         P6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692630729; x=1693235529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9B1WPg720c/UQRGbMagsKGeB4rOW/mtgVsxIYWp3tA=;
        b=eGRBO7iNvQW1CVKxqwiehO1yl53dUaP3UZuFPoL9JBhEeYcblIOIlmpxomkYw0jLWU
         tf5qeUuCjhCQt2T9bkCpbFffoJwSJ3fT2aWAaq5cjYPiVquEqttexprNXmoc6v6h4B8A
         7vOlwMkc7DzMiSHD1hkOptvefv1+TaQMyjOxkSxxdI7iYVvKgpmDSEerOKIigGUHoUjW
         tVfXlRvRDMK4XVWi8Zl4O8H6kXXWdYREhIIPtOxYqgGlbVGKtHf6UAoSec/ls/nN0FCb
         KsZRQ8xB8qBYU/h/IpD10nnu3MGlhwcNALbOfCyFTAl/7y+QziJ6RzMGyWRh34++a0Tb
         D01A==
X-Gm-Message-State: AOJu0YxYGRSEsVKQRUDE22KyLYBlhf10HwFqrAfk+m112GK57vSztUDj
        Mwkwmm53623Y/sDQlpWtGiEz264Hi6i30/H41kk=
X-Google-Smtp-Source: AGHT+IEZA1kBL3yVlQA44VcyLySARltBr4dHnEz7Xo7TabNRoZse8HXfYwb0zXbiKDqJgOQSGz0aoz8SS6dSpdDBE3o=
X-Received: by 2002:a1f:66c1:0:b0:48f:87d6:f039 with SMTP id
 a184-20020a1f66c1000000b0048f87d6f039mr12785vkc.2.1692630728876; Mon, 21 Aug
 2023 08:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230723190906.4082646-1-42.hyeyoo@gmail.com> <20230723190906.4082646-2-42.hyeyoo@gmail.com>
 <7a94996f-b6f0-c427-eb1e-126bcb97930c@suse.cz>
In-Reply-To: <7a94996f-b6f0-c427-eb1e-126bcb97930c@suse.cz>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 22 Aug 2023 00:11:56 +0900
Message-ID: <CAB=+i9QmqJTCN4NZTxW3=hGLCN5hDH6wS2seFbZbU0A-PyMP0A@mail.gmail.com>
Subject: Re: [RFC 1/2] Revert "mm, slub: change percpu partial accounting from
 objects to pages"
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Binder Makin <merimus@google.com>, aneesh.kumar@linux.ibm.com,
        tsahu@linux.ibm.com, piyushs@linux.ibm.com, fengwei.yin@intel.com,
        ying.huang@intel.com, lkp <lkp@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Cc Jesper - he might have an opinion on this. ]

On Wed, Jul 26, 2023 at 7:34=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Nit: I would change the subject from "Revert: " as it's not a revert
> exactly. If we can come up with a good subject that's not very long :)

Will do :)

> On 7/23/23 21:09, Hyeonggon Yoo wrote:
> > This is partial revert of commit b47291ef02b0 ("mm, slub: change percpu
> > partial accounting from objects to pages"). and full revert of commit
> > 662188c3a20e ("mm/slub: Simplify struct slab slabs field definition").
> >
> > While b47291ef02b0 prevents percpu partial slab list becoming too long,
> > it assumes that the order of slabs are always oo_order(s->oo).

> I think I've considered this possibility, but decided it's not important
> because if the system becomes memory pressured in a way that it can't
> allocate the oo_order() and has to fallback, we no longer care about
> accurate percpu caching, as we're unlikely having optimum performance any=
way.

But it does not perform any direct reclamation/compaction to allocate
high order slabs,
so isn't it an easier condition to happen than that?

> > The current approach can surprisingly lower the number of objects cache=
d
> > per cpu when it fails to allocate high order slabs. Instead of accounti=
ng
> > the number of slabs, change it back to accounting objects, but keep
> > the assumption that the slab is always half-full.
>
> That's a nice solution as that avoids converting the sysfs variable, so I
> wouldn't mind going that way even if I doubt the performance benefits in =
a
> memory pressured system.

> But maybe there's a concern that if the system is
> really memory pressured and has to fallback to smaller orders, before thi=
s
> patch it would keep fewer percpu partial slabs than after this patch, whi=
ch
> would increase the pressure further and thus be counter-productive?

You mean SLUB needs to stop per-cpu caching when direct/or indirect
reclamation is desired?

> > With this change, the number of cached objects per cpu is not surprisin=
gly
> > decreased even when it fails to allocate high order slabs. It still
> > prevents large inaccuracy because it does not account based on the
> > number of free objects when taking slabs.
> > ---
> >  include/linux/slub_def.h |  2 --
> >  mm/slab.h                |  6 ++++++
> >  mm/slub.c                | 31 ++++++++++++-------------------
> >  3 files changed, 18 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > index deb90cf4bffb..589ff6a2a23f 100644
> > --- a/include/linux/slub_def.h
> > +++ b/include/linux/slub_def.h
> > @@ -109,8 +109,6 @@ struct kmem_cache {
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> >       /* Number of per cpu partial objects to keep around */
> >       unsigned int cpu_partial;
> > -     /* Number of per cpu partial slabs to keep around */
> > -     unsigned int cpu_partial_slabs;
> >  #endif
> >       struct kmem_cache_order_objects oo;
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 799a315695c6..be38a264df16 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -65,7 +65,13 @@ struct slab {
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> >                               struct {
> >                                       struct slab *next;
> > +#ifdef CONFIG_64BIT
> >                                       int slabs;      /* Nr of slabs le=
ft */
> > +                                     int pobjects;   /* Approximate co=
unt */
> > +#else
> > +                                     short int slabs;
> > +                                     short int pobjects;
> > +#endif
> >                               };
> >  #endif
> >                       };
> > diff --git a/mm/slub.c b/mm/slub.c
> > index f7940048138c..199d3d03d5b9 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -486,18 +486,7 @@ static inline unsigned int oo_objects(struct kmem_=
cache_order_objects x)
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> >  static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr=
_objects)
> >  {
> > -     unsigned int nr_slabs;
> > -
> >       s->cpu_partial =3D nr_objects;
> > -
> > -     /*
> > -      * We take the number of objects but actually limit the number of
> > -      * slabs on the per cpu partial list, in order to limit excessive
> > -      * growth of the list. For simplicity we assume that the slabs wi=
ll
> > -      * be half-full.
> > -      */
> > -     nr_slabs =3D DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
> > -     s->cpu_partial_slabs =3D nr_slabs;
> >  }
> >  #else
> >  static inline void
> > @@ -2275,7 +2264,7 @@ static void *get_partial_node(struct kmem_cache *=
s, struct kmem_cache_node *n,
> >       struct slab *slab, *slab2;
> >       void *object =3D NULL;
> >       unsigned long flags;
> > -     unsigned int partial_slabs =3D 0;
> > +     int objects_taken =3D 0;
> >
> >       /*
> >        * Racy check. If we mistakenly see no partial slabs then we
> > @@ -2312,11 +2301,11 @@ static void *get_partial_node(struct kmem_cache=
 *s, struct kmem_cache_node *n,
> >               } else {
> >                       put_cpu_partial(s, slab, 0);
> >                       stat(s, CPU_PARTIAL_NODE);
> > -                     partial_slabs++;
> > +                     objects_taken +=3D slab->objects / 2;
> >               }
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> >               if (!kmem_cache_has_cpu_partial(s)
> > -                     || partial_slabs > s->cpu_partial_slabs / 2)
> > +                     || objects_taken > s->cpu_partial / 2)
> >                       break;
> >  #else
> >               break;
> > @@ -2699,13 +2688,14 @@ static void put_cpu_partial(struct kmem_cache *=
s, struct slab *slab, int drain)
> >       struct slab *slab_to_unfreeze =3D NULL;
> >       unsigned long flags;
> >       int slabs =3D 0;
> > +     int pobjects =3D 0;
> >
> >       local_lock_irqsave(&s->cpu_slab->lock, flags);
> >
> >       oldslab =3D this_cpu_read(s->cpu_slab->partial);
> >
> >       if (oldslab) {
> > -             if (drain && oldslab->slabs >=3D s->cpu_partial_slabs) {
> > +             if (drain && oldslab->pobjects >=3D s->cpu_partial) {
> >                       /*
> >                        * Partial array is full. Move the existing set t=
o the
> >                        * per node partial list. Postpone the actual unf=
reezing
> > @@ -2714,14 +2704,17 @@ static void put_cpu_partial(struct kmem_cache *=
s, struct slab *slab, int drain)
> >                       slab_to_unfreeze =3D oldslab;
> >                       oldslab =3D NULL;
> >               } else {
> > +                     pobjects =3D oldslab->pobjects;
> >                       slabs =3D oldslab->slabs;
> >               }
> >       }
> >
> >       slabs++;
> > +     pobjects +=3D slab->objects / 2;
> >
> >       slab->slabs =3D slabs;
> >       slab->next =3D oldslab;
> > +     slab->pobjects =3D pobjects;
> >
> >       this_cpu_write(s->cpu_slab->partial, slab);
> >
> > @@ -5653,13 +5646,13 @@ static ssize_t slabs_cpu_partial_show(struct km=
em_cache *s, char *buf)
> >
> >               slab =3D slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu=
));
> >
> > -             if (slab)
> > +             if (slab) {
> >                       slabs +=3D slab->slabs;
> > +                     objects +=3D slab->objects;
> > +             }
> >       }
> >  #endif
> >
> > -     /* Approximate half-full slabs, see slub_set_cpu_partial() */
> > -     objects =3D (slabs * oo_objects(s->oo)) / 2;
> >       len +=3D sysfs_emit_at(buf, len, "%d(%d)", objects, slabs);
> >
> >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> > @@ -5669,7 +5662,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem=
_cache *s, char *buf)
> >               slab =3D slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu=
));
> >               if (slab) {
> >                       slabs =3D READ_ONCE(slab->slabs);
> > -                     objects =3D (slabs * oo_objects(s->oo)) / 2;
> > +                     objects =3D READ_ONCE(slab->pobjects);
> >                       len +=3D sysfs_emit_at(buf, len, " C%d=3D%d(%d)",
> >                                            cpu, objects, slabs);
> >               }
>
