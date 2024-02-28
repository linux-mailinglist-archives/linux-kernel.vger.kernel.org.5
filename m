Return-Path: <linux-kernel+bounces-85102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4737A86B070
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0737528AB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321114C5B6;
	Wed, 28 Feb 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jffe1l4Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UngALnpu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DC6CDBC;
	Wed, 28 Feb 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127361; cv=none; b=criSwb6oGesdgNOBKO0KMhGDSxjOoc3WaK5BVwuKW+fKI2gnFfY6uucqpB1FsYhT9dfchWMybCgyxY69NAFbvO1eHoCuAXzXOWNiOCZY6fUb4ad7iHsx68CH+sgRseZSUdGNqboBvjG07AGNyw+AhuaM9Ho5Zi4H0RLbxhCEj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127361; c=relaxed/simple;
	bh=bV7rC9AwyM7rwmPwCODY5JQR5FkAI2361fVWivOoLGU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SB2HQmlJBi7UTch4wutyaI0hcQgV1O9cr7YqytXwM4CtNXMC/Tcho4hUIvjLKC43b4TKsatHzKASXVzGK0TM4m8jNGt+EqFUeFYljisVEGJFvVhDMgr+SCX7nwDa9FYi0awWU0gMc5urOsQLPvR1EanL4amHVwHeYS9acEg3Ic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jffe1l4Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UngALnpu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 13:35:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709127357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3261/azcGbpm0bz+42s7atBucovQYrO3uk/Loe+guZw=;
	b=jffe1l4YFxuIeO1TsvAoU0Vfod9XgZdPHVaq5vDjM2YyGMI8vABMVp1zsBR2xcBzJ02dh+
	xmvKEHdFqEuAoMb+bovewxry9hRbaavzLJu7jC343B4XMH/2fsUeHBqmborh5nNU20+OUv
	aVAf+02PEMt4SKsdtsbn4SXHo0Zn8+N+lDcMT+A9FenzIQZThSi6CzoYe1jFHlazu1Ogjs
	s+yi6UK9NaJ2hTrRt3Z2zoSiZg0y4GwABTRLthXZEJOMDtvr6CQL41g2D4ICk0tnmOu1Mj
	vetvwJ4wMH1ywrnKD7ovrbwhYCU6rYR1P1EV1OS0lYpTk26ngnRn6G4Kfo5c9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709127357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3261/azcGbpm0bz+42s7atBucovQYrO3uk/Loe+guZw=;
	b=UngALnpu5WnIKr0UlT7Addn9mvStlWFfdsVUj67sBrBGhYvfDZAkA8wJSizXzR515nsXUh
	BoO/cunRrUBjDDBQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] efi/x86: Set the PE/COFF header's NX compat flag
 unconditionally
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240116085347.2193966-2-ardb+git@google.com>
References: <20240116085347.2193966-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170912735700.398.16561638992186941827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     891f8890a4a3663da7056542757022870b499bc1
Gitweb:        https://git.kernel.org/tip/891f8890a4a3663da7056542757022870b499bc1
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 16 Jan 2024 09:53:48 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 28 Feb 2024 14:23:55 +01:00

efi/x86: Set the PE/COFF header's NX compat flag unconditionally

Now that the proper section and file alignment is used, and the EFI
memory attributes protocol to manage executable permissions where needed
is invoked, set the NX compat flag unconditionally.

  [ bp: Remove the "we"s. ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240116085347.2193966-2-ardb+git@google.com
---
 arch/x86/boot/header.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index a1bbedd..b5c79f4 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -111,11 +111,7 @@ extra_header_fields:
 	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
-#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
 	.word	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	# DllCharacteristics
-#else
-	.word	0				# DllCharacteristics
-#endif
 #ifdef CONFIG_X86_32
 	.long	0				# SizeOfStackReserve
 	.long	0				# SizeOfStackCommit

