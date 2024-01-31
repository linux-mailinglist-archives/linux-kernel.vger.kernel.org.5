Return-Path: <linux-kernel+bounces-45908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02368437BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D7C286852
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0694277F2C;
	Wed, 31 Jan 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PiWZTW0s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QpyCoExD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C296EB6E;
	Wed, 31 Jan 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685685; cv=none; b=slJvwcFMOzYjpLEcQZ+tYnHlEwy8ia6fNJv/Rb4DJBeie0JocGtVGaVPNFhGRv+qBntSKGibVniW5CkttMwatG3oPVLuZpsDQ3IfnmuihlSBptwBN00CabswcPoFLkBFkPnBQy7F7p7Yq3X8bIPxOcy9s7XzM8RTDb5CveuG+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685685; c=relaxed/simple;
	bh=iN93XF6AxKKzsSQL9ZoFgCg0tjO+/eLTzqimzzD2HqA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kE1f2Pz48a5n8k0kI36rYtoeCyt2EofCi07pBa65ZlXNhQpcdrTGINXD2DRyaamQ5/SePRPxiX3XXvdyH44Bb8mBb+SRBCqxN5RGSU03CLgIYdQ2EfbOnEeewOOHc6AYbHdRYqwFN2P5I1z4BzVnSIwxj6j8MjkVke1+izVtFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PiWZTW0s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QpyCoExD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtXhmepG/FwjJctQY+5k1etzBHV91IRy5NEUJdOZ2GA=;
	b=PiWZTW0sS1eKYDFKB6qzmjcXMbTieFgL4+fabOb9MiC3DFFx3q1qo03eLJM4+DrCbrSaDS
	mx4GcZreePSb5tY132c+vZsY95DA3avAysE6+NjpMLo+HI3nh7Di5dFYRTe1nHNEwhxmus
	zm7dLo7GTD+VT0S++kyb4O+bmJ2jO+nkiIDp0W0U+piCQyHxcU+jF/8z62tby4MWTfaGp3
	Qf5bhm1ZYO1WJNMmU09egD3a1yeh8C1bk7C9sj8xE4ZTr+nNSILSs/ZK57xdEYu6yNpBsv
	1GGP89eHnksZIptHCNLetzNNy2j4jc0ooa3MirXcSJoWfOTgt0mISEqgrwNACw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtXhmepG/FwjJctQY+5k1etzBHV91IRy5NEUJdOZ2GA=;
	b=QpyCoExDoHy5puXVrAiTMq/SXoaRGJfEZD+1ik4NZb7r7yX/u0MaWFIV2MEa1RhTOJwwV1
	r2ddBtwNs3u9dBDg==
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
Message-ID: <170668568088.398.11299824087703623770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     5710910a6c94bcb08d1081ca94119220066331ad
Gitweb:        https://git.kernel.org/tip/5710910a6c94bcb08d1081ca94119220066=
331ad
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:07 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

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

