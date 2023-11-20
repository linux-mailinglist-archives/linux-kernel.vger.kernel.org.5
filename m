Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441097F1196
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjKTLQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjKTLP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:15:57 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C719C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:15:44 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so52115171fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700478943; x=1701083743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCEH2OhSh1wtb14SLQZhMNkQFOWqwz8F0y6cfbziznw=;
        b=FwiNNWm1RJ4KDnKIyZwNMjqSwyrMTxG8G3YUHCQUK0c5wVehU2GyEJUOLL5xi2tltd
         cjbEQPnZLM7XX08/R/jocIxDsS0drsIKzeoZ0NHmGBfZ6bn+PWD18rOMTF7gKSgD8Kpk
         P8RnMUqqXn85VsGQqYKRs8XuNvmFxLtEEIwf3HowSmNUf29wxgUO2hDsiii4vnbyew2a
         efEQrqDEYVN7gPIdNsNgHSxZ2bPcFd3uNfzlik0GSbrd6BSZ6UI8hqBqj1rSkw6Ohr8D
         pa0PTV7B0icW2thnsiwZwyDYZ12sBCpz52Z63ZxGyEhrtuaMTe9WTK6s5gWhSbXcmyQ7
         GDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478943; x=1701083743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCEH2OhSh1wtb14SLQZhMNkQFOWqwz8F0y6cfbziznw=;
        b=rO8LhxEZtK2D+7yOIwwdXq6QTK4MgJmCnev0H05CLtek1DKvcXnPlzGYFDoJcKcAg+
         N0sD0PYap+GfDfPyAmfwSHnwgSUgU+C2By4kHOJJg/BdcV7RIBuzyvaik+QOt82d58FO
         POMOPR1p76g1yUNjOgApKU1IhxyMZ+s1EP8di5kGQl+P2CtqTPfhIFwKXGQPUqzL+XZS
         jZzVi0B8dN9DXRPazBZoC4OxYIp+YedfeF6x0YrWbVryQO734+bawXk+diOjd7dKp+3x
         Zq7Xg9lYadnKIAsUqw1AOKE8r/iKtUbu3LcSp82wIngquWbDyVPWsljz103GPntLF0sP
         mcIg==
X-Gm-Message-State: AOJu0YwZ2RqZgzgXpEL7eBjv7J1zgje06e3jrB/ulamFX5JQ2rkdG3Li
        itzQ9Gn8cR1Ls7yX2Ds78AvCY34T8I6CXW1XkLY=
X-Google-Smtp-Source: AGHT+IF5n5gAGiAyqw8nx/M9Y9DqsxUXIgsVPKnI6sLOE04ugWRfa1R84lxyi5u8UgH3nbITAeT48406+0Ri6tJ34bc=
X-Received: by 2002:a2e:9348:0:b0:2c5:2221:614f with SMTP id
 m8-20020a2e9348000000b002c52221614fmr4209856ljh.45.1700478942832; Mon, 20 Nov
 2023 03:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-5-ryncsn@gmail.com>
 <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com>
In-Reply-To: <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 19:15:25 +0800
Message-ID: <CAMgjq7D_OJiaNPWquFqxk5DKZXqoUMrD7Y_CRM7D0RnRnHmW7Q@mail.gmail.com>
Subject: Re: [PATCH 04/24] mm/swap: avoid setting page lock bit and doing
 extra unlock check
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
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

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=80 12:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > When swapping in a page, mem_cgroup_swapin_charge_folio is called for n=
ew
> > allocated folio, nothing else is referencing the folio so no need to se=
t
> > the lock bit. This avoided doing unlock check on error path.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_state.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index ac4fa404eaa7..45dd8b7c195d 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -458,6 +458,8 @@ struct page *__read_swap_cache_async(swp_entry_t en=
try, gfp_t gfp_mask,
>
> You move the mem_cgroup_swapin_charge_folio() inside the for loop:
>
>
>         for (;;) {
>                 int err;
>                 /*
>                  * First check the swap cache.  Since this is normally
>                  * called after swap_cache_get_folio() failed, re-calling
>                  * that would confuse statistics.
>                  */
>                 folio =3D filemap_get_folio(swap_address_space(entry),
>                                                 swp_offset(entry));
>
>
> >                                                 mpol, ilx, numa_node_id=
());
> >                 if (!folio)
> >                          goto fail_put_swap;
> > +               if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mas=
k, entry))
> > +                       goto fail_put_folio;
>
> Wouldn't it cause repeat charging of the folio when it is racing
> against others in the for loop?

The race loser will call folio_put and discharge it?

>
> >
> >                 /*
> >                  * Swap entry may have been freed since our caller obse=
rved it.
> > @@ -483,13 +485,9 @@ struct page *__read_swap_cache_async(swp_entry_t e=
ntry, gfp_t gfp_mask,
> >         /*
> >          * The swap entry is ours to swap in. Prepare the new page.
> >          */
> > -
> >         __folio_set_locked(folio);
> >         __folio_set_swapbacked(folio);
> >
> > -       if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry=
))
> > -               goto fail_unlock;
> > -
>
> The original code makes the charge outside of the for loop. Only the
> winner can charge once.

Right, this patch may make the charge/dis-charge path more complex for
race swapin, I'll re-check this part.

>
> Chris
