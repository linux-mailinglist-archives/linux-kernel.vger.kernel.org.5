Return-Path: <linux-kernel+bounces-112562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE6887B87
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4F1F2198E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493605398;
	Sun, 24 Mar 2024 03:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="llFjSg6y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pgBsK9xa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4D17C8;
	Sun, 24 Mar 2024 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711250160; cv=none; b=IbpPzI5Hh22Rs5X2N6uX9EJijvbRz5Qys2agb/gvPNAWrju+2Xx7GtPBHZ0R/0VvKNR+e/ZjCKy/dpFTl7U6Y2dC0qjt+UqBVz/s30gj83GwjqkyzVIxUsqyOqdFueYZEqxG+NgKGfddHG558bwkj6YZBJKZr4xaj7f8Zhvdzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711250160; c=relaxed/simple;
	bh=jnp2R5h1C/6qLBDLdYp/ZLAdEwQEcCATMu1AvOw4+5c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VZD+RNorPhhH5IjQ4KYypPEgcuzPhoijvh1a4psvA+JbKb52fRNid/REqiDzlrInuwHEUVdAd73Y+7CUO6tIlmtz/sjOwWs0pUTxolGnjaQuBavzLR5xosuvXr0WeFvjuYRlTwHcyO4m0A2focY8bLE7JeJq/hIzBUwJSPUXk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=llFjSg6y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pgBsK9xa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Mar 2024 03:15:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711250156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKzrE45/SlJnh2OIv78+wg9CIfM09TLSbytvDClZoDk=;
	b=llFjSg6yaxuYz1JxFFMT9XVNpvCYvvUuruaBK4XDEFnAHzVo2oE5V1FYkewNspUpGrRlh5
	71ZRAKLcjDk8GXSCvyA3qcpn+4jC3ucYQh0HPA9PGj1jBVwbQWrCDSUY3lGJjVGHnuOCvN
	gaa8sk9iQPsGuR3Fqcj+KfNybvM+xytPzQKN29LsKbFrwHFyWEO6c1e0nCwcEokHgwqtNb
	S4hx9NlsIDzBH/U0C4nrMYANKb5WGqceDJfMDcF0MZcU5KMygJSmeaGfT6DUdqIsR0Nnwk
	n86ITYi6YjbfW6ATP6v2osTjJQnihS0x/D4z9XzNAJbIx5IDbT1okLBBiTYO3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711250156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKzrE45/SlJnh2OIv78+wg9CIfM09TLSbytvDClZoDk=;
	b=pgBsK9xa3jgKMgnvaPIv4VBb5bBBI/evy9P/uf1byxerL6Rbz9/52KWtKV74wpEhBHjQb+
	z4TAEOYRm/cs6FDQ==
From: "tip-bot2 for Adamos Ttofari" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Keep xfd_state in sync with MSR_IA32_XFD
Cc: Adamos Ttofari <attofari@amazon.de>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240322230439.456571-1-chang.seok.bae@intel.com>
References: <20240322230439.456571-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171125015587.10875.6945249739054425304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     10e4b5166df9ff7a2d5316138ca668b42d004422
Gitweb:        https://git.kernel.org/tip/10e4b5166df9ff7a2d5316138ca668b42d004422
Author:        Adamos Ttofari <attofari@amazon.de>
AuthorDate:    Fri, 22 Mar 2024 16:04:39 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Mar 2024 04:03:54 +01:00

x86/fpu: Keep xfd_state in sync with MSR_IA32_XFD

Commit 672365477ae8 ("x86/fpu: Update XFD state where required") and
commit 8bf26758ca96 ("x86/fpu: Add XFD state to fpstate") introduced a
per CPU variable xfd_state to keep the MSR_IA32_XFD value cached, in
order to avoid unnecessary writes to the MSR.

On CPU hotplug MSR_IA32_XFD is reset to the init_fpstate.xfd, which
wipes out any stale state. But the per CPU cached xfd value is not
reset, which brings them out of sync.

As a consequence a subsequent xfd_update_state() might fail to update
the MSR which in turn can result in XRSTOR raising a #NM in kernel
space, which crashes the kernel.

To fix this, introduce xfd_set_state() to write xfd_state together
with MSR_IA32_XFD, and use it in all places that set MSR_IA32_XFD.

Fixes: 672365477ae8 ("x86/fpu: Update XFD state where required")
Signed-off-by: Adamos Ttofari <attofari@amazon.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240322230439.456571-1-chang.seok.bae@intel.com

Closes: https://lore.kernel.org/lkml/20230511152818.13839-1-attofari@amazon.de
---
 arch/x86/kernel/fpu/xstate.c |  5 +++--
 arch/x86/kernel/fpu/xstate.h | 14 ++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c..33a214b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -178,10 +178,11 @@ void fpu__init_cpu_xstate(void)
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
 	 * key as that does not work on the boot CPU. This also ensures
-	 * that any stale state is wiped out from XFD.
+	 * that any stale state is wiped out from XFD. Reset the per CPU
+	 * xfd cache too.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+		xfd_set_state(init_fpstate.xfd);
 
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 3518fb2..19ca623 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -148,20 +148,26 @@ static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rs
 #endif
 
 #ifdef CONFIG_X86_64
+static inline void xfd_set_state(u64 xfd)
+{
+	wrmsrl(MSR_IA32_XFD, xfd);
+	__this_cpu_write(xfd_state, xfd);
+}
+
 static inline void xfd_update_state(struct fpstate *fpstate)
 {
 	if (fpu_state_size_dynamic()) {
 		u64 xfd = fpstate->xfd;
 
-		if (__this_cpu_read(xfd_state) != xfd) {
-			wrmsrl(MSR_IA32_XFD, xfd);
-			__this_cpu_write(xfd_state, xfd);
-		}
+		if (__this_cpu_read(xfd_state) != xfd)
+			xfd_set_state(xfd);
 	}
 }
 
 extern int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu);
 #else
+static inline void xfd_set_state(u64 xfd) { }
+
 static inline void xfd_update_state(struct fpstate *fpstate) { }
 
 static inline int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu) {

