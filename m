Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED6804331
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbjLEAU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjLEAUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:20:24 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07220FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:20:30 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4b2ce4ffb0cso698299e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735629; x=1702340429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5bLYrX5YTJX4H6MnsGRPEGJTo5dwitg3APNnKg8kiU=;
        b=Fp1qbUidctI9SoRAlYdG5IIHcbNaNJpnwqcWHBwR0jwOXs15wnTzXJ2Sk7FmTI6CbK
         Y33CtG2qdP+i5sduCzHRBibvpIB4nk9Ef7LCanqulnc2o9fPWk6kmN3dIfwctLjoKDFh
         DeJHEkkK+E1hxEv0FGtYMJt51Aza+b/AJiDb7yZ2GKLt1sTk9DDLKD/cC/qSP90Auv1N
         yugzWmytxYSCXJtBqol4bNHtQkEPoAE7MpKoMcdXP68dscAnst59XA/i8bfASN4snyoB
         0n7+IcGd7EbEkxCY4tBuu9L04a8IYtm2b246cYjHJCMLQM+VSXynnrYLqxFmiZlAT8EU
         kWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735629; x=1702340429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5bLYrX5YTJX4H6MnsGRPEGJTo5dwitg3APNnKg8kiU=;
        b=MyWJiNaYnaOch6DDeLTcJ2mJJupRrmNMOD5zG6uv2unW38cMT/w1fOscNWjqWjlbEL
         ZVL3UpOk0ZzVjTAdT1OUxTfTIAMz3oRiPeYPAyMX/jDZhfTbvRN1iops0WKHHFlka/n2
         JPPcjLjdUJn2fiPrfqALa2NJLOyHZpiqHfHyoFJ33eg+l9g+GIiK822+dFNkOCUIXOAP
         mdJDpQqTVOr2ElHkGz+L1KT9Z5dXu9hYYQay5JIuh3jtoAZgOkFJHz1XRPv2q0g3T+B+
         qnjCOG2YObmWX/0caPKY+1xo8OV2OEVg1G2uYI/2CR7vqJAhWctprL24x8bQ87zQKLeR
         ZjYw==
X-Gm-Message-State: AOJu0YykpBVHvZV+14r3x+k4kk+uoZkkOz3M23mZVR3L8nRzU/quaVzZ
        fNWTUnW33ccZiqWRbKyaDNd9Ejdw7ANFuZ6tMsY=
X-Google-Smtp-Source: AGHT+IGnKVGoNBNAJmW7CV96jPzWc2+Vep8/SrLvCCqAVIXoe4Hf+5kL/epSi+naWzFLUNBzYCwzWa2kefZhb5Z+C3k=
X-Received: by 2002:a05:6122:da5:b0:496:248e:43fc with SMTP id
 bc37-20020a0561220da500b00496248e43fcmr3134948vkb.8.1701735628937; Mon, 04
 Dec 2023 16:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-8-chengming.zhou@linux.dev> <CAB=+i9RR-n4q5NU6LFqmhM8ys4kM0SPqwj0zYtr4twu=yYmPPA@mail.gmail.com>
 <93dcdf0c-336b-cb20-d646-7a48d872e08c@suse.cz>
In-Reply-To: <93dcdf0c-336b-cb20-d646-7a48d872e08c@suse.cz>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 5 Dec 2023 09:20:17 +0900
Message-ID: <CAB=+i9RxKrweScgSEv3m9fzuKoa1_gm7nowQamaDAs8XNh-6cQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] slub: Optimize deactivate_slab()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org,
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

On Tue, Dec 5, 2023 at 2:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 12/3/23 10:23, Hyeonggon Yoo wrote:
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
> >                                                spin_lock(&n->list_lock)
> >                                                (slab's empty but not
> > on partial list,
> >
> > spin_unlock(&n->list_lock) and return)
> > spin_lock(&n->list_lock)
> > put slab into partial list
> > spin_unlock(&n->list_lock)
> >
> > IMHO it should be fine in the real world, but just wanted to
> > mention as it doesn't seem to be intentional.
>
> I've noticed it too during review, but then realized it's not a new
> behavior, same thing could happen with deactivate_slab() already before t=
he
> series.

Ah, you are right.

>  Free slabs on partial list are supported, we even keep some
> intentionally as long as "n->nr_partial < s->min_partial" (and that check=
 is
> racy too) so no need to try making this more strict.

Agreed.

> > Otherwise it looks good to me!
>
> Good enough for a reviewed-by? :)

Yes,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!
--
Hyeonggon
