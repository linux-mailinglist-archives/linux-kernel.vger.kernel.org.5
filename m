Return-Path: <linux-kernel+bounces-130622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFB897AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD91F232EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F997156865;
	Wed,  3 Apr 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDalylfr";
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vc9TB4Kn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5E154C03;
	Wed,  3 Apr 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179551; cv=none; b=PAHFQDR7hZGRn3JonzKSUSDGo2P8/yjbIyvDVmEFr5xdgs/di9TYnCMSB6mL1DR7spsjmkWZcIBC9o/FVoGE2iiMoe925zgHTvk59KOiLfYG05GW9Jmzczwz2nK/w36Aw4J6n75InC6MPSxaIO6IiF1Q1qpWCqp+DVAfvGaI16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179551; c=relaxed/simple;
	bh=QhkKtD1uBAEweDR2IhCb7s3QhV7FjMUyg4DE5gxSXbA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gsrdkzur6WWCu94q/FVuInoxKjoGTcleausQtdcKw1uLnnr6l88KTk9I/rQ7gz2t5jp23j5gPBO/f1t2wYUjmZqattH9yaws+rIH/c97KrQ39hnWOdVGTgyNuNGrRAG0LMZ+yuO0hrMsrwVJij8sa2FYJnyZ58ihN0kQdnBofH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BDalylfr; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vc9TB4Kn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=cPFKl7wUoVzAYU+1z5HHSrJsYx6CbnDKl33923a76CQ=; b=BDalylfrkM9ahJ5DYWKa/KevZM
	yT2u1EY85g+8Cu3cvQtyNmUovpVpj/2Pb8dGo+LuQb3gschbgnNF4aY4DiIKdmykYywt3KjtkuV+s
	24RB8ANmh60Hlgw4YycX+3uYbjZ2qrUi0OzJV0x+K3wcDwg/VhaMkbKBn49jjXqCmcLI0DhLDFM2d
	T8IsNRRgpnmLZcCVeo5rGdudk4Eyn7XbQIWlL5plRdsUIMFieoQAj3AzxTK+ZNHCQIl9bdgdKw4a+
	OyRffy62OIQR2eBnDIaou93Ww8ivhU4NKHGV8YUvmFnud7+Kt4xY3b/fWxAAb95fySBn0WjCVia1k
	xLErqrdA==;
Received: from merlin.infradead.org ([2001:8b0:10b:1234::107])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs86i-00000004R8y-2amM;
	Wed, 03 Apr 2024 21:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=cPFKl7wUoVzAYU+1z5HHSrJsYx6CbnDKl33923a76CQ=; b=vc9TB4KnejhHEeCBoHtZnOxxql
	1nuJjE00e19K/yeqwmu0GrF0rccd5RCmc07eBSU+ic6tKes42YiZVLnRfVe+VTWtlbIouParGrXs+
	rMBeJFXpyYP/0m/oNt9urr5MXzzCXkT12ZXorkXH53+4RldtcV0Sh7tfmkc7mckCAtjU22Bvmpi6G
	dH4sY4HcRGmY/5+2xZOh80T8UZnugv7KLSuD8zhTHBkukdymX5sGN6D3Xqh+/oHTY7JdASSqXn2e3
	zzqcl0RwYAm+iPy7veKqLl8+xUVNrbMcRXifsBRoVoRHZZOK2rV81PSaP/Z1W+kkMh3TwvJ5rxdWi
	lLNE+edg==;
Received: from kyle by merlin.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs7vW-00000007HPW-3Mrh;
	Wed, 03 Apr 2024 21:16:30 +0000
Date: Wed, 3 Apr 2024 17:13:43 -0400
From: Kyle McMartin <kyle@infradead.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org, kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] therm_throt: test bits as we build
 therm_intr_core_clear_mask
Message-ID: <Zg3GhhTZotBNvlRR@merlin.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

X86_FEATURE_HWP appears to be insufficient on some platforms, and
writing 1 to BIT(13)|BIT(15) results in the wrmsrl trapping and failing
to clear PROCHOT_LOG.

Instead, also try to wrmsrl_safe with those bits set in the mask, and
check if we get -EIO back. If so, those bits will trap and prevent us
from writing to THERM_STATUS.

