Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555147F22F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjKUBQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKUBP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:15:59 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDAF91
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:15:55 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so157285466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700529354; x=1701134154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjY00jS05kwn5BSYUnYd0PcyI2gRMkkzxEGPgeY8Yfc=;
        b=nHnVQkHnshxH2MiLtwIbMpoGlch7WzXOsBB2BJewBf9GlPvC0Wc6Nzi+zVDhQzroC8
         mf2W3jc00IYD9bU38xzBjJkP0py95pxgWgp5iMnRZ4gNH/qrlck1j0yfjnt0e30tRoq0
         jmXtZATCvwgLvphZP03YR3JCDDveiArJwi4jbcwZq/uwcMGVSBSXbpuSY4KpbcGUfqtO
         WQ/+TO3+h1dhqrFwDeaHcHHqrX0tX9/My9kFFKNqJuvS+wlSTSlaQF9weKksNEx0iPok
         vLa6ztoz1pvnFB3tnJin08siPqCxrioHDQzDteSq/goUeUIYDM1VCFjgzcQJZLVrfSFB
         MQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700529354; x=1701134154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjY00jS05kwn5BSYUnYd0PcyI2gRMkkzxEGPgeY8Yfc=;
        b=d7XbCPhVBXpK40WE1ORLVxv0sCkf0rKCgZm8R1IQQPW4uLRsryj6RFHhHjr0PjUiEJ
         BD16XPP2Ds4ikflSUBPZang0/lifNbJUUYq17+2FaAFACSlLUjfr4ZBq4bDqW7h31q4u
         iZ0O51D2/7ZS3T09OrS2tUiS+2PJ8NOauB1ARLK2yGXrXJyeXNw/UzZP1tNlj1ybCOo1
         pHyIpduYmfdGitLYPsrMlKESO8HiE93+JXTuHN/fexo6ell1fvvMgOJukDL3s92xH1A+
         yhY0+IuOr1kuM1B673Q7CDtQY+gXYWKdHCygO+WJwp0SDeY4lbyBu1Vqa8tUd947QVra
         qZIg==
X-Gm-Message-State: AOJu0YzQGQefNEeA6MHUxT7lt57uUflc6Jua1o3BAKGLh3ygnN14LYBN
        zqFB6fI6knXVFmqMSFxP5KaaVJwVwB97KV0+Ks+HJQ==
X-Google-Smtp-Source: AGHT+IGE9JGytLkYwuXYv424QTiXwuMTGFYTcr3WNFwtS4AArg7TkdCIA5Vrl8cQyU8mdcb0zDHhO7HTUB9eu8pbIRo=
X-Received: by 2002:a17:906:51d0:b0:9eb:af0e:39da with SMTP id
 v16-20020a17090651d000b009ebaf0e39damr6746294ejk.46.1700529353980; Mon, 20
 Nov 2023 17:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkbfjhC8SHZ=KspVfrTECZyY8BYrPGcLVLJcJRwXXdYDrw@mail.gmail.com>
 <87edgkapsz.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edgkapsz.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 20 Nov 2023 17:15:15 -0800
Message-ID: <CAJD7tkamaGjmP0anhez+JHxJx++UQcykyxRDieQxcTt5Q4+YuQ@mail.gmail.com>
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

On Mon, Nov 20, 2023 at 4:57=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Chris Li <chriscli@google.com> writes:
> >>
> >> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> >> >>
> >> >> Not bypassing the swap slot cache, just make the callbacks to
> >> >> invalidate the zswap entry, do memg uncharging, etc when the slot i=
s
> >> >> no longer used and is entering the swap slot cache (i.e. when
> >> >> free_swap_slot() is called), instead of when draining the swap slot
> >> >> cache (i.e. when swap_range_free() is called). For all parts of MM
> >> >> outside of swap, the swap entry is freed when free_swap_slot() is
> >> >> called. We don't free it immediately because of caching, but this
> >> >> should be transparent to other parts of MM (e.g. zswap, memcg, etc)=
.
> >> >
> >> > That will cancel the batching effect on the swap slot free, making t=
he
> >> > common case for  swapping  faults take longer to complete, righ?
> >> > If I recall correctly, the uncharge is the expensive part of the swa=
p
> >> > slot free operation.
> >> > I just want to figure out what we are trading off against. This is n=
ot
> >> > one side wins all situations.
> >>
> >> Per my understanding, we don't batch memcg uncharging in
> >> swap_entry_free() now.  Although it's possible and may improve
> >> performance.
> >
> > Yes. It actually causes a long tail in swapin fault latency as Chris
> > discovered in our prod. I am wondering if doing the memcg uncharging
> > outside the slots cache will actually amortize the cost instead.
> >
> > Regardless of memcg charging, which is more complicated, I think we
> > should at least move the call to zswap_invalidate() before the slots
> > cache. I would prefer that we move everything non-swapfile specific
> > outside the slots cache layer (zswap_invalidate(),
> > arch_swap_invalidate_page(),  clear_shadow_from_swap_cache(),
> > mem_cgroup_uncharge_swap(), ..).  However, if some of those are
> > controversial, we can move some of them for now.
>
> That makes sense for me.
>
> > When draining free swap slots from the cache, swap_range_free() is
> > called with nr_entries =3D=3D 1 anyway, so I can't see how any batching=
 is
> > going on. If anything it should help amortize the cost.
>
> In swapcache_free_entries(), the sis->lock will be held to free multiple
> swap slots via swap_info_get_cont() if possible.  This can reduce
> sis->lock contention.

Ah yes that's a good point. Since most of these callbacks don't
actually access sis, but use the swap entry value itself, I am
guessing the reason we need to hold the lock for all these callbacks
is to prevent swapoff and swapon reusing the same swap entry on a
different swap device, right?
