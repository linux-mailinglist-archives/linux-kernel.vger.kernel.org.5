Return-Path: <linux-kernel+bounces-157322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C808B0FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C6C1C24926
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900DB161B58;
	Wed, 24 Apr 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfvFKDnT"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480A161338;
	Wed, 24 Apr 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976109; cv=none; b=INiSFg85k7rtViTcNR4SUebiQLO8ro51YQgi9D2LK3orU3XXBh4PSo0m7wj/JqJwkWb1umSlp2KbAw7uf2+t+HLQTirlwVGcTznvD3qbFcJfav6x2yXlqcB8kcpklikgeynh/rBuptexACS1zu07zKtzMlUsuVaqxSnDFhdeVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976109; c=relaxed/simple;
	bh=nXICmLNa5ne/beLDRI7Fc+Ize090vpoxiK3SaiUT+pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gH0Zgtw45jbaaSBxdr6/I7absz1KQef3QR1gpKCDhVhnB4VIePzdVzrNmUBYn1R7S7TCr9zFhTyxP15nySpF5rx+foUGFYnXmLD9LkUZzeEKUml1XUxSvJDZv5+P0uQzme45pwKcZuPSd5eHU6oG1csV/g91e28laQJaYu+j2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfvFKDnT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57222fc625aso1990752a12.3;
        Wed, 24 Apr 2024 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713976105; x=1714580905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JqRkyrHFPe2Hk6rtj2fC55FVgPhDwmSNOrraGk0QQY=;
        b=OfvFKDnThEhTB8ovrMAM6neHvZJK3qeXU165Ew+Ur0p3K4xYyD1GGqdg1AAK0ddH1l
         dxI31RHKo+el8rNOEIqV8njCBEmjczABWVF5EAchD5VI9TyKq7icQTeg1Xs4MbYpbnlv
         44QC8s+JllITGjCSqysmjfzxEqHIt0ENe1pM9oPownLCNev1AxN5Kt63vCxet4T12fiV
         JWfpxWIweSnXMUwBzsFpg7jno+rMidDhYXmQsS/5Wu7+Vp/wFHZdLHSwA/8hmf/oqGtw
         ApeRPyb0Ts5ByfWR1iaPD5TgiPPAr0OOrpKtiykfUXFWn94iys+IUYZp3sPX8QbX985r
         MnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976105; x=1714580905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JqRkyrHFPe2Hk6rtj2fC55FVgPhDwmSNOrraGk0QQY=;
        b=MsBcpW4gONhnysvE+snfHs9VOx5jeoDRJjr7TLFWxFHgk3hMY1jwyBvvwWaF9eMUXL
         +w67qEg4jey8eNieW2/9DIajHJVZNa4fUdgmfiN1BVCcQqes1vuEO2kLdGDjNBLewjH1
         BFONl7GkBjYTwIOm2ill/nQT75GCYlbaJ59yh2+427XkfE+mucXMoc66CkLs88olX+oo
         ocGTWERCcu7b00O9W5pR4Zz0u27ptDKXeB3Dpe4NWt5sZCKTvmjfUZ5Joi7lTmcL1CKl
         G0Wi+lfPWamIM+j9aI0fyI8CE+vV1qw/MCOJ5CTJnvrL+RstxMba+XvMv6RNK+ne+Yv3
         zh5w==
X-Forwarded-Encrypted: i=1; AJvYcCUR/OxsysKCk4T6IEIrUxc0J7WnUvsoH7W6PR6ne3I7DsXlQToBLLCuBh1AxeS4fzzKMifyhHDslDwaRfFVdmmQ1EhVdD8uK23l
X-Gm-Message-State: AOJu0YyBA64J4KF6E1PdIrdJxsxaZrETWKofB4s5EOrewVVkYNSndlDc
	5aF9hxdq1f4WRdv8/Q637tZ88w6At37XAUUrPhX1o17SFZsFUQmsaHkGpI8aDqkC/MpR8oldkDY
	z3uTCiA7TqMdbsQXs7UpyBBKIljxW+Q==
X-Google-Smtp-Source: AGHT+IH2zGJqGBW8yYoAiv97KOpycs4WS5UjEgOW6mRB5suj5uSecL+wVAVA0XwFMqqzKD/7sl1rggQpu8UvoTv44mM=
X-Received: by 2002:a17:906:2a1b:b0:a55:b488:27b9 with SMTP id
 j27-20020a1709062a1b00b00a55b48827b9mr2623451eje.38.1713976105203; Wed, 24
 Apr 2024 09:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122630.495788-1-david@redhat.com>
In-Reply-To: <20240424122630.495788-1-david@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 24 Apr 2024 09:28:13 -0700
Message-ID: <CAHbLzkrAW0RK81ABnveJf98besYHaAaA7nJzrqWYm=hf382s2g@mail.gmail.com>
Subject: Re: [PATCH v1] mm/khugepaged: replace page_mapcount() check by folio_likely_mapped_shared()
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>, 
	John Hubbard <jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:26=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> We want to limit the use of page_mapcount() to places where absolutely
