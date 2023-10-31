Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52D7DD60C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjJaS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjJaS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:29:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C588E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:29:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2809414efa9so1389828a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698776986; x=1699381786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PKVfy4ZthRoQBgmQEAFsfsI4stxqvYuDQMfSgfvCZc=;
        b=aN5STz1aoJMWtIPqikabjJyS+Mrk71QkUATaxObnC20pBrt3V5tBlOJCUU6bY6p6sL
         Sw8wfS9l6PEKx9W7K4Ecpoka1lOsCDVlVy0AdaJgB0SsA3X4PXvZhJkZqb2GpVfHJGSU
         Rhv+LWHfCLyq0OR6q/m1TxxsGs97CFyDGd15wP/iziwr2wBexBJVPINvacudttD6Minv
         Wh1JXiNIypsnO8povzsp8A3LIOzUReZq/TG5hNrl4jFF+F9M0nz6GqjKgVGp1tlA7tCH
         uLsoiRqi5zgMNgBe2p1HKun91kckuQi5NVzcF7SaGsB2N0deefVLB56TSufS++hjm4dj
         MX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698776986; x=1699381786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PKVfy4ZthRoQBgmQEAFsfsI4stxqvYuDQMfSgfvCZc=;
        b=LiHI180NHBTqOFUpSsHJlDjqzfZddK2D4losRB6DnahQudr1VkKm/NrPUN5o9rAqF7
         MP2FKsDpFpQgIb8GDYE/TzXRNDokhUwsdmalDqu6Fum8bvTgtz7X4n5s3myLEfIHcN02
         UyX0FHsIkG1rpiLeSmkaZ2ycbJsZqx0/CYcA4bO2rtJGYqi7lWkSMGwK3DR+9mOb5bx1
         TvZSUCmK9eXzAioRruMl8M5mfyhSgwaFXd97r2dLvis3MOpbRGwSXyFu4VZFFnrFobGH
         pIl9s8riG1+HrI8XIwDGSQwX+7LpodrkCxcFU7X5bQbDCJoXClH9Tilj9xJkFtc9NQGi
         o45w==
X-Gm-Message-State: AOJu0YyJ9tDRUcQRmLL8rUNVeZyD7tKAI4SCVB6c9EfZTKYf3nN9ew3F
        exNI7f2OhYHF1Eu8aChURry5HL7sGUZLNgiRtIE=
X-Google-Smtp-Source: AGHT+IHqLkIwkQP219z9PHoWu6HjZxKQ8OlMO5fel3Q1LczSmnwlmvCqPu8jPp+hILckOmvy3NUjIiPLhcSZrepKF64=
X-Received: by 2002:a17:90a:1a17:b0:280:2c55:77c5 with SMTP id
 23-20020a17090a1a1700b002802c5577c5mr6842416pjk.46.1698776985860; Tue, 31 Oct
 2023 11:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com> <7a3a2d49-528d-4297-ae19-56aa9e6c59c6@arm.com>
 <cf97cf90-ceae-4fc8-8fd8-3f8068e53611@arm.com>
In-Reply-To: <cf97cf90-ceae-4fc8-8fd8-3f8068e53611@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 31 Oct 2023 11:29:34 -0700
Message-ID: <CAHbLzkrJAsWzAJCrh+Dh5gNTE1UrH9ndbWQqH9fStoptpMkEew@mail.gmail.com>
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

On Tue, Oct 31, 2023 at 4:55=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 31/10/2023 11:50, Ryan Roberts wrote:
> > On 06/10/2023 21:06, David Hildenbrand wrote:
> > [...]
> >>
> >> Change 2: sysfs interface.
> >>
> >> If we call it THP, it shall go under "/sys/kernel/mm/transparent_hugep=
age/", I
> >> agree.
> >>
> >> What we expose there and how, is TBD. Again, not a friend of "orders" =
and
> >> bitmaps at all. We can do better if we want to go down that path.
> >>
> >> Maybe we should take a look at hugetlb, and how they added support for=
 multiple
> >> sizes. What *might* make sense could be (depending on which values we =
actually
> >> support!)
> >>
> >>
> >> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/
> >> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/
> >> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/
> >> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/
> >> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/
> >> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/
> >>
> >> Each one would contain an "enabled" and "defrag" file. We want somethi=
ng minimal
> >> first? Start with the "enabled" option.
> >>
> >>
> >> enabled: always [global] madvise never
> >>
> >> Initially, we would set it for PMD-sized THP to "global" and for every=
thing else
> >> to "never".
> >
> > Hi David,
> >
> > I've just started coding this, and it occurs to me that I might need a =
small
> > clarification here; the existing global "enabled" control is used to dr=
ive
> > decisions for both anonymous memory and (non-shmem) file-backed memory.=
 But the
> > proposed new per-size "enabled" is implicitly only controlling anon mem=
ory (for
> > now).
> >
> > 1) Is this potentially confusing for the user? Should we rename the per=
-size
> > controls to "anon_enabled"? Or is it preferable to jsut keep it vague f=
or now so
> > we can reuse the same control for file-backed memory in future?
> >
> > 2) The global control will continue to drive the file-backed memory dec=
ision
> > (for now), even when hugepages-2048kB/enabled !=3D "global"; agreed?
> >
> > Thanks,
> > Ryan
> >
>
> Also, an implementation question:
>
> hugepage_vma_check() doesn't currently care whether enabled=3D"never" for=
 DAX VMAs
> (although it does honour MADV_NOHUGEPAGE and the prctl); It will return t=
rue
> regardless. Is that by design? It couldn't fathom any reasoning from the =
commit log:

The enabled=3D"never" is for anonymous VMAs, DAX VMAs are typically file VM=
As.

>
> bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flag=
s,
>                         bool smaps, bool in_pf, bool enforce_sysfs)
> {
>         if (!vma->vm_mm)                /* vdso */
>                 return false;
>
>         /*
>          * Explicitly disabled through madvise or prctl, or some
>          * architectures may disable THP for some mappings, for
>          * example, s390 kvm.
>          * */
>         if ((vm_flags & VM_NOHUGEPAGE) ||
>             test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>                 return false;
>         /*
>          * If the hardware/firmware marked hugepage support disabled.
>          */
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUP=
PORTED))
>                 return false;
>
>         /* khugepaged doesn't collapse DAX vma, but page fault is fine. *=
/
>         if (vma_is_dax(vma))
>                 return in_pf;  <<<<<<<<
>
>         ...
> }
>
>
