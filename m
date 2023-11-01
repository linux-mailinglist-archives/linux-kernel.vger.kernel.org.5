Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101477DE5E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbjKASMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjKASMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:12:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA1C1BDB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:11:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso184265ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698862296; x=1699467096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFXG9E/24dOz3uE7iAGtCMg93Y3K/HY/Z5kpbtFMk+E=;
        b=YnLndn273305jLur8Q8pVylPsncqEgBfwsRxM4UOvaNnp9MaQYBybcOEQqnJprekgc
         2d5mHYwdxYUv9zu47bBfKoSKvXyx+LcqdyrFFqf18ITa4t9ikJT4p12ZBTm2s7yelmgH
         VYLls8As2MViCrU76StO62ZqZvh7RaND/C/J/nzkPqwVt4q8OOmq8/GEOSPN4BZe0uT0
         Gi+Q/WsyfLQOuPbmF7OL0Mgf0U3ixGuDLqz4xsFDLkxcw2wu04jlxSYKo49tVakZU+ZD
         aqzXY1oK/mZbmT4ErWYvGvx9NH86a5EuYHpkwhO7iTnyNq85NjZDCBtRxkoLIdvcGc92
         Tn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698862296; x=1699467096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFXG9E/24dOz3uE7iAGtCMg93Y3K/HY/Z5kpbtFMk+E=;
        b=dbVFCHotuxI1SMOL0W75V9u8T/ZaXjCPhkECZ3XE+7R3nIbEYZgtQIieJeNfCK/+tO
         He4BS+9Nphs0HLO3mbzCiJ0h26zDJaHgi4ugFUoA0d111PUfW5G6cdvGctZX0Fj3hV87
         qmVqTCX+bEPFy7ILxjuy7FIGrDX6wMhfv2FisMS97LTvfSr09HWQU1YLe56ZkK7KZCCu
         07xucJnFlpXgmY3B5DQlp8inOhy3yM/GXTPXnIIr6XOesamw+/m+5sZuL/KylTXcZ4/x
         XWCeaXbzBjT7REh8QAEhAww9d8ifGCUVbCwFy4eLK4CM4+jUCjJC59SoRM+RxWVyqDUt
         nqyw==
X-Gm-Message-State: AOJu0Yy/NwyuqPmNVmX2KEIqvjCsqEJXqMbJLQcosV7lA/oOWHzgbur9
        delhgu61oVc1dgvxM2pjb+r3XQyAefkpayc+jg8=
X-Google-Smtp-Source: AGHT+IHq2bUWyykKiAizgFLTKMG68uREfVJLn8kvLbTYyMrdN91Dxa+syscP1tRk/dGZuEQVtYubryieUgC8UL++r+I=
X-Received: by 2002:a17:90a:ca13:b0:27f:fce3:2266 with SMTP id
 x19-20020a17090aca1300b0027ffce32266mr14439023pjt.24.1698862296552; Wed, 01
 Nov 2023 11:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com> <7a3a2d49-528d-4297-ae19-56aa9e6c59c6@arm.com>
 <cf97cf90-ceae-4fc8-8fd8-3f8068e53611@arm.com> <CAHbLzkrJAsWzAJCrh+Dh5gNTE1UrH9ndbWQqH9fStoptpMkEew@mail.gmail.com>
 <148676a4-8267-42de-a3ad-a3734e3f4bd9@arm.com>
In-Reply-To: <148676a4-8267-42de-a3ad-a3734e3f4bd9@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 1 Nov 2023 11:11:24 -0700
Message-ID: <CAHbLzkpNrtCfzuWFXWO-3Rwa62YibKYGBFuj0Wek_gO+nd7jMg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 7:02=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 31/10/2023 18:29, Yang Shi wrote:
> > On Tue, Oct 31, 2023 at 4:55=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 31/10/2023 11:50, Ryan Roberts wrote:
> >>> On 06/10/2023 21:06, David Hildenbrand wrote:
> >>> [...]
> >>>>
> >>>> Change 2: sysfs interface.
> >>>>
> >>>> If we call it THP, it shall go under "/sys/kernel/mm/transparent_hug=
epage/", I
> >>>> agree.
> >>>>
> >>>> What we expose there and how, is TBD. Again, not a friend of "orders=
" and
> >>>> bitmaps at all. We can do better if we want to go down that path.
> >>>>
> >>>> Maybe we should take a look at hugetlb, and how they added support f=
or multiple
> >>>> sizes. What *might* make sense could be (depending on which values w=
e actually
> >>>> support!)
> >>>>
> >>>>
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/
> >>>>
> >>>> Each one would contain an "enabled" and "defrag" file. We want somet=
hing minimal
> >>>> first? Start with the "enabled" option.
> >>>>
> >>>>
> >>>> enabled: always [global] madvise never
> >>>>
> >>>> Initially, we would set it for PMD-sized THP to "global" and for eve=
rything else
> >>>> to "never".
> >>>
> >>> Hi David,
> >>>
> >>> I've just started coding this, and it occurs to me that I might need =
a small
> >>> clarification here; the existing global "enabled" control is used to =
drive
> >>> decisions for both anonymous memory and (non-shmem) file-backed memor=
y. But the
> >>> proposed new per-size "enabled" is implicitly only controlling anon m=
emory (for
> >>> now).
> >>>
> >>> 1) Is this potentially confusing for the user? Should we rename the p=
er-size
> >>> controls to "anon_enabled"? Or is it preferable to jsut keep it vague=
 for now so
> >>> we can reuse the same control for file-backed memory in future?
> >>>
> >>> 2) The global control will continue to drive the file-backed memory d=
ecision
> >>> (for now), even when hugepages-2048kB/enabled !=3D "global"; agreed?
> >>>
> >>> Thanks,
> >>> Ryan
> >>>
> >>
> >> Also, an implementation question:
> >>
> >> hugepage_vma_check() doesn't currently care whether enabled=3D"never" =
for DAX VMAs
> >> (although it does honour MADV_NOHUGEPAGE and the prctl); It will retur=
n true
> >> regardless. Is that by design? It couldn't fathom any reasoning from t=
he commit log:
> >
> > The enabled=3D"never" is for anonymous VMAs, DAX VMAs are typically fil=
e VMAs.
>
> That's not quite true; enabled=3D"never" is honoured for non-DAX/non-shme=
m file
> VMAs (for collapse via CONFIG_READ_ONLY_THP_FOR_FS and more recently for

When implementing READ_ONLY_THP_FOR_FS the file THP just can be
collapsed by khugepaged, but khugepaged is started iff enabled !=3D
"never". So READ_ONLY_THP_FOR_FS has to honor it. Unfortunately there
are some confusing exceptions... But anyway DAX is not the same class.

> anything that implements huge_fault() - see
> 7a81751fcdeb833acc858e59082688e3020bfe12).

IIUC this commit just gives the vmas which implement huge_fault() a
chance to handle the fault. Currently just DAX vmas implement
huge_fault() in vanilla kernel AFAICT.

>
