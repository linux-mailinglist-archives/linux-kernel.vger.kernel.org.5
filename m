Return-Path: <linux-kernel+bounces-79427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF2862212
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B39F286B69
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D038F7D;
	Sat, 24 Feb 2024 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2iET+rh"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904E8F58
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739212; cv=none; b=U/kSKVwB0+Pa555V8ePMSycESfsHDxoGhtBZM6yPywhXn4n3MEYjZ7SYfvgUYQ6koHS+Q1HwwUrAeafjy0dSLDVWRGoAwY26y/e6CBD7dggKBqt8SKcdO+MhY7KcIBk4kroA8R8bBua5UQL2QXXMOxHbCOLlnjKRWeJdlt+vhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739212; c=relaxed/simple;
	bh=aOpj8b8K6nXhwis7TUAgOs+6qNVRGmzL4eVMg54DuJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm6bydjBzaYC6NSnsjvIMbS967LUmCjbGxKP1ZOopTOepab58WNdzeNNTa2NCOKhIbExx7SBqxnx1PrAktxCtGq56oh2NimCdWaLeQJwIL1Mvk+QbGjgfqW+m7yz/+N3Bc2+vXArnLajT5flMgGloehpA2CEyL18jBS87MbrWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2iET+rh; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1331467a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708739210; x=1709344010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIeIOGeE7UM5CqcK2hhFn+X4HHNjpmx1AY/quZst6ic=;
        b=T2iET+rhkI//GBJ9aApNMJjQv7cGplqO1yp/4FE79W6EhzLTfSjNny7cbJkdXjB9b6
         tRXvvX3khIBirAkLYR0RR1EGxlxaKkELlqo6KkvuraaDL2n9ZtA7TGTHN1bJdeMLqGOH
         H6kphGkigkypGD4krfltiPm3GqQjAOyjiUxs9ReiktmD7lCRrTWxiJPS+wlAba/vEgFB
         RrQakcYGrFbEdw+k9q/1nUbbD83sQkOCeuUmIT5bR4dLXRgEVDaeqnzkpkCfjYGYtcJZ
         Hnc1e/BYMiNC2PbvA41J3AdcxuStNL88bfXoWaOquWRXfS0YzXsHsn0BiyDfig285SNt
         6X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708739210; x=1709344010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIeIOGeE7UM5CqcK2hhFn+X4HHNjpmx1AY/quZst6ic=;
        b=ihMGBJOqB0J8bGFpOr5cgyl3R4YlgTv0WGvOtGOaZ7J9o4ElIHDCfSg2/xsyvk24fc
         8nKuzc+NeW8hoASYNcuA2u+E1qw7EdIJ9cPOdJ0oM+u6ea7khrf8QwxfzPnAT5oH/vxg
         IfkOGzq0ZuqlEvrwUUFaWrwtpW8B7BZjHzJa2zAoIHW8Sa2oG747i7/0SwujL89wLVM1
         e8kcv0M+icqaX92O/mqqXsfX87lA4HvWL6rLcTrAGnfg7eAfRzevTHgyJuabFOlqHwJl
         7AhgczFq9RPjAQ7cR8dhOKp8lOgJQu9QZPwcQTTxx+DAxS0uLC3axq2IZl/yLsnhE7d2
         6kYw==
X-Forwarded-Encrypted: i=1; AJvYcCUC1oo4coEwRztUxFLSRPK3bXlJrPwStUerV4dPKNU3BRhXNIMT4l5qB5JafDqgwhYU24Rb3wwiZGW/Ezwj8Wx2WeD0Nksq3cMeYgC9
X-Gm-Message-State: AOJu0YzyMUWCk9CgRSiN5JdwECZ74dKFZTWbW/VX7hsJrTZ6RBjH+WmM
	T8U1htfPltzDU0O7Wi/06nrtzp+N6fR5lhypJNvx4Lp+vRVSqtKslPIhUc5/bK/wcTSNRmYkkI7
	FRl/Qn3sNWDZu8vPePZx2nHJ7f+NjQsmDVqA=
X-Google-Smtp-Source: AGHT+IECl7hOsYW40Y45gV1sm9Ytj58js8VudwCqI2NFWpL1iSFcuXN1PTrg/XYWifynnUbTGy+eShGLDdOhm9ZDNi4=
X-Received: by 2002:a17:90a:e550:b0:29a:7fde:7087 with SMTP id
 ei16-20020a17090ae55000b0029a7fde7087mr1573643pjb.8.1708739210543; Fri, 23
 Feb 2024 17:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com>
