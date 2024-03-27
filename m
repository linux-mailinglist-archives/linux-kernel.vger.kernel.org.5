Return-Path: <linux-kernel+bounces-121253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62288E464
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A8329B170
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECFF130AD2;
	Wed, 27 Mar 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMJ9LMZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1981A437A;
	Wed, 27 Mar 2024 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542467; cv=none; b=kcoikKUgQG26O69mXKjhpxMNEuSxfjZ5SU5sBrd/eDkiGbV8LLkHIa59P7ViKwARhwHWk+i0nY8onW1ifdWrBfajqLhAiOAMblHGX5YcKn+oogGN9/55yG7rBW9Nz+rcy0sVPpwybKuSXHilPq6DMD+FeWp1j010nbvhzjNJScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542467; c=relaxed/simple;
	bh=11wqF5Qf94rl14vnsEmmzG689BeSZ1U3gUQoMWuYmCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Io1xmiD9hMI2+WEHuBUba5cVGPrz2NHlF7IvRqGJxR/i2c5+/8FQ/D/MNCSwwJBVjjw+FT61JD2mwnjhs90Sme+UQR5abWKazOujDlMTVz+Kfix4fFBBPVvYfGxnqpqOCudNFKIudY7ODWjp+qwKMEuKx3wNTWH4kZOvzedOWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMJ9LMZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF85C433C7;
	Wed, 27 Mar 2024 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542466;
	bh=11wqF5Qf94rl14vnsEmmzG689BeSZ1U3gUQoMWuYmCY=;
	h=From:To:Cc:Subject:Date:From;
	b=YMJ9LMZu3hPMkOdqCKtnaxAf0KbF1/rmTpXh4qURLQ6+pnrVIKS/8v+hCwCww9J2I
	 SHJVJTNYQy8Cbvz+eOUUeGPuS9VplYa0OHWeBZY5qgSykaR6XHLLWuFQmio+5F9Bb9
	 b5SaJAOs91UqhMdYPiybafv/IQ4bCW0+k7MgKg9HhK0e5LBRLk5x/tyJjErTkV6KyA
	 Wu+i13kC8i6Al3o66eO1zoTHseFe4yVVbnudc4JVJkMrAd6zGDDexNGB/S5HLKrIvU
	 ZCiW89hzEvUzGYaNpdZnKm7Nq2WeoXgf6Zt1tCISTrm1dNFR0j5uGsdeDqE2ML+bpv
	 rKKuE/c4bUGag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: FAILED: Patch "powerpc: xor_vmx: Add '-mhard-float' to CFLAGS" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:44 -0400
Message-ID: <20240327122744.2842179-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





