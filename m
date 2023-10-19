Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19957CEE28
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjJSCkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:40:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896DAB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:40:06 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41b19dda4c6so93381cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697683206; x=1698288006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS2B+TS/F6gmJ3pZVDceQT8dQ0sqAwMF5HOk2cnCljk=;
        b=FiEBNUDN9gXiAsrqBxn4BUFpHOAzEdRGyy2askS3qETiRWQeo+raYjqhF7Y8WhBE3D
         59h1gOje/C1p9XtVQYVlDTCudGHPX7I4/JiI3tMGkmYqnKQBlQk8JVMqU1h7YMaqvs9T
         f/KCBvTLr4CKoz8s9+r6J0TzvXKLU7L1OB2Q4nvoHpXtxf2fF3DrVyvIoP4vfysUZQ1u
         SljSqmnmpGHqD5Nof1NvOHsxYrqbpcQ9kXIFptUG7M5e2C8MOYyM+gf/KdWkZJ0Gwspn
         alWHbTWumPhPlSFmBhmWLoCmyr3TGnA7nZ9O5SR+0GjvcrI1UoyUGRrWjTQWv5DxHrIl
         mMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697683206; x=1698288006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rS2B+TS/F6gmJ3pZVDceQT8dQ0sqAwMF5HOk2cnCljk=;
        b=G4DJpcPws5ZziW1OFSUeY0H97e/6oboaw7il52hTnQoxVshRBec0vOEDS3OZGUiwvd
         o5NMv5VzK6uQZdMLmfoNW3Uaysepob1Y35bZINi4QAs1UgYvlsYy8nZ9jjrmeTOqCVuC
         ue73ZGaQ3iOL79YC6lNKGNH3SlrMBlacKaaZB7tulTdWCUlbiN1fN24qOYGl+e3jMmZG
         EGaK5L5fYErtAhqnupnLBnbYPttc5MQ4/VcpjnwwNFLNsJGX85VGeiWzr5uMmRQ6rlXY
         89Us0sx3MVwviZFVoedO5goO1j+zqsRxvWkNP6vx/VyBtuCYhCds/g3I4ZFvAr4PS980
         /AFw==
X-Gm-Message-State: AOJu0Yw2CUsz8dRFlyK2WsXtplPddi5C4NRfLoGOJZmcLoPZLkBV2Itz
        uogDkpZU4J49HLt8b69APtSJ18EwiYUaSDKGwfehmg==
X-Google-Smtp-Source: AGHT+IFNfGxhq5sczrNn3Qtx2XrdaCbu0XyasK81FI5UI44xIWtZOTvhkLnVK326QHcLq+4YFJvWGAILcwP+sK5qlfA=
X-Received: by 2002:a05:622a:440e:b0:41c:bdfa:e5d8 with SMTP id
 ka14-20020a05622a440e00b0041cbdfae5d8mr99015qtb.9.1697683205613; Wed, 18 Oct
 2023 19:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231018082104.3918770-1-link@vivo.com> <20231018082104.3918770-3-link@vivo.com>
 <CAOUHufbPiAhpvHuo=oH7Zhyoc0hR-6kpVrCEe-b0OuWYWne2=A@mail.gmail.com> <a2373558-920a-49b1-91ac-9b0a6a1468b2@vivo.com>
In-Reply-To: <a2373558-920a-49b1-91ac-9b0a6a1468b2@vivo.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 18 Oct 2023 20:39:28 -0600
Message-ID: <CAOUHufYiu-5wEkNnrt+HdnwHTZ+5FytqBB-j3nuHS5kgY+c3ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: multi-gen lru: fix stat count
To:     Huan Yang <link@vivo.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, opensource.kernel@vivo.com
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

On Wed, Oct 18, 2023 at 8:17=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
>
> Hi Yu Zhao,
>
> Thanks for your reply.
>
> =E5=9C=A8 2023/10/19 0:21, Yu Zhao =E5=86=99=E9=81=93:
> > On Wed, Oct 18, 2023 at 2:22=E2=80=AFAM Huan Yang <link@vivo.com> wrote=
:
> >> For multi-gen lru reclaim in evict_folios, like shrink_inactive_list,
> >> gather folios which isolate to reclaim, and invoke shirnk_folio_list.
> >>
> >> But, when complete shrink, it not gather shrink reclaim stat into sc,
> >> we can't get info like nr_dirty\congested in reclaim, and then
> >> control writeback, dirty number and mark as LRUVEC_CONGESTED, or
> >> just bpf trace shrink and get correct sc stat.
> >>
> >> This patch fix this by simple copy code from shrink_inactive_list when
> >> end of shrink list.
> > MGLRU doesn't try to write back dirt file pages in the reclaim path --
> > it filters them out in sort_folio() and leaves them to the page
> Nice to know this,  sort_folio() filters some folio indeed.
> But, I want to know, if we touch some folio in shrink_folio_list(), may s=
ome
> folio become dirty or writeback even if sort_folio() filter then?

Good question: in that case MGLRU still doesn't try to write those
folios back because isolate_folio() cleared PG_reclaim and
shrink_folio_list() checks PG_reclaim:

if (folio_test_dirty(folio)) {
/*
* Only kswapd can writeback filesystem folios
* to avoid risk of stack overflow. But avoid
* injecting inefficient single-folio I/O into
* flusher writeback as much as possible: only
* write folios when we've encountered many
* dirty folios, and when we've already scanned
* the rest of the LRU for clean folios and see
* the same dirty folios again (with the reclaim
* flag set).
*/
if (folio_is_file_lru(folio) &&
    (!current_is_kswapd() ||
     !folio_test_reclaim(folio) ||
     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