Signed-off-by: Kyle McMartin <jkkm@fb.com>

---

We noticed a problem on some of our production hosts while rolling out
6.4 kernels where we were seeing PROCHOT_LOG set but never cleared,
along with a warn on once in wrmsr.

I tracked this down to:

commit 930d06bf071aa746db11d68d2d75660b449deff3
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Tue Nov 15 18:54:17 2022 -0800

    thermal: intel: Protect clearing of thermal status bits

which started setting some unexpected bits in THERM_STATUS on our
platform. Previously, the mask had these bits set, but we were masking
with the MSR which was resulting in them not being written to 1.

Starting with 117e4e5bd9d47b89777dbf6b37a709dcfe59520f, these bits were
protected by the HWP CPUID flag, but on some of our platforms, this
doesn't seem sufficient.

On Broadwell and Broadwell-DE, the HWP flag is not set, but writing
these bits does not trap.

On our Skylake-DE, Skylake, and Cooper Lake platforms, the HWP flag is
set in CPUID, and writing 1 to these bits traps attempting to write
0xAAA8 to MSR 0x19C (THERM_STATUS). Writing 0xAA8 from userspace works
as expected to un-stick PROCHOT_LOG.

On our Sapphire Rapids platforms, the HWP flag is set, and writing 1 to
these bits is successful.

 drivers/thermal/intel/therm_throt.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index e69868e868eb..3058d8fcfcef 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -196,8 +196,14 @@ static const struct attribute_group thermal_attr_group = {
 static u64 therm_intr_core_clear_mask;
 static u64 therm_intr_pkg_clear_mask;
 
+/* Probe each addition to the mask to ensure that our wrmsrl
+ * won't fail to clear bits.
+ */
 static void thermal_intr_init_core_clear_mask(void)
 {
+	u64 bits = 0;
+	u64 mask = 0;
+
 	if (therm_intr_core_clear_mask)
 		return;
 
@@ -211,25 +217,34 @@ static void thermal_intr_init_core_clear_mask(void)
 	 * Bit 1, 3, 5: CPUID.01H:EDX[22] = 1. This driver will not
 	 * enable interrupts, when 0 as it checks for X86_FEATURE_ACPI.
 	 */
-	therm_intr_core_clear_mask = (BIT(1) | BIT(3) | BIT(5));
+	mask = (BIT(1) | BIT(3) | BIT(5));
 
 	/*
 	 * Bit 7 and 9: Thermal Threshold #1 and #2 log
 	 * If CPUID.01H:ECX[8] = 1
 	 */
-	if (boot_cpu_has(X86_FEATURE_TM2))
-		therm_intr_core_clear_mask |= (BIT(7) | BIT(9));
+	bits = BIT(7) | BIT(9);
+	if (boot_cpu_has(X86_FEATURE_TM2) &&
+	    wrmsrl_safe(MSR_IA32_THERM_STATUS, mask | bits) >= 0)
+		mask |= bits;
+
 
 	/* Bit 11: Power Limitation log (R/WC0) If CPUID.06H:EAX[4] = 1 */
-	if (boot_cpu_has(X86_FEATURE_PLN))
-		therm_intr_core_clear_mask |= BIT(11);
+	bits = BIT(11);
+	if (boot_cpu_has(X86_FEATURE_PLN) &&
+	    wrmsrl_safe(MSR_IA32_THERM_STATUS, mask | bits) >= 0)
+		mask |= bits;
 
 	/*
 	 * Bit 13: Current Limit log (R/WC0) If CPUID.06H:EAX[7] = 1
 	 * Bit 15: Cross Domain Limit log (R/WC0) If CPUID.06H:EAX[7] = 1
 	 */
-	if (boot_cpu_has(X86_FEATURE_HWP))
-		therm_intr_core_clear_mask |= (BIT(13) | BIT(15));
+	bits = BIT(13) | BIT(15);
+	if (boot_cpu_has(X86_FEATURE_HWP) &&
+	    wrmsrl_safe(MSR_IA32_THERM_STATUS, mask | bits) >= 0)
+		mask |= bits;
+
+	therm_intr_core_clear_mask = mask;
 }
 
 static void thermal_intr_init_pkg_clear_mask(void)

