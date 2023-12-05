Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434B3805E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbjLETAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLETAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:00:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674A0CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 11:00:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1a0bc1e415so567896366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701802818; x=1702407618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjh7Ubx9BbyItPB9Xg+Qe9tw2FWSOXg11Jr74Wx0OFw=;
        b=DYyiwrx2vgX4CAZ/SiswikCjZdbTUmzq0LGOtUrVtQdtuHQlENuAmNAz+Yly78mZh5
         1dAA8cNXuqW8CCQFYLV4MdS2F/ZkOLWim0Z4PXe5E1oN92sbWg7UMQKIA4OzGK9k3Q0m
         f3KccnLPNccOzwwTKK5WlMTdWnHitx4Q0a007MXZ1U+cOT/wM0mzcNPD9ddu/e8sHTPi
         V0uFx/d/gPVfljzM65l6285FgIYwDPMZNV88QRGxCOYsHELTnHMcbpOv2t3BbHxGMqgC
         hxasdK3GOdXuBBVv6orZz2EzP5aooTex++brYNNXfurNgukAFk3u6A4AfNCQcHJ4awcN
         bXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802818; x=1702407618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjh7Ubx9BbyItPB9Xg+Qe9tw2FWSOXg11Jr74Wx0OFw=;
        b=E8oR/sYZjPH3jWjiBXfma0wMRVyHk9PoD35ad9ar7Ow+TyQHdISNAsS+YD8jQaXyek
         Oy0PKfjC3GHjQTICZROnVk5U0be2UPgR0dIbPTHl3/QpFvIoP/hQSjeEMxRR60FHlsJs
         covtEiKO6faHXH3YZcYGZOcXnaNKcLtX2bcRh9LeBX+nwtwGWS2UXgYzvXKddxVjp+o4
         l7Zi5oeM/VSa0BQKioppNJVW23UMfwbsmTasmArCJfbs91WDFMJkjv7KNWC2Jc7K735G
         9JBmll+w9tIM49LrlqfXlAML76zZ57l0uMxGU49ialZTCwjvBKqIh9GqdL32ENCkHBNw
         /YXA==
X-Gm-Message-State: AOJu0YwF557D66tKW4jfXAnWdFB282h/6vfafDC6BGRmtcb5zP+2fzrY
        5B1xCh7poM7HzfCAw3zLALoYCw6YofYABPhe2cNnlw==
X-Google-Smtp-Source: AGHT+IHgdcBdFf1UHwXVmyqpTmKQlO+VWkt+HaI2W2eYEZy5VFr0THrQhpyhuf+1LfRUz2o5Ld0BTwIYRpdFNaxq6yE=
X-Received: by 2002:a17:906:7487:b0:a1c:d0f7:3f7a with SMTP id
 e7-20020a170906748700b00a1cd0f73f7amr516860ejl.43.1701802817693; Tue, 05 Dec
 2023 11:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-4-nphamcs@gmail.com>
 <CAJD7tkbSKDZBEWxeau_orTRtarm0fCjcWJHVSZGDRp+ZJ1uLzw@mail.gmail.com> <CAKEwX=NXzpDbonY2K7O-bWJm60OE_FUGvyArpqyK9dLxhyvWAQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NXzpDbonY2K7O-bWJm60OE_FUGvyArpqyK9dLxhyvWAQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Dec 2023 10:59:41 -0800
