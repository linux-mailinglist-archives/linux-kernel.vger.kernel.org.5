Return-Path: <linux-kernel+bounces-4709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E668180E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C5A1F23C70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F67063D1;
	Tue, 19 Dec 2023 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLlQsIzX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343C5C97
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17141C433C8;
	Tue, 19 Dec 2023 05:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702963145;
	bh=EegGAbquI0Kz77iG8EbA05ksIWJlcmWcA5xeDy8CDcQ=;
	h=Date:To:Cc:From:Subject:From;
	b=FLlQsIzXG7T1eSey28exVXvIm2EjuszTK7dqEwUj/hUOZ06It3BfYgqFBD6yF2xKT
	 JbYoyjnDk9ni4NIUcsTf7rIjMbpu9QcEbIxo3Ic2oXYbbLQp+hOjIshM3U7PSamwuL
	 zZy41Pgtb1Epk6ApcbdATcegYhsYFgDGVJ7DZ2Zv0btAvKZnCxxzyt3ihLD5OAPmmR
	 L7d2stUvN5wWkGMvT7wDtOeJyK3vDPcj78FjBAoC+7xO4mR2skXLY2ISLGjcibjaNd
	 VnDt/FYsaGEQFZ5567P8BTOEEvC2RtP53cjk2/lsNAjWUVrqCvkyCaeYwiEm+TH6f+
	 2cNnS3YV88bgg==
Message-ID: <889dc07d-f00f-4012-985d-314da7dda52d@kernel.org>
Date: Mon, 18 Dec 2023 21:19:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: arcml <linux-snps-arc@lists.infradead.org>,
 lkml <linux-kernel@vger.kernel.org>, Pavel Kozlov
 <Pavel.Kozlov@synopsys.com>, Dan Carpenter <dan.carpenter@linaro.org>
From: Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC fixes for 6.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Late in the cycle but we have a bunch of fixes for ARC. Please pull.

Thx,
-Vineet

--------------->
The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
tags/arc-6.7-fixes

for you to fetch changes up to 9a733dc4fbeec3f6d99645b845712b035e7440cf:

  ARC: add hugetlb definitions (2023-12-13 19:33:10 -0800)

----------------------------------------------------------------
ARC fixes for 6.7

 - build error for hugetlb, sparse and smatch fixes

 - Removal of VIPT aliasing cache code

----------------------------------------------------------------
Pavel Kozlov (1):
      ARC: add hugetlb definitions

Vineet Gupta (5):
      ARC: entry: SAVE_ABI_CALLEE_REG: ISA/ABI specific helper
      ARC: entry: move ARCompact specific bits out of entry.h
      ARC: mm: retire support for aliasing VIPT D$
      ARC: fix spare error
      ARC: fix smatch warning

 arch/arc/Kconfig                     |   5 --
 arch/arc/include/asm/cacheflush.h    |  43 -----------
 arch/arc/include/asm/entry-arcv2.h   |  32 +++++++++
 arch/arc/include/asm/entry-compact.h |  87 +++++++++++++++++++++-
 arch/arc/include/asm/entry.h         | 110 ++--------------------------
 arch/arc/include/asm/hugepage.h      |   7 ++
 arch/arc/include/asm/ptrace.h        |  14 ++--
 arch/arc/kernel/setup.c              |   4 +-
 arch/arc/kernel/signal.c             |   6 +-
 arch/arc/mm/cache.c                  | 136
++---------------------------------
 arch/arc/mm/mmap.c                   |  21 +-----
 arch/arc/mm/tlb.c                    |  16 ++---
 12 files changed, 155 insertions(+), 326 deletions(-)

