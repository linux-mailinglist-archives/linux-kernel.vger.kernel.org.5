Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D25805E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjLETJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLETJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:09:36 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56696B0;
        Tue,  5 Dec 2023 11:09:42 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d56fb336aso13246325ab.0;
        Tue, 05 Dec 2023 11:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701803381; x=1702408181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J729J8T0oHmAd28LiRHuVX32xW95nvOWkbAOq4Mb/cE=;
        b=bCj9CR4RG1oc8JzmakcENMmRaRnB2jWITkjq+c+HLUHKGH0hCjygUo3eHh5gKKJf1E
         IUO3lUqhiFJ0Qf8BbyTpq8M4so/cl6sbxDbkLxchja+lGJzcSUJ61ZKygwmk/3ujEzll
         hgnhhZbg8+lZvbe/+E802LnT+1/NzwjrrSGe2KUviDEekQmUyyOeygA6vsqnmQ8UQN42
         V1b7YG2R7/CqH9Xa/lhBGzSGrlHmrrtr+NOWSJU+5oBV6TRdOL/x2sO8YgeUnZ2MxrSc
         r2rh7hsK20yTm5x9vqKw7BtKZvGma0NmpJmKGtpXcWf+ifCwYvgH4O3T91+DLiM5Tw7O
         IfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803381; x=1702408181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J729J8T0oHmAd28LiRHuVX32xW95nvOWkbAOq4Mb/cE=;
        b=WToMx273/JV151KB6e8zbI4wh6TTksxuZev+Jf6H6RpF7tLT3Ycb87djTvQrFzvmFQ
         7pgkr5/2LO/IGx/j/7LnAEnucJ81sGm1IDjm+szXs8Komc584UDjtAHNIjDq0CDMZXc+
         AJNpU0EfsJq3AdrGfbm491fNBarRWdf/Z6NkbWnhycpCROpmofEyYfsQncELnSkj3p8R
         9k9TxcKMyn9YP17zVYscoCcgOLD9S5wWzOh+WNiSw/shBJ1ZOjbZfwpXUcXlZz1PeWby
         ZSBxK/l1jdqaUNQaZYozE9Pbdccw0YRE58EhNCYFaEFIhFuQjs0HGRXfqDxvOK2Lf//4
         pKWQ==
X-Gm-Message-State: AOJu0Yw5V6H7OomrOEd46LcjGw5IsVD7VwtxgtoLCXh5texwdvCWN6DC
        uc8NyUKWxW/069P3Azc9YMVgMJpr+hE1yuvQCtI=
X-Google-Smtp-Source: AGHT+IE2MjGPFNHCe+1rynSzRfDzuhYy+Elaw7KC+ql1s6Aba1jUjS/b0zNqFaH8LsgB+lOTg8RBGqEyfiUsqAT+7qg=
X-Received: by 2002:a92:d6d2:0:b0:35d:6741:600a with SMTP id
 z18-20020a92d6d2000000b0035d6741600amr4601683ilp.58.1701803381643; Tue, 05
 Dec 2023 11:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-4-nphamcs@gmail.com>
 <CAJD7tkbSKDZBEWxeau_orTRtarm0fCjcWJHVSZGDRp+ZJ1uLzw@mail.gmail.com>
 <CAKEwX=NXzpDbonY2K7O-bWJm60OE_FUGvyArpqyK9dLxhyvWAQ@mail.gmail.com> <CAJD7tkYPfHP-=vYdfjvAfYbhJi0kqJF13R5QjayzpSCGvF0qrw@mail.gmail.com>