Message-ID: <CAJD7tkYPfHP-=vYdfjvAfYbhJi0kqJF13R5QjayzpSCGvF0qrw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] zswap: make shrinking memcg-aware
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]
> > >  static void shrink_worker(struct work_struct *w)
> > >  {
> > >         struct zswap_pool *pool = container_of(w, typeof(*pool),
> > >                                                 shrink_work);
> > > +       struct mem_cgroup *memcg;
> > >         int ret, failures = 0;
> > >
> > > +       /* global reclaim will select cgroup in a round-robin fashion. */
> > >         do {
> > > -               ret = zswap_reclaim_entry(pool);
> > > -               if (ret) {
> > > -                       zswap_reject_reclaim_fail++;
> > > -                       if (ret != -EAGAIN)
> > > +               spin_lock(&zswap_pools_lock);
> > > +               pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
> > > +               memcg = pool->next_shrink;
> > > +
> > > +               /*
> > > +                * We need to retry if we have gone through a full round trip, or if we
> > > +                * got an offline memcg (or else we risk undoing the effect of the
> > > +                * zswap memcg offlining cleanup callback). This is not catastrophic
> > > +                * per se, but it will keep the now offlined memcg hostage for a while.
> > > +                *
> > > +                * Note that if we got an online memcg, we will keep the extra
> > > +                * reference in case the original reference obtained by mem_cgroup_iter
> > > +                * is dropped by the zswap memcg offlining callback, ensuring that the
> > > +                * memcg is not killed when we are reclaiming.
> > > +                */
> > > +               if (!memcg) {
> > > +                       spin_unlock(&zswap_pools_lock);
> > > +                       if (++failures == MAX_RECLAIM_RETRIES)
> > >                                 break;
> > > +
> > > +                       goto resched;
> > > +               }
> > > +
> > > +               if (!mem_cgroup_online(memcg)) {
> > > +                       /* drop the reference from mem_cgroup_iter() */
> > > +                       mem_cgroup_put(memcg);
> >
> > Probably better to use mem_cgroup_iter_break() here?
>
> mem_cgroup_iter_break(NULL, memcg) seems to perform the same thing, right?

Yes, but it's better to break the iteration with the documented API
(e.g. if mem_cgroup_iter_break() changes to do extra work).

>
> >
> > Also, I don't see mem_cgroup_tryget_online() being used here (where I
> > expected it to be used), did I miss it?
>
> Oh shoot yeah that was a typo - it should be
> mem_cgroup_tryget_online(). Let me send a fix to that.
>
> >
> > > +                       pool->next_shrink = NULL;
> > > +                       spin_unlock(&zswap_pools_lock);
> > > +
> > >                         if (++failures == MAX_RECLAIM_RETRIES)
> > >                                 break;
> > > +
> > > +                       goto resched;
> > >                 }
> > > +               spin_unlock(&zswap_pools_lock);
> > > +
> > > +               ret = shrink_memcg(memcg);
> >
> > We just checked for online-ness above, and then shrink_memcg() checks
> > it again. Is this intentional?
>
> Hmm these two checks are for two different purposes. The check above
> is mainly to prevent accidentally undoing the offline cleanup callback
> during memcg selection step. Inside shrink_memcg(), we check
> onlineness again to prevent reclaiming from offlined memcgs - which in
> effect will trigger the reclaim of the parent's memcg.

Right, but two checks in close proximity are not doing a lot.
Especially that the memcg online-ness can change right after the check
inside shrink_memcg() anyway, so it's a best effort thing.

Anyway, it shouldn't matter much. We can leave it.

>
> >
> > > +               /* drop the extra reference */
> >
> > Where does the extra reference come from?
>
> The extra reference is from mem_cgroup_tryget_online(). We get two
> references in the dance above - one from mem_cgroup_iter() (which can
> be dropped) and one extra from mem_cgroup_tryget_online(). I kept the
> second one in case the first one was dropped by the zswap memcg
> offlining callback, but after reclaiming it is safe to just drop it.

Right. I was confused by the missing mem_cgroup_tryget_online().

>
> >
> > > +               mem_cgroup_put(memcg);
> > > +
> > > +               if (ret == -EINVAL)
> > > +                       break;
> > > +               if (ret && ++failures == MAX_RECLAIM_RETRIES)
> > > +                       break;
> > > +
> > > +resched:
> > >                 cond_resched();
> > >         } while (!zswap_can_accept());
> > > -       zswap_pool_put(pool);
> > >  }
> > >
> > >  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
[..]
> > > @@ -1240,15 +1395,15 @@ bool zswap_store(struct folio *folio)
> > >                 zswap_invalidate_entry(tree, dupentry);
> > >         }
> > >         spin_unlock(&tree->lock);
> > > -
> > > -       /*
> > > -        * XXX: zswap reclaim does not work with cgroups yet. Without a
> > > -        * cgroup-aware entry LRU, we will push out entries system-wide based on
> > > -        * local cgroup limits.
> > > -        */
> > >         objcg = get_obj_cgroup_from_folio(folio);
> > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > -               goto reject;
> > > +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > > +               memcg = get_mem_cgroup_from_objcg(objcg);
> >
> > Do we need a reference here? IIUC, this is folio_memcg() and the folio
> > is locked, so folio_memcg() should remain stable, no?
>
> Hmmm obj_cgroup_may_zswap() also holds a reference to the objcg's
> memcg, so I just followed the patterns to be safe.

Perhaps it's less clear inside obj_cgroup_may_zswap(). We can actually
pass the folio to obj_cgroup_may_zswap(), add a debug check that the
folio is locked, and avoid getting the ref there as well. That can be
done separately. Perhaps Johannes can shed some light on this, if
there's a different reason why getting a ref there is needed.

For this change, I think the refcount manipulation is unnecessary.

>
>
> >
> > Same for the call below.
> >
> > > +               if (shrink_memcg(memcg)) {
> > > +                       mem_cgroup_put(memcg);
> > > +                       goto reject;
> > > +               }
> > > +               mem_cgroup_put(memcg);
> > > +       }
> > >
> > >         /* reclaim space if needed */
> > >         if (zswap_is_full()) {
[..]
