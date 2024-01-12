Return-Path: <linux-kernel+bounces-25118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E882C823
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BF6287510
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC91A5B7;
	Fri, 12 Jan 2024 23:55:57 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1281A5AC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so5033841b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705103755; x=1705708555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gs+osQ4JMk0b+DIOh+BXavjsZaPBoH1jST1sDAxf3IQ=;
        b=v4m9ezi6NN+iqSR8JLr851VZXPVf5WM/zkKHKdZfKQsgWtMG6DzkCONaQM/GxCW7ez
         hEBDLtcRvWbyLRABop6rAOf0BxLxVyS/Qhrz7gKfHUxYwQXbrOQqD7dYtuy0qklA0bf/
         i9YTfuHcfU+IdipX4aqCWVdOWhdDEThi69oxg8VyR3lJS2GBA9iYlODE/b5+catafrb9
         5v9UwYh1J3ASn6+tnO6hdCwHY4ts/R7hMGxdiFqkBwhxBwmY4urG71UooXyBKZs7GRS5
         U5bcajO1AyRd3q4AYUQtVQ2LBOsrHc0I7ONn5lbYIE/kAlIYd41WH6DwCTvrGlYyDd83
         qWFA==
X-Gm-Message-State: AOJu0YzUPf6fAdKpdc1cPo4MvRqW0povBFRvtdh43ewPRClO8tbYWi2K
	76bEu0RNxPlGWZ8otq9T7Hs=
X-Google-Smtp-Source: AGHT+IF+jF0gpJYaqoi2WiUfdqepgcp3xTM6CSJapbK5axmXSuTSvNtyDn3J2cjluoevKTrzYzf7tA==
X-Received: by 2002:a17:90b:3b8a:b0:28d:a535:ca23 with SMTP id pc10-20020a17090b3b8a00b0028da535ca23mr3133012pjb.20.1705103754948;
        Fri, 12 Jan 2024 15:55:54 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090ad60500b0028ce12f8cdasm4807193pju.10.2024.01.12.15.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:55:54 -0800 (PST)
Date: Fri, 12 Jan 2024 15:55:52 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v6.8-rc1
Message-ID: <ZaHRiNj3biQBaSKr@snowbird>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This enables the percpu page allocator for risc-v as a fallback path.

Separately, I just sent out a respin of Thomas' cpu hotplug related fixes
for percpu_counters in [1]. I'll hopefully pull that in shortly and get
it into for-next for some wider testing.

[1] https://lore.kernel.org/lkml/cover.1705101789.git.dennis@kernel.org/

Thanks,
Dennis

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.8

for you to fetch changes up to 6b9f29b81b155af023da95f560f738f29722b306:

  riscv: Enable pcpu page first chunk allocator (2023-12-14 00:24:06 -0800)

----------------------------------------------------------------
percpu:
- Enable percpu page allocator for risc-v. There are risc-v
  configurations with sparse NUMA configurations and small vmalloc
  space causing dynamic percpu allocations to fail as the backing chunk
  stride is too far apart.

----------------------------------------------------------------
Alexandre Ghiti (2):
      mm: Introduce flush_cache_vmap_early()
      riscv: Enable pcpu page first chunk allocator

 arch/arc/include/asm/cacheflush.h      | 1 +
 arch/arm/include/asm/cacheflush.h      | 2 ++
 arch/csky/abiv1/inc/abi/cacheflush.h   | 1 +
 arch/csky/abiv2/inc/abi/cacheflush.h   | 1 +
 arch/m68k/include/asm/cacheflush_mm.h  | 1 +
 arch/mips/include/asm/cacheflush.h     | 2 ++
 arch/nios2/include/asm/cacheflush.h    | 1 +
 arch/parisc/include/asm/cacheflush.h   | 1 +
 arch/riscv/Kconfig                     | 2 ++
 arch/riscv/include/asm/cacheflush.h    | 3 ++-
 arch/riscv/include/asm/tlbflush.h      | 1 +
 arch/riscv/mm/kasan_init.c             | 8 ++++++++
 arch/riscv/mm/tlbflush.c               | 5 +++++
 arch/sh/include/asm/cacheflush.h       | 1 +
 arch/sparc/include/asm/cacheflush_32.h | 1 +
 arch/sparc/include/asm/cacheflush_64.h | 1 +
 arch/xtensa/include/asm/cacheflush.h   | 6 ++++--
 include/asm-generic/cacheflush.h       | 6 ++++++
 mm/percpu.c                            | 8 +-------
 19 files changed, 42 insertions(+), 10 deletions(-)

