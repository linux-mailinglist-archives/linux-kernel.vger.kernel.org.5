Return-Path: <linux-kernel+bounces-150826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259AC8AA54F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FDC1C21E45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB37199E9B;
	Thu, 18 Apr 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="zDheyhDn"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEBA180A67
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478320; cv=none; b=qJ9e97KGivtovLbcTQiV6K9EbF7XYMOi5YpXrr5iXhx6ivGDypN941q84fT3hOeGl4MSAbHzFo0LWvCggO8XpNhnm/QTKcofZNKlDYsGE5gGWV0MVH7L4pThCWuitF4UpilzoGxSxjzphr+j67nBtyuzwbQ8mgYRCImCfXfsuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478320; c=relaxed/simple;
	bh=qC73A3C+2ySXkYRdhc6wiS5hdCuQCzyFsXeqp/DMf2w=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=gGrszSREAQhzv4KuKyg0gdosuURTAvwA6YF0dUhPAHYhQ0QeaoUl9umU537t4IsxBbF1O8xonTb31DrbUQVeSumfEPsatLDTBxfcienOxek1ribRfbLvHQfT14RElLKg2pMW/peemeUXWuD7dKznePQkHqbUTx5cgZ5KUm8SXNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=zDheyhDn; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22ec61aaf01so833626fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1713478318; x=1714083118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJWNYLKtKkE3VgEEb7txo69kf/MROzgyItmd/8X/Bkw=;
        b=zDheyhDnes1JFgEb7i7lavl61MoAOiTBxb0W4oMg1oV6h4nwVnyGvQPlc/EOT9cING
         dHak2xF2NisrUCnaHNcrig7gQQXANiOeLOJj66w1aW12agsBDJlDTH4h2aKdFF+BgPpx
         XPQKpaVpSEN2sPvFN28+Jdsyqcgv/ea6Wi6M2hO8kW4GD77xJ4Niis991ryVbYAGvhtL
         quRpnFMRAXYFrVdxpR+KzoGaA6ARa7IG59vN1BRIrIMx+Q0fV96XJglo4EkA1zlR1Lwo
         m7LU8g4OD8/O8+4D5eNRXq7KyVerZsNQ76PBG7Xi4w3l2Bc83uIYGuVXDMcKT7kPeDnO
         K88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713478318; x=1714083118;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJWNYLKtKkE3VgEEb7txo69kf/MROzgyItmd/8X/Bkw=;
        b=ZpoZ+RkHuxeYIvQSk6oKh6r94QNIs/cerufNxA24XAsFTT8zref/EIY7DeVxf1zhXb
         +rPxE+bnEVxSsoHaeDamFTuiVp7Ef34a+7CV8NY5PEj9j2e2VWGmZMQOVfrn0PWLw7MH
         fpe9GEDpN+jVTsGZqeNaft3IiZ6/i5IeYC32WCWqd9w0h43Jgv7mUiT0oanP8eb1yxf1
         1GpyL3CP4+gM2z5uMtU39R2Xri7RCZBbGvCc7drziDObKj20WvCjPZxy2+pu/PDjm9vy
         WC58Dqi7YrFNA1a2y0//g1S16IICKOoiVpsgRHla5J7fokWAaCv8FQ88DcnvR80jYPBq
         YepQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLPOdA9FVMalwar0eXr0fhcoiftq9lwVfb2czUpdDeiDwyLWlj1T+s/30CZ62ab+cHcFFXd9nuk09iZ9LLoiNMo9c1ywiA0cvuQLJT
X-Gm-Message-State: AOJu0YzodU9SO6PFDrc3JEVrYQwPvllBMYgwHBHFnFjaMthTSkq9q2wQ
	b0rN0w5CeX1+o6CQGI4DamFGl9f9ELWlkcoS+AcDsIIggooEiidT7xRpTgudtl8=
X-Google-Smtp-Source: AGHT+IH5Rrf98QC4gFatEepR9aZzJYc9ESCNODVH0HHIz4PIvza73yv3y89sBwp3q1CAuQ8k41fxxw==
X-Received: by 2002:a05:6870:d187:b0:232:ff53:44fe with SMTP id a7-20020a056870d18700b00232ff5344femr362648oac.38.1713478317422;
        Thu, 18 Apr 2024 15:11:57 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id q9-20020a63d609000000b005dc9439c56bsm1877624pgg.13.2024.04.18.15.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 15:11:56 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:11:56 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2024 15:11:55 PDT (-0700)
