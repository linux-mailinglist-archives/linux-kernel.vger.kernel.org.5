Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA997D073F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346921AbjJTEDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjJTEDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:03:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27558C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:03:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso454823a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697774593; x=1698379393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9ETrTHEQk+WXMsfozc4cinDz8MB2A8nnq6gXwJvEpA=;
        b=u2MfuAN8HGV4mtw2grwSb0V0meg5mlWZCnijEG15dYhiRXWgE8GTIdDyGGyENo8uCt
         cnXpi/cTLydPsxFmOnByXaXyx0t98AeEaYYdI7DAf5Pu9stFaBBO+1uHQPf1F0Zzo+C8
         1co4oRhqc4u7touz4+iaWqpg15g9R/q9k0qQi2pRCdXpM+rMGSsEGjbYQ5EFMBKK1Us4
         h3ejEpY2bj6A5+pg5psdypmLweXKyZbdbw5cNCRj2x0IdYfk7ujuwHkhxfZv/rOhhi8q
         UUBW0/dBdgNlpzJE427+j9z/7mqbHSR96fIwWACOuaIyWqGgFzl7n504GwhfvydoXLLr
         Ww3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697774593; x=1698379393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9ETrTHEQk+WXMsfozc4cinDz8MB2A8nnq6gXwJvEpA=;
        b=Cob4ndCOF2PWX4mHs0NKp7IA1+3myP6V/6vj22dXp4Z/YoR2KbuTmJO/NGW9SrhGEy
         gK/BwUcaEy+1Tx6jZSvSfJnWxszEWUudJBBZ1jNLorN9nW+TOXLobMgjq0JiKJjYx8/t
         bCZhUwa1Wlzt1ESE3aRJ/gIlTDgODKKhJX+gbl+d/8vvuKDudGrXYzvabl/L1GXOFLjo
         10YmyCp4nPQQpVmFNEi6CPd39gx6EZRQABkjiBkPRz62ABhob6WyMpMJ84fxQawCipl4
         sZyp/vyrAop1GCoaCXNiwPHHm8U5OFPTvgtOBFNw/RYJhDe8H2I1R50W/YS9TOh38GDj
         cYOQ==
X-Gm-Message-State: AOJu0Yy1zsXZjWa2da3JxO0mqWqh9yjWfS8r99r4pPlmlftUbMKtxvXE
        GRdWgHKh0IFggZpVa9vHzmY7AA7Kd7DrbiI0XEZ0eGP1gydmV/qcFFOsHA==
X-Google-Smtp-Source: AGHT+IGQLjTrZjisjjWo5Ccc+gH4ZaKHg46CBwViuytgKv/Sa3WnG2vMPWOyzvfVlBcp1IhpmlbtHjsVBn4WiELfirg=
X-Received: by 2002:a17:906:4fd0:b0:9c7:4dab:20ea with SMTP id
 i16-20020a1709064fd000b009c74dab20eamr400243ejw.67.1697774593348; Thu, 19 Oct
 2023 21:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com> <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com> <27f40fc2-806a-52a9-3697-4ed9cd7081d4@intel.com>
 <e8099116-6f78-cb4a-5036-1d7e38b63e52@linux.alibaba.com> <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
 <05d596f3-c59c-76c3-495e-09f8573cf438@linux.alibaba.com> <b9042fcb-05df-460f-87b8-4d7a04d3bd5e@intel.com>
 <e84f8c2d-6264-f2a3-3737-17d48a0251f8@linux.alibaba.com> <93abbbfb-27fb-4f65-883c-a6aa38c61fa0@intel.com>
 <0aaf6bf4-a327-9582-569e-2a634ce74af4@linux.alibaba.com> <CAJD7tkbA0Ofvw8wQM0017DKWC3SXOT71rCnUhGkoPgQ4wOfLOA@mail.gmail.com>
 <fb225c52-0d46-4a67-a897-f39b5c1b5554@intel.com>
In-Reply-To: <fb225c52-0d46-4a67-a897-f39b5c1b5554@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 19 Oct 2023 21:02:37 -0700
Message-ID: <CAJD7tkYNLERnUKLu_Jsr7YAxqWNmJk7AXvOFRGSxN=1k+uq=UQ@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 8:52=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 10/20/2023 11:45 AM, Yosry Ahmed wrote:
> >>>>
> >>>> IMHO, that seems too hacky to me. I still prefer to rely on the migr=
ation process of the mlcock pages.
> >>>
> >>> BTW, Yosry tried to address the overlap of field lru and mlock_count:
> >>> https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@goog=
le.com/
> >>> But the lore doesn't group all the patches.
> >>
> >> Thanks for the information. I'd like to review and test if this work c=
an
> >> continue.
> >
> > The motivation for this work was reviving the unevictable LRU for the
> > memcg recharging RFC series [1]. However, that series was heavily
> > criticized. I was not intending on following up on it.
> >
> > If reworking the mlock_count is beneficial for other reasons, I am
> > happy to respin it if the work needed to make it mergeable is minimal.
> > Otherwise, I don't think I have the time to revisit (but feel free to
> > pick up the patches if you'd like).
> >
> > [1]https://lore.kernel.org/lkml/20230720070825.992023-1-yosryahmed@goog=
le.com/
>
> I believe reworking the mlock_count is focus here. If there is no overlap
> between lru and mlock_count, the whole logic of lru_add_drain() can be
> removed here.

All patches except patch 4 are for reworking the mlock_count. Once the
mlock count is reworked, reviving the unevictable LRU is actually very
simple and removes more code than it adds (see patch 4 below).

>
> And I noticed the link:
> https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.c=
om/
> only has cover letter and the patches didn't grouped.

That's weird, here are the patches (in order):
https://lore.kernel.org/lkml/20230618065744.1363948-1-yosryahmed@google.com=
/
https://lore.kernel.org/lkml/20230618065756.1364399-1-yosryahmed@google.com=
/
https://lore.kernel.org/lkml/20230618065809.1364900-1-yosryahmed@google.com=
/
https://lore.kernel.org/lkml/20230618065816.1365301-1-yosryahmed@google.com=
/
https://lore.kernel.org/lkml/20230618065824.1365750-1-yosryahmed@google.com=
/

>
>
> Regards
> Yin, Fengwei
>
