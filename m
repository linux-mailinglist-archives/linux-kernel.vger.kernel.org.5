Return-Path: <linux-kernel+bounces-64264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC016853CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16132B257DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04967C44;
	Tue, 13 Feb 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QH1F94UV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7HnKYKGS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B86216B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858298; cv=none; b=L/opfwcF8Ad6EylenNWTLU0tEWT0G/JH6xkA5wEYUckrGgdM7MiQuO+CC4FkCy/sfWg32qOi/3c/pEuVVF1BDzfZHsPOexk2ZlrRBpwNE/7WLta9FCFmTisH83aAz0NQiDm+e+a1EtaaOfe/Jn4Jz/4IynPntypt3trPbvDAdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858298; c=relaxed/simple;
	bh=bZ3Lsv6X9bv7EA18HKzbW7ZxzwC4tsHSaKq0hcHmERE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=m7CFgl/ArDWg70wj5YOGp0vc9eSVOVy1nHarJJXeX+7wPFNlS4IynYpqrkkDZelAJZSN8s5KgJNWuSRVoOVTgAmL8i/CKIvvbrVbhh7krYvQrqsd09Ob9SMAEgp+4BsDumnKpY0RpiQA0l7hSGDKvK5otIG4UOIai4fVPFfcMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QH1F94UV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7HnKYKGS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154638.995080989@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jUZlkCc/jvJdl89X2GtPdPNSmaXo0cCqu9OLjZmb7Lc=;
	b=QH1F94UVw+6NVB+HHB9GcZL3lwyRVW0EdwWdQQaiP626+rIiROmZf1q8IpbV8uwAjZZA0x
	P2RU2UIycP8y1OF7TcxCB239yreBwQEBgWYB70IALNV1QiKMq2LPCp9aZVLYWql/YrSY4y
	Z6PPEnEIdSyVhc33dlL+2KCQXiuq2Qc2+aVJ5Xb43HNGjw+fhhIg/8G7axPTOUq8nYZYMP
	nGqo7zEKv8U3lDMW8UyYQ2Dy3JxUBIg+ysNVP/2HxfkXd3ASbGtgNEFdAGZYK9EA+1aqVy
	8ntnAPNbdVy+VYJ2F/4NVWcn8CwTUBqK8N1RAOcbY5DyZ6fUO9X41l3mn7NmnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jUZlkCc/jvJdl89X2GtPdPNSmaXo0cCqu9OLjZmb7Lc=;
	b=7HnKYKGS92RlEqyxHgo3cF+p3yPiy/0rnPeURo0ExhLCpJfj0swFqXli3TIhzP/mgYQ/43
	XVbKCLa+Vn3zmGAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 03/22] x86/ioapic: Replace some more set bit nonsense
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:55 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Yet another set_bit() operation wrapped in oring a mask.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/mpspec.h  |    3 ---
 arch/x86/kernel/apic/io_apic.c |    6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)
---

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -86,9 +86,6 @@ typedef struct physid_mask physid_mask_t
 #define physid_set(physid, map)			set_bit(physid, (map).mask)
 #define physid_isset(physid, map)		test_bit(physid, (map).mask)
 
-#define physids_or(dst, src1, src2)					\
-	bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_LOCAL_APIC)
-
 #define physids_clear(map)					\
 	bitmap_zero((map).mask, MAX_LOCAL_APIC)
 
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2494,9 +2494,8 @@ unsigned int arch_dynirq_lower_bound(uns
 #ifdef CONFIG_X86_32
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
-	union IO_APIC_reg_00 reg_00;
 	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
-	physid_mask_t tmp;
+	union IO_APIC_reg_00 reg_00;
 	unsigned long flags;
 	int i = 0;
 
@@ -2542,8 +2541,7 @@ static int io_apic_get_unique_id(int ioa
 		apic_id = i;
 	}
 
-	physid_set_mask_of_physid(apic_id, &tmp);
-	physids_or(apic_id_map, apic_id_map, tmp);
+	physid_set(apic_id, apic_id_map);
 
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;



