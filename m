Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B13803EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbjLDTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDTwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:52:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB84E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:52:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso3212568a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701719526; x=1702324326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eYidRuFuyjgtGaepFNp4s5KekmZ8R0Vv2VOTsdlcvvk=;
        b=bBCB65tagxMbJm06o9N432XeCR4VFyR9V1b1/flkMi76CJewjryEFwrNwis8LdAway
         xBGd7K+a5+beoo5qj5238UhxJqhuGHR39kCM548IyOsgRhTSJQcf9WYqH7UmW9l2h2e1
         zfVBu/b1Pp5AB5k/52q3MO2ENFRjuTWWdeD2Z1AHmTttlJi8CQn/HL+5q7AsZiOmub02
         F6d0U8Ps5HqtAHDXPOOOkRVULiPIGqqB4+4ugBoKedUnnyJfNYJn/aYojZhHCQEmsFqI
         /KOdQIY8iDqW8cRBSPmY4evBCUhgVa5OucGoa1JpQ1OTdxYjI8PPR6rGf4Xiem+l4zp+
         G/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719526; x=1702324326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYidRuFuyjgtGaepFNp4s5KekmZ8R0Vv2VOTsdlcvvk=;
        b=I3kT/KTYPN2miXkSUqSFoN2s4V2MkwBY+JNBTUPMFdwWLFySGd6Ka+rKivhi34UAI2
         fMnD9mil6Q4f2th7voWL5lTbW0kh2Stx0eBHbHrWCTrvRC5Fh4rMsz4TftCXxzn71PgG
         vg76Xq5ZhG4XkwnJiGW4D3v6iCOVYjo2nbBQRdtC5A5nBGrBq4oOvtATNx/WG2x1Hgh4
         GN/SD+96v2gyJW5/idExcAh1VFuD26x98q6LObZPC1rfXbEaUBF9qofMeuUDUCljbAqX
         V1la+r3itBSabL1LBDPWn5XWsM+JRI6HQtXrJUTwzyvT1sC3iDEqpfzvc6hSmmW5erDS
         cvwg==
X-Gm-Message-State: AOJu0YyddYdLfXHlTIm61A+GTwli4xfGYs1LHOlaCm/h0NP8c6PcshXF
        AEAHxnVom6LE01ciO5qk/cEbcXn5z92lNdf9jhrJCA==
X-Google-Smtp-Source: AGHT+IFlwZwLSTjml6GJX9pmadhYbMF7fdFHsa20v/3WIXVEPDjbDlUP+SUIT8iByELIZI3zCmeFa5ieAkvSDn1t5m8=
X-Received: by 2002:a17:906:2207:b0:a16:37ce:f81a with SMTP id
 s7-20020a170906220700b00a1637cef81amr3789708ejs.8.1701719525571; Mon, 04 Dec
 2023 11:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <ZWqPBHCXz4nBIQFN@archie.me>
In-Reply-To: <ZWqPBHCXz4nBIQFN@archie.me>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 4 Dec 2023 11:51:29 -0800
Message-ID: <CAJD7tkbk=AUfjuq+6HiPwNeoUi===h99rbJ2RkhN6dCk2E2xdg@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Attreyee M <tintinm2017@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux CGroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index dce41577a49d2..7d3dacab8451a 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -464,8 +464,12 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
> >
> >       rcu_read_unlock();
> >
> > -     /* Flush stats (and potentially sleep) outside the RCU read section */
> > -     mem_cgroup_flush_stats_ratelimited();
> > +     /*
> > +      * Flush stats (and potentially sleep) outside the RCU read section.
> > +      * XXX: With per-memcg flushing and thresholding, is ratelimiting
> > +      * still needed here?
> > +      */
> > +     mem_cgroup_flush_stats_ratelimited(eviction_memcg);
>
> What if flushing is not rate-limited (e.g. above line is commented)?
>

Hmm I think I might be misunderstanding the question. The call to
mem_cgroup_flush_stats_ratelimited() does not ratelimit other
flushers, it is rather a flush call that is itself ratelimited. IOW,
it may or may not flush based on when was the last time someone else
flushed.

This was introduced because flushing in the fault path was expensive
in some cases, so we wanted to avoid flushing if someone else recently
did a flush, as we don't expect a lot of pending changes in this case.
However, that was when flushing was always on the root level. Now that
we are flushing on the memcg level, it may no longer be needed as:
- The flush is more scoped, there should be less work to do.
- There is a per-memcg threshold now such that we only flush when
there are pending updates in this memcg.

This is why I added a comment that the ratelimited flush here may no
longer be needed. I didn't want to investigate this as part of this
series, especially that I do not have a reproducer for the fault
latency introduced by the flush before ratelimiting. Hence, I am
leaving the comment such that people know that this ratelimiting may
no longer be needed with this patch.

> >
> >       eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> >       refault = atomic_long_read(&eviction_lruvec->nonresident_age);
> > @@ -676,7 +680,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
> >               struct lruvec *lruvec;
> >               int i;
> >
> > -             mem_cgroup_flush_stats();
> > +             mem_cgroup_flush_stats(sc->memcg);
> >               lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
> >               for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
> >                       pages += lruvec_page_state_local(lruvec,
>
> Confused...

Which part is confusing? The call to mem_cgroup_flush_stats() now
receives a memcg argument as flushing is scoped to that memcg only to
avoid doing unnecessary work to flush other memcgs with global
flushing.
