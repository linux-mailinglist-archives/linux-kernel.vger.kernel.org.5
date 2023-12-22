Return-Path: <linux-kernel+bounces-9681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4E881C989
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71EE2869BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F54821A05;
	Fri, 22 Dec 2023 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjHR5MVA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13242134B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13664C433CB;
	Fri, 22 Dec 2023 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703246253;
	bh=vzAUwHIH1r+/fUC34Yyxdlm+3Xgnktg3iqTJcmMW334=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjHR5MVAmrvSXQrnh46hTtmqK2B9Ui39aUg7OorT2cb7T849p32wzZw9EYsyX9q9N
	 pBB+OF3PIATNO4q1fk4nJjhiCj7Vtir85aXm+msta1pHfJBBUi49qgN+24XqFg/cnh
	 9AODp2lyUyp/yMu1DkyVIuZ4hjS0Sf0kwkbyy9vhPiti2WZ3KGKEGRdbvBIVFQPLOB
	 CJpuzMqlx2Hnk8FPva7wkN7HUj0wizLUI2a9WJF/1iztEH6nb2GGSkVLDXBX465EEr
	 nWpko0+T3CgqYkOaQAKDzZOBFMmlxTXV6KLQD9pxMD0PyvN/24cCIFzUJT3KCkdHs3
	 CN27UjUDwUs4Q==
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
Subject: [PATCH V3 3/4] riscv: mm: Remove unused TASK_SIZE_MIN
Date: Fri, 22 Dec 2023 06:57:02 -0500
Message-Id: <20231222115703.2404036-4-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222115703.2404036-1-guoren@kernel.org>
References: <20231222115703.2404036-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Remove TASK_SIZE_MIN because it's not used anymore.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
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


