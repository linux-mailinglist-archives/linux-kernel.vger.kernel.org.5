Return-Path: <linux-kernel+bounces-68838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F578580D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10ABA286D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E814C583;
	Fri, 16 Feb 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K6bJAlo3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AYcL8YEr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353414AD09;
	Fri, 16 Feb 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096647; cv=none; b=fSHRukjkZGm/B0khlvcjNlixg2+gLMtvZ9FKvCOy1qz4Za2on743T3NzaQD9dmtpaGCP760PhIjwqBrt9VzHDm/AE0j1E7fzhVCoEchYt7t8cRUNo3yYlbWu5sPGT+rN0MnlZqjO/QG1J9IVtcfNebk0gYFk7EL2hILqwMWONCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096647; c=relaxed/simple;
	bh=CbxqfD57ahlDGsg/W1qoVAKxsYbkt8WtKjjubMB/bKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nG8GPcQI0Kp4fCbX4NYc2VtXAj4h/eehaTQ3+VKnm0JyUO3AjbR/e/yB7qGiC2o9wvc8M/H1/UPXy1GdzkBaPJtO1BHrUnVOQYjeXX2+E1e1f4acwgpe1GrNbAahfR1R+yk1BI2q7IhdQZNxeD4bQlvjgg5J0D8iWooY8Tj+9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K6bJAlo3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AYcL8YEr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTFyXwwlOioHRxjIX6ke3k85czRHtWlk/dgGaN7PYFQ=;
	b=K6bJAlo3psYcoubVQZeE1mz9TdyQfUO48i9jyRS2st8zT5fP+yIzisq8Li62iDpNgJTRHs
	OfY0BIvm9ZgR3S8Z98eXtP+XOZmlhgrZVwAP9gteRZQhVltb9iSCQMO21O5FP9gztxN0Xa
	XQvC5o6sOR3RaFuIVZ1VXTCAAfovVt4z+gTN1m+aZaM11I+ksBFKZ3Caer0wZDJboF0C2R
	uofa/8VbhNINKSla1KUhxKZs7d2d9d1TptidP8AHLxB7q1tfnmqA09iHzrfFITcI8iDYLm
	eU0GTzfvupjWgxb5wgskv4WMvMIPEuYTOryzHgaZoOnsMeCnm402+FkcmLMmGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTFyXwwlOioHRxjIX6ke3k85czRHtWlk/dgGaN7PYFQ=;
	b=AYcL8YErtQ1RnZ5b3Kosu7H9XtE+gaavvmGJGbI9BgdCp2SX6/1Y3bPJ1Ml6u4Jf/2vAvQ
	4LOGZevvEC/m95Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Replace some more set bit nonsense
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154638.995080989@linutronix.de>
References: <20240212154638.995080989@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664295.398.9551739358512163557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2ac9e529d76a8534fa357e723942dd3f076c37da
Gitweb:        https://git.kernel.org/tip/2ac9e529d76a8534fa357e723942dd3f076c37da
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:39 +01:00

x86/ioapic: Replace some more set bit nonsense

Yet another set_bit() operation wrapped in oring a mask.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154638.995080989@linutronix.de



---
 arch/x86/include/asm/mpspec.h  | 3 ---
 arch/x86/kernel/apic/io_apic.c | 6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 4b0f98a..9bf1e75 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -86,9 +86,6 @@ typedef struct physid_mask physid_mask_t;
 #define physid_set(physid, map)			set_bit(physid, (map).mask)
 #define physid_isset(physid, map)		test_bit(physid, (map).mask)
 
-#define physids_or(dst, src1, src2)					\
-	bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_LOCAL_APIC)
-
 #define physids_clear(map)					\
 	bitmap_zero((map).mask, MAX_LOCAL_APIC)
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index e71745e..b62c7ee 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2494,9 +2494,8 @@ unsigned int arch_dynirq_lower_bound(unsigned int from)
 #ifdef CONFIG_X86_32
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
-	union IO_APIC_reg_00 reg_00;
 	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
-	physid_mask_t tmp;
+	union IO_APIC_reg_00 reg_00;
 	unsigned long flags;
 	int i = 0;
 
@@ -2542,8 +2541,7 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 		apic_id = i;
 	}
 
-	physid_set_mask_of_physid(apic_id, &tmp);
-	physids_or(apic_id_map, apic_id_map, tmp);
+	physid_set(apic_id, apic_id_map);
 
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;

