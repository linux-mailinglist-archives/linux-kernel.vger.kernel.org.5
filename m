Return-Path: <linux-kernel+bounces-12044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77281EF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD931F21E06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C2C45967;
	Wed, 27 Dec 2023 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGE7P2j3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C445955
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso39187227b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703686340; x=1704291140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tv2A+JHXhlf9Bg7FPGETCJC0ghqPw0lJWeTtYvu2G8=;
        b=iGE7P2j3QEWL476lcKt3dZdsySUef7uJX12fq+LkrFPL1ISmncgzS2GkMIMM/I/u30
         HRWZHbv5qIEpVGALKLOGBIWqmQlHDRoMqZJfuXbe0bLXCGhEFFscfIAszDti9GNx9mFD
         GmNZCzp7wjvbGVhUAVoOT8Aci4DpfqsAbYNFGz2BFoC7cXCKfW7Kbi2f8TtmG6YhprrB
         TX4cSudYl8SlkstS/ninuxu+1yQWZlrnJ2MI7xnA7QX03Y6hdCYxT6lES3cBBwdoI8OT
         EB/f2uayFN0QLiUVMRni0dPShf/vJlXcxHdiYtq0lY1QCEYY7P1QsXMwU+0tqYoaGhAj
         V0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703686340; x=1704291140;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tv2A+JHXhlf9Bg7FPGETCJC0ghqPw0lJWeTtYvu2G8=;
        b=N3KIdOC+1Axqizrd5YxMiafFa4IkkfqB1NVyil86MfHFss946BDseWyfaE1mXH4SCS
         bskXGPffyA1qppEAHqGuY83Eu1MjI5JylP4qmFdXx+ZYvD7ut49awiqBBvRoXaYUihfa
         XC9O8fWQUzopfq1Ub8qLqgyymfau+LI/BZn+4Y6FUU6lN/YfXsNv49JplcPlpeokOT8Q
         ejPtvMt4mxvmOT0jQpexWBASNjywn1vSXYWLudn1ctLndrF6vl2TMZVgjkTlkUW6aQ8u
         BAhmyeGcSyZcwXNpwPa3vlmP/0EDBxknDQTbk4sNEx0td5N1kaz9iWmCLgTzKWnkqiks
         9/fQ==
X-Gm-Message-State: AOJu0YxdLFIbOI33+ck6asbSrHLHvA39eXnjzHqZ5vd7cTIdKjZCFH/M
	BtlbUz+NXSKk2mFvUkYBd5ZEU0ZFom0f26E5fD+P
X-Google-Smtp-Source: AGHT+IHwVa/QDufw4XZePu+mq/xQNqTfQ8hKtMC9gzbof2NYIPLJNIfN8vnkn0KrZ756JvG0eTeD8lTdTGxjaw==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6902:1369:b0:db5:4692:3ab7 with SMTP
 id bt9-20020a056902136900b00db546923ab7mr3370911ybb.8.1703686340534; Wed, 27
 Dec 2023 06:12:20 -0800 (PST)
Date: Wed, 27 Dec 2023 14:12:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231227141205.2200125-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 0/5] mm/mglru: Kconfig cleanup
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is the result of the following discussion:
https://lore.kernel.org/47066176-bd93-55dd-c2fa-002299d9e034@linux.ibm.com/

It mainly avoids building the code that walks page tables on CPUs that
use it, i.e., those don't support hardware accessed bit. Specifically,
it introduces a new Kconfig to guard some of functions added by
commit bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
on CPUs like POWER9, on which the series was tested.
---
v4: fix kernel build bot error by adding dummy pmd_dirty()

v3: https://lore.kernel.org/20231220040037.883811-1-kinseyho@google.com/


Kinsey Ho (5):
  mm/mglru: add CONFIG_ARCH_HAS_HW_PTE_YOUNG
  mm/mglru: add CONFIG_LRU_GEN_WALKS_MMU
  mm/mglru: remove CONFIG_MEMCG
  mm/mglru: add dummy pmd_dirty()
  mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE

 arch/Kconfig                         |   8 +
 arch/arm64/Kconfig                   |   1 +
 arch/loongarch/include/asm/pgtable.h |   1 +
 arch/mips/include/asm/pgtable.h      |   1 +
 arch/riscv/include/asm/pgtable.h     |   1 +
 arch/s390/include/asm/pgtable.h      |   1 +
 arch/sparc/include/asm/pgtable_64.h  |   1 +
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/pgtable.h       |   7 +-
 include/linux/memcontrol.h           |   2 +-
 include/linux/mm_types.h             |  16 +-
 include/linux/mmzone.h               |  28 +--
 include/linux/pgtable.h              |   9 +-
 kernel/fork.c                        |   2 +-
 mm/Kconfig                           |   4 +
 mm/vmscan.c                          | 271 ++++++++++++++-------------
 16 files changed, 187 insertions(+), 167 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