In-Reply-To: <CAJD7tkYPfHP-=vYdfjvAfYbhJi0kqJF13R5QjayzpSCGvF0qrw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 5 Dec 2023 11:09:30 -0800
Message-ID: <CAKEwX=N8mHVr750-4NCQRAhp_RW5dG0Xux5TnvhP6satceapZw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] zswap: make shrinking memcg-aware
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Tue, Dec 5, 2023 at 11:00=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> [..]
> > > >  static void shrink_worker(struct work_struct *w)
> > > >  {
> > > >         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> > > >                                                 shrink_work);
> > > > +       struct mem_cgroup *memcg;
> > > >         int ret, failures =3D 0;
> > > >
> > > > +       /* global reclaim will select cgroup in a round-robin fashi=
on. */
> > > >         do {
> > > > -               ret =3D zswap_reclaim_entry(pool);
> > > > -               if (ret) {
> > > > -                       zswap_reject_reclaim_fail++;
> > > > -                       if (ret !=3D -EAGAIN)
> > > > +               spin_lock(&zswap_pools_lock);
> > > > +               pool->next_shrink =3D mem_cgroup_iter(NULL, pool->n=
ext_shrink, NULL);
> > > > +               memcg =3D pool->next_shrink;
> > > > +
> > > > +               /*
> > > > +                * We need to retry if we have gone through a full =
round trip, or if we
> > > > +                * got an offline memcg (or else we risk undoing th=
e effect of the
> > > > +                * zswap memcg offlining cleanup callback). This is=
 not catastrophic
> > > > +                * per se, but it will keep the now offlined memcg =
hostage for a while.
> > > > +                *
> > > > +                * Note that if we got an online memcg, we will kee=
p the extra
> > > > +                * reference in case the original reference obtaine=
d by mem_cgroup_iter
> > > > +                * is dropped by the zswap memcg offlining callback=
, ensuring that the
> > > > +                * memcg is not killed when we are reclaiming.
> > > > +                */
> > > > +               if (!memcg) {
> > > > +                       spin_unlock(&zswap_pools_lock);
> > > > +                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > > >                                 break;
> > > > +
> > > > +                       goto resched;
> > > > +               }
> > > > +
> > > > +               if (!mem_cgroup_online(memcg)) {
> > > > +                       /* drop the reference from mem_cgroup_iter(=
) */
> > > > +                       mem_cgroup_put(memcg);
> > >
> > > Probably better to use mem_cgroup_iter_break() here?
> >
> > mem_cgroup_iter_break(NULL, memcg) seems to perform the same thing, rig=
ht?
>
> Yes, but it's better to break the iteration with the documented API
> (e.g. if mem_cgroup_iter_break() changes to do extra work).

Hmm, a mostly aesthetic fix to me, but I don't have a strong opinion otherw=
ise.

>
> >
> > >
> > > Also, I don't see mem_cgroup_tryget_online() being used here (where I
> > > expected it to be used), did I miss it?
> >
> > Oh shoot yeah that was a typo - it should be
> > mem_cgroup_tryget_online(). Let me send a fix to that.
> >
> > >
> > > > +                       pool->next_shrink =3D NULL;
> > > > +                       spin_unlock(&zswap_pools_lock);
> > > > +
> > > >                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > > >                                 break;
> > > > +
> > > > +                       goto resched;
> > > >                 }
> > > > +               spin_unlock(&zswap_pools_lock);
> > > > +
> > > > +               ret =3D shrink_memcg(memcg);
> > >
> > > We just checked for online-ness above, and then shrink_memcg() checks
> > > it again. Is this intentional?
> >
> > Hmm these two checks are for two different purposes. The check above
> > is mainly to prevent accidentally undoing the offline cleanup callback
> > during memcg selection step. Inside shrink_memcg(), we check
> > onlineness again to prevent reclaiming from offlined memcgs - which in
> > effect will trigger the reclaim of the parent's memcg.
>
> Right, but two checks in close proximity are not doing a lot.
> Especially that the memcg online-ness can change right after the check
> inside shrink_memcg() anyway, so it's a best effort thing.
>
> Anyway, it shouldn't matter much. We can leave it.
>
> >
> > >
> > > > +               /* drop the extra reference */
> > >
> > > Where does the extra reference come from?
> >
> > The extra reference is from mem_cgroup_tryget_online(). We get two
> > references in the dance above - one from mem_cgroup_iter() (which can
> > be dropped) and one extra from mem_cgroup_tryget_online(). I kept the
> > second one in case the first one was dropped by the zswap memcg
> > offlining callback, but after reclaiming it is safe to just drop it.
>
> Right. I was confused by the missing mem_cgroup_tryget_online().
>
> >
> > >
> > > > +               mem_cgroup_put(memcg);
> > > > +
> > > > +               if (ret =3D=3D -EINVAL)
> > > > +                       break;
> > > > +               if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
> > > > +                       break;
> > > > +
> > > > +resched:
> > > >                 cond_resched();
> > > >         } while (!zswap_can_accept());
> > > > -       zswap_pool_put(pool);
> > > >  }
> > > >
> > > >  static struct zswap_pool *zswap_pool_create(char *type, char *comp=
ressor)
> [..]
> > > > @@ -1240,15 +1395,15 @@ bool zswap_store(struct folio *folio)
> > > >                 zswap_invalidate_entry(tree, dupentry);
> > > >         }
> > > >         spin_unlock(&tree->lock);
> > > > -
> > > > -       /*
> > > > -        * XXX: zswap reclaim does not work with cgroups yet. Witho=
ut a
> > > > -        * cgroup-aware entry LRU, we will push out entries system-=
wide based on
> > > > -        * local cgroup limits.
> > > > -        */
> > > >         objcg =3D get_obj_cgroup_from_folio(folio);
> > > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > -               goto reject;
> > > > +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > > > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > >
> > > Do we need a reference here? IIUC, this is folio_memcg() and the foli=
o
> > > is locked, so folio_memcg() should remain stable, no?
> >
> > Hmmm obj_cgroup_may_zswap() also holds a reference to the objcg's
> > memcg, so I just followed the patterns to be safe.
>
> Perhaps it's less clear inside obj_cgroup_may_zswap(). We can actually
> pass the folio to obj_cgroup_may_zswap(), add a debug check that the
> folio is locked, and avoid getting the ref there as well. That can be
> done separately. Perhaps Johannes can shed some light on this, if
> there's a different reason why getting a ref there is needed.
>
> For this change, I think the refcount manipulation is unnecessary.

Hmm true. I'm leaning towards playing it safe - worst case scenario,
we can send a follow up patch to optimize this (perhaps for both
places, if neither place requires pinning the memcg). But I'll wait
for Johannes to chime in with his opinions on the matter.

>
> >
> >
> > >
> > > Same for the call below.
> > >
> > > > +               if (shrink_memcg(memcg)) {
> > > > +                       mem_cgroup_put(memcg);
> > > > +                       goto reject;
> > > > +               }
> > > > +               mem_cgroup_put(memcg);
> > > > +       }
> > > >
> > > >         /* reclaim space if needed */
> > > >         if (zswap_is_full()) {
> [..]
