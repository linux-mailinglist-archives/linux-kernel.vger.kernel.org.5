Return-Path: <linux-kernel+bounces-81342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718E867483
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E27B1C2822E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE775604D8;
	Mon, 26 Feb 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAxVLl/r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cU85OEgu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7BE604A6;
	Mon, 26 Feb 2024 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949569; cv=none; b=lNt/LQqVl/IinGkHcw76gsafSESr/uc1dAgv1PVAMBnbQ9vNQf4H8MK+SdXsRcnbenHTcN8I0SkdI/HTEcIE7r/3Mwx0TfVeEuxQikuItIzclIOds119MIyLKCpTkjJLvMhwya5WwpOL0XxMFfMRrXdCzh8miZ5qgf8SnHK7PWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949569; c=relaxed/simple;
	bh=bwRzofoQc1RDGlHqXnA41HlMJKkt5r3QOFjZX8uCq8Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LM4ngieT4eYsQn0cl8kWZae04Fbi8KrjCaNlhGBEJYGMxSlM/ihRZ1D6AKMIy6zhrsl+G/Ioqpayia5gQoZskX2oBrNZuEPV8hXfTSwMt/S4uY03ICDTAb6ppAUW9M9GE0Z3QsQWSBeUC3KX2qLZhHAxoDXLkQNINDt3jDkrnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAxVLl/r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cU85OEgu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 12:12:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708949566;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCS5+J7KvMvad6FLXR5WOTfaQ75X+hv4sRaw/+/OesA=;
	b=hAxVLl/r47Bmd1s1tEBB83qwc/2lyryrzayVM2DoRgQOmNU7YUmPI2pnsVzk6gIAZUrRcn
	W+7zPWsCiPrZN7HzRMa9Ct4HA3QR22YtWwO1d0MqdeoQTcfPyIF8xndKGa1evfyert4iHP
	HWGCCF0YBNRDJy0pI1GErArBZJkHc102pHc6+iTcIfzYlO/iRKSu5L5cpLCA3L8xVg0N3Y
	vHTN+rMQML+5l/p8Y7lQsN/iwit8FTufQDBMvM93tkrQ/T2oG5dqeMpYYPM/pI0c8znqNt
	ilSw1AU8IySpMhes8gyrgc2j4ot6LHObO3cC/mv8dV5P125T6s2FIhf29Tt/bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708949566;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCS5+J7KvMvad6FLXR5WOTfaQ75X+hv4sRaw/+/OesA=;
	b=cU85OEguit2eLo1qNz+mHPbsigTgUdRXFtsqeD8grVMzakybyrU1SKLS614zYqTXuPBZ5K
	O0M+riZyfIxo31Aw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/64: Use RIP_REL_REF() to access
 '__supported_pte_mask'
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221113506.2565718-22-ardb+git@google.com>
References: <20240221113506.2565718-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170894956531.398.13914554549519966538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4f8b6cf25f5c119b117cb2a4bacb604a6cd00ff1
Gitweb:        https://git.kernel.org/tip/4f8b6cf25f5c119b117cb2a4bacb604a6cd00ff1
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 21 Feb 2024 12:35:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Feb 2024 12:58:35 +01:00

x86/boot/64: Use RIP_REL_REF() to access '__supported_pte_mask'

'__supported_pte_mask' is accessed from code that executes from a 1:1
mapping so it cannot use a plain access from C. Replace the use of
fixup_pointer() with RIP_REL_REF(), which is better and simpler.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240221113506.2565718-22-ardb+git@google.com
---
 arch/x86/kernel/head64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 2ac9041..e2573dd 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -177,7 +177,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
-	pteval_t *mask_ptr;
 	bool la57;
 	int i;
 
@@ -259,8 +258,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
-	pmd_entry &= *mask_ptr;
+	pmd_entry &= RIP_REL_REF(__supported_pte_mask);
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 

