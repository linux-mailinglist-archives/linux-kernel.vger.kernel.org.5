Return-Path: <linux-kernel+bounces-82151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D07867FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007121F28B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3C12F59F;
	Mon, 26 Feb 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NIaQONGi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4JGeO0/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC212C522;
	Mon, 26 Feb 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973099; cv=none; b=ZUFwMSohNnbf2uqMdDxI0JcKubWCTgDQeruNtS6Pne47J/jkgQfvOmqTFJW9r5fog2rpQSku4uzpiNQcpZCeWyX3uamWklQUL2oV/tFCDaqaep/CVghgoncspbwoBPfimctbHbYIw2PC21nQzoWUZQ9fxR/c4OtBPZ7p6+NsXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973099; c=relaxed/simple;
	bh=GS9gp4VWJdv3Hua02gaR8hLCNcDTZXmN4IufTEOI7P8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qGJf/I8eqF7bRkbJBXplx/MLUw26VCExVoRmG/EAte/8tizvlezT8DE6546VPXeQb93qk3hOtLXhVsr8rpxbS5gsfOkHOtbecGT1fBFXa+gZ8/sW1PuIR98ulHxqd00pA2gLfpfeW1oxfnB/k0ZX3+CiJYh+nT5EU5baFOW+1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NIaQONGi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4JGeO0/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 18:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708973095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=enCiCbZJXdvA+exzx6jm5HR+LaOpH1BSeM0RAR+839A=;
	b=NIaQONGiZrV6tvOmXJAcajmiD2Z8bk+YdO5qEII9+vm0+SI9yiDQbB/FltbsHEyw281RaL
	0hw6HNdJtI60EAkJ02yYJOhuVBdTf1KkV6CiKr2zRynDFlijK9EMR9vx5mDAH839H9aaBs
	HHU59FHq0FenOWZbwFS1XPMWIB58yPytfivbkIF2NBhwo5P1aQNmNagP0DaiwenYanepTi
	iDClAVFRdHXYFPuOBT4l3uFQ4oEyQZKwgVuAvNv5JX43NHwmKoNi4HImTj5L17SYoezPSf
	Ctlr99nPeZz21cBbzKNz27OAApxEDhGOl/MCCWdnHmXzHIW81fb5tLdGnuPJww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708973095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=enCiCbZJXdvA+exzx6jm5HR+LaOpH1BSeM0RAR+839A=;
	b=s4JGeO0/CC6oNTJCYW5QKUjHgcyV4UR/caPpfsWxgLaM4C6ENE/MOaFnhbeWtBi0D6asFf
	bjNhsAMyQ3Ej3XDQ==
From: "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Allow reducing x86_phys_bits during
 early_identify_cpu()
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170897309511.398.3611355957607833957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9a458198eba98b7207669a166e64d04b04cb651b
Gitweb:        https://git.kernel.org/tip/9a458198eba98b7207669a166e64d04b04cb651b
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Thu, 01 Feb 2024 00:09:01 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 26 Feb 2024 08:16:15 -08:00

x86/cpu: Allow reducing x86_phys_bits during early_identify_cpu()

In commit fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct
value straight away, instead of a two-phase approach"), the initialization
of c->x86_phys_bits was moved after this_cpu->c_early_init(c).  This is
incorrect because early_init_amd() expected to be able to reduce the
value according to the contents of CPUID leaf 0x8000001f.

Fortunately, the bug was negated by init_amd()'s call to early_init_amd(),
which does reduce x86_phys_bits in the end.  However, this is very
late in the boot process and, most notably, the wrong value is used for
x86_phys_bits when setting up MTRRs.

To fix this, call get_cpu_address_sizes() as soon as X86_FEATURE_CPUID is
set/cleared, and c->extended_cpuid_level is retrieved.

Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240131230902.1867092-2-pbonzini%40redhat.com
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcd..fbc4e60 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1589,6 +1589,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
+		get_cpu_address_sizes(c);
 		cpu_parse_early_param();
 
 		if (this_cpu->c_early_init)
@@ -1601,10 +1602,9 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 			this_cpu->c_bsp_init(c);
 	} else {
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
+		get_cpu_address_sizes(c);
 	}
 
-	get_cpu_address_sizes(c);
-
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
 	cpu_set_bug_bits(c);

