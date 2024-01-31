Return-Path: <linux-kernel+bounces-47134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB148449BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207A6B27407
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12FF3EA6B;
	Wed, 31 Jan 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBiZIVKf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4amRHlQQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1843B290;
	Wed, 31 Jan 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735693; cv=none; b=WRHvUrGue6b9hOEZiG+CFb07hbe8pBVgtOGg92U3dLIEsXsT9IZaRv4DdBZolTVYMyGrfofw/5J1jwOpIw9GXwASw2XOndI3fxim9gzWa+kKOkyz/04D3xFBpZasUB+Y5PQyUWMXUtwItjusE9GOtU5FugQ51M8xYKHR7Qoy0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735693; c=relaxed/simple;
	bh=cvq7V1ykTUX7C4s4O7SikD/1AEfkrbUY/8Ahx//l2q0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DVs1gphl5QyGoN97vjnvFZ+tecHrIMefyd8EOykHo7EVd5CgVITNcuQlOop/ISK4r6BDZNzHVKaOs9zN2rhj4VFl6wlTl8XWQ3u8NvDn7hQQ+GTttmqaReEFcJn8PZ9vfXSkaGSf9KpAEEbok1PdsG+dvMGzgo2h3Ef8Z8GxAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBiZIVKf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4amRHlQQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkt8/v6brDioiH+ccpJMIFc54wdOcur1lkPXnHjo/as=;
	b=lBiZIVKfNRjTED24uJsB9XsqiXyfTQiXPwVqOu5px06Lv551XP+gV7dGNMEw0gAyC0NCew
	RFIbQ27ZwX8ZNTcWFEdUOBOfr9wkD3rLH6ezhCu2uN8HsgEH482iolTKFmmm0W/8pADpKf
	qxWiG1awVnQQqtPSESMHvuIidBJhKI/qj3GDsnUw20XaDeuBV+d31i7a0ftVJVSIVm27Y6
	zDRBnmL0piykYBuV1y21B+o6QnwD4PENjARZ5BR8PsCfBYZ/inPTXIZ8JT3hAoGbRDsQBJ
	M6KokbdP4x24KEzKN8JjKvXhv19H1xrfBZV+61u3KecGrjqkClASHYXSlH/Lhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkt8/v6brDioiH+ccpJMIFc54wdOcur1lkPXnHjo/as=;
	b=4amRHlQQgYmix+Tqwx4aqy3cPjKOmDCWufA5+ZDF2Ro/xZ1HWZPqx6zHwGCa5zSuTtYWg6
	SyuG2Av+6YzWc1BA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Disallow the swapgs instruction when FRED
 is enabled
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-19-xin3.li@intel.com>
References: <20231205105030.8698-19-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568930.398.340341597805157045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     09794f68936a017e5632774c3e4450bebbcca2cb
Gitweb:        https://git.kernel.org/tip/09794f68936a017e5632774c3e4450bebbc=
ca2cb
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:07 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:01:41 +01:00

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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

