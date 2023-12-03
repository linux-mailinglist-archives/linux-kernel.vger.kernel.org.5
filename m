Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D558022AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjLCLTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjLCLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:19:44 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CEE10E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:19:50 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77dd54d9da2so250490285a.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701602390; x=1702207190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw+/5qq37rQrr1uVu+tKsvD2lTjhdzLYaYrSz1LEfBY=;
        b=EqRTHxh1MumMP/SI4s2sxupUZTYM8WoE96qVu7sSyfllV5rjV775fdW5B8/fP4YNSR
         GWBtaVmLcdK0gB962cgsTFkZHmCF2spp2NGhB5iWZILShnwJIed4SqlddH8cDR/ovgP7
         khbhtRtigi7hJfpcdm3LoetcLhusFqos4Nzspa9ZP5l7/SsWPfiCYY3PypC0z3z6P4Lo
         UfpxAlAC3kXzm40eHiygoY1HSxq6kFYkJsmrLUAy4n1DUZt6vOUg5DZ/PSFbvhHRU5Ry
         z2ARZ73vFclNFlZieo4LjvwvDNRnc/9WfK17HJIXNKKrWYvb6Tz1uiGAQSM38ImWm9Dz
         3oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602390; x=1702207190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw+/5qq37rQrr1uVu+tKsvD2lTjhdzLYaYrSz1LEfBY=;
        b=o8sSqH6VrCXr9n64MSmkP7SRuix/7UgyeHgmTRnwWHXMLpn1mYMkXdVXmWmHRRaVpg
         NNTb3tN32WrjZWD+ugcA0r4Vc3uP7Q40q8rqgLwdsCKSBHheRAdRCm/dYBnq6plPZTsy
         1fyJOtNOLUkBh01EpxJMzLFSw4bYbxtV1VYylurZjcK7WvoJd1FtH2AYRolcTkDLbXXT
         hxvrGxPoQaUJPOxNmIkarFn31y8DN3NQMm0a2pd/CNWUJ66YN8LFp9UMgqxuPqh5/OKr
         XC4QQHCXgLfak8NKRU3oVbWztgHBqhnesUx3hoCtexgsWhWA2uEnLl8dHMmh1NrloXlp
         MfNQ==
X-Gm-Message-State: AOJu0YwlChktSYDATTTNmyLZ1pIAnoNR6mEV6dzzLxr0zZxVVe+PiXFc
        wj9ngKJ3js+fB8Hamf2+F5nN0gpeAIJxkW87PsM=
X-Google-Smtp-Source: AGHT+IHtR3/KcQdwOQzCPNMSV2WOidMSRhcsGQgfPHZTJ+W7zZsKFPQVwvjzRtuh35cMVjVUYJkiHYeuA8aiWSuME4g=
X-Received: by 2002:a05:620a:179e:b0:77e:fba3:81bd with SMTP id
 ay30-20020a05620a179e00b0077efba381bdmr3122145qkb.83.1701602389881; Sun, 03
 Dec 2023 03:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-8-chengming.zhou@linux.dev> <CAB=+i9RR-n4q5NU6LFqmhM8ys4kM0SPqwj0zYtr4twu=yYmPPA@mail.gmail.com>
 <af74599e-6384-4bcc-9773-d37b061eabdf@linux.dev>
