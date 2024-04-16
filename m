Return-Path: <linux-kernel+bounces-147647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A809D8A76DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C37281B46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1F13A889;
	Tue, 16 Apr 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="gyUxID/N"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E113A41D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303329; cv=none; b=CBYaaQJ0JTwh7Kg17uSdgARmqJmdXMN1+J0uBKjCb+eGCYyVtAdOU6fAylqm6TCPrB1zW+jJh00gPO1xSppK2YRxZeZum3igfrKmZANJyp8IAkdUeT5wUZd6kBp5vls9Ap20Op89nbCBvAT8EROz9BWVXvXkUoRRtZKluRkKWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303329; c=relaxed/simple;
	bh=E57kJ0JrkRpk8eR+Xx58hV6q/REDS03PqWfDJFb/djY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpJXtFnF+qMjKB0E85im0hJy/HAUmYndS67Xs1rJCCS/43OtZqDWOicRky594Sw9yqX/yId8i5FUwPF3aGPdIdj+S4fRlBFMcK3KtM2MmLqqQVSNS+V6q1wZy5zNS5HguN6TxtT5VZ8ZSbEHNPvmTeX5tMUW+QQeVO+zmSMRWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=gyUxID/N; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4371955d27fso10932581cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1713303327; x=1713908127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsVvW9UN/T1Z6HI6qn67MvHY2qYpnw17QsJrjMaEsPI=;
        b=gyUxID/Nsv+B6rGUylEh7WUVoqdNGppUxDxW/kfGNz18CdrzopDoMfQhUSgQDVzR4c
         erzLMmTrx+acCwPjvtfySu6ZWrpaSc8JDXDSvcNREfvKb2SDV+cUEiBmqsw3+L5Hu5ie
         FlOp/f7m8Z3NJM7VfQMjNJsoPdu8F/3Te9BXR8H6IfOfw/VFTuN0we5sA8QgU8fdmuyy
         V2hgP5hJ7mGS+9gTKPIGhXp3Z/aPZmTIztMtoI23ScX1wnu7PP8j0N8YCRIXhXoPpG+j
         +ron8+v5inFYV5rJyGh5J3h96xzuVZ2eSr1AssItuPpEin3tiFVTdQ2jI8yweGV3WJhR
         ceyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713303327; x=1713908127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsVvW9UN/T1Z6HI6qn67MvHY2qYpnw17QsJrjMaEsPI=;
        b=LOuFvv52GBCoJKsUR7SsV4PnPVmQj3egaBwRibH4ITWO0EQ7jpz5Nlm5FFKaqzGMQp
         GulH9i4mdMVYE4lWVSECivYK7+G14XqV67bfPgyXuwLivjNUi7v659ZzmM0UFOjGV7Gr
         WsisJOPyT+iVrryYLbcD6azj82AiZX7AegaiYmukoMtdhMuqxJUTsQtCb5HV7Ijw+XZO
         INzPIyxHo4Tp71mxmVeo7Ad3Vssc8is7E5g/ZJTtCttkb8/0eD06pp55RcqbzfOzE+Z+
         iRyiJtGE2rjuDKlTylpPnz/n19qY2dymwmanJ9kRMffSoUb00tbz0OKXWjkl6+IY5CCY
         K6fA==
X-Gm-Message-State: AOJu0Yw1dP5jQms1OodTXEBXxTop4qq8QIxPXGKU7ucbhg4kWd01pteB
	xuAo15kgbJOHCHu0PQ5VDpT6mOU2MN0G0dwefuPNzietPm1T2vUFwtfjrn4Z6IVHE/AYdYS2ydr
	wzeB1VV8kvdpP3TM8bLb38UciEXDKMscrFSmOPA==
X-Google-Smtp-Source: AGHT+IFuefJGGOxRGnvAFV36oj38O3TLAnqZtZNp7C+CXSwoxzFpU/Yla/VjxPkq7ft4YaBFjwQ0EwK4l8JA0kUOItw=
X-Received: by 2002:ac8:59c1:0:b0:437:5da2:7537 with SMTP id
 f1-20020ac859c1000000b004375da27537mr1760441qtf.9.1713303326702; Tue, 16 Apr
 2024 14:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415205259.2535077-1-peterx@redhat.com>
In-Reply-To: <20240415205259.2535077-1-peterx@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 16 Apr 2024 17:34:50 -0400
Message-ID: <CA+CK2bCSs8om+7tO_Sq2fAUD+gzD_4unUXMtO9oRUB+=4biv-Q@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: Support userfault wr-protect entries
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nadav Amit <nadav.amit@gmail.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thanks for this patch, I like this extra checking logic, my comments below:

