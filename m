Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6297F260E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjKUHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:03:59 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF8BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:03:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5056059e0so70417601fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700550234; x=1701155034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOp3reY2bag6A9E6TpTlNAlJv0Ad2NbW094QK59DdBw=;
        b=Du8MJY88Q2yvQTxS5DrPw2ESq5UTXCrDXjIigzq5ra40P8VNJMaK+0N+wr9rjxZKf1
         R+pYQA2bs8iTnR142Q1Ex8e93oOTiT3hIQap3MDEaWy5ChV0XBtAu+GfMOxEVKuuVcld
         FkiBOe3LPA801iHMlrcg6rWb2UI402yzmLYGrcAWzx6HryyGK2lEczj2jDKlH1PCBsVA
         u0s0HFHLQkzThlT/U7m9J9h+9OO4ptZIvrjOLVYe1wZyINd6PaVVB2Y1ei9Oi/cCeqyg
         xtcp6EefFrbklG+8Y/XI9u048XhStrYwUiy6Wv/yaZCNgbGC86gt40qJTwx0c+caLUrk
         Mbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700550234; x=1701155034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOp3reY2bag6A9E6TpTlNAlJv0Ad2NbW094QK59DdBw=;
        b=qI8e2Jdx3sOmALm6VCX8GvRMxDpotE+QrzYHHJxFRdODkzu9jCKW+5HrqnqJljzv70
         AFwSKQzW3kU4nPivZlk6LzjUDQKgaOmIw342fWGIOvoRLGTiC0XHfR0hHRh8sg98fzE6
         dtPU7XrGQq7vEJ8tdQw8VE1ZppzASJO/bztgGuETLPGV9ujS3mH2UwsGISyB1lcvg25n
         W62M19qPozW7zK93JYce46RldTrz+e7hoVcURao97Ql4UneYE6GUd67GcacZ/5RhTkT6
         TfV/pSgJHpaQMpGe9Bz+uO/pbnELu9233nBqgt7Hmw1VDeKxf7bsz4NtjTrvPUzMKbJ/
         hjIw==
X-Gm-Message-State: AOJu0Ywt2YnUDD+lUnNWK6t0kJrHTZg4x1GvsvrQLg1Ic8A58laYhsfp
        rnSrG6cz35P+vHzBwBJAIkEPZWM48rwYd84o4G8=
X-Google-Smtp-Source: AGHT+IFeCq5NRHAVzCqCZaxA+wFlgaRv8aKB2Cp8sklzT3oed/MSHwYLFt5htutSECDvAkeG76R6UVPu9dW2BS5NO18=
X-Received: by 2002:a2e:7307:0:b0:2c8:721c:6912 with SMTP id
 o7-20020a2e7307000000b002c8721c6912mr5890785ljc.37.1700550233662; Mon, 20 Nov
 2023 23:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-8-ryncsn@gmail.com>
 <CAF8kJuMYHB_VWCompfGHQXuyk3MiDtka9dDfUDLxfGk40aN2Hw@mail.gmail.com>
In-Reply-To: <CAF8kJuMYHB_VWCompfGHQXuyk3MiDtka9dDfUDLxfGk40aN2Hw@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Tue, 21 Nov 2023 15:03:36 +0800
Message-ID: <CAMgjq7BdZ-XTPZ8+_w87WC5syLYqpZ=1=S2AsivH2GUn96i+oA@mail.gmail.com>
Subject: Re: [PATCH 07/24] mm/swap: move swap_count to header to be shared
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

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kairui,
>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > No feature change, prepare for later commits.
>
> Again, I don't see the value of having this as a stand alone patch.
> If one of the later patches needs to use this function as external
> rather than static, move it with the patch that uses it. From the
> reviewing point of view, it is unnecessary overhead to cross reference
> different patches in order to figure out why it is moved.

Good suggestion, I do this locally for easier rebase & conflict
resolving, will get rid of these little parts next time.

>
> Chris
>
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap.h     | 5 +++++
> >  mm/swapfile.c | 5 -----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/swap.h b/mm/swap.h
> > index f82d43d7b52a..a9a654af791e 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -61,6 +61,11 @@ static inline unsigned int folio_swap_flags(struct f=
olio *folio)
> >  {
> >         return page_swap_info(&folio->page)->flags;
> >  }
> > +
> > +static inline unsigned char swap_count(unsigned char ent)
> > +{
> > +       return ent & ~SWAP_HAS_CACHE; /* may include COUNT_CONTINUED fl=
ag */
> > +}
> >  #else /* CONFIG_SWAP */
> >  struct swap_iocb;
> >  static inline void swap_readpage(struct page *page, bool do_poll,
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 0142bfc71b81..a8ae472ed2b6 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -114,11 +114,6 @@ static struct swap_info_struct *swap_type_to_swap_=
info(int type)
> >         return READ_ONCE(swap_info[type]); /* rcu_dereference() */
> >  }
> >
> > -static inline unsigned char swap_count(unsigned char ent)
> > -{
> > -       return ent & ~SWAP_HAS_CACHE;   /* may include COUNT_CONTINUED =
flag */
> > -}
> > -
> >  /* Reclaim the swap entry anyway if possible */
> >  #define TTRS_ANYWAY            0x1
> >  /*
> > --
> > 2.42.0
> >
> >
