Return-Path: <linux-kernel+bounces-35328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A63838F80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4F028E5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81960250;
	Tue, 23 Jan 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0CJKA+0F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JTZgr5g1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D85FF09
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015422; cv=none; b=rHhErCmItLPafAbaU8Nb4CB7ZA6eWpoBF/b3+GPofFJko/pb/+RgDBKYKuBbGHNRxcqCaROgxgRqp05HitHw1EJDzmKSNsjOKJaK1uD0TQfxQKP6hW9phA/6Y1xGH10sEFK5lzHElQu14mDCyt4DXCVUB7Zh+ksLGLsAFTavJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015422; c=relaxed/simple;
	bh=silN7Z0mWATeBr/u5C80Ue3GusfjSlxWIavxaUlWUA8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GRgoBmf/dZcPHzoXG/HAbDPgYQEbPDk+LD93NI1tzJVRfhJ9fuJHoOij+9Fpe2QgTs+YB/i4AWOtBmkKHxvpJz3wKSwbNOH7mHdtfXa+qYUFXRButCkDx5KWELSkH1D8OGOpnN7QuyJPRrCXYFHW2kxVsH+UfDxys0cLj9IBDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0CJKA+0F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JTZgr5g1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.992663226@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5M8pf0IXk2VyMzofjgccZ4PNCk1F6abMBaNgwEELfJ4=;
	b=0CJKA+0FBtzo7KaOJ9JIE7DwXygXPwYzbC7tj/T+r5UwuakzRj5KiKEHmb6P8E7lego44k
	GIyxs4gw3efMWzn1itpjU8eFFeSzQTAf30M475yFN2pMnCYXBtZ+8y7tzm/SGF6AmAUssA
	sD37mSSZer/J4TdjMB6/0DU/qGs1LuGdj7kgnJf6Ji6oBOPR2tqnFObSH029WtGa1aER6Z
	S9OFxgnOdsMuIvn3dyRIuu77wP8iLMTicwnzRCQdBbRfJgprcN5yvbWU96eIUauy0gQVFC
	R3XU2B+jPMVwB4DwWzit7cXNOT59CGo6w85sS3eSA2jwXZdK0h0t2cBVpo7EnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5M8pf0IXk2VyMzofjgccZ4PNCk1F6abMBaNgwEELfJ4=;
	b=JTZgr5g187X0WRwktelWVmTlyf1KcGb5DM0qyKJYx0FxtIOKCjbU+bL10R6AIkvDHiD6oq
	c5IYcH/OOeROG2Cw==
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
Subject: [patch V2 10/22] x86/mpparse: Prepare for callback separation
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:18 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

In preparation of splitting the get_smp_config() callback, rename
default_get_smp_config() to mpparse_get_smp_config() and provide an early
and late wrapper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/mpspec.h |   12 ++++++++----
 arch/x86/kernel/mpparse.c     |   12 +++++++++++-
 arch/x86/kernel/x86_init.c    |    2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)
---
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -60,12 +60,16 @@ static inline void early_get_smp_config(
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
 extern void mpparse_find_mptable(void);
-extern void default_get_smp_config(unsigned int early);
+extern void mpparse_parse_early_smp_config(void);
+extern void mpparse_parse_smp_config(void);
+extern void mpparse_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
-#define enable_update_mptable	0
-#define mpparse_find_mptable	x86_init_noop
-#define default_get_smp_config	x86_init_uint_noop
+#define enable_update_mptable		0
+#define mpparse_find_mptable		x86_init_noop
+#define mpparse_parse_early_smp_config	x86_init_noop
+#define mpparse_parse_smp_config	x86_init_noop
+#define mpparse_get_smp_config		x86_init_uint_noop
 #endif
 
 int generic_processor_info(int apicid);
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -473,7 +473,7 @@ static int __init check_physptr(struct m
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init default_get_smp_config(unsigned int early)
+void __init mpparse_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf;
 
@@ -538,6 +538,16 @@ void __init default_get_smp_config(unsig
 	early_memunmap(mpf, sizeof(*mpf));
 }
 
+void __init mpparse_parse_early_smp_config(void)
+{
+	mpparse_get_smp_config(true);
+}
+
+void __init mpparse_parse_smp_config(void)
+{
+	mpparse_get_smp_config(false);
+}
+
 static void __init smp_reserve_memory(struct mpf_intel *mpf)
 {
 	memblock_reserve(mpf->physptr, get_mpc_size(mpf->physptr));
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -71,7 +71,7 @@ struct x86_init_ops x86_init __initdata
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
 		.find_mptable		= mpparse_find_mptable,
-		.get_smp_config		= default_get_smp_config,
+		.get_smp_config		= mpparse_get_smp_config,
 	},
 
 	.irqs = {


