Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6687F5CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbjKWKwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjKWKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:52:20 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475931BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:52:26 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso9355791fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700736744; x=1701341544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlBw+J1DKtTqdlCO/c1cUzIzbtROUCDGWtDerK3Z8as=;
        b=TjpNstBkzm0o+js6eFXimRn0h62B8Mho/bxO56s1U3NIaixHwmQKkVewWB6c7ciW+9
         8TUm+YzkpjacYpFSjorIIWWHyf0Pei2MsVRu1HshmPXSnMuO8Stwx+voa2BLTqz67p6y
         IAmHDS+GB3GHG8ZZ7BOShktMVao+UlC5Qp4AKp1mXn8uIel/yWTrd80wDEN+O8nFcdsE
         uOiMqnRI/NlvEmsmXsRikJlOomfgW/C+2vDrwzpm4IX8sBZySojsZSPuMrTPVhRWOYl7
         0BoABxAOsCYzQtdoq3CtZTDFrzS5v1rzimAsAicy9kmcqb20HAnTAM95TsChp/GS4lG9
         0Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736744; x=1701341544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlBw+J1DKtTqdlCO/c1cUzIzbtROUCDGWtDerK3Z8as=;
        b=AcLe19lBldC3zfIiRRFZ5XKCTYLw2VmJ0foQCT2LDA+TDHLat2P1C2qeB4FszOVVHV
         9Jiumv2iS4yE2xBHL7D/r+3e4/2xhSmzXtCZfUWYAqTTrxP94O7TVDM6nU5gOcjUDzhG
         ifUQGjFd+gdTq2KWZy6NsRYBim5C7Czi/hzX5bqVG8vXKPTiAmkXDM2HaeFq9dPUsvel
         i29Ok00Bk3CpPoBl1Cwr2o/6KdI4LDEIIkXrNetzbqRqU25DDJglL9x/wbsbXbTic+Ij
         OmoZLX4tDI38RQzwSn/Ux3E/MiC79QKpw24BT0aeW4KXrJ+N9KUhT18IDh1fjPB+NmEn
         aoOA==
X-Gm-Message-State: AOJu0YxM+jGZDLb14eGeu+JQ+OCob9SyMRmGbdeQQCLkyHG4IKQqQ1Z2
        nJa4PTBQRYDL763b9/OBXx08kZBWgGclMolWGEk=
X-Google-Smtp-Source: AGHT+IFy+GdLH/BGXHcIl+Z3rWxvxH/CWpgB+pDVDbYP2pF0svbwAz0jWWBpfdzxDgZJSsjzgjCwsYAer7r8hl601rI=
X-Received: by 2002:a2e:9b0f:0:b0:2c5:1ad3:7798 with SMTP id
 u15-20020a2e9b0f000000b002c51ad37798mr3042949lji.52.1700736744207; Thu, 23
 Nov 2023 02:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-9-ryncsn@gmail.com>
 <CAF8kJuPTp5AJPStY0U-Q+t7HhoZB2B9cSQJONJv+xvR3qhxd1g@mail.gmail.com>
In-Reply-To: <CAF8kJuPTp5AJPStY0U-Q+t7HhoZB2B9cSQJONJv+xvR3qhxd1g@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Thu, 23 Nov 2023 18:52:06 +0800
Message-ID: <CAMgjq7C8o+Jr=oaoo_q+pdUV4wpGk9DZJHX3y5Zt5R4dPErYwQ@mail.gmail.com>
Subject: Re: [PATCH 08/24] mm/swap: check readahead policy per entry
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
=E5=91=A8=E4=BA=8C 15:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently VMA readahead is globally disabled when any rotate disk is
> > used as swap backend. So multiple swap devices are enabled, if a slower
> > hard disk is set as a low priority fallback, and a high performance SSD
> > is used and high priority swap device, vma readahead is disabled global=
ly.
> > The SSD swap device performance will drop by a lot.
> >
> > Check readahead policy per entry to avoid such problem.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_state.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index ff6756f2e8e4..fb78f7f18ed7 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -321,9 +321,9 @@ static inline bool swap_use_no_readahead(struct swa=
p_info_struct *si, swp_entry_
> >         return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_coun=
t(entry) =3D=3D 1;
> >  }
> >
> > -static inline bool swap_use_vma_readahead(void)
> > +static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
> >  {
> > -       return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rota=
te_swap);
> > +       return data_race(si->flags & SWP_SOLIDSTATE) && READ_ONCE(enabl=
e_vma_readahead);
>
> A very minor point:
> I notice you change the order enable_vma_readahead to the last.
> Normally if enable_vma_reachahead =3D=3D 0, there is no need to check the=
 si->flags.
> The si->flags check is more expensive than simple memory load.
> You might want to check enable_vma_readahead first then you can short
> cut the more expensive part.

Thanks, I'll improve this part.
