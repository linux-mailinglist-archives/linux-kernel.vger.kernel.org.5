Return-Path: <linux-kernel+bounces-140109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451C8A0B83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F91B1F23F83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC796145353;
	Thu, 11 Apr 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gzQYj3H8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+/KU2VP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F3144319;
	Thu, 11 Apr 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824834; cv=none; b=hx4zEqq5gXfUe/q+7ZhSzaGkG158irx807rIXS2THMyh0LYIJzNe0zTISCqvIYp3UB9jUMNfPTf+YO/JHfxo2LwbMivHcQ/RDgTt+6HFEK/X5c+lF82BUEGstnLY4jOP5Qmud/G31yIPv5wYelHjZXsr1WFyZm0dQvLGQ9YfFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824834; c=relaxed/simple;
	bh=6IKb9HZopR97AJ288H4GpXDXmBr140+wx1S92ZXT6as=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j8AdnCLtKeRDMiM4qUs4KfXcwmXViMMN7wjJ6BpSrWy94UpZ0pS5+de3OPWk01J9JtWfM0kfmh8dMILmb0AX+OmmTea4Xp/tnpoz72DF3ALD8AZhX8Gy53H2R5ysR9AYBQVGXvFPIH7etS3HhUwvitoiEvTp1zxnODVpqlq7hNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gzQYj3H8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+/KU2VP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 08:40:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712824824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcN7tXMnMywbBqjQJHCC0LtqV5AS39Utc3hiYI/TTyY=;
	b=gzQYj3H8P6zaLgGYIyysyU8PGJ6pc/EZebPbli3ZxFKEoeAD2TpiG9VzcBN6wZVyHKAkxW
	iE7bnbaq06I1k9vzOC7ycLYKYCsiJWUTPZ8fQtw+OGUIDNAujLRk4uOIVie4yg1or+uYE+
	vfAdPJjl2cYroG+6KWsmnHip0vWmx3ogT1a9oMZt6ZQ3Y2HXcBTmgZMQ/pZnJdGNcc7s7K
	FYTQfbAnd80+SgGdXtMYQVrNWtjnQV3nG12/AriJm8CDdxIZ3ZK06mgRWGi1dRM4o2S0sb
	PQGQVFxkqxapmC6lM5V9E+d9OvstDpY4xzTl5nwrRGN+bkxw8OxqL685jHHoiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712824824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcN7tXMnMywbBqjQJHCC0LtqV5AS39Utc3hiYI/TTyY=;
	b=i+/KU2VPvdhGCeA+gvq5An+lNmZTqWivkB8/p+hvsYjJmkKcAgqvyW1f0nUxLjoRxMmSrz
	3mNlpGExa/U4nDBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Fix BHI documentation
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8c84f7451bfe0dd08543c6082a383f390d4aa7e2.1712813475.git.jpoimboe@kernel.org>
References:
 <8c84f7451bfe0dd08543c6082a383f390d4aa7e2.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171282482362.10875.17185203405613428370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dfe648903f42296866d79f10d03f8c85c9dfba30
Gitweb:        https://git.kernel.org/tip/dfe648903f42296866d79f10d03f8c85c9dfba30
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 22:40:45 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 10:30:25 +02:00

x86/bugs: Fix BHI documentation

Fix up some inaccuracies in the BHI documentation.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/8c84f7451bfe0dd08543c6082a383f390d4aa7e2.1712813475.git.jpoimboe@kernel.org
---
 Documentation/admin-guide/hw-vuln/spectre.rst   | 15 ++++++++-------
 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++-----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index b70b1d8..3cf18e4 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -439,11 +439,11 @@ The possible values in this file are:
    - System is protected by retpoline
  * - BHI: BHI_DIS_S
    - System is protected by BHI_DIS_S
- * - BHI: SW loop; KVM SW loop
+ * - BHI: SW loop, KVM SW loop
    - System is protected by software clearing sequence
  * - BHI: Syscall hardening
    - Syscalls are hardened against BHI
- * - BHI: Syscall hardening; KVM: SW loop
+ * - BHI: Syscall hardening, KVM: SW loop
    - System is protected from userspace attacks by syscall hardening; KVM is protected by software clearing sequence
 
 Full mitigation might require a microcode update from the CPU
@@ -666,13 +666,14 @@ kernel command line.
 		of the HW BHI control and the SW BHB clearing sequence.
 
 		on
-			unconditionally enable.
+			(default) Enable the HW or SW mitigation as
+			needed.
 		off
-			unconditionally disable.
+			Disable the mitigation.
 		auto
-			enable if hardware mitigation
-			control(BHI_DIS_S) is available, otherwise
-			enable alternate mitigation in KVM.
+			Enable the HW mitigation if needed, but
+			*don't* enable the SW mitigation except for KVM.
+			The system may be vulnerable.
 
 For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 70046a0..a029ad6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3444,6 +3444,7 @@
 					       retbleed=off [X86]
 					       spec_rstack_overflow=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       spectre_bhi=off [X86]
 					       spectre_v2_user=off [X86]
 					       srbds=off [X86,INTEL]
 					       ssbd=force-off [ARM64]
@@ -6069,11 +6070,12 @@
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
-			on   - unconditionally enable.
-			off  - unconditionally disable.
-			auto - (default) enable hardware mitigation
-			       (BHI_DIS_S) if available, otherwise enable
-			       alternate mitigation in KVM.
+			on   - (default) Enable the HW or SW mitigation
+			       as needed.
+			off  - Disable the mitigation.
+			auto - Enable the HW mitigation if needed, but
+			       *don't* enable the SW mitigation except
+			       for KVM.  The system may be vulnerable.
 
 	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.

