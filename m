Return-Path: <linux-kernel+bounces-77481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC186062C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBCD28629A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9D918032;
	Thu, 22 Feb 2024 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UGhp8xO6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z2Ritci3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667A12E40;
	Thu, 22 Feb 2024 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643026; cv=none; b=uSklAvkr+78u6424Ocg0GoQJbhxB5FARYkpSHM7T+CL9x4u9OCSQrDCcqzV5RRZYY48hlz9iHVSPswDO5PJusPB1MHggWF6tEIbn47Fp9WXoAD/5Q8naxaL+WFSC+64Z/UbFMbWUWpMBlII6ZLAzso7rpGcJ6+mSaz3f6MBPNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643026; c=relaxed/simple;
	bh=65ctlHPFx8HGBnJ8HHkM9o0DAjuwNkJMkaldzDFz6as=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CGvgGGYa6lCLRNjxoYw1tL4ng9SzimNkd/whY3A91sY0144U5nRro3W1cGPA45Vtf2PPvh7693ZejA0ROCa/GPbiAiZjmmwFq1O49KVEv7f23vYGdjQMqf8h0ROItFyBli/9h+ZEhyUhMQwOwtjt/i2AT7hryx83kU0M2NvMk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UGhp8xO6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z2Ritci3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 23:03:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708643022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O7SorYCwmf0domtChWfkJadL/FzGPFi6yHpZIU9XWg8=;
	b=UGhp8xO6rUUr5SZmNhrQr9c7VWMS9WkDSGQS7xu66gb3I6lrwArB/unYEbEUVj+MOUwCTj
	owy3xjbLrI0bcDTmFctMj3re8g2hznzBNXyvEf3jUypn8sc4vkSP39Lppgj/3NUcr+TFtA
	dmdM6SwtU7WF4gdQdtXkMRCGNrvS3i71Fj7IBEm9oS2p9t7fYVkjRKqEy77y67n4j12SBw
	L8iUTrmlixYo22v4qA3mkmJR9mVInJJq2xq1C4PfiA9q6ieOIW+gIQdYl9Ey2Vvhv52bMf
	wMkGXpr02u1FQUKV8hbipjgDrI6/1cOSGpcQT18qRtMIuFOLBTWKQfMXiK7zMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708643022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O7SorYCwmf0domtChWfkJadL/FzGPFi6yHpZIU9XWg8=;
	b=Z2Ritci3bXsI1GSHwmfUX3YG1uRh5oGQhxM5KHiFyCbNhA3Ww7OH6tgfZ+ig6BBkzJgvlL
	VFIpZu3rTUF96hBw==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/asm: Remove the __iomem annotation of
 movdir64b()'s dst argument
Cc: kernel test robot <lkp@intel.com>, Kai Huang <kai.huang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Yuan Yao <yuan.yao@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170864302149.398.6585871274599667665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     5bdd181821b2c65b074cfad07d7c7d5d3cfe20bf
Gitweb:        https://git.kernel.org/tip/5bdd181821b2c65b074cfad07d7c7d5d3cfe20bf
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 26 Jan 2024 15:38:52 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 22 Feb 2024 14:52:09 -08:00

x86/asm: Remove the __iomem annotation of movdir64b()'s dst argument

Commit e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all
packages") causes a sparse warning:

  arch/x86/virt/vmx/tdx/tdx.c:683:27: warning: incorrect type in argument 1 (different address spaces)
  arch/x86/virt/vmx/tdx/tdx.c:683:27:    expected void [noderef] __iomem *dst
  arch/x86/virt/vmx/tdx/tdx.c:683:27:    got void *

The reason is TDX must use the MOVDIR64B instruction to convert TDX
private memory (which is normal RAM but not MMIO) back to normal.  The
TDX code uses existing movdir64b() helper to do that, but the first
argument @dst of movdir64b() is annotated with __iomem.

When movdir64b() was firstly introduced in commit 0888e1030d3e
("x86/asm: Carve out a generic movdir64b() helper for general usage"),
it didn't have the __iomem annotation.  But this commit also introduced
the same "incorrect type" sparse warning because the iosubmit_cmds512(),
which was the solo caller of movdir64b(), has the __iomem annotation.

This was later fixed by commit 6ae58d871319 ("x86/asm: Annotate
movdir64b()'s dst argument with __iomem").  That fix was reasonable
because until TDX code the movdir64b() was only used to move data to
MMIO location, as described by the commit message:

  ... The current usages send a 64-bytes command descriptor to an MMIO
  location (portal) on a device for consumption. When future usages for
  the MOVDIR64B instruction warrant a separate variant of a memory to
  memory operation, the argument annotation can be revisited.

Now TDX code uses MOVDIR64B to move data to normal memory so it's time
to revisit.

The SDM says the destination of MOVDIR64B is "memory location specified
in a general register", thus it's more reasonable that movdir64b() does
not have the __iomem annotation on the @dst.

Remove the __iomem annotation from the @dst argument of movdir64b() to
fix the sparse warning in TDX code.  Similar to memset_io(), introduce a
new movdir64b_io() to cover the case where the destination is an MMIO
location, and change the solo caller iosubmit_cmds512() to use the new
movdir64b_io().

In movdir64b_io() explicitly use __force in the type casting otherwise
there will be below sparse warning:

  warning: cast removes address space '__iomem' of expression

[ dhansen: normal changelog tweaks ]

Closes: https://lore.kernel.org/oe-kbuild-all/202312311924.tGjsBIQD-lkp@intel.com/
Fixes: e56d28df2f66 ("x86/virt/tdx: Configure global KeyID on all packages")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
Link: https://lore.kernel.org/all/20240126023852.11065-1-kai.huang%40intel.com
---
 arch/x86/include/asm/io.h            |  2 +-
 arch/x86/include/asm/special_insns.h |  9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 3814a92..294cd2a 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -379,7 +379,7 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
 	const u8 *end = from + count * 64;
 
 	while (from < end) {
-		movdir64b(dst, from);
+		movdir64b_io(dst, from);
 		from += 64;
 	}
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 48f8dd4..09a5461 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -224,10 +224,10 @@ static inline void serialize(void)
 }
 
 /* The dst parameter must be 64-bytes aligned */
-static inline void movdir64b(void __iomem *dst, const void *src)
+static inline void movdir64b(void *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } __iomem *__dst = dst;
+	struct { char _[64]; } *__dst = dst;
 
 	/*
 	 * MOVDIR64B %(rdx), rax.
@@ -245,6 +245,11 @@ static inline void movdir64b(void __iomem *dst, const void *src)
 		     :  "m" (*__src), "a" (__dst), "d" (__src));
 }
 
+static inline void movdir64b_io(void __iomem *dst, const void *src)
+{
+	movdir64b((void __force *)dst, src);
+}
+
 /**
  * enqcmds - Enqueue a command in supervisor (CPL0) mode
  * @dst: destination, in MMIO space (must be 512-bit aligned)

