Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271D7F24AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjKUDht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUDhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:37:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F97C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:37:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9f27af23443so689859066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700537862; x=1701142662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6JP77IJAFcT7qYQ8fIPmy5AeO6uJhz8/ThBZXngqfQ=;
        b=vjnhcDSo0wsep1jyNGbAfgkzI/5fd6zEiXuTVd6yfPJPrL1/pYoIK/9HzV/4Q5ef+j
         VuxtO/Ptax8LXY21zq80byn/65la1b9iDXw+v6rZVROIlVA7rSUC/6NSkkFqOFobWn2F
         eMYP0thrjRwPGYxZBHVdcg0q8dVmddo0oZP9m7F/5zW5GrTlgjEYHnbqD5mYnBmgqUaf
         fQ4OLmkd/8x8DV9uxt6cFugU7gp84NIWoMvfMGc1ZSIjhIaRQj7WL394x1pgQosDadVV
         UQLgX4AhlPkpIJv1pCM8wPXJo0+PP3zmJJHkTAIRLV4AUqzEJnF+ODuY73XX4dT7bqAq
         5ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700537862; x=1701142662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6JP77IJAFcT7qYQ8fIPmy5AeO6uJhz8/ThBZXngqfQ=;
        b=d39CFSFh+DQIAwKJzv66mPgGx3Rr4GhiWfDXJMjq201J/efFzCJUHVzPI8e5aQg6IC
         suMLCjkOBT3945N1nguKcp+/8E/4eu+gmoicZ1y4W6aDWMYyhPMdmAiGti8+23JAbSwV
         Q80eEjXNP/iu9RMbpQK357u13cR9ykTHS74/dasOi23DmDizgNRXE+acoURiXoWUHdtd
         +VW0djQ4r37OMUgshQW3qKFiHNp9mtmO8p9SY/n/kR7RUlpj4gP1/vm7nKAHGCVzlc/G
         pyN6+Gshyn4UtLjYH6Yk81zbzrtvmCzNoCwh+fRHM+CqZrMPJ7JtG5B2lIy0lAfzaHfH
         sfmQ==
X-Gm-Message-State: AOJu0YzS7XACpT7Ud8k3oN8EtXy19lmYcOQt8rm4VgRGo/24RAX5F7wt
        QLOp5Et8YJKVrJ6H37gdlFwpD3oZu0NTGzeVyXfPag==
X-Google-Smtp-Source: AGHT+IFSVsiy9K7Vb1LpBknGoBKKIsCYVMduksOP0PyaPxHgTyui5kGNuohqFfHP60cDN3HGY1EfEQ2m/n2viXtGiLE=
X-Received: by 2002:a17:906:29ca:b0:a00:231a:92f8 with SMTP id
 y10-20020a17090629ca00b00a00231a92f8mr2231136eje.15.1700537861827; Mon, 20
 Nov 2023 19:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkbfjhC8SHZ=KspVfrTECZyY8BYrPGcLVLJcJRwXXdYDrw@mail.gmail.com>
 <87edgkapsz.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkamaGjmP0anhez+JHxJx++UQcykyxRDieQxcTt5Q4+YuQ@mail.gmail.com>
 <875y1vc1n7.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkbeN3X7e2ErYeYAAkd41p8DUsCVh7DhrwQ55+ip1eQrQA@mail.gmail.com>
 <871qcjbx20.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871qcjbx20.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 20 Nov 2023 19:37:05 -0800
Message-ID: <CAJD7tkYw5K2s9RGFDnbmP-ChcQ-GrnWudRdKYeym2bwzB47ScA@mail.gmail.com>
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

