Return-Path: <linux-kernel+bounces-39096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558FF83CAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A591C25FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EEE13AA57;
	Thu, 25 Jan 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+XMuS+m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZm2HAVD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4AD137C59;
	Thu, 25 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206895; cv=none; b=gCQ+ulXuR8jRMyJblQ5RMxWG/88cY/cQ+roj6CeJcplfaqmztdUA0msf4Cq/ok2hmqGaoR1UG187+MkmARLU+Igm58KTj/xvmYC6NIRytsaMe8GOz0wZrG0O5f9BdYiZ3MD6FhjPd2GedarRDfq6f+t+uKEL4wQCQah7d4DeciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206895; c=relaxed/simple;
	bh=W3+J1CThxkEIStuaBxXX2N9iHrdtjDG4TfKHHutXggk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q2KnTOKxYy/O6LPIJUMiSaNrBWtnXBH9Zf4fwHSHIvugMPNGX2nUDU48TTmoaCd+XHij7sKFGccGaq6pgdygnpTvDQdSOY9tNVwoMm76QGtIiRvmYzaMa3zkBnohA3F57jwkHEp0cpJ6RIfQ1G47OE4cZgr9JyVSiHG9Ifs+/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E+XMuS+m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZm2HAVD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PW5fTiqFur/MlyLg1C6VrNNPlj5qDZ8Qy1Dz7WWKRCo=;
	b=E+XMuS+mYhUaWw5uTZi+1ojqJu3OkH/FXWJM5G5NlbBJwNl+XXLrfQE4gLtbwG1yvss4bb
	ZsefOQIMi3I88Z951USOjj9CQTHpbBkcJONunNKHl1Ezul8vs4evr/fLEegTfsYqe3igT0
	9R2TJuU7kbeXm4bUSJ4jqyLP/zK2EhcdEIpIO6BtWuveOWCm2AZoL5P5FVFmvYN2ZclnZP
	Sx3VqxK/qXtMQJBzx9Xfiu6aQ2fexZ88LVW0lMKDsLxnzs3LBNDnmERMTm0p/uSC1FaD9/
	AI1aoyhEO85qe8GmocW5KYsPNTrweROe/N/WfUC3gBOTd9RkYXbHbtVsQjXyow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PW5fTiqFur/MlyLg1C6VrNNPlj5qDZ8Qy1Dz7WWKRCo=;
	b=NZm2HAVDVa+GwxqoOJ2pudKFgJDJ9s6XfPDhgPfUIrz/fAPGt+i6LP029r87yjpJBiMnJt
	D2rlx1S3pLpvFSAA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Disallow the swapgs instruction when FRED
 is enabled
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-19-xin3.li@intel.com>
References: <20231205105030.8698-19-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620688794.398.9560084584740644544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     45ba25d49059ddab201a22d62c9364eab283856f
Gitweb:        https://git.kernel.org/tip/45ba25d49059ddab201a22d62c9364eab28=
3856f
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:07 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:31 +01:00

x86/fred: Disallow the swapgs instruction when FRED is enabled

SWAPGS is no longer needed thus NOT allowed with FRED because FRED
transitions ensure that an operating system can _always_ operate
with its own GS base address:

  - For events that occur in ring 3, FRED event delivery swaps the GS
    base address with the IA32_KERNEL_GS_BASE MSR.

  - ERETU (the FRED transition that returns to ring 3) also swaps the
    GS base address with the IA32_KERNEL_GS_BASE MSR.

And the operating system can still setup the GS segment for a user
thread without the need of loading a user thread GS with:

  - Using LKGS, available with FRED, to modify other attributes of the
    GS segment without compromising its ability always to operate with
    its own GS base address.

  - Accessing the GS segment base address for a user thread as before
    using RDMSR or WRMSR on the IA32_KERNEL_GS_BASE MSR.

Note, LKGS loads the GS base address into the IA32_KERNEL_GS_BASE MSR
instead of the GS segment's descriptor cache. As such, the operating
system never changes its runtime GS base address.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-19-xin3.li@intel.com

---
 arch/x86/kernel/process_64.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 0f78b58..4f87f59 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -166,7 +166,29 @@ static noinstr unsigned long __rdgsbase_inactive(void)
=20
 	lockdep_assert_irqs_disabled();
=20
-	if (!cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	/*
+	 * SWAPGS is no longer needed thus NOT allowed with FRED because
+	 * FRED transitions ensure that an operating system can _always_
+	 * operate with its own GS base address:
+	 * - For events that occur in ring 3, FRED event delivery swaps
+	 *   the GS base address with the IA32_KERNEL_GS_BASE MSR.
+	 * - ERETU (the FRED transition that returns to ring 3) also swaps
+	 *   the GS base address with the IA32_KERNEL_GS_BASE MSR.
+	 *
+	 * And the operating system can still setup the GS segment for a
+	 * user thread without the need of loading a user thread GS with:
+	 * - Using LKGS, available with FRED, to modify other attributes
+	 *   of the GS segment without compromising its ability always to
+	 *   operate with its own GS base address.
+	 * - Accessing the GS segment base address for a user thread as
+	 *   before using RDMSR or WRMSR on the IA32_KERNEL_GS_BASE MSR.
+	 *
+	 * Note, LKGS loads the GS base address into the IA32_KERNEL_GS_BASE
+	 * MSR instead of the GS segment=E2=80=99s descriptor cache. As such, the
+	 * operating system never changes its runtime GS base address.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    !cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		native_swapgs();
 		gsbase =3D rdgsbase();
 		native_swapgs();
@@ -191,7 +213,8 @@ static noinstr void __wrgsbase_inactive(unsigned long gsb=
ase)
 {
 	lockdep_assert_irqs_disabled();
=20
-	if (!cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    !cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		native_swapgs();
 		wrgsbase(gsbase);
 		native_swapgs();

