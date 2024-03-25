Return-Path: <linux-kernel+bounces-116522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F2588A051
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5631C31438
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66D823D1;
	Mon, 25 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdKqpJYq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80D1C257F;
	Mon, 25 Mar 2024 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341756; cv=none; b=BXYC03+e9Pf8tNjlmaC1/b3s1mJhF7xoiuVyBtZWF5w0dGyQ2ILl7DyowtlJ8N93//FLR8mC/Oid1kWOEImu9HGUc7yjU3YSQ0H6JIRq9HKYm2nBfn/oLVKP2nlqWqy+aSNqZLmWtBsguIkBfwrT4mAePx69Rn5gOryRcrWU/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341756; c=relaxed/simple;
	bh=XMszcJq9qKpbV4DFBwSekh9f/MWb18ne5dXsAM6kKD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n6GUeeA950p+sk6iXYaZAimMUE/yxDbJ1+xLOKUDGpOiNkSW2dLd65hj7kHgwHe492ZHdrzfZT3vpzC6P+6aKbRdY2Yhq4qMBGZ7KKoLi9EHaU/bRE4HDTjC5ItxMTZ5v88uF3moovDA/2PsMZj3bfUYnA3oXMrJb+2IijCkVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdKqpJYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB0CCC43143;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341754;
	bh=XMszcJq9qKpbV4DFBwSekh9f/MWb18ne5dXsAM6kKD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GdKqpJYqq4nzWFRO9Hpv5UH3Py1smxmB/DXoCXJtllla7M+UbtYM4CJ5/L896W7IV
	 yQNZ+TVXisg+8sTpUFlmLRoFuUc0LEioY4l5kubTTV7+kTnb8wBKXBmUQuqxFirQOM
	 +r7s6pXT4cgp/uVDoprMn8sgYkXHbx8mHeeSxDTGj5EF3mvSNK50KxsmorJkJA4wO7
	 zDT9ZpkpOD2ZRWN3OzSLAbYkoL+iyKgdNDK5cCLI9ndEy0u4mkYkxx8ZcQ9kia61k/
	 zgU/eNUoN3a7r9NnvA0lfHszFUpclZw3XcF/Xe2dG4exz/EXhbcXzChTQzT6SVcFzX
	 xxSpvAwPq1e4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB1EAD95072;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/15] mm/memory: optimize fork() with PTE-mapped THP
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134175476.18749.11889611045887549553.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:42:34 +0000
References: <20240129124649.189745-1-david@redhat.com>
In-Reply-To: <20240129124649.189745-1-david@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
 ryan.roberts@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, dinguyen@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 29 Jan 2024 13:46:34 +0100 you wrote:
> Now that the rmap overhaul[1] is upstream that provides a clean interface
> for rmap batching, let's implement PTE batching during fork when processing
> PTE-mapped THPs.
> 
> This series is partially based on Ryan's previous work[2] to implement
> cont-pte support on arm64, but its a complete rewrite based on [1] to
> optimize all architectures independent of any such PTE bits, and to
> use the new rmap batching functions that simplify the code and prepare
> for further rmap accounting changes.
> 
> [...]

Here is the summary with links:
  - [v3,01/15] arm64/mm: Make set_ptes() robust when OAs cross 48-bit boundary
    (no matching commit)
  - [v3,02/15] arm/pgtable: define PFN_PTE_SHIFT
    (no matching commit)
  - [v3,03/15] nios2/pgtable: define PFN_PTE_SHIFT
    (no matching commit)
  - [v3,04/15] powerpc/pgtable: define PFN_PTE_SHIFT
    (no matching commit)
  - [v3,05/15] riscv/pgtable: define PFN_PTE_SHIFT
    https://git.kernel.org/riscv/c/57c254b2fb31
  - [v3,06/15] s390/pgtable: define PFN_PTE_SHIFT
    (no matching commit)
  - [v3,07/15] sparc/pgtable: define PFN_PTE_SHIFT
    (no matching commit)
  - [v3,08/15] mm/pgtable: make pte_next_pfn() independent of set_ptes()
    (no matching commit)
  - [v3,09/15] arm/mm: use pte_next_pfn() in set_ptes()
    (no matching commit)
  - [v3,10/15] powerpc/mm: use pte_next_pfn() in set_ptes()
    (no matching commit)
  - [v3,11/15] mm/memory: factor out copying the actual PTE in copy_present_pte()
    (no matching commit)
  - [v3,12/15] mm/memory: pass PTE to copy_present_pte()
    (no matching commit)
  - [v3,13/15] mm/memory: optimize fork() with PTE-mapped THP
    (no matching commit)
  - [v3,14/15] mm/memory: ignore dirty/accessed/soft-dirty bits in folio_pte_batch()
    (no matching commit)
  - [v3,15/15] mm/memory: ignore writable bit in folio_pte_batch()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



