Return-Path: <linux-kernel+bounces-125650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E985892A25
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944FD283563
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8A6200DA;
	Sat, 30 Mar 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="La7RP1vY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+PRTUA5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167991EA90;
	Sat, 30 Mar 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792646; cv=none; b=FqfEkQRbnd+14RwDAWVVsMJmQblPXZ7Mx1MslkdCrBBT8WDKr3Z0DmVtLEfpkXk0RrRSlgNtdBwkiqRKAISg7jrfw8uitn56k40w16I/vorJqWbJBZxqjfEtHosAt8V5p/OQnC7B+frV31I+kXBAvO0pMMVd3qrTZGu6FD8uUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792646; c=relaxed/simple;
	bh=PF8Vo3VW456vbwRtZcMpnli6XoXHuJ9oeBnvNs6KVXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cs1sf42YXqEaBjJrl994XaaJctdTAmUvJFOfOSTbeLif/KXLQM7RMcaMGYsjkLSOwMDNigI9QWDAPbcpUVhzYxPazDB7XNf6Hr055DonjOEu9bn9MAj5qWbkWnCZ/1+UQFrFnMm3GQnoYiwhQaw4+BerIh9BD0noQX5KwZorCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=La7RP1vY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+PRTUA5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 30 Mar 2024 09:57:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711792636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8w5NUE/ympVQrHFZtBDRDq9eUSr4b3MwYjTnTBR9p0=;
	b=La7RP1vYofw5oU5uiaTy7r/VwoP13x1O8h8MRDrc/uBIYWwypSlqnZEGCVBreDBDwu+MDR
	9G9fw0ij9R0uYzTb1h7yitj7ndg3hjHwJa9tYGk+k4SrgX4M9KP9M3V3loTpYSSwSVmrhn
	LTYUY1ky64VYVp3Py+q3jXAsAKwncuIcDgCknQxvKKNEZS31m+RTbsfK9z5DWDCT6jqChf
	0c+QRfEVv9CLcMLQA8TO1jl8H3rkSBFq/uEmb9Aqlj3ngNYvyeNgPsngixAgDtIQmWKA2f
	SbZRP5vFAVQ8Mue1jFuvkBLr+mGnc6lqYyMOiCw5ONeMUjdfdO66zMCFxL1sow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711792636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8w5NUE/ympVQrHFZtBDRDq9eUSr4b3MwYjTnTBR9p0=;
	b=t+PRTUA5PZh/5d1r6A0rukl/xpywMZLKeG9q0PhSUi137+YatB4/uXXi3xMRfPnRMTdlRw
	PmEPj87gzZe71MDw==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Use obj-y to descend into arch/x86/virt/
Cc: Masahiro Yamada <masahiroy@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240330060554.18524-1-masahiroy@kernel.org>
References: <20240330060554.18524-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171179263581.10875.12577077230652188795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3f1a9bc5d878004ed4bc3904e5cb9b7fb317fbe2
Gitweb:        https://git.kernel.org/tip/3f1a9bc5d878004ed4bc3904e5cb9b7fb317fbe2
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sat, 30 Mar 2024 15:05:54 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 30 Mar 2024 10:41:49 +01:00

x86/build: Use obj-y to descend into arch/x86/virt/

Commit c33621b4c5ad ("x86/virt/tdx: Wire up basic SEAMCALL functions")
introduced a new instance of core-y instead of the standardized obj-y
syntax.

X86 Makefiles descend into subdirectories of arch/x86/virt inconsistently;
into arch/x86/virt/ via core-y defined in arch/x86/Makefile, but into
arch/x86/virt/svm/ via obj-y defined in arch/x86/Kbuild.

This is problematic when you build a single object in parallel because
multiple threads attempt to build the same file.

  $ make -j$(nproc) arch/x86/virt/vmx/tdx/seamcall.o
    [ snip ]
    AS      arch/x86/virt/vmx/tdx/seamcall.o
    AS      arch/x86/virt/vmx/tdx/seamcall.o
  fixdep: error opening file: arch/x86/virt/vmx/tdx/.seamcall.o.d: No such file or directory
  make[4]: *** [scripts/Makefile.build:362: arch/x86/virt/vmx/tdx/seamcall.o] Error 2

Use the obj-y syntax, as it works correctly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240330060554.18524-1-masahiroy@kernel.org
---
 arch/x86/Kbuild        | 2 +-
 arch/x86/Makefile      | 2 --
 arch/x86/virt/Makefile | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 6a1f36d..cf0ad89 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -28,7 +28,7 @@ obj-y += net/
 
 obj-$(CONFIG_KEXEC_FILE) += purgatory/
 
-obj-y += virt/svm/
+obj-y += virt/
 
 # for cleaning
 subdir- += boot tools
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 662d9d4..5ab93fc 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -251,8 +251,6 @@ archheaders:
 
 libs-y  += arch/x86/lib/
 
-core-y += arch/x86/virt/
-
 # drivers-y are linked after core-y
 drivers-$(CONFIG_MATH_EMULATION) += arch/x86/math-emu/
 drivers-$(CONFIG_PCI)            += arch/x86/pci/
diff --git a/arch/x86/virt/Makefile b/arch/x86/virt/Makefile
index 1e36502..ea343fc 100644
--- a/arch/x86/virt/Makefile
+++ b/arch/x86/virt/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y	+= vmx/
+obj-y	+= svm/ vmx/

