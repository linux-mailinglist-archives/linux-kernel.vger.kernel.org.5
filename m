Return-Path: <linux-kernel+bounces-35346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3148E838F97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1701F27C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E282E5F852;
	Tue, 23 Jan 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6BedB4S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ffwbn9mF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2164627F9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015459; cv=none; b=rv2Bce7HItH8Um4cPDcA46DsDEZt+AOO3UYi9ulDTWgZhZWB8+JbQZ89wYQ0mTxK3eRO5vs/dENaPGYqoFIo2jAvDttE9Nj3DofdYICffOS25OjsvnIcCNutHorYIpVevlEm371Nqs2A/gM6gYBVVHH+LipHoDQn0XXPbQAGiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015459; c=relaxed/simple;
	bh=1BKSN1DKRpFuwYrUk2DSp5Ep6fmfjgFGAglqD62w0Us=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oeknV7zIyhSBiAo/gdbS9UIlPEq4oFaHtoMAT9eaZwIkcP5GItCaPMGglMplXlewN0y1z/8mdkNSUM3NdNF7gEfKr6neweTcKlOMGpM/Y7gUDjQnLGzme2MvyXGZNBIa0q0If15NQCZPEOHJAZr+7dhT1ogPso4aaP8X/8Le0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6BedB4S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ffwbn9mF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123648.779871266@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=18yKEKGde+iVcK/8qscP13axTMaC1pWtYv9SEapVNnI=;
	b=S6BedB4Sx/6S6Fx5tiCeHsd0n63UmsC4InGxj7OE4CEGf4cH5a+3PkzHoUhrhjGbU6i5PU
	0uD5NcvBNROJaQ17WRy4y4PkzllAjGJ06X2AqYYxdsXV6lpNJoxWSAY6VuGdnCX0OxdHJx
	GFfpGbuwlV06XTLsH3NjIYZCOBXnQDIUlNaucielEAHYmOic1w61bWzMk+StjnCfE8hSsd
	FZD54XgoPOV5AwV8oIe1YaAX2OWJeDCjD5NlSsFyAmtkteMg6GncuVx3VS5Ath7PwTAWtT
	rR67j+OsLliC2HCRT9UCzMWMGmXtYM2bbh4g1LUu6dDaNKokNsuZN2Ngl6PbUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=18yKEKGde+iVcK/8qscP13axTMaC1pWtYv9SEapVNnI=;
	b=ffwbn9mFlIdhoKuy5jcPYwrAQeirwQoirahpTYtilZiq2ChtwDGkL0aRv5jwKX8kU3Exw0
	a3Iw5RYM64CQH9Ag==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v2 04/30] x86/jailhouse: Use new APIC registration function
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:55 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/jailhouse.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -102,7 +102,7 @@ static void __init jailhouse_parse_smp_c
 	register_lapic_address(0xfee00000);
 
 	for (cpu = 0; cpu < setup_data.v1.num_cpus; cpu++)
-		generic_processor_info(setup_data.v1.cpu_ids[cpu]);
+		topology_register_apic(setup_data.v1.cpu_ids[cpu], CPU_ACPIID_INVALID, true);
 
 	smp_found_config = 1;
 


