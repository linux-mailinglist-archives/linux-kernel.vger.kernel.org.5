Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE48C7B0DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjI0VI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:08:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F6AD6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:08:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317c3ac7339so11546239f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695848902; x=1696453702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfvm8/a4exaNtV5rVjrKr+Z7FNNhpbs91r3Q2boPyn4=;
        b=PQMsjgmTDr28+eR4LVVQExIu21VEFblKzfIPza/dkP713y7a+zeokh5FY3qryxi1EL
         ZshnxcOHOKlKegFmrNivJ6ykl638dWbeTHgRrpcGHveCSh6vIxlH+ozCUQW92HjFDFx+
         kBnfEWGs3Dm0/bVVn1ldCuNoKaQxQdxVnZocY9GJUyj/3gj9zeXquoufUBQksRK1jMHm
         uk3R5mPV+sf/3BkKBBsv/rpsfvCFpPhSY56kUNzjXKCfPVK09RwEfpnJ9a6xok0LNhyx
         XwawcA9SfQ/SkA3IY/Ry753Mawd8THjcsKNHFzDk/LNLc1b7JRM8HodRyHktPPUhmVCT
         b5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695848902; x=1696453702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hfvm8/a4exaNtV5rVjrKr+Z7FNNhpbs91r3Q2boPyn4=;
        b=Bg90IdgE8x2xk5ddTxHwPNLTNgcy6ywVQRZrJmrtwTiQ6wR+RTNfBzwA3d2rVOQEwq
         9c5udn7l99CsnqSyENv2qNDkrp7BbQqGoZAL0Lr0ezHLICTr2JTus4qAjQKCtlMoN3Hq
         xTayAOxubrmNz3Fsd8/2v/2rKf4a9cNFvnPBbYDvrDDnrt0GY0rmex4RVJIrEx/LXqPP
         IB+sHZExwyI2OEmpA9M0/a7hEFXIVXJZx72Z1haLZmLFiLBis3TvkRbtP6a7J8MvtQxH
         uABhE9b1Nja7+vF09VeS5pIeflBe8MsIZus+j4OH/3Z7PeCIQgwW2GO/dt2ChSSSJa/f
         64nQ==
X-Gm-Message-State: AOJu0YzBNiEK5khREFs11hNIs5h6M/jQW3YnLs8YxD8CHPQcnWmqmtDy
        97UT0PDYXMepOHH8LGEDZFzlCQLaQuoVQ/uo8wWkWw==
X-Google-Smtp-Source: AGHT+IGgbVlUZsL5dndb0Q67CFV4Q9kOla86kBHqm7mYfzIxee1MZaJ7YtGhjbLlr//eTV6W+H9iSLVy/KEczb1yuNc=
X-Received: by 2002:adf:ce8b:0:b0:323:33b1:dc44 with SMTP id
 r11-20020adfce8b000000b0032333b1dc44mr2908496wrn.0.1695848901844; Wed, 27 Sep
 2023 14:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230919171447.2712746-1-nphamcs@gmail.com> <20230919171447.2712746-2-nphamcs@gmail.com>
 <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com>
 <CA+CLi1httFOg4OM-0Hu3+fOvya4kpacCqN7A0upqOt4-YJiECg@mail.gmail.com> <20230927210206.GC399644@cmpxchg.org>
In-Reply-To: <20230927210206.GC399644@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 27 Sep 2023 14:07:45 -0700
Message-ID: <CAJD7tkbG0Rg-xM=wn8tnt=mXfty8-Y=6t0sbvtArrsnBPyH2cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 2:02=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Sep 27, 2023 at 09:48:10PM +0200, Domenico Cerasuolo wrote:
> > > > @@ -485,6 +487,17 @@ struct page *__read_swap_cache_async(swp_entry=
_t entry, gfp_t gfp_mask,
> > > >         __folio_set_locked(folio);
> > > >         __folio_set_swapbacked(folio);
> > > >
> > > > +       /*
> > > > +        * Page fault might itself trigger reclaim, on a zswap obje=
ct that
> > > > +        * corresponds to the same swap entry. However, as the swap=
 entry has
> > > > +        * previously been pinned, the task will run into an infini=
te loop trying
> > > > +        * to pin the swap entry again.
> > > > +        *
> > > > +        * To prevent this from happening, we remove it from the zs=
wap
> > > > +        * LRU to prevent its reclamation.
> > > > +        */
> > > > +       zswap_lru_removed =3D zswap_remove_swpentry_from_lru(entry)=
;
> > > > +
> > >
> > > This will add a zswap lookup (and potentially an insertion below) in
> > > every single swap fault path, right?. Doesn't this introduce latency
> > > regressions? I am also not a fan of having zswap-specific details in
> > > this path.
> > >
> > > When you say "pinned", do you mean the call to swapcache_prepare()
> > > above (i.e. setting SWAP_HAS_CACHE)? IIUC, the scenario you are
> > > worried about is that the following call to charge the page may invok=
e
> > > reclaim, go into zswap, and try to writeback the same page we are
> > > swapping in here. The writeback call will recurse into
> > > __read_swap_cache_async(), call swapcache_prepare() and get EEXIST,
> > > and keep looping indefinitely. Is this correct?
>
> Yeah, exactly.
>
> > > If yes, can we handle this by adding a flag to
> > > __read_swap_cache_async() that basically says "don't wait for
> > > SWAP_HAS_CACHE and the swapcache to be consistent, if
> > > swapcache_prepare() returns EEXIST just fail and return"? The zswap
> > > writeback path can pass in this flag and skip such pages. We might
> > > want to modify the writeback code to put back those pages at the end
> > > of the lru instead of in the beginning.
> >
> > Thanks for the suggestion, this actually works and it seems cleaner so =
I think
> > we'll go for your solution.
>
> That sounds like a great idea.
>
> It should be pointed out that these aren't perfectly
> equivalent. Removing the entry from the LRU eliminates the lock
> recursion scenario on that very specific entry.
>
> Having writeback skip on -EEXIST will make it skip *any* pages that
> are concurrently entering the swapcache, even when it *could* wait for
> them to finish.
>
> However, pages that are concurrently read back into memory are a poor
> choice for writeback anyway, and likely to be removed from swap soon.
>
> So it happens to work out just fine in this case. I'd just add a
> comment that explains the recursion deadlock, as well as the
> implication of skipping any busy entry and why that's okay.

Good point, we will indeed skip even if the concurrent insertion from
the swapcache is coming from a different cpu.

As you said, it works out just fine in this case, as the page will be
removed from zswap momentarily anyway. A comment is indeed due.
