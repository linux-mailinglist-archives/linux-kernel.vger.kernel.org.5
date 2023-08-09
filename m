Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3572B776070
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjHINR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjHINR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:17:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA51B6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:17:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977e0fbd742so935675466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691587074; x=1692191874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7GQah3LR29pNwUlAFsHmzB3/MgA9amRpVJYquX5jX0=;
        b=j2xSiU48lAhLr6GSJ/DFJP5FmUuUSjaBQhgGtPkSEPls0F47OUNh8TIbrSr5UMunMZ
         uM2ZUT0AV6Yl9Qlwub03wbHBRZjf4OaV9YYJm/YEXekUy4vO6Sjeybnabl5D10LLVSjn
         swU57o/MSbPRGeE+ljLde+9aziPyf0+7ZdSzgtsDh6skzxrYO/yjzQ+Pj0y2dU1pdUdr
         2y6VTAnLM4T3A1v5je6mTuQx7nD+wKUg0/0kJJk3EZnC32WVXkdj0Q0Sk5PC/EHZ4xgU
         8lISujnCVovjWP5Jh+CduFXCDAJVx2O+ylOXE2UnEchucJ2qS+wwVmDkpuWz7YVTBaqW
         /Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587074; x=1692191874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7GQah3LR29pNwUlAFsHmzB3/MgA9amRpVJYquX5jX0=;
        b=H7Tuptr5n3t+IY1KcVVGY67f0LFiTF9cy/mUtmk+sS2s+SCbqhuJDLt0BXB2/Iqpvm
         cRIxIcJIIzt2GuawimQR5h7rX7/la7SZGPaiRLEPGqHyI2hEuSIxI1nhv9sA6/Q6AF+5
         dqh9dBtyndJJixOuReltHXZrdMVAokaTEpK9Qn7pkbmP5zeCqV/I6/H7Fb1Qknp4a9Wy
         JWp+kZ2T8iRdemAu6/5MaksLZ1sL5s+FnyFKdYpYxbt+Spv/rWzvhHIABM4MH8a8lKS5
         6Qu8X0F1wk/qDF3fng+sbrkwrGmXJw/TDRoomxwMjy7Viii0aKstAR2z3nC/CzMvU9UX
         7PvQ==
X-Gm-Message-State: AOJu0Yxgj6lHiBwTvK0UiPclBf0Wtft1B772K9qBxSn+zaywLz5FBZvS
        4xWoVIipJpYK4vYX2UBn0mkWpyoJUvNm02MehBSskg==
X-Google-Smtp-Source: AGHT+IGIzc/TMK7NNoqOzdlb2frVhrYUSFPRNGS6tLA/DRsJVToruJ1YAinbznO7/6EkrahVfqFaeMRaWmgFTbKkw9M=
X-Received: by 2002:a17:906:220e:b0:99b:f3d1:7735 with SMTP id
 s14-20020a170906220e00b0099bf3d17735mr2206402ejs.29.1691587074277; Wed, 09
 Aug 2023 06:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz>
In-Reply-To: <ZNONgeoytpkchHga@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 9 Aug 2023 06:17:18 -0700
Message-ID: <CAJD7tkaPPcMsq-pbu26H332xBJP-m=v1aBbU_NJQQn+7motX9g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> > > [...]
> > > > @@ -639,17 +639,24 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
> > > >       }
> > > >  }
> > > >
> > > > -static void do_flush_stats(void)
> > > > +static void do_flush_stats(bool full)
> > > >  {
> > > > +     if (!atomic_read(&stats_flush_ongoing) &&
> > > > +         !atomic_xchg(&stats_flush_ongoing, 1))
> > > > +             goto flush;
> > > > +
> > > >       /*
> > > > -      * We always flush the entire tree, so concurrent flushers can just
> > > > -      * skip. This avoids a thundering herd problem on the rstat global lock
> > > > -      * from memcg flushers (e.g. reclaim, refault, etc).
> > > > +      * We always flush the entire tree, so concurrent flushers can choose to
> > > > +      * skip if accuracy is not critical. Otherwise, wait for the ongoing
> > > > +      * flush to complete. This avoids a thundering herd problem on the rstat
> > > > +      * global lock from memcg flushers (e.g. reclaim, refault, etc).
> > > >        */
> > > > -     if (atomic_read(&stats_flush_ongoing) ||
> > > > -         atomic_xchg(&stats_flush_ongoing, 1))
> > > > -             return;
> > > > -
> > > > +     while (full && atomic_read(&stats_flush_ongoing) == 1) {
> > > > +             if (!cond_resched())
> > > > +                     cpu_relax();
> > >
> > > You are reinveting a mutex with spinning waiter. Why don't you simply
> > > make stats_flush_ongoing a real mutex and make use try_lock for !full
> > > flush and normal lock otherwise?
> >
> > So that was actually a spinlock at one point, when we used to skip if
> > try_lock failed.
>
> AFAICS cgroup_rstat_flush is allowed to sleep so spinlocks are not
> really possible.

Sorry I hit the send button too early, didn't get to this part.

We were able to use a spinlock because we used to disable sleeping
when flushing the stats then, which opened another can of worms :)

>
> > We opted for an atomic because the lock was only used
> > in a try_lock fashion. The problem here is that the atomic is used to
> > ensure that only one thread actually attempts to flush at a time (and
> > others skip/wait), to avoid a thundering herd problem on
> > cgroup_rstat_lock.
> >
> > Here, what I am trying to do is essentially equivalent to "wait until
> > the lock is available but don't grab it". If we make
> > stats_flush_ongoing a mutex, I am afraid the thundering herd problem
> > will be reintroduced for stats_flush_ongoing this time.
>
> You will have potentially many spinners for something that might take
> quite a lot of time (sleep) if there is nothing else to schedule. I do
> not think this is a proper behavior. Really, you shouldn't be busy
> waiting for a sleeper.
>
> > I am not sure if there's a cleaner way of doing this, but I am
> > certainly open for suggestions. I also don't like how the spinning
> > loop looks as of now.
>
> mutex_try_lock for non-critical flushers and mutex_lock of syncing ones.
> We can talk a custom locking scheme if that proves insufficient or
> problematic.

I have no problem with this. I can send a v2 following this scheme,
once we agree on the importance of this patch :)

> --
> Michal Hocko
> SUSE Labs
