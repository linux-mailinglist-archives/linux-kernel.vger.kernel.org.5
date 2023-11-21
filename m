Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF177F242A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjKUCq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:46:57 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01337C4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:46:53 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a013d22effcso62020666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700534812; x=1701139612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT8XHAvcEhECV25AWmpJElN+FUmGpxVcHQIxuxXBKgE=;
        b=hl4rA/iScYUS/ZpABmXD+D508ZjQ2mMPVc4v6mk1DCgkUBn4wqrY5Y5ZIlNwylTkKj
         KYO825BzZz9RhL7Q1TPlMRm2FbsCoYEn9uPvWRp+0oM1h/rY3ylEUN0cMj3qqMoKjq0A
         1uVTDVVsGQaPw+nV5jFxn1Ey6Y6PtLYjEVhQu/DcL53WAuR/dQ63Fm2KUwmaYhoO8s2Z
         trQA+9E0v+x6GoCBTqxeSIG+DG2OwjmNpkaFIXHurkL1KdMxBIsy8/OstkIrYC+ezsdl
         NtJWD5Y9yCcugBQHXvJ9OrA3T1N6wapaHwv2XwVY33+WgBGXqlOBI0uIbbMsF5vRfkAC
         Ij0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700534812; x=1701139612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT8XHAvcEhECV25AWmpJElN+FUmGpxVcHQIxuxXBKgE=;
        b=bGVoSwLY2/OAL+NadAfEVoA3zBXPXdev5foytbAynbmXPfYgyvKlLP01kFjvVpzDlS
         Xc/8HDWrR0dhoV60jkd+RGIZq1H40FPaRzH1Hi/j4xc+WUnFFULn98QmAeexhKwGMOth
         L4hASHWJ2otZbhVPhhjmdTqGRE2Oc4wbEu6VA0/0KAIEnqX38xqq5b+ge5g6erfAM0Ql
         DdocJtdBkrWhrgwD7LLAeWz1hDkAr4HjvFvzQJJDA6MHQW2csg948fVCC6Zyiuht8eaz
         jz5/nJcv8iSkB3mUNqY6Qj3FVaLnnCnEi47Pif2znUCm/XfSLK+/OL5T2S5vsBkOB5sb
         mhIg==
X-Gm-Message-State: AOJu0YxHvqM1/qCZnNNHHSXfzBXAuIyLMQ9YkqZoF4WL8wjI+cLdm3UM
        I8+4ilX5kV40531Dsmtof1hE2CssZEd7aMzqrL5vtQ==
X-Google-Smtp-Source: AGHT+IH87VC6gbnVo/3R0Xr0pw1M8eld0MmABD+ImDPfoq9nyWWCLUItjAGmYW4djLZJlaVZXvoObpIeJMOMTTOnIrc=
X-Received: by 2002:a17:906:414a:b0:9dd:9380:bb15 with SMTP id
 l10-20020a170906414a00b009dd9380bb15mr6688701ejk.50.1700534812389; Mon, 20
 Nov 2023 18:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkbfjhC8SHZ=KspVfrTECZyY8BYrPGcLVLJcJRwXXdYDrw@mail.gmail.com>
 <87edgkapsz.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkamaGjmP0anhez+JHxJx++UQcykyxRDieQxcTt5Q4+YuQ@mail.gmail.com>
 <875y1vc1n7.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875y1vc1n7.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 20 Nov 2023 18:46:13 -0800
Message-ID: <CAJD7tkbeN3X7e2ErYeYAAkd41p8DUsCVh7DhrwQ55+ip1eQrQA@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Chris Li <chriscli@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Nov 20, 2023 at 5:55=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Mon, Nov 20, 2023 at 4:57=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >>
> >> > On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Chris Li <chriscli@google.com> writes:
> >> >>
> >> >> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@=
google.com> wrote:
> >> >> >>
> >> >> >> Not bypassing the swap slot cache, just make the callbacks to
> >> >> >> invalidate the zswap entry, do memg uncharging, etc when the slo=
t is
> >> >> >> no longer used and is entering the swap slot cache (i.e. when
> >> >> >> free_swap_slot() is called), instead of when draining the swap s=
lot
> >> >> >> cache (i.e. when swap_range_free() is called). For all parts of =
MM
> >> >> >> outside of swap, the swap entry is freed when free_swap_slot() i=
s
> >> >> >> called. We don't free it immediately because of caching, but thi=
s
> >> >> >> should be transparent to other parts of MM (e.g. zswap, memcg, e=
tc).
> >> >> >
> >> >> > That will cancel the batching effect on the swap slot free, makin=
g the
> >> >> > common case for  swapping  faults take longer to complete, righ?
> >> >> > If I recall correctly, the uncharge is the expensive part of the =
swap
> >> >> > slot free operation.
> >> >> > I just want to figure out what we are trading off against. This i=
s not
> >> >> > one side wins all situations.
> >> >>
> >> >> Per my understanding, we don't batch memcg uncharging in
> >> >> swap_entry_free() now.  Although it's possible and may improve
> >> >> performance.
> >> >
> >> > Yes. It actually causes a long tail in swapin fault latency as Chris
> >> > discovered in our prod. I am wondering if doing the memcg uncharging
> >> > outside the slots cache will actually amortize the cost instead.
> >> >
> >> > Regardless of memcg charging, which is more complicated, I think we
> >> > should at least move the call to zswap_invalidate() before the slots
> >> > cache. I would prefer that we move everything non-swapfile specific
> >> > outside the slots cache layer (zswap_invalidate(),
> >> > arch_swap_invalidate_page(),  clear_shadow_from_swap_cache(),
> >> > mem_cgroup_uncharge_swap(), ..).  However, if some of those are
> >> > controversial, we can move some of them for now.
> >>
> >> That makes sense for me.
> >>
> >> > When draining free swap slots from the cache, swap_range_free() is
> >> > called with nr_entries =3D=3D 1 anyway, so I can't see how any batch=
ing is
> >> > going on. If anything it should help amortize the cost.
> >>
> >> In swapcache_free_entries(), the sis->lock will be held to free multip=
le
> >> swap slots via swap_info_get_cont() if possible.  This can reduce
> >> sis->lock contention.
> >
> > Ah yes that's a good point. Since most of these callbacks don't
> > actually access sis, but use the swap entry value itself, I am
> > guessing the reason we need to hold the lock for all these callbacks
> > is to prevent swapoff and swapon reusing the same swap entry on a
> > different swap device, right?
>
> In,
>
> swapcache_free_entries()
>   swap_entry_free()
>     swap_range_free()
>
> Quite some sis fields will be accessed.

I wasn't referring to this code. I was what's preventing us from
moving the callbacks I mentioned outside the lock (zswap_invalidate(),
arch_swap_invalidate_page(),  clear_shadow_from_swap_cache(),
mem_cgroup_uncharge_swap(), ..). I think most or all of them don't
really access sis, but perhaps they need the lock to ensure the swap
entry value does not get reused?

>
> --
> Best Regards,
> Huang, Ying
