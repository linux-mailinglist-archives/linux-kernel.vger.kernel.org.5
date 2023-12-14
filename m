Return-Path: <linux-kernel+bounces-178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3411A813D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593B91C21DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9620B6720A;
	Thu, 14 Dec 2023 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B85ZHcEP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZBXHdJh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406F671E8;
	Thu, 14 Dec 2023 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Dec 2023 22:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702592177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=23JHJ4YvU/vkCLKZ2ZNv1Me7c3wPWOyfscdZ0QqE0yM=;
	b=B85ZHcEPL6OBxidkyNeYDGRwlyAnTSgk5TlH8Fx2toPSd1CWBMGCI5635rTuac68jt09n0
	gsaboMZLZitgmwAUSGFfIM4idrK1Vno5U7p8DlsB+rCkzzlbw7AQHZa6HXg7Zvbju3siHe
	wfb15MWPqm+FqpqZinGSGY4P9i9iX1FE7Vg3l6TQizDqxTd8jrfEs4319lbe43Ize0pWcr
	Rv/4Fo1XS0bQ9FJAcZr9ZirhaQkrCvN7mmdlrRAOUM1gcIOIKrfF4bXKLGlbmZfEe89lTR
	RDp6Ylr95alC7qTMaFwYRYpvNDl2NPdhIgeFvYiCQ1cnPhtHk8EDhy39YOQ/vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702592177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=23JHJ4YvU/vkCLKZ2ZNv1Me7c3wPWOyfscdZ0QqE0yM=;
	b=2ZBXHdJhShe2SpVwbYYZWLqU1MCZ84W0wKRQGtqyPRuurOEh8v7v+17ZPz+W/WrHq+YBkl
	S9ro0568/hMkKBCA==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Make TDX host depend on X86_MCE
Cc: Arnd Bergmann <arnd@kernel.org>, Kai Huang <kai.huang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170259217628.398.17615017051831948237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8
Gitweb:        https://git.kernel.org/tip/83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Thu, 14 Dec 2023 11:28:25 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 14 Dec 2023 14:08:24 -08:00

x86/virt/tdx: Make TDX host depend on X86_MCE

A build failure was reported that when INTEL_TDX_HOST is enabled but
X86_MCE is not, the tdx_dump_mce_info() function fails to link:

  ld: vmlinux.o: in function `tdx_dump_mce_info':
  ...: undefined reference to `mce_is_memory_error'
  ...: undefined reference to `mce_usable_address'

The reason is in such configuration, despite there's no caller of
tdx_dump_mce_info() it is still built and there's no implementation for
the two "mce_*()" functions.

Make INTEL_TDX_HOST depend on X86_MCE to fix.

It makes sense to enable MCE support for the TDX host anyway.  Because
the only way that TDX has to report integrity errors is an MCE, and it
is not good to silently ignore such MCE.  The TDX spec also suggests
the host VMM is expected to implement the MCE handler.

Note it also makes sense to make INTEL_TDX_HOST select X86_MCE but this
generates "recursive dependency detected!" error in the Kconfig.

Closes: https://lore.kernel.org/all/20231212214612.GHZXjUpBFa1IwVMTI7@fat_crate.local/T/
Fixes: 70060463cb2b ("x86/mce: Differentiate real hardware #MCs from TDX erratum ones")
Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20231212214612.GHZXjUpBFa1IwVMTI7@fat_crate.local/T/#m1a109c29324b2bbd0b3b1d45c218012cd3a13be6
Link: https://lore.kernel.org/all/20231213222825.286809-1-kai.huang%40intel.com
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 01cdb16..92c03cb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1974,6 +1974,7 @@ config INTEL_TDX_HOST
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
 	depends on !KEXEC_CORE
+	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX

