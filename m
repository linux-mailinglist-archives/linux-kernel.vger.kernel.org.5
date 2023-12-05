Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B822E805E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjLES42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLES41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:56:27 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE55C0;
        Tue,  5 Dec 2023 10:56:33 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35d5b30eb85so10941485ab.3;
        Tue, 05 Dec 2023 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701802593; x=1702407393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX7BSvsSgEvxeEewDtCNHmyfYjnN75yOhnwgeA3SiHc=;
        b=hVsJIRy5J3p7kWysWdVSbdN5z70vmt8G1VtK+CN2ZwAt7O79YvIjExLanND1ZrVW3S
         7aUWlyPa6AjN5NR1YQC2yG4SEIlTNLG5T/HxHFmcV78EXzBrh0JfrKf+Jv1ziR4rX4BH
         sXpGIbi7lRLXNf4qhUI+qzGX2xrokGQ9N/OpCoaYXGZcm6PO5B1BOVacsmo0lgaIPa5H
         Ps2iy+Bm/dpvzwGZ1GaNg6dmmIPLcDx+65mM3xs0uDlGOm8c/JpA0/LpL8MzlXSjb95t
         I6F3nD4FryxknFSDiaND8ccyON2/0WJmZ+sYbCa4s0OFMinALVgqZTR/9kGEzEnNyJsn
         YSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802593; x=1702407393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX7BSvsSgEvxeEewDtCNHmyfYjnN75yOhnwgeA3SiHc=;
        b=rQNkRtzb55tAapipDFNsCHvLZL6wn95S6JVnDxDGJPhgQ331/q81UkaO1RP0W5RIOC
         DJCp3zAU5HRdY7iv25jxKHWViYSF4l/NMUqjGHlKRDRiAULMPuqeWFrx6m2063f2sFhD
         Xbf9r10f6y5/GZyHylywpC0cvzrO5iWyKhnD5ItOkM+fr90t6oPxEaRKmHr5YG1CQeze
         sS2JgPoO9WOOEjbOWll3dZC/Elj2l3xVgYZuGvHmGBGeSTQbvvml07EmHxjKMZew1gR/
         xjkKpv6I5CU/DWxiT+kRVI3QPb6whYRhji05JVSvJWeb811bQ3PnV3sc++gmimyIA2Pw
         UKNA==
X-Gm-Message-State: AOJu0YxcolGKczTbxJrlSi4rEfffgtHRiBk6jJMUqKs/xx9la90aN/AR
        u76BugBEJ78GVRR6vmzhf7v1bEmrSnLYvQUaVqA=
X-Google-Smtp-Source: AGHT+IEcE/zesmD+UCjJA2C2FvRizWi9OIb6LAruDxE2y1Ht+ILvyPpADLGvz0Glk6mjK92qRYLqCUCwpWsqGARdGlk=
X-Received: by 2002:a05:6e02:1b02:b0:35d:6e20:6a59 with SMTP id
 i2-20020a056e021b0200b0035d6e206a59mr4813195ilv.22.1701802593017; Tue, 05 Dec
 2023 10:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-5-nphamcs@gmail.com>
 <CAJD7tkZeXY0HbBQu_pZr+kDgoPoDR+kQZq4XxYo6ZXfrO2=BKQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZeXY0HbBQu_pZr+kDgoPoDR+kQZq4XxYo6ZXfrO2=BKQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 5 Dec 2023 10:56:22 -0800
Message-ID: <CAKEwX=Nwm_wG7pTANKc_jJFsz=RHB4A_fKXGXfeyc2hb-bcG1A@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] mm: memcg: add per-memcg zswap writeback stat
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Tue, Dec 5, 2023 at 10:22=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >
> > Since zswap now writes back pages from memcg-specific LRUs, we now need=
 a
> > new stat to show writebacks count for each memcg.
> >
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/vm_event_item.h | 1 +
> >  mm/memcontrol.c               | 1 +
> >  mm/vmstat.c                   | 1 +
> >  mm/zswap.c                    | 4 ++++
> >  4 files changed, 7 insertions(+)
> >
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_ite=
m.h
> > index d1b847502f09..f4569ad98edf 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -142,6 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPO=
UT,
> >  #ifdef CONFIG_ZSWAP
> >                 ZSWPIN,
> >                 ZSWPOUT,
> > +               ZSWP_WB,
>
> I think you dismissed Johannes's comment from v7 about ZSWPWB and
> "zswpwb" being more consistent with the existing events.

I missed that entirely. Oops. Yeah I prefer ZSWPWB too. Let me send a fix.

>
> >  #endif
> >  #ifdef CONFIG_X86
> >                 DIRECT_MAP_LEVEL2_SPLIT,
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 792ca21c5815..21d79249c8b4 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -703,6 +703,7 @@ static const unsigned int memcg_vm_event_stat[] =3D=
 {
> >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> >         ZSWPIN,
> >         ZSWPOUT,
> > +       ZSWP_WB,
> >  #endif
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >         THP_FAULT_ALLOC,
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index afa5a38fcc9c..2249f85e4a87 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1401,6 +1401,7 @@ const char * const vmstat_text[] =3D {
> >  #ifdef CONFIG_ZSWAP
> >         "zswpin",
> >         "zswpout",
> > +       "zswp_wb",
> >  #endif
> >  #ifdef CONFIG_X86
> >         "direct_map_level2_splits",
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f323e45cbdc7..49b79393e472 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -760,6 +760,10 @@ static enum lru_status shrink_memcg_cb(struct list=
_head *item, struct list_lru_o
> >         }
> >         zswap_written_back_pages++;
> >
> > +       if (entry->objcg)
> > +               count_objcg_event(entry->objcg, ZSWP_WB);
> > +
> > +       count_vm_event(ZSWP_WB);
> >         /*
> >          * Writeback started successfully, the page now belongs to the
> >          * swapcache. Drop the entry from zswap - unless invalidate alr=
eady
> > --
> > 2.34.1
