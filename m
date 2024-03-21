Return-Path: <linux-kernel+bounces-110634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF8886189
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681A31F2294C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B5134CC7;
	Thu, 21 Mar 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="khFV506D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZUi/oE7I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615EAF4FA;
	Thu, 21 Mar 2024 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052369; cv=none; b=Htum4848FjNd8kTV3s7TT2tADV9GWoO5z6ibK2muVFQ43zkSKAxpZivbhaRG6xCeYt6QUPimsjnvJ3wIWc9yNaBw6N76BPhJY1Y+WQuR6GBhl+3nRTy/Fk/zVuoj/S5zV5Cu4zT8LGCV8SeezIxfUC3RTln6PIjC1BoFaVX08DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052369; c=relaxed/simple;
	bh=0+7yLupFUJn3tZxnu2lqPHb28Vn9hA0mXxBfuZkl76Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U4roXnPpNHqevaGXVV19yUTgHDiNy2s6SE20bEDfeCq52aiiSfCHGNr7upggiGxFIv0z0YBln8RcR6FJ5MKlsZDnObiSnRr/5nzKXQRngGwfyW9hM9zX/7zg/t7oiV/l1MLX9qEic8OTm8XLsZrMIBayHLJnAWA2avOsjui1Jfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=khFV506D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZUi/oE7I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 20:19:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711052365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crUYMPOl/nFJOh+gZdNsIAU1wjH2L9wkVovg4jxZ6Tc=;
	b=khFV506D8rWV3Eg9RuSurxyKn23YqfYihQFxyvVVkfDc2xHLF/4g5JnMtjEZvcRr8V1nFF
	ppmUBkMJqXboGZA580p9dB8QjokvK9fNnXJq9idXzDdYX9PwtzoN3ZJK4t77BYg4OmPCYq
	3QsCJ98zoVfGYO7NzA7wAnLBnRPGDlA+aFGGGpegMF9SoGnFaUQOm6sZTjfMNL/Vt5HcyA
	TqbpTfWXOO54W9JLaPMg0eKETVEXWc1RJdSKabkAe1ySufByftDmwEr8w46MDi4ZKP/8zu
	7uyBIbOh08rBqtmEy770b4shN82N2W7cSo1WiAm8ncUJUBIDXQzoYoHwWuok7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711052365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crUYMPOl/nFJOh+gZdNsIAU1wjH2L9wkVovg4jxZ6Tc=;
	b=ZUi/oE7IS+ZyqsMIUoep38sKY73vBnGWvtnPDMAT0wSm0u0BZLMqgubMB6I/6FlRWsk9x6
	c0aU8dHwXYCwUuBw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Get rid of an unnecessary local variable in
 get_cpu_address_sizes()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240316120706.4352-1-bp@alien8.de>
References: <20240316120706.4352-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171105236391.10875.2779822144402584041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     95bfb35269b2e85cff0dd2c957b2d42ebf95ae5f
Gitweb:        https://git.kernel.org/tip/95bfb35269b2e85cff0dd2c957b2d42ebf95ae5f
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 16 Mar 2024 13:07:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Mar 2024 21:13:56 +01:00

x86/cpu: Get rid of an unnecessary local variable in get_cpu_address_sizes()

Drop 'vp_bits_from_cpuid' as it is not really needed.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240316120706.4352-1-bp@alien8.de
---
 arch/x86/kernel/cpu/common.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ba8cf5e..9a34651 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1053,18 +1053,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
-	bool vp_bits_from_cpuid = true;
 
 	if (!cpu_has(c, X86_FEATURE_CPUID) ||
-	    (c->extended_cpuid_level < 0x80000008))
-		vp_bits_from_cpuid = false;
-
-	if (vp_bits_from_cpuid) {
-		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
-
-		c->x86_virt_bits = (eax >> 8) & 0xff;
-		c->x86_phys_bits = eax & 0xff;
-	} else {
+	    (c->extended_cpuid_level < 0x80000008)) {
 		if (IS_ENABLED(CONFIG_X86_64)) {
 			c->x86_clflush_size = 64;
 			c->x86_phys_bits = 36;
@@ -1078,7 +1069,13 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 			    cpu_has(c, X86_FEATURE_PSE36))
 				c->x86_phys_bits = 36;
 		}
+	} else {
+		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
+
+		c->x86_virt_bits = (eax >> 8) & 0xff;
+		c->x86_phys_bits = eax & 0xff;
 	}
+
 	c->x86_cache_bits = c->x86_phys_bits;
 	c->x86_cache_alignment = c->x86_clflush_size;
 }