On Mon, Apr 15, 2024 at 4:53=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Allow page_table_check hooks to check over userfaultfd wr-protect criteri=
a
> upon pgtable updates.  The rule is no co-existance allowed for any writab=
le
> flag against userfault wr-protect flag.
>
> This should be better than c2da319c2e, where we used to only sanitize suc=
h
> issues during a pgtable walk, but when hitting such issue we don't have a
> good chance to know where does that writable bit came from [1], so that
> even the pgtable walk exposes a kernel bug (which is still helpful on
> triaging) but not easy to track and debug.
>
> Now we switch to track the source.  It's much easier too with the recent
> introduction of page table check.
>
> There are some limitations with using the page table check here for
> userfaultfd wr-protect purpose:
>
>   - It is only enabled with explicit enablement of page table check confi=
gs
>   and/or boot parameters, but should be good enough to track at least
>   syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED] for
>   x86 [1].  We used to have DEBUG_VM but it's now off for most distros,
>   while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED], whi=
ch
>   is similar.
>
>   - It conditionally works with the ptep_modify_prot API.  It will be
>   bypassed when e.g. XEN PV is enabled, however still work for most of th=
e
>   rest scenarios, which should be the common cases so should be good
>   enough.
>
>   - Hugetlb check is a bit hairy, as the page table check cannot identify
>   hugetlb pte or normal pte via trapping at set_pte_at(), because of the
>   current design where hugetlb maps every layers to pte_t... For example,
>   the default set_huge_pte_at() can invoke set_pte_at() directly and lose
>   the hugetlb context, treating it the same as a normal pte_t. So far it'=
s
>   fine because we have huge_pte_uffd_wp() always equals to pte_uffd_wp() =
as
>   long as supported (x86 only).  It'll be a bigger problem when we'll
>   define _PAGE_UFFD_WP differently at various pgtable levels, because the=
n
>   one huge_pte_uffd_wp() per-arch will stop making sense first.. as of no=
w
>   we can leave this for later too.
>
> This patch also removes commit c2da319c2e altogether, as we have somethin=
g
> better now.
>
> [1] https://lore.kernel.org/all/000000000000dce0530615c89210@google.com/
>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/include/asm/pgtable.h | 18 +-----------------
>  mm/page_table_check.c          | 32 +++++++++++++++++++++++++++++++-

Please add the new logic to: Documentation/mm/page_table_check.rst

>  2 files changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtabl=
e.h
> index 273f7557218c..65b8e5bb902c 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -388,23 +388,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>  static inline int pte_uffd_wp(pte_t pte)
>  {
> -       bool wp =3D pte_flags(pte) & _PAGE_UFFD_WP;
> -
> -#ifdef CONFIG_DEBUG_VM
> -       /*
> -        * Having write bit for wr-protect-marked present ptes is fatal,
> -        * because it means the uffd-wp bit will be ignored and write wil=
l
> -        * just go through.
> -        *
> -        * Use any chance of pgtable walking to verify this (e.g., when
> -        * page swapped out or being migrated for all purposes). It means
> -        * something is already wrong.  Tell the admin even before the
> -        * process crashes. We also nail it with wrong pgtable setup.
> -        */
> -       WARN_ON_ONCE(wp && pte_write(pte));
> -#endif
> -
> -       return wp;
> +       return pte_flags(pte) & _PAGE_UFFD_WP;
>  }
>
>  static inline pte_t pte_mkuffd_wp(pte_t pte)
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index af69c3c8f7c2..d4eb1212f0f5 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -7,6 +7,8 @@
>  #include <linux/kstrtox.h>
>  #include <linux/mm.h>
>  #include <linux/page_table_check.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>
>  #undef pr_fmt
>  #define pr_fmt(fmt)    "page_table_check: " fmt
> @@ -182,6 +184,23 @@ void __page_table_check_pud_clear(struct mm_struct *=
mm, pud_t pud)
>  }
>  EXPORT_SYMBOL(__page_table_check_pud_clear);
>
> +/* Whether the swap entry cached writable information */
> +static inline bool swap_cached_writable(swp_entry_t entry)
> +{
> +       unsigned type =3D swp_type(entry);
> +
> +       return type =3D=3D SWP_DEVICE_EXCLUSIVE_WRITE ||
> +           type =3D=3D SWP_MIGRATION_WRITE;
> +}
> +
> +static inline void __page_table_check_pte(pte_t pte)

may be something like:
page_table_check_new_pte() ? Naming is starting to get confusing. The
idea for this function is to check the pte that is about to be set
into the page table.

> +{
> +       if (pte_present(pte) && pte_uffd_wp(pte))
> +               WARN_ON_ONCE(pte_write(pte));
> +       else if (is_swap_pte(pte) && pte_swp_uffd_wp(pte))
> +               WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pte)))=
;
> +}
> +
>  void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_=
t pte,
>                 unsigned int nr)
>  {
> @@ -190,18 +209,29 @@ void __page_table_check_ptes_set(struct mm_struct *=
mm, pte_t *ptep, pte_t pte,
>         if (&init_mm =3D=3D mm)
>                 return;
>
> -       for (i =3D 0; i < nr; i++)
> +       for (i =3D 0; i < nr; i++) {
> +               __page_table_check_pte(pte);

This should really be called only once after this loop.

>                 __page_table_check_pte_clear(mm, ptep_get(ptep + i));
> +       }
>         if (pte_user_accessible_page(pte))
>                 page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
>  }
>  EXPORT_SYMBOL(__page_table_check_ptes_set);
>
> +static inline void __page_table_check_pmd(pmd_t pmd)

page_table_check_new_pmd() ?

> +{
> +       if (pmd_present(pmd) && pmd_uffd_wp(pmd))
> +               WARN_ON_ONCE(pmd_write(pmd));
> +       else if (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd))
> +               WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)))=
;
> +}
> +
>  void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t=
 pmd)
>  {
>         if (&init_mm =3D=3D mm)
>                 return;
>
> +       __page_table_check_pmd(pmd);
>         __page_table_check_pmd_clear(mm, *pmdp);
>         if (pmd_user_accessible_page(pmd)) {
>                 page_table_check_set(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT=
,
> --
> 2.44.0
>

Thanks,
Pasha