On Mon, Nov 20, 2023 at 7:35=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Mon, Nov 20, 2023 at 5:55=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >>
> >> > On Mon, Nov 20, 2023 at 4:57=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >> >>
> >> >> > On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Chris Li <chriscli@google.com> writes:
> >> >> >>
> >> >> >> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahm=
ed@google.com> wrote:
> >> >> >> >>
> >> >> >> >> Not bypassing the swap slot cache, just make the callbacks to
> >> >> >> >> invalidate the zswap entry, do memg uncharging, etc when the =
slot is
> >> >> >> >> no longer used and is entering the swap slot cache (i.e. when
> >> >> >> >> free_swap_slot() is called), instead of when draining the swa=
p slot
> >> >> >> >> cache (i.e. when swap_range_free() is called). For all parts =
of MM
> >> >> >> >> outside of swap, the swap entry is freed when free_swap_slot(=
) is
> >> >> >> >> called. We don't free it immediately because of caching, but =
this
> >> >> >> >> should be transparent to other parts of MM (e.g. zswap, memcg=
, etc).
> >> >> >> >
> >> >> >> > That will cancel the batching effect on the swap slot free, ma=
king the
> >> >> >> > common case for  swapping  faults take longer to complete, rig=
h?
> >> >> >> > If I recall correctly, the uncharge is the expensive part of t=
he swap
> >> >> >> > slot free operation.
> >> >> >> > I just want to figure out what we are trading off against. Thi=
s is not
> >> >> >> > one side wins all situations.
> >> >> >>
> >> >> >> Per my understanding, we don't batch memcg uncharging in
> >> >> >> swap_entry_free() now.  Although it's possible and may improve
> >> >> >> performance.
> >> >> >
> >> >> > Yes. It actually causes a long tail in swapin fault latency as Ch=
ris
> >> >> > discovered in our prod. I am wondering if doing the memcg uncharg=
ing
> >> >> > outside the slots cache will actually amortize the cost instead.
> >> >> >
> >> >> > Regardless of memcg charging, which is more complicated, I think =
we
> >> >> > should at least move the call to zswap_invalidate() before the sl=
ots
> >> >> > cache. I would prefer that we move everything non-swapfile specif=
ic
> >> >> > outside the slots cache layer (zswap_invalidate(),
> >> >> > arch_swap_invalidate_page(),  clear_shadow_from_swap_cache(),
> >> >> > mem_cgroup_uncharge_swap(), ..).  However, if some of those are
> >> >> > controversial, we can move some of them for now.
> >> >>
> >> >> That makes sense for me.
> >> >>
> >> >> > When draining free swap slots from the cache, swap_range_free() i=
s
> >> >> > called with nr_entries =3D=3D 1 anyway, so I can't see how any ba=
tching is
> >> >> > going on. If anything it should help amortize the cost.
> >> >>
> >> >> In swapcache_free_entries(), the sis->lock will be held to free mul=
tiple
> >> >> swap slots via swap_info_get_cont() if possible.  This can reduce
> >> >> sis->lock contention.
> >> >
> >> > Ah yes that's a good point. Since most of these callbacks don't
> >> > actually access sis, but use the swap entry value itself, I am
> >> > guessing the reason we need to hold the lock for all these callbacks
> >> > is to prevent swapoff and swapon reusing the same swap entry on a
> >> > different swap device, right?
> >>
> >> In,
> >>
> >> swapcache_free_entries()
> >>   swap_entry_free()
> >>     swap_range_free()
> >>
> >> Quite some sis fields will be accessed.
> >
> > I wasn't referring to this code. I was what's preventing us from
> > moving the callbacks I mentioned outside the lock (zswap_invalidate(),
> > arch_swap_invalidate_page(),  clear_shadow_from_swap_cache(),
> > mem_cgroup_uncharge_swap(), ..). I think most or all of them don't
> > really access sis, but perhaps they need the lock to ensure the swap
> > entry value does not get reused?
>
> In fact, the swap entries to be freed by swapcache_free_entries() is in
> a state that can not be freed by other path (including swapoff()).  It's
> swap_map value is SWAP_HAS_CACHE, but we can not find folio in
> swap_address_space().

Interesting, it would be even nicer if we can move them outside the lock.

>
> To be honest, I don't know whether there are dependencies on sis->lock
> in these callbacks.  You need to investigate them one by one.

Yeah moving these callbacks outside batching and the lock is very
intriguing but needs to be done carefully. We don't need to do it all
at once, we can start with zswap_invalidate() and move them as we see
fit. It would be nice if the code is refactored such that it's clear
what callbacks are made immediately when the entry is no longer used
and what callbacks are made when the swap slot is being freed.

>
> --
> Best Regards,
> Huang, Ying
