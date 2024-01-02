Return-Path: <linux-kernel+bounces-14910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ED082246A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55274B228E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8618AEA;
	Tue,  2 Jan 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FV9nuTJA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A245E18AE6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28c075ad8e7so7041751a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232897; x=1704837697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AiLZ+S8ss+wMnNlNoL9Dmtw+ys4LyrrpsDpp+lAvHs=;
        b=FV9nuTJAd4+3cQC2jUpbRzSDEqZqBnkjQEBPu4ooN1a9vrUxWs5ABsRWFt1PAx0MbC
         VCWIJIc7Cn6tc6+QLyRW4heWprYJmkZUgbTe/OZ9HxAWZvWZjUhfadpvvZAcAifiEipv
         Zes9sRWGGpr0wH75CTZwwIQ0zWjr4M6c7OF9kvqYp4fkk01hcirukOJd9LgVInzExATI
         R3cUaNBUi1NWGHv34iHMEJK5HLEFQ4OdafQ99tNBZDHL1j9F9EZRdJshfV2Ld1Es4Nat
         Qw1m0bqB4+J3WYARTZ7CkOxQUOOgtnj0kjAQD6Mu28XpWRMRmcYU4CVcim1BM58L9etg
         OcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232897; x=1704837697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AiLZ+S8ss+wMnNlNoL9Dmtw+ys4LyrrpsDpp+lAvHs=;
        b=mHjSEJcpmniNhJvKZ5tnEXWNVpX2gJ2nfwPPkl2K0KYvcDAur7TkM3591t9J70ze3C
         rlsyySkBb5B8IR1WGHyaPq4uKYU47CNgfsiWOwQmYzgAbvDh/MFeTWLxCj4qeABWN4vP
         18CczAUOP+s3sgtjTBBGjYxuVz6cxChiuqQOI03WAjZOKVdfITFZJTb1hg6EEIFbMoKC
         SQlg9CWZvpxP0PjVZ3JE9+GQzO4vo161aNQUrMG7Pti4QPA/nHCC2Kf16wtNjnTx8mPh
         /7kg4Lby1Lh+niRppvf2OCO9vOWcIrZ+HEFgzZBU9aSimWXxkoC/Uo2jq6EMrnYzPIa/
         HQoQ==
X-Gm-Message-State: AOJu0YxgNRmrvZ/Z6RKPP3NDi3FoJzkact3IcSqw+hegkUtQsJziP76Q
	NvCAv+d+AUwqy8JiWe4YQpypSrx7RbEbqA==
X-Google-Smtp-Source: AGHT+IFeov/gk3M9avfaoFHoq8DxqDNeNKONTMxG1L5Z5D7bNfNm3jHAFAoBaA7kbVFzjuOMQZ9Zxw==
X-Received: by 2002:a17:90a:5898:b0:28c:890f:f814 with SMTP id j24-20020a17090a589800b0028c890ff814mr5775390pji.29.1704232896832;
        Tue, 02 Jan 2024 14:01:36 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:36 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 00/12] riscv: ASID-related and UP-related TLB flush enhancements
Date: Tue,  2 Jan 2024 14:00:37 -0800
Message-ID: <20240102220134.3229156-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing Alexandre Ghiti's "riscv: tlb flush improvements"
series[1], I noticed that most TLB flush functions end up as a call to
local_flush_tlb_all() when SMP is disabled. This series resolves that,
and also optimizes the scenario where SMP is enabled but only one CPU is
present or online. Along the way, I realized that we should be using
single-ASID flushes wherever possible, so I implemented that as well.

Here are some numbers from D1 (with SMP disabled) which show the
performance impact:

v6.7-rc8:
 System Benchmarks Partial Index              BASELINE       RESULT    INDEX
 Execl Throughput                                 43.0        207.4     48.2
 File Copy 1024 bufsize 2000 maxblocks          3960.0      52187.4    131.8
 File Copy 256 bufsize 500 maxblocks            1655.0      14872.6     89.9
 File Copy 4096 bufsize 8000 maxblocks          5800.0     146597.8    252.8
 Pipe Throughput                               12440.0     125318.4    100.7
 Pipe-based Context Switching                   4000.0      17804.2     44.5
 Process Creation                                126.0        479.2     38.0
 Shell Scripts (1 concurrent)                     42.4        564.5    133.1
 Shell Scripts (16 concurrent)                     ---         36.8      ---
 Shell Scripts (8 concurrent)                      6.0         74.3    123.9
 System Call Overhead                          15000.0     182050.7    121.4
                                                                    ========
 System Benchmarks Index Score (Partial Only)                           93.2

