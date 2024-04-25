Return-Path: <linux-kernel+bounces-158414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333938B1FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA4B1F22369
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912EC2374C;
	Thu, 25 Apr 2024 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vSV0dd/e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="89X14WQJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F441D53F;
	Thu, 25 Apr 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042344; cv=none; b=pl+BjdEL4T1U3qpw1nFQwcIFJ2DG3DURDApUjZh+wwmhlWv+qyPXjI/pVMgelBg7Hb51hPjFFKcvI5gaBlcQ290opdQBeG9C04BcvqNcxm5S6JykfasukHc5DfFbmDG8cBn2T+gFEa6DxkWi3EuMTcBpeoMvdMtHQJpGzF0hxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042344; c=relaxed/simple;
	bh=pShO0c7KzGz61XItFLkgN19PQLdEoC1UOl8AH5BK24A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DlL/W/d4c62F8bIVJfnhkDNpCuAE941VD8vbOohi7bgk5jIicslrzUtrHWtqfcV0nvrFRkwT3DiaaARg0GNMgfJBAQe4Pgh03qIsdagf4BQmegbQlRiOcr1rkqiW4nqS+9Z5RCxDWxDJMGj/pmKEmmurjVYIHfUYNdyBcCgL3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vSV0dd/e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=89X14WQJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 10:52:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714042336;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPZfu3AAsXB7okaVcD/0QHI6MFbUYpenoIlPfWwqYVM=;
	b=vSV0dd/e8rNJqu5sh667dn9uRXAPUI1X0eh18ubVedkH7q91ekOfrXS3r8KqqGpgKj601z
	m19TAGy+PBgDYp3WKc2wAEDEDtA/2YYC9/pRC0MZag+H/sLeZ236cCEISmVgtdzBKNm0h4
	XSu/ecCzyH3RhC1HDwrQ6+D6VWaMSNzQnMUwEMhpslt2ghnHXcwmd03g4L6M+j0ctoARus
	kRcNaxZNU3lQL3u5db85t08jA+oVciHnLpy9R15cBSlTWJpaoU+yXuaivJ1YR0lFlQN0EC
	dzc6IGFTuD1T9otQAOmnUE2CPZqBXJHyivGqGZ8PW5gFS7mcFJOZRAAP7/hAPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714042336;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPZfu3AAsXB7okaVcD/0QHI6MFbUYpenoIlPfWwqYVM=;
	b=89X14WQJuPMuauRViNPa8IcTCeTPWWHi2tseiO030s+cpNW/F1m6J+p6eT+4zGEwqy6nI8
	sLRHAyLjP/Z99ICw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/bugs: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240424181506.41673-1-tony.luck@intel.com>
References: <20240424181506.41673-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171404233198.10875.13057892909385015693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8a28b0220266e2b8290e696d4b21c88f32e6aeb1
Gitweb:        https://git.kernel.org/tip/8a28b0220266e2b8290e696d4b21c88f32e6aeb1
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:06 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 25 Apr 2024 12:27:25 +02:00

x86/bugs: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240424181506.41673-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/bugs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ca295b0..32d86dd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -26,7 +26,7 @@
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
 #include <asm/tlbflush.h>
@@ -2390,20 +2390,20 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	if (c->x86 != 6)
 		return;
 
-	switch (c->x86_model) {
-	case INTEL_FAM6_NEHALEM:
-	case INTEL_FAM6_WESTMERE:
-	case INTEL_FAM6_SANDYBRIDGE:
-	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_G:
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_SKYLAKE_L:
-	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
+	switch (c->x86_vfm) {
+	case INTEL_NEHALEM:
+	case INTEL_WESTMERE:
+	case INTEL_SANDYBRIDGE:
+	case INTEL_IVYBRIDGE:
+	case INTEL_HASWELL:
+	case INTEL_HASWELL_L:
+	case INTEL_HASWELL_G:
+	case INTEL_BROADWELL:
+	case INTEL_BROADWELL_G:
+	case INTEL_SKYLAKE_L:
+	case INTEL_SKYLAKE:
+	case INTEL_KABYLAKE_L:
+	case INTEL_KABYLAKE:
 		if (c->x86_cache_bits < 44)
 			c->x86_cache_bits = 44;
 		break;

