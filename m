Return-Path: <linux-kernel+bounces-35321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC28C838F75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298DB1C27D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD025F867;
	Tue, 23 Jan 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z0A6fDd8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bu77tmJx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CC35F565
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015411; cv=none; b=bvzgZJysB1REmwRJUimLkKxeT+C1ZCUtbN3G9H8uh4r2pXqcXAQ3vYLpgzGhkvyhec4cERCbYD+5i3rpxhS8qT+Kxt+rt3WYOAxNEjWOJG1UhekS7ICY6vnsq0hmlYZUcEsxsrTKWvgYSDaEVkVfGxgNYCP02SsXozRwertlmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015411; c=relaxed/simple;
	bh=U/DLxChlLCqthW3vHjb7aMN/pen6F2q2GTJKDqPUa90=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OSjdIwvOH5Dm/xyRLsWPP0h+brz2sfzWCnrZ45I7GsU+U/UlA7hmTqVrqbr+07RGvCfhjOV1XyIOaYcRS33C+iv3mHR3w6pOoJ9yzlNUoVm1aJhnki6Eu7VA+1hqYdEpKNtgELf2/14dY5OT3FQswPwD332AZSychiroPWOMRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z0A6fDd8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bu77tmJx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.535095752@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KJq1l3J+hbdWy27msXWjqYqAfuetS1dX1b6xZhUavIg=;
	b=z0A6fDd8qGqLw3H0ZY86DRyRgV1uCF9IRdrCnnKcWAVEyPBt5d6eaQxBjy+sv2LAFZ8cH6
	rJx0l3l/SiEgh7EsEGwa9XGRX+WPPkJT4XP4IFpuT9XuzFJv422B+bCPJDwm+YGv5oNTCs
	x6d+FqbrPqK5LzhBZ101o3E4Mfm6Bg0hy5TK9RQIj7DEeUQD3fwoobuxbrxGrnWdY77YRk
	GQsnnWcnhAS6rOTi6tI1xX/ONW8n2iuTnhudPBIPcHCDWSREi4kZxNWDbY+rwYMsIjiJfo
	vrGNRTTvFHVf1tOFOq1ann9JjVpZjhxToAj2bAkAyCNJNRtB60MIeK6FtLdb0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KJq1l3J+hbdWy27msXWjqYqAfuetS1dX1b6xZhUavIg=;
	b=Bu77tmJxmSiXm9N6qoZF9RZ2pRXPOwgBTrfk/tPVXsBN8RX/1lfNe2BU8zKBs551FzkzIv
	dTrw5MSQLpRnU3Dw==
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
Subject: [patch V2 03/22] x86/ioapic: Replace some more set bit nonsense
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:07 +0100 (CET)

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