v6.7-rc8 plus this patch series:
 System Benchmarks Partial Index              BASELINE       RESULT    INDEX
 Execl Throughput                                 43.0        208.5     48.5
 File Copy 1024 bufsize 2000 maxblocks          3960.0      56847.0    143.6
 File Copy 256 bufsize 500 maxblocks            1655.0      17728.9    107.1
 File Copy 4096 bufsize 8000 maxblocks          5800.0     168016.2    289.7
 Pipe Throughput                               12440.0     133376.2    107.2
 Pipe-based Context Switching                   4000.0      19736.3     49.3
 Process Creation                                126.0        484.5     38.4
 Shell Scripts (1 concurrent)                     42.4        564.1    133.0
 Shell Scripts (16 concurrent)                     ---         36.6      ---
 Shell Scripts (8 concurrent)                      6.0         74.1    123.5
 System Call Overhead                          15000.0     210181.8    140.1
                                                                    ========
 System Benchmarks Index Score (Partial Only)                          100.1

[1]: https://lore.kernel.org/linux-riscv/20231030133027.19542-1-alexghiti@rivosinc.com/

Changes in v4:
 - Fix a possible race between flush_icache_*() and SMP bringup
 - Refactor riscv_use_ipi_for_rfence() to make later changes cleaner
 - Optimize kernel TLB flushes with only one CPU online
 - Optimize global cache/TLB flushes with only one CPU online
 - Merge the two copies of __flush_tlb_range() and rely on the compiler
   to optimize out the broadcast path (both clang and gcc do this)
 - Merge the two copies of flush_tlb_all() and rely on constant folding
 - Only set tlb_flush_all_threshold when CONFIG_MMU=y.

Changes in v3:
 - Fixed a performance regression caused by executing sfence.vma in a
   loop on implementations affected by SiFive CIP-1200
 - Rebased on v6.7-rc1

Changes in v2:
 - Move the SMP/UP merge earlier in the series to avoid build issues
 - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
 - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)

Samuel Holland (12):
  riscv: Flush the instruction cache during SMP bringup
  riscv: Use IPIs for remote cache/TLB flushes by default
  riscv: mm: Broadcast kernel TLB flushes only when needed
  riscv: Only send remote fences when some other CPU is online
  riscv: mm: Combine the SMP and UP TLB flush code
  riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
  riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
  riscv: mm: Introduce cntx2asid/cntx2version helper macros
  riscv: mm: Use a fixed layout for the MM context ID
  riscv: mm: Make asid_bits a local variable
  riscv: mm: Preserve global TLB entries when switching contexts
  riscv: mm: Always use an ASID to flush mm contexts

 arch/riscv/errata/sifive/errata.c    |  5 ++
 arch/riscv/include/asm/errata_list.h | 12 ++++-
 arch/riscv/include/asm/mmu.h         |  3 ++
 arch/riscv/include/asm/mmu_context.h |  2 -
 arch/riscv/include/asm/sbi.h         |  4 ++
 arch/riscv/include/asm/smp.h         | 15 +-----
 arch/riscv/include/asm/tlbflush.h    | 50 ++++++++----------
 arch/riscv/kernel/sbi-ipi.c          | 11 +++-
 arch/riscv/kernel/smp.c              | 11 +---
 arch/riscv/kernel/smpboot.c          |  7 +--
 arch/riscv/mm/Makefile               |  5 +-
 arch/riscv/mm/cacheflush.c           |  7 +--
 arch/riscv/mm/context.c              | 26 ++++------
 arch/riscv/mm/tlbflush.c             | 76 +++++++++-------------------
 drivers/clocksource/timer-clint.c    |  2 +-
 15 files changed, 102 insertions(+), 134 deletions(-)

-- 
2.42.0


