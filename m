Return-Path: <linux-kernel+bounces-121161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD4888E42E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D5FB33DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4417964D;
	Wed, 27 Mar 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT5EQ0JM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22B17965A;
	Wed, 27 Mar 2024 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542240; cv=none; b=iW3YnnwCbQkvG0yIBhYXMvTrNQAjC5MoZY57HPczaWAY+oXryRRVsUcEhoBjX3s03V7FK4f8vX9POhqkLg1hQr7bC15LCOSjzv7tsA+G2RVLZ2zpDf7mYdVc9vpEJmYZj3hZ/zWyArDcU+N0e7MkLu6ODshdPVOYIdEKx3YUapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542240; c=relaxed/simple;
	bh=UAD1UidXUE1/xojuOHsvPucGi6ZvT8vO1Nl3SmyVnjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWbts243k9t6H5Ne46LK66LwGYuyv6QzfuQGa3JZOM3osauIjWfWmsF9uhqa1oBjrWYXF2wmVcYGmy7BlSJifNhbgVeSiO+M5g8tbXe+goKZ/bu6pGSzwuC+Lm8VaZQhtkC4XlnRgKeCbcALdlEm58mH4wc2MP1OszYJjfsKxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT5EQ0JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DBDC433C7;
	Wed, 27 Mar 2024 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542239;
	bh=UAD1UidXUE1/xojuOHsvPucGi6ZvT8vO1Nl3SmyVnjw=;
	h=From:To:Cc:Subject:Date:From;
	b=kT5EQ0JMsEjDpROLLGuKEEKU1sEjZD8dOU8OxAbjFc2Rey413e2wP8NpcLMMJrwAg
	 6A9als6z+uQ9CoBcL2nclTDs7tKKMvdRN7/wIwQ6Yh8JzS5adQk4EVA/g8k643OWvS
	 QUo0HLBWySIMlh2Bcw3TXD5oAaHmzDH+S/xuCSdrFwvGoN6EeT3xaMOcLZvfSr6w87
	 M6/ggiSvNzApP4V7LRi8NfKllHsKpRe2bS8wge0kKOLGWoNUsN3kLLxUr019SpQE+R
	 7rXFR0SnmOwpiF0NzEYKl4s8llGauQ9YZFasZymakkZo+WRQimlOFEA4FGugqMP1AX
	 QCFUWmEs1sCrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: FAILED: Patch "powerpc: xor_vmx: Add '-mhard-float' to CFLAGS" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:57 -0400
Message-ID: <20240327122358.2838999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 35f20786c481d5ced9283ff42de5c69b65e5ed13 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 27 Jan 2024 11:07:43 -0700
Subject: [PATCH] powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

arch/powerpc/lib/xor_vmx.o is built with '-msoft-float' (from the main
powerpc Makefile) and '-maltivec' (from its CFLAGS), which causes an
error when building with clang after a recent change in main:

  error: option '-msoft-float' cannot be specified with '-maltivec'
  make[6]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] Error 1

Explicitly add '-mhard-float' before '-maltivec' in xor_vmx.o's CFLAGS
to override the previous inclusion of '-msoft-float' (as the last option
wins), which matches how other areas of the kernel use '-maltivec', such
as AMDGPU.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1986
Link: https://github.com/llvm/llvm-project/commit/4792f912b232141ecba4cbae538873be3c28556c
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240127-ppc-xor_vmx-drop-msoft-float-v1-1-f24140e81376@kernel.org
---
 arch/powerpc/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 6eac63e79a899..0ab65eeb93ee3 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -76,7 +76,7 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 # Enable <altivec.h>
 CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
 
-- 
2.43.0





