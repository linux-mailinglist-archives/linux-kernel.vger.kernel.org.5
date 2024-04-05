Return-Path: <linux-kernel+bounces-133656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145189A6B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C305C1C2182F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256D1779BC;
	Fri,  5 Apr 2024 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iwOBc/t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HdmRh/Oa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4241779A4;
	Fri,  5 Apr 2024 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353896; cv=none; b=fahMmP5hBaQDjUgUHuxRaP2wgjOdloKVMBdE+kDI3VhlHjYSzJlA2x6jI7mGPnNcvGfHYVtBK+YP13Gad11JI8GQHEwq3aR8Ey93oV5mama0KZVODoCXZ6jIf7v1LCnFlIHKjXNBqgpI6wZhMBonOVKkcUTsRwcBPxObdU3oG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353896; c=relaxed/simple;
	bh=oKB2qd/NZJAjjB7QeYPo+hX4DK1YgoBLEsQYGwSIwoU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tutDstbTqARfHxUPUNVP3oZWppOtCDJWYyVZ1h/p6kY9qpFikXrfKdLfCiimDtW2Sj/GoXPraDp8lpF0hA5Vx4FWW9retZt9b2dnTU2AbfvdOsMAd38XeVqtXw7Vln86ogISl/Wfa+g00VC4AYsNeywK8qlCpyH/1Ln5k0Hz8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iwOBc/t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HdmRh/Oa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Apr 2024 21:51:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712353892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYs/l19lyE/y5md5pl5/wiWrXS7ul49W9Gipadj6kzs=;
	b=0iwOBc/tRCaHu/3mc71pbVn/xvSEszWoVWSJ165pYlpxxLYlSJtuW7s0pp17GVaG9qQE6W
	drUuDTHWHLH96Lu+4bh8/FF/7n/7zB17N079rK1FGj1bPoEsDhc0WskGwmRmFJ7jqwTo8P
	7Gyjlyzcz0Qt9FhqFvx0vj2XrGHJkXHtlpvjpKf6d8YSmHV8iwsHjisIa5vvO27bygb6ne
	UHUDmla9S7sX37r0AiJ9IvPcD3pOtvEGKChajuuulNUjBmsTfGrO7L4w4eGhmQoaAIK2MJ
	A3w3xVcFj/wggLefcl3gQnv8vYJEuuZeQcz+OCPepP1WiJV6jJyShBF841jnrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712353892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYs/l19lyE/y5md5pl5/wiWrXS7ul49W9Gipadj6kzs=;
	b=HdmRh/OamjGC0j1m1U5z+lZJULEOpY65/GLJrfvKBlR1ELqk/HnaZz0RFjfI1/izqgLeZX
	6QCQUiMESilfNiCg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/microcode] x86/microcode/AMD: Avoid -Wformat warning with clang-15
Cc: Arnd Bergmann <arnd@arndb.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240405204919.1003409-1-arnd@kernel.org>
References: <20240405204919.1003409-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171235389181.10875.6698872044485533713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     9e11fc78e2df7a2649764413029441a0c897fb11
Gitweb:        https://git.kernel.org/tip/9e11fc78e2df7a2649764413029441a0c897fb11
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 05 Apr 2024 22:49:07 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 05 Apr 2024 23:26:18 +02:00

x86/microcode/AMD: Avoid -Wformat warning with clang-15

Older versions of clang show a warning for amd.c after a fix for a gcc
warning:

  arch/x86/kernel/cpu/microcode/amd.c:478:47: error: format specifies type \
    'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Werror,-Wformat]
                           "amd-ucode/microcode_amd_fam%02hhxh.bin", family);
                                                       ~~~~~~        ^~~~~~
                                                       %02hx

In clang-16 and higher, this warning is disabled by default, but clang-15 is
still supported, and it's trivial to avoid by adapting the types according
to the range of the passed data and the format string.

  [ bp: Massage commit message. ]

Fixes: 2e9064faccd1 ("x86/microcode/amd: Fix snprintf() format string warning in W=1 build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240405204919.1003409-1-arnd@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 13b45b9..620f0af 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -465,7 +465,7 @@ static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, siz
 	return !__apply_microcode_amd(mc);
 }
 
-static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
+static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct firmware fw;