Subject:     Re: [PATCH 0/9] Merge arm64/riscv hugetlbfs contpte support
In-Reply-To: <CAHVXubiH64beFuB_GHSq5BKCus=O_+bqYTCwWQ+=2Q-F=T=ctQ@mail.gmail.com>
CC: ryan.roberts@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-mm@kvack.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alexghiti@rivosinc.com
Message-ID: <mhng-911ba065-e6c8-4d42-978c-e47897bcb493@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 01 Mar 2024 03:29:18 PST (-0800), alexghiti@rivosinc.com wrote:
> Hi Ryan,
>
> On Fri, Mar 1, 2024 at 11:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi Alexandre,
>>
>> I confess I haven't looked at the patches yet, but this cover letter raises a
>> few quesions for me. I'll aim to look at the actual patches in due course.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case someone wants to pick them up via a generic tree.  I'm happy to 
take them via the RISC-V tree if folk want, no rush on my end I'm just 
scrubbing through old stuff.

>> On 01/03/2024 09:14, Alexandre Ghiti wrote:
>> > This patchset intends to merge the contiguous ptes hugetlbfs implementation
>> > of arm64 and riscv.
>> >
>> > Both arm64 and riscv support the use of contiguous ptes to map pages that
>> > are larger than the default page table size, respectively called contpte
>> > and svnapot.
>> >
>> > The riscv implementation differs from the arm64's in that the LSBs of the
>> > pfn of a svnapot pte are used to store the size of the mapping, allowing
>> > for future sizes to be added (for now only 64KB is supported). That's an
>> > issue for the core mm code which expects to find the *real* pfn a pte points
>> > to. Patch 1 fixes that by always returning svnapot ptes with the real pfn
>> > and restores the size of the mapping when it is written to a page table.
>>
>> Yes that makes sense to me. The intention for mTHP (!hugetlb) is to fully
>> encapsulate PTEs beind set_ptes(), ptep_get() and friends, so what's actually
>> written to the pgtable is arch-specific and well abstracted.
>>
>> >
>> > The following patches are just merges of the 2 different implementations
>> > that currently exist in arm64 and riscv which are very similar. It paves
>> > the way to the reuse of the recent contpte THP work by Ryan [1] to avoid
>> > reimplementing the same in riscv.
>>
>> You seem to be talking about both hugetlb (which uses the "huge" pte helpers)
>> and contpte for THP (i.e. mTHP, which uses the regular pte helpers). They are
>> pretty separate in my mind, so not sure why you would be modifying them both in
>> the same series?
>
> I don't, this patchset only deals with hugetlb, I just meant that this
> series was just the beginning as I'm working on moving the contpte for
> THP support in the generic code for riscv to use.
>
> Sorry my wording was ambiguous :)
>
> Thanks,
>
> Alex
>
>>
>> Thanks,
>> Ryan
>>
>> >
>> > This patchset was tested by running the libhugetlbfs testsuite with 64KB
>> > and 2MB pages on both architectures (on a 4KB base page size arm64 kernel).
>> >
>> > [1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-ryan.roberts@arm.com/
>> >
>> > Alexandre Ghiti (9):
>> >   riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
>> >   riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
>> >   mm: Use common huge_ptep_get() function for riscv/arm64
>> >   mm: Use common set_huge_pte_at() function for riscv/arm64
>> >   mm: Use common huge_pte_clear() function for riscv/arm64
>> >   mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
>> >   mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
>> >   mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
>> >   mm: Use common huge_ptep_clear_flush() function for riscv/arm64
>> >
>> >  arch/arm64/Kconfig                  |   1 +
>> >  arch/arm64/include/asm/pgtable.h    |  59 +++++-
>> >  arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
>> >  arch/riscv/Kconfig                  |   1 +
>> >  arch/riscv/include/asm/hugetlb.h    |   2 +-
>> >  arch/riscv/include/asm/pgtable-64.h |  11 ++
>> >  arch/riscv/include/asm/pgtable.h    | 120 +++++++++++-
>> >  arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
>> >  mm/Kconfig                          |   3 +
>> >  mm/Makefile                         |   1 +
>> >  mm/contpte.c                        | 268 +++++++++++++++++++++++++
>> >  11 files changed, 456 insertions(+), 528 deletions(-)
>> >  create mode 100644 mm/contpte.c
>> >
>>

