Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D409B7F4E72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjKVRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjKVRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:33:21 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A0B83
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:33:18 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso368731fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700674396; x=1701279196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHEeFsHmTkW/k0EikMcBHjMiZLLoJEpFmWQ5VwQyws8=;
        b=avePR3EiTiMxQ94K0Eaki6IbfJIiHnzLf9cYZlIjEhQkSR5Al/xguMSsOa3ng8gU+J
         huLFL/oGeleTUdmAyNKm/dNTl8/cqf8smn7w8RG6fXOOwJcLGidRLNG1QKa2n0rYY4b0
         E05+bVLCScdKm3t02u8FVwyXh79HmRdtmYEO+XsuaWlcmeTB0ive6GgfVYd2NJXi97Ui
         I5tLm/rlI17sGxQ88ne2nu7F0sQ5v9Bt+IBvjLqi+9yKJncCdPNzWMMI39S5bCb35rYV
         1dB9xxanSgpaS1FiwIGAg+pEKdOrQmFHlPl9hs14micT4KByFDiE6E4Qt7+Py+ubvISn
         nO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674396; x=1701279196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHEeFsHmTkW/k0EikMcBHjMiZLLoJEpFmWQ5VwQyws8=;
        b=Rdm8HCn4R2/Q+AmtttYuIB8p/W8F3BftBnEydahN9aM6dBfH6jrXTsuA16dXZaz6xI
         6xkzBbIaaK0mqT+4h0IpghEcWB5kotTLGmgUYWbwQZDcy9iSuPqVsrAyBf9i2cE+QNtL
         alV47ljPE1yRsG0YpTiZFGpHr+olU9Tam+4Rgr6gH+IhMpo9GO58DkWhluWkVk2b32eL
         h3b8gYDg3Lkq2asKgzTnw65E/xHrNybmEuWYe0chJDmDOTuURTKAKdlb2ju5Q1sSs6AJ
         QAXhaz0uW1y4iCePQ6Xzde2/228lqzC1eaubcXnf6qAt3OFk4INvP6RKB6MBix2pHO/N
         d6gw==
X-Gm-Message-State: AOJu0YzHaJgWDqQ3khHlXP2MqECdLYnlXNIk66YMJd9zyxtHEErPyrIw
        kkzqTkw6S6oSTmCHFULhkSs7qjSEfTM3L7YFS8k=
X-Google-Smtp-Source: AGHT+IGkd+NKe1U0R0nPxVu4xUlaRhq2hW7OVG+0UgiBYcmsECC8oJTycVpCAVdrGZED3XyT25qj8bBT9N6oMbqp2P8=
X-Received: by 2002:a2e:9f47:0:b0:2c5:130c:d41e with SMTP id
 v7-20020a2e9f47000000b002c5130cd41emr2364618ljk.29.1700674395777; Wed, 22 Nov
 2023 09:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-5-ryncsn@gmail.com>
 <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com>
 <CAMgjq7D_OJiaNPWquFqxk5DKZXqoUMrD7Y_CRM7D0RnRnHmW7Q@mail.gmail.com> <CAF8kJuOzXAy8Er_knD0hi60Tb+XDMrijg-W83KD=Zdjqbu1Dmw@mail.gmail.com>
In-Reply-To: <CAF8kJuOzXAy8Er_knD0hi60Tb+XDMrijg-W83KD=Zdjqbu1Dmw@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Thu, 23 Nov 2023 01:32:58 +0800
Message-ID: <CAMgjq7DNVkyhwyXz9PRcp3XTBNvznZ97dOFFA_DGsJks12_pQw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C 01:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 20, 2023 at 3:15=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> > > > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > > > index ac4fa404eaa7..45dd8b7c195d 100644
> > > > --- a/mm/swap_state.c
> > > > +++ b/mm/swap_state.c
> > > > @@ -458,6 +458,8 @@ struct page *__read_swap_cache_async(swp_entry_=
t entry, gfp_t gfp_mask,
> > >
> > > You move the mem_cgroup_swapin_charge_folio() inside the for loop:
> > >
> > >
> > >         for (;;) {
> > >                 int err;
> > >                 /*
> > >                  * First check the swap cache.  Since this is normall=
y
> > >                  * called after swap_cache_get_folio() failed, re-cal=
ling
> > >                  * that would confuse statistics.
> > >                  */
> > >                 folio =3D filemap_get_folio(swap_address_space(entry)=
,
> > >                                                 swp_offset(entry));
> > >
> > >
> > > >                                                 mpol, ilx, numa_nod=
e_id());
> > > >                 if (!folio)
> > > >                          goto fail_put_swap;
> > > > +               if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp=
_mask, entry))
> > > > +                       goto fail_put_folio;
> > >
> > > Wouldn't it cause repeat charging of the folio when it is racing
> > > against others in the for loop?
> >
> > The race loser will call folio_put and discharge it?
>
> There are two different charges. Memcg charging and memcg swapin charging=
.
> The folio_put will do the memcg discharge, the corresponding memcg
> charge is in follio allocation.

Hi Chris,

I didn't get your idea here... By "memcg swapin charge", do you mean
"memory.swap.*"? And "memcg charging" means "memory.*"?. There is no
memcg charge related code in folio allocation (alloc_pages_mpol),
actually the mem_cgroup_swapin_charge_folio here is doing memcg charge
not memcg swapin charge. Swapin path actually need to uncharge
"memory.swap" by mem_cgroup_swapin_uncharge_swap in later part of this
function.


> Memcg swapin charge does things differently, it needs to modify the
> swap relately accounting.
> The memcg uncharge is not a pair for memcg swapin charge.
>
> > > >                 /*
> > > >                  * Swap entry may have been freed since our caller =
observed it.
> > > > @@ -483,13 +485,9 @@ struct page *__read_swap_cache_async(swp_entry=
_t entry, gfp_t gfp_mask,
> > > >         /*
> > > >          * The swap entry is ours to swap in. Prepare the new page.
> > > >          */
> > > > -
> > > >         __folio_set_locked(folio);
> > > >         __folio_set_swapbacked(folio);
> > > >
> > > > -       if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, e=
ntry))
> > > > -               goto fail_unlock;
> > > > -
> > >
> > > The original code makes the charge outside of the for loop. Only the
> > > winner can charge once.
> >
> > Right, this patch may make the charge/dis-charge path more complex for
> > race swapin, I'll re-check this part.
>
> It is more than just complex, it seems to change the behavior of this cod=
e.
>
> Chris
