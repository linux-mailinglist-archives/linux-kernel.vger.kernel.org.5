Return-Path: <linux-kernel+bounces-144602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E18A4844
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8819EB221E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88DF1CFA9;
	Mon, 15 Apr 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErcIv7ML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704A1C6B9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163145; cv=none; b=PzoL5XP3efVUdoJ5w2c/xa9I9smxLXHP6XhYxGF0nkL9jEa7hQVuXGyBG0ELANbK9v5KfBd7+A+JwJ9OI5oxGkC8sWrjq5hd+I4ZIUpxNh+YBY13CAN1WaF4gUU0l3huAYWIjLcyzQVOs2WSd6boX3nfStdsCxE8JdR1iI9hgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163145; c=relaxed/simple;
	bh=WfgQkz1O24qdMgxAqlkplv/ziGxYLznIbd05tGFu1IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMRWMGNU3GiNoNs0+Kc6lLyFt71Nt7w4vg+/5p29lgQ1b2yeRMrUQvEUEXX1PK32p3Ixrc5sffEWkSFr37E92pryfGVdVpv3kQRtnXgqOnFaQZxRR5MY8lCa1IglUsqGCx8JamirvWl4L8WRJi18S1Grk5UYZu88dGIcvlllI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErcIv7ML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959F4C32781
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713163144;
	bh=WfgQkz1O24qdMgxAqlkplv/ziGxYLznIbd05tGFu1IA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ErcIv7ML1uwx3A3L+0shIh63p7Y0HlvRmP6y/EePlnvGF37wfIMSDRgPkzrIbyXDU
	 +Kkw56yrxjZi5qTx0DvL1HzhkmAFYpoEAj7kQzxyA3NyNcgwTv4NmQ/7F8+aTqu/RE
	 UvEDXNSqJp1zWC0Wa9xuVk9Wz3j4d1kodypw6psBowS+UxPKkFPQeTMpwZoNg9RYAG
	 6Gtj1ju26SsQcVmKcla/SCRtPvSoTaV6AxN9g0QpwM3tnNd4FMuvlMVYw2N56Jm0AL
	 g5KFzrW1AWLNi4SmdPcemnjKGW6AmbBXyg3+2B5NyJg2g8ksez47Fb/TqQFMSmSZQA
	 LnjN47XTLS7Dg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2da68af6c6fso10431401fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:39:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOi8DWl12YkkxNJS4So//50BhD2XKlCRtXkXjLVklme/UWOsaN/fQu4d3jEdX8zQJEKuaUwcNO1/cSspIRUsIZO2ZOzmdaZjjYJzds
X-Gm-Message-State: AOJu0Yx6wWY2ermOmEpBPmsOFWbIGzaqnnGzCO8NkkQVKc0NVM3Y/jTu
	0/ehhk/8saMXIG7iibxWq1zx4eSD6HK72HYOaOYmbypz0BicHUzZrWC11O6leAa6YdMLUQD/CJg
	qCwWpZaOmNVX4onJFYX6Bg7AJ+AU=
X-Google-Smtp-Source: AGHT+IH1cioSkSwvmqsBAJDHAkDlCRPWk6le9Uik49UsIc3u7bJ8AH+2ytgMy8WmN1LmckTjmydi5avalvRsirptxos=
X-Received: by 2002:a2e:bc19:0:b0:2da:9d98:5ec2 with SMTP id
 b25-20020a2ebc19000000b002da9d985ec2mr110279ljf.4.1713163142885; Sun, 14 Apr
 2024 23:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415063110.1795707-1-anshuman.khandual@arm.com>
In-Reply-To: <20240415063110.1795707-1-anshuman.khandual@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 15 Apr 2024 08:38:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFS+9ErLn5VyEFLzqwPBgiZBPLjv2OgsAFQPSN=jPWm+A@mail.gmail.com>
Message-ID: <CAMj1kXFS+9ErLn5VyEFLzqwPBgiZBPLjv2OgsAFQPSN=jPWm+A@mail.gmail.com>
Subject: Re: [PATCH] arm64/hugetlb: Fix page table walk in huge_pte_alloc()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, Dev Jain <dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hello Anshuman,

On Mon, 15 Apr 2024 at 08:31, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Currently normal HugeTLB fault ends up crashing the kernel, as p4dp derived
> from p4d_offset() is an invalid address when PGTABLE_LEVEL = 5. A p4d level
> entry needs to be allocated when not available while walking the page table
> during HugeTLB faults. Let's call p4d_alloc() to allocate such entries when
> required instead of current p4d_offset().
>
>  Unable to handle kernel paging request at virtual address ffffffff80000000
>  Mem abort info:
>    ESR = 0x0000000096000005
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x05: level 1 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  swapper pgtable: 4k pages, 52-bit VAs, pgdp=0000000081da9000
>  [ffffffff80000000] pgd=1000000082cec003, p4d=0000000082c32003, pud=0000000000000000
>  Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>  Modules linked in:
>  CPU: 1 PID: 108 Comm: high_addr_hugep Not tainted 6.9.0-rc4 #48
>  Hardware name: Foundation-v8A (DT)
>  pstate: 01402005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>  pc : huge_pte_alloc+0xd4/0x334
>  lr : hugetlb_fault+0x1b8/0xc68
>  sp : ffff8000833bbc20
>  x29: ffff8000833bbc20 x28: fff000080080cb58 x27: ffff800082a7cc58
>  x26: 0000000000000000 x25: fff0000800378e40 x24: fff00008008d6c60
>  x23: 00000000de9dbf07 x22: fff0000800378e40 x21: 0004000000000000
>  x20: 0004000000000000 x19: ffffffff80000000 x18: 1ffe00010011d7a1
>  x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000001
>  x14: 0000000000000000 x13: ffff8000816120d0 x12: ffffffffffffffff
>  x11: 0000000000000000 x10: fff00008008ebd0c x9 : 0004000000000000
>  x8 : 0000000000001255 x7 : fff00008003e2000 x6 : 00000000061d54b0
>  x5 : 0000000000001000 x4 : ffffffff80000000 x3 : 0000000000200000
>  x2 : 0000000000000004 x1 : 0000000080000000 x0 : 0000000000000000
>  Call trace:
>  huge_pte_alloc+0xd4/0x334
>  hugetlb_fault+0x1b8/0xc68
>  handle_mm_fault+0x260/0x29c
>  do_page_fault+0xfc/0x47c
>  do_translation_fault+0x68/0x74
>  do_mem_abort+0x44/0x94
>  el0_da+0x2c/0x9c
>  el0t_64_sync_handler+0x70/0xc4
>  el0t_64_sync+0x190/0x194
>  Code: aa000084 cb010084 b24c2c84 8b130c93 (f9400260)
>  ---[ end trace 0000000000000000 ]---
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: a6bbf5d4d9d1 ("arm64: mm: Add definitions to support 5 levels of paging")
> Reported-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.9-rc4
>
>  arch/arm64/mm/hugetlbpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for fixing this. One question below.


> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 0f0e10bb0a95..5c819459555a 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -276,7 +276,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>         pte_t *ptep = NULL;
>
>         pgdp = pgd_offset(mm, addr);
> -       p4dp = p4d_offset(pgdp, addr);
> +       p4dp = p4d_alloc(mm, pgdp, addr);

Shouldn't we check p4dp for NULL here?

>         pudp = pud_alloc(mm, p4dp, addr);
>         if (!pudp)
>                 return NULL;
> --
> 2.25.1
>