> required, to prepare for kernel configs where we won't keep track of
> per-page mapcounts in large folios.
>
> khugepaged is one of the remaining "more challenging" page_mapcount()
> users, but we might be able to move away from page_mapcount() without
> resulting in a significant behavior change that would warrant
> special-casing based on kernel configs.
>
> In 2020, we first added support to khugepaged for collapsing COW-shared
> pages via commit 9445689f3b61 ("khugepaged: allow to collapse a page shar=
ed
> across fork"), followed by support for collapsing PTE-mapped THP in commi=
t
> 5503fbf2b0b8 ("khugepaged: allow to collapse PTE-mapped compound pages")
> and limiting the memory waste via the "page_count() > 1" check in commit
> 71a2c112a0f6 ("khugepaged: introduce 'max_ptes_shared' tunable").
>
> As a default, khugepaged will allow up to half of the PTEs to map shared
> pages: where page_mapcount() > 1. MADV_COLLAPSE ignores the khugepaged
> setting.
>
> khugepaged does currently not care about swapcache page references, and
> does not check under folio lock: so in some corner cases the "shared vs.
> exclusive" detection might be a bit off, making us detect "exclusive" whe=
n
> it's actually "shared".
>
> Most of our anonymous folios in the system are usually exclusive. We
> frequently see sharing of anonymous folios for a short period of time,
> after which our short-lived suprocesses either quit or exec().
>
> There are some famous examples, though, where child processes exist for a
> long time, and where memory is COW-shared with a lot of processes
> (webservers, webbrowsers, sshd, ...) and COW-sharing is crucial for
> reducing the memory footprint. We don't want to suddenly change the
> behavior to result in a significant increase in memory waste.
>
> Interestingly, khugepaged will only collapse an anonymous THP if at least
> one PTE is writable. After fork(), that means that something (usually a
> page fault) populated at least a single exclusive anonymous THP in that P=
MD
> range.
>
> So ... what happens when we switch to "is this folio mapped shared"
> instead of "is this page mapped shared" by using
> folio_likely_mapped_shared()?
>
> For "not-COW-shared" folios, small folios and for THPs (large
> folios) that are completely mapped into at least one process,
> switching to folio_likely_mapped_shared() will not result in a change.
>
> We'll only see a change for COW-shared PTE-mapped THPs that are
> partially mapped into all involved processes.
>
> There are two cases to consider:
>
> (A) folio_likely_mapped_shared() returns "false" for a PTE-mapped THP
>
>   If the folio is detected as exclusive, and it actually is exclusive,
>   there is no change: page_mapcount() =3D=3D 1. This is the common case
>   without fork() or with short-lived child processes.
>
>   folio_likely_mapped_shared() might currently still detect a folio as
>   exclusive although it is shared (false negatives): if the first page is
>   not mapped multiple times and if the average per-page mapcount is small=
er
>   than 1, implying that (1) the folio is partially mapped and (2) if we a=
re
>   responsible for many mapcounts by mapping many pages others can't
>   ("mostly exclusive") (3) if we are not responsible for many mapcounts b=
y
>   mapping little pages ("mostly shared") it won't make a big impact on th=
e
>   end result.
>
>   So while we might now detect a page as "exclusive" although it isn't,
>   it's not expected to make a big difference in common cases.
>
> (B) folio_likely_mapped_shared() returns "true" for a PTE-mapped THP
>
>   folio_likely_mapped_shared() will never detect a large anonymous folio
>   as shared although it is exclusive: there are no false positives.
>
>   If we detect a THP as shared, at least one page of the THP is mapped by
>   another process. It could well be that some pages are actually exclusiv=
e.
>   For example, our child processes could have unmapped/COW'ed some pages
>   such that they would now be exclusive to out process, which we now
>   would treat as still-shared.

IIUC, case A may under-count shared PTEs, however on the opposite side
case B may over-count shared PTEs, right? So the impact may depend on
what value is used by max_shared_ptes tunable. It may have a more
noticeable impact on a very conservative setting (i.e. max_shared_ptes
=3D=3D 1) if it is under-counted or on a very aggressive setting (i.e.
max_shared_ptes =3D=3D 510) if it is over-counted.

So I agree it should not matter much for common cases. AFAIK, the
usecase for aggressive setting should be very rare, but conservative
setting may be more usual, so improving the under-count for
conservative setting may be worth it.

>
>   Examples:
>   (1) Parent maps all pages of a THP, child maps some pages. We detect
>       all pages in the parent as shared although some are actually
>       exclusive.
>   (2) Parent maps all but some page of a THP, child maps the remainder.
>       We detect all pages of the THP that the parent maps as shared
>       although they are all exclusive.
>
>   In (1) we wouldn't collapse a THP right now already: no PTE
>   is writable, because a write fault would have resulted in COW of a
>   single page and the parent would no longer map all pages of that THP.
>
>   For (2) we would have collapsed a THP in the parent so far, now we
>   wouldn't as long as the child process is still alive: unless the child
>   process unmaps the remaining THP pages or we decide to split that THP.
>
>   Possibly, the child COW'ed many pages, meaning that it's likely that
>   we can populate a THP for our child first, and then for our parent.
>
>   For (2), we are making really bad use of the THP in the first
>   place (not even mapped completely in at least one process). If the
>   THP would be completely partially mapped, it would be on the deferred
>   split queue where we would split it lazily later.
>
>   For short-running child processes, we don't particularly care. For
>   long-running processes, the expectation is that such scenarios are
>   rather rare: further, a THP might be best placed if most data in the
>   PMD range is actually written, implying that we'll have to COW more
>   pages first before khugepaged would collapse it.
>
> To summarize, in the common case, this change is not expected to matter
> much. The more common application of khugepaged operates on
> exclusive pages, either before fork() or after a child quit.
>
> Can we improve (A)? Yes, if we implement more precise tracking of "mapped
> shared" vs. "mapped exclusively", we could get rid of the false
> negatives completely.
>
> Can we improve (B)? We could count how many pages of a large folio we map
> inside the current page table and detect that we are responsible for most
> of the folio mapcount and conclude "as good as exclusive", which might he=
lp
> in some cases. ... but likely, some other mechanism should detect that
> the THP is not a good use in the scenario (not even mapped completely in
> a single process) and try splitting that folio lazily etc.
>
> We'll move the folio_test_anon() check before our "shared" check, so we
> might get more expressive results for SCAN_EXCEED_SHARED_PTE: this order
> of checks now matches the one in __collapse_huge_page_isolate(). Extend
> documentation.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>
> How much time can one spend writing a patch description? Unbelievable. Bu=
t
> it was likely time well spend to have a clear picture of the impact.
>
> This really needs the folio_likely_mapped_shared() optimization [1] that
> resides in mm-unstable, I think, to reduce "false negatives".
>
> The khugepage MM selftests keep working as expected, including:
>
>         Run test: collapse_max_ptes_shared (khugepaged:anon)
>         Allocate huge page... OK
>         Share huge page over fork()... OK
>         Trigger CoW on page 255 of 512... OK
>         Maybe collapse with max_ptes_shared exceeded.... OK
>         Trigger CoW on page 256 of 512... OK
>         Collapse with max_ptes_shared PTEs shared.... OK
>         Check if parent still has huge page... OK
>
> Where we check that collapsing in the parent behaves as expected after
> COWing a lot of pages in the parent: a sane scenario that is essentially
> unchanged and which does not depend on any action in the child process
> (compared to the cases discussed in (B) above).
>
> [1] https://lkml.kernel.org/r/20240409192301.907377-6-david@redhat.com
>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |  3 ++-
>  mm/khugepaged.c                            | 22 +++++++++++++++-------
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index f82300b9193fe..076443cc10a6c 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -278,7 +278,8 @@ collapsed, resulting fewer pages being collapsed into
>  THPs, and lower memory access performance.
>
>  ``max_ptes_shared`` specifies how many pages can be shared across multip=
le
> -processes. Exceeding the number would block the collapse::
> +processes. khugepaged might treat pages of THPs as shared if any page of
> +that THP is shared. Exceeding the number would block the collapse::
>
>         /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2f73d2aa9ae84..cf518fc440982 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -583,7 +583,8 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                 folio =3D page_folio(page);
>                 VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>
> -               if (page_mapcount(page) > 1) {
> +               /* See hpage_collapse_scan_pmd(). */
> +               if (folio_likely_mapped_shared(folio)) {
>                         ++shared;
>                         if (cc->is_khugepaged &&
>                             shared > khugepaged_max_ptes_shared) {
> @@ -1317,8 +1318,20 @@ static int hpage_collapse_scan_pmd(struct mm_struc=
t *mm,
>                         result =3D SCAN_PAGE_NULL;
>                         goto out_unmap;
>                 }
> +               folio =3D page_folio(page);
>
> -               if (page_mapcount(page) > 1) {
> +               if (!folio_test_anon(folio)) {
> +                       result =3D SCAN_PAGE_ANON;
> +                       goto out_unmap;
> +               }
> +
> +               /*
> +                * We treat a single page as shared if any part of the TH=
P
> +                * is shared. "False negatives" from
> +                * folio_likely_mapped_shared() are not expected to matte=
r
> +                * much in practice.
> +                */
> +               if (folio_likely_mapped_shared(folio)) {
>                         ++shared;
>                         if (cc->is_khugepaged &&
>                             shared > khugepaged_max_ptes_shared) {
> @@ -1328,7 +1341,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                         }
>                 }
>
> -               folio =3D page_folio(page);
>                 /*
>                  * Record which node the original page is from and save t=
his
>                  * information to cc->node_load[].
> @@ -1349,10 +1361,6 @@ static int hpage_collapse_scan_pmd(struct mm_struc=
t *mm,
>                         result =3D SCAN_PAGE_LOCK;
>                         goto out_unmap;
>                 }
> -               if (!folio_test_anon(folio)) {
> -                       result =3D SCAN_PAGE_ANON;
> -                       goto out_unmap;
> -               }
>
>                 /*
>                  * Check if the page has any GUP (or other external) pins=
.
> --
> 2.44.0
>
>

