Return-Path: <linux-kernel+bounces-78740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEAE86181E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F321F2394F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCAE128801;
	Fri, 23 Feb 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3220xFlS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N0kygYMq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EF1272D9;
	Fri, 23 Feb 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706281; cv=none; b=mxaaMVJr2c1gj/ci4fRCFiPbMGW8O0Kghe/g+mvI4eLp+/qolly6uScmjnuEEgzVDh4T/G25EDDPSs27nHbqHtE68zl+iDKZXVAWVgBkAZAiehLr975h4d1VEhrJLLbMmmkSpkwASYy8WPUBJsCyvOABSBxTHDtQ2BcGxV7Lw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706281; c=relaxed/simple;
	bh=8F2rfIl1oXQXijAvfjLCxS4uHIpMSGYRug5N/NQxstU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=eyv9+lUtJ1YjPc2hCaeP84yvdDAsRhdSN4yE3zD0KJxAQP1MdYUvh0XBUJ+DBhhMW9kxoes0MCYjrTCYzI4bnQ/mL5JGf7dlq4DMCZY0HLl4LxKbWNJf0AOPaY7V5loCyFh9ydhVeIhDP9uqrL6ExGbwmqYqZbHgZ/Flmc8WJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3220xFlS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N0kygYMq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 16:37:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708706277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l+yIHpDqOw5/hXaF7TeNmF5npvyBmzvP2PhHvrHPalc=;
	b=3220xFlS5p8NWng7bY8OGd7qpqMAbCY/VwVv94QSDAEnNmVWLMVj8ecVPlxGeMne7x3rik
	TNNh9eaIG4zloekH+XE2KNDLNJZi+yQILTEi3Tz4AOVjKzhnYnfI9YtFqS5PeN0bQrHsa7
	tpculCxI6g2bCbnPhLpvqFv6DzLnrhQ+LAspgLvg9OcAAs/bNf1SU0nI11D8791zNa8WD4
	ehLQoZABEXHMP9mY/laLgAen5yl/wFUvgKCd2qc9lkJYtcPK49/eYSmxfmpm85SgK3mVCW
	ymL4ur+r524noft2ZWIRFMJ++TCniXPbJT7Xzkbcg3PdWakGxc+gioOhq7axHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708706277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l+yIHpDqOw5/hXaF7TeNmF5npvyBmzvP2PhHvrHPalc=;
	b=N0kygYMq2c6uF0s4aexPvMFng5DL1RhvQJ0ysZwBQjsBffCPvLM/udZAuD3IIcvycv/gWa
	mDUdxY9/q8nguxAg==
From: "tip-bot2 for Chris Koch" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] kexec: Allocate kernel above bzImage's pref_address
Cc: Cloud Hsu <cloudhsu@google.com>, Chris Koch <chrisko@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170870627680.398.14239353324950664750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     43b1d3e68ee7f41c494ee5558d8def3d3d0b7f1b
Gitweb:        https://git.kernel.org/tip/43b1d3e68ee7f41c494ee5558d8def3d3d0b7f1b
Author:        Chris Koch <chrisko@google.com>
AuthorDate:    Fri, 15 Dec 2023 11:05:21 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 22 Feb 2024 15:13:57 -08:00

kexec: Allocate kernel above bzImage's pref_address

A relocatable kernel will relocate itself to pref_address if it is
loaded below pref_address. This means a booted kernel may be relocating
itself to an area with reserved memory on modern systems, potentially
clobbering arbitrary data that may be important to the system.

This is often the case, as the default value of PHYSICAL_START is
0x1000000 and kernels are typically loaded at 0x100000 or above by
bootloaders like iPXE or kexec. GRUB behaves like the approach
implemented here.

Also fixes the documentation around pref_address and PHYSICAL_START to
be accurate.

[ dhansen: changelog tweak ]

Co-developed-by: Cloud Hsu <cloudhsu@google.com>
Signed-off-by: Cloud Hsu <cloudhsu@google.com>
Signed-off-by: Chris Koch <chrisko@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/all/20231215190521.3796022-1-chrisko%40google.com
---
 Documentation/arch/x86/boot.rst   |  3 ++-
 arch/x86/Kconfig                  | 10 +++++-----
 arch/x86/kernel/kexec-bzimage64.c |  5 ++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index c513855..4fd492c 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -878,7 +878,8 @@ Protocol:	2.10+
   address if possible.
 
   A non-relocatable kernel will unconditionally move itself and to run
-  at this address.
+  at this address. A relocatable kernel will move itself to this address if it
+  loaded below this address.
 
 ============	=======
 Field name:	init_size
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec17..1a33575 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2114,11 +2114,11 @@ config PHYSICAL_START
 	help
 	  This gives the physical address where the kernel is loaded.
 
-	  If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
-	  bzImage will decompress itself to above physical address and
-	  run from there. Otherwise, bzImage will run from the address where
-	  it has been loaded by the boot loader and will ignore above physical
-	  address.
+	  If the kernel is not relocatable (CONFIG_RELOCATABLE=n) then bzImage
+	  will decompress itself to above physical address and run from there.
+	  Otherwise, bzImage will run from the address where it has been loaded
+	  by the boot loader. The only exception is if it is loaded below the
+	  above physical address, in which case it will relocate itself there.
 
 	  In normal kdump cases one does not have to set/change this option
 	  as now bzImage can be compiled as a completely relocatable image
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 2a422e0..cde167b 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -503,7 +503,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	kbuf.bufsz =  kernel_len - kern16_size;
 	kbuf.memsz = PAGE_ALIGN(header->init_size);
 	kbuf.buf_align = header->kernel_alignment;
-	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
+	if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
+		kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
+	else
+		kbuf.buf_min = header->pref_address;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)

