Return-Path: <linux-kernel+bounces-8705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962381BB47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E61C25F57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37525821D;
	Thu, 21 Dec 2023 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgB0V+Jg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343258215
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E87C433C9;
	Thu, 21 Dec 2023 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703173641;
	bh=6UdCU34QB2Jmf2RjW8+f6vf0kvi9jkFwVt1GuOPbhWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgB0V+JgevKv68oSzprvvmES0zf5NYWiDKBW18gsxXShgft2Goop1S8a7mLFoT5l0
	 +rGKecm/9UuNuLwYdE7hr9fIyDiiecKjjmxLvtCUMUUZ6NT33DBHy3EuwYNty6beWu
	 m54WfYoNUMG6eVMDoljKnDRfTixV1RYzkpy6afJ26+1JDdBk2BLAXU5lRJ4vQ+IEXr
	 1vEwskikoDkcJ/KJDvRNqPxmSQO1F0g/laB/c+eybU+7+Wjt7Iq0Pqm8zUxoly/WQF
	 c0HI0oKrzX8K3Dzj8b/JUteTjfZwqBiqJXiIlLAXpJEatNQCozmCg9lNjo5H/zk85n
	 bazdYY014sD7g==
From: guoren@kernel.org
To: linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	guoren@kernel.org,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	leobras@redhat.com
Cc: linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 3/4] riscv: mm: Remove unused TASK_SIZE_MIN
Date: Thu, 21 Dec 2023 10:47:00 -0500
Message-Id: <20231221154702.2267684-4-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221154702.2267684-1-guoren@kernel.org>
References: <20231221154702.2267684-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Remove TASK_SIZE_MIN because it's not used anymore.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 74ffb2178f54..e415582276ec 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -878,7 +878,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
-#define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32	(_AC(0x80000000, UL))
@@ -890,7 +889,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 
 #else
 #define TASK_SIZE	FIXADDR_START
-#define TASK_SIZE_MIN	TASK_SIZE
 #endif
 
 #else /* CONFIG_MMU */
-- 
2.40.1