In-Reply-To: <af74599e-6384-4bcc-9773-d37b061eabdf@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 3 Dec 2023 20:19:38 +0900
Message-ID: <CAB=+i9T+aLEj6BHdXXJxqY914O1ZVCbmL8iL_5wiFB3dQN6yUg@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] slub: Optimize deactivate_slab()
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 3, 2023 at 7:26=E2=80=AFPM Chengming Zhou <chengming.zhou@linux=
.dev> wrote:
>
> On 2023/12/3 17:23, Hyeonggon Yoo wrote:
> > On Thu, Nov 2, 2023 at 12:25=E2=80=AFPM <chengming.zhou@linux.dev> wrot=
e:
> >>
> >> From: Chengming Zhou <zhouchengming@bytedance.com>
> >>
> >> Since the introduce of unfrozen slabs on cpu partial list, we don't
> >> need to synchronize the slab frozen state under the node list_lock.
> >>
> >> The caller of deactivate_slab() and the caller of __slab_free() won't
> >> manipulate the slab list concurrently.
> >>
> >> So we can get node list_lock in the last stage if we really need to
> >> manipulate the slab list in this path.
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >> ---
> >>  mm/slub.c | 79 ++++++++++++++++++------------------------------------=
-
> >>  1 file changed, 26 insertions(+), 53 deletions(-)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index bcb5b2c4e213..d137468fe4b9 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2468,10 +2468,8 @@ static void init_kmem_cache_cpus(struct kmem_ca=
che *s)
> >>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
> >>                             void *freelist)
> >>  {
> >> -       enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
> >>         struct kmem_cache_node *n =3D get_node(s, slab_nid(slab));
> >>         int free_delta =3D 0;
> >> -       enum slab_modes mode =3D M_NONE;
> >>         void *nextfree, *freelist_iter, *freelist_tail;
> >>         int tail =3D DEACTIVATE_TO_HEAD;
> >>         unsigned long flags =3D 0;
> >> @@ -2509,65 +2507,40 @@ static void deactivate_slab(struct kmem_cache =
*s, struct slab *slab,
> >>         /*
> >>          * Stage two: Unfreeze the slab while splicing the per-cpu
> >>          * freelist to the head of slab's freelist.
> >> -        *
> >> -        * Ensure that the slab is unfrozen while the list presence
> >> -        * reflects the actual number of objects during unfreeze.
> >> -        *
> >> -        * We first perform cmpxchg holding lock and insert to list
> >> -        * when it succeed. If there is mismatch then the slab is not
> >> -        * unfrozen and number of objects in the slab may have changed=
.
> >> -        * Then release lock and retry cmpxchg again.
> >>          */
> >> -redo:
> >> -
> >> -       old.freelist =3D READ_ONCE(slab->freelist);
> >> -       old.counters =3D READ_ONCE(slab->counters);
> >> -       VM_BUG_ON(!old.frozen);
> >> -
> >> -       /* Determine target state of the slab */
> >> -       new.counters =3D old.counters;
> >> -       if (freelist_tail) {
> >> -               new.inuse -=3D free_delta;
> >> -               set_freepointer(s, freelist_tail, old.freelist);
> >> -               new.freelist =3D freelist;
> >> -       } else
> >> -               new.freelist =3D old.freelist;
> >> -
> >> -       new.frozen =3D 0;
> >> +       do {
> >> +               old.freelist =3D READ_ONCE(slab->freelist);
> >> +               old.counters =3D READ_ONCE(slab->counters);
> >> +               VM_BUG_ON(!old.frozen);
> >> +
> >> +               /* Determine target state of the slab */
> >> +               new.counters =3D old.counters;
> >> +               new.frozen =3D 0;
> >> +               if (freelist_tail) {
> >> +                       new.inuse -=3D free_delta;
> >> +                       set_freepointer(s, freelist_tail, old.freelist=
);
> >> +                       new.freelist =3D freelist;
> >> +               } else {
> >> +                       new.freelist =3D old.freelist;
> >> +               }
> >> +       } while (!slab_update_freelist(s, slab,
> >> +               old.freelist, old.counters,
> >> +               new.freelist, new.counters,
> >> +               "unfreezing slab"));
> >>
> >> +       /*
> >> +        * Stage three: Manipulate the slab list based on the updated =
state.
> >> +        */
> >
> > deactivate_slab() might unconsciously put empty slabs into partial list=
, like:
> >
> > deactivate_slab()                    __slab_free()
> > cmpxchg(), slab's not empty
> >                                                cmpxchg(), slab's empty
> > and unfrozen
>
> Hi,
>
> Sorry, but I don't get it here how __slab_free() can see the slab empty,
> since the slab is not empty from deactivate_slab() path, and it can't be
> used by any CPU at that time?

The scenario is CPU B previously allocated an object from slab X, but
put it into node partial list and then CPU A have taken slab X into cpu sla=
b.

While slab X is CPU A's cpu slab, when CPU B frees an object from slab X,
it puts the object into slab X's freelist using cmpxchg.

Let's say in CPU A the deactivation path performs cmpxchg and X.inuse was 1=
,
and then CPU B frees (__slab_free()) to slab X's freelist using cmpxchg,
_before_ slab X's put into partial list by CPU A.

Then CPU A thinks it's not empty so put it into partial list, but by CPU B
the slab has become empty.

Maybe I am confused, in that case please tell me I'm wrong :)

Thanks!

--
Hyeonggon