In-Reply-To: <20240129054551.57728-1-ioworker0@gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 23 Feb 2024 17:46:38 -0800
Message-ID: <CAHbLzkrScCvmDOPF0_+CieOtfcaP4JE=Pn29eYS_ZKiX-o4=-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 9:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> khugepaged scans the entire address space in the
> background for each given mm, looking for
> opportunities to merge sequences of basic pages
> into huge pages. However, when an mm is inserted
> to the mm_slots list, and the MMF_DISABLE_THP flag
> is set later, this scanning process becomes
> unnecessary for that mm and can be skipped to avoid
> redundant operations, especially in scenarios with
> a large address space.
>
> This commit introduces a check before each scanning
> process to test the MMF_DISABLE_THP flag for the
> given mm; if the flag is set, the scanning process
> is bypassed, thereby improving the efficiency of
> khugepaged.
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/khugepaged.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2b219acb528e..d6a700834edc 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -410,6 +410,12 @@ static inline int hpage_collapse_test_exit(struct mm=
_struct *mm)
>         return atomic_read(&mm->mm_users) =3D=3D 0;
>  }
>
> +static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *=
mm)
> +{
> +       return hpage_collapse_test_exit(mm) ||
> +              test_bit(MMF_DISABLE_THP, &mm->flags);
> +}
> +
>  void __khugepaged_enter(struct mm_struct *mm)
>  {
>         struct khugepaged_mm_slot *mm_slot;
> @@ -1422,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged_mm_sl=
ot *mm_slot)
>
>         lockdep_assert_held(&khugepaged_mm_lock);
>
> -       if (hpage_collapse_test_exit(mm)) {
> +       if (hpage_collapse_test_exit_or_disable(mm)) {

I'm not quite sure whether we should remove the mm from mm_slot and
drop mm_count or not since clearing MMF_THP_DISABLE flag doesn't add
the mm back. Creating new vma may add the mm back, but I don't think
the behavior should depend on this.

>                 /* free mm_slot */
>                 hash_del(&slot->hash);
>                 list_del(&slot->mm_node);
> @@ -2360,7 +2366,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                 goto breakouterloop_mmap_lock;
>
>         progress++;
> -       if (unlikely(hpage_collapse_test_exit(mm)))
> +       if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
>                 goto breakouterloop;
>
>         vma_iter_init(&vmi, mm, khugepaged_scan.address);
> @@ -2368,7 +2374,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                 unsigned long hstart, hend;
>
>                 cond_resched();
> -               if (unlikely(hpage_collapse_test_exit(mm))) {
> +               if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {
>                         progress++;
>                         break;
>                 }
> @@ -2390,7 +2396,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                         bool mmap_locked =3D true;
>
>                         cond_resched();
> -                       if (unlikely(hpage_collapse_test_exit(mm)))
> +                       if (unlikely(hpage_collapse_test_exit_or_disable(=
mm)))
>                                 goto breakouterloop;
>
>                         VM_BUG_ON(khugepaged_scan.address < hstart ||
> @@ -2408,7 +2414,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>                                 fput(file);
>                                 if (*result =3D=3D SCAN_PTE_MAPPED_HUGEPA=
GE) {
>                                         mmap_read_lock(mm);
> -                                       if (hpage_collapse_test_exit(mm))
> +                                       if (hpage_collapse_test_exit_or_d=
isable(mm))
>                                                 goto breakouterloop;
>                                         *result =3D collapse_pte_mapped_t=
hp(mm,
>                                                 khugepaged_scan.address, =
false);
> @@ -2450,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
>          * Release the current mm_slot if this mm is about to die, or
>          * if we scanned all vmas of this mm.
>          */
> -       if (hpage_collapse_test_exit(mm) || !vma) {
> +       if (hpage_collapse_test_exit_or_disable(mm) || !vma) {

Same like the above comment.

In addition, didn't you need to change hpage_collapse_test_exit() to
hpage_collapse_test_exit_or_disable() in hugepage_vma_revalidate()?

>                 /*
>                  * Make sure that if mm_users is reaching zero while
>                  * khugepaged runs here, khugepaged_exit will find
> --
> 2.33.1
>

