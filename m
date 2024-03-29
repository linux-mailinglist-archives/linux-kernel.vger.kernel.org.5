Return-Path: <linux-kernel+bounces-124266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C8891496
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339ECB22109
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC2D43172;
	Fri, 29 Mar 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SSOItfHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0AI4tBql"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF840BF2;
	Fri, 29 Mar 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698680; cv=none; b=PKxmi04elCiDa7GoklTnbaBIqmVTix0UP+5Q4YLwdRmRcZ4oZUmReJkLWE3fY/j+8HVc1WrLlIkbCzMzG3LrrOSQf9iIjzKHXAZBOYzJpSoloUnJHLbvzAv5B3xc4uzrEuceAzDYZaXpsun6Q8F6AUj77X8mUldSVr829iMva08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698680; c=relaxed/simple;
	bh=kssLs14+1mmKrGcbJAu/wx7F410h9lOjtBruzYyegfo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ONKQldaWpSp9NAO95UoG3Tsd8VQrhpCCEBy6kf2AKgMDWd/k8Oud6dHGyXKHgiPLxCiOHcEFWIeMRe1KhDm/ULgWDUmY7t8tOUW+M5sS8mMr7MV4DEB177rq20RkB8TkMMpddVLr/xrroPA5B+6WNdsvXxmrwi/DY7JFtciHEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SSOItfHl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0AI4tBql; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Mar 2024 07:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711698676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNckAjxfyn1sROrDnBaGaxAoA+tycTH4dWbz8gqse2A=;
	b=SSOItfHlKenPNDi7V2gSmI+I7etMdd8KSIo0kgzlBl9duoWB5tuFhnY5J0WB/WtKTD3JlF
	8y24RqBHeSSz17Jz3iLP+ijKBrs1+VeykCh3eXOfvDw+X6xPOYjrtUBU4T1j3COg+Aro9z
	Fzw2Y6G2bebK2kB9fkfRtPSbSMvQTEVLNeReC22bryrsaSopNCzeT2KUxhb61cmWXaStaS
	PxePtWwYmgoAjS8B2zAW+wHZ2G1c/P/WP8SpvjwDfQOSSTfUxH2fEsPdJOD+Bq/JRESAC2
	uH5pExdDaZ71GMBp5SFGsvpwVG7ICZ+z4E4tpEYNoeCOGeYha1smU9SiArTuGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711698676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNckAjxfyn1sROrDnBaGaxAoA+tycTH4dWbz8gqse2A=;
	b=0AI4tBqlvR5V4ezaQYY3jRZG1P8NLWwgNHCj67HHTi7ufj+8xkXB+Mvy/bM45L3J3goJcD
	Kd3EeaKteqtxjFCg==
From: "tip-bot2 for Muhammad Usama Anjum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/selftests: Skip the tests if prerequisites aren't
 fulfilled
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Ingo Molnar <mingo@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240327111720.3509180-1-usama.anjum@collabora.com>
References: <20240327111720.3509180-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171169867577.10875.3062034590185547871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     99c84311e35f9399bdce666f6306a048e2a5b404
Gitweb:        https://git.kernel.org/tip/99c84311e35f9399bdce666f6306a048e2a5b404
Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
AuthorDate:    Wed, 27 Mar 2024 16:17:17 +05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Mar 2024 08:33:40 +01:00

x86/selftests: Skip the tests if prerequisites aren't fulfilled

Skip instead of failing when prerequisite conditions aren't fulfilled,
such as invalid xstate values etc.

Make the tests show as 'SKIP' when run:

  make -C tools/testing/selftests/ TARGETS=x86 run_tests

  ...
  # timeout set to 45
  # selftests: x86: amx_64
  # # xstate cpuid: invalid tile data size/offset: 0/0
  ok 42 selftests: x86: amx_64 # SKIP
  # timeout set to 45
  # selftests: x86: lam_64
  # # Unsupported LAM feature!
  ok 43 selftests: x86: lam_64 # SKIP
  ...

In the AMX test, Move away from check_cpuid_xsave() and start using
arch_prctl() to find out if AMX support is present or not. In the
kernels where AMX isn't present, arch_prctl() returns -EINVAL, hence it is
backward compatible.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240327111720.3509180-1-usama.anjum@collabora.com
---
 tools/testing/selftests/x86/amx.c | 27 ++++++++++-----------------
 tools/testing/selftests/x86/lam.c |  2 +-
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index d884fd6..95aad6d 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -103,21 +103,6 @@ static void clearhandler(int sig)
 
 #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
 #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
-static inline void check_cpuid_xsave(void)
-{
-	uint32_t eax, ebx, ecx, edx;
-
-	/*
-	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
-	 * support for the XSAVE feature set, including
-	 * XGETBV.
-	 */
-	__cpuid_count(1, 0, eax, ebx, ecx, edx);
-	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
-		fatal_error("cpuid: no CPU xsave support");
-	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
-		fatal_error("cpuid: no OS xsave support");
-}
 
 static uint32_t xbuf_size;
 
@@ -350,6 +335,7 @@ enum expected_result { FAIL_EXPECTED, SUCCESS_EXPECTED };
 
 /* arch_prctl() and sigaltstack() test */
 
+#define ARCH_GET_XCOMP_SUPP	0x1021
 #define ARCH_GET_XCOMP_PERM	0x1022
 #define ARCH_REQ_XCOMP_PERM	0x1023
 
@@ -928,8 +914,15 @@ static void test_ptrace(void)
 
 int main(void)
 {
-	/* Check hardware availability at first */
-	check_cpuid_xsave();
+	unsigned long features;
+	long rc;
+
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+	if (rc || (features & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+		ksft_print_msg("no AMX support\n");
+		return KSFT_SKIP;
+	}
+
 	check_cpuid_xtiledata();
 
 	init_stashed_xsave();
diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 215b815..c0f016f 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -1183,7 +1183,7 @@ int main(int argc, char **argv)
 
 	if (!cpu_has_lam()) {
 		ksft_print_msg("Unsupported LAM feature!\n");
-		return -1;
+		return KSFT_SKIP;
 	}
 
 	while ((c = getopt(argc, argv, "ht:")) != -1) {

