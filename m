Return-Path: <linux-kernel+bounces-35339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA693838F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900B5B26C69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD860DED;
	Tue, 23 Jan 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pQRz7I5z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="71JUgUxs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592760BB4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015439; cv=none; b=eYiHgXDjFS24aeX6hSjYRqkUrz6SNFnuqAATfx8GJVjqLKwq8NzCrtJUpPu+VqiKxPl9Kiotgps0GLLd4ZFseLB50eN2RjmnX5/oF9ueSaeFN07LvmEGQPvHx6olkCKazJjJww/v6xSHjS/zy+ZFJfE9XDlQgcij4Vbp8TIPTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015439; c=relaxed/simple;
	bh=xSUFl6k2v6b6iyk8OXHK+cvV476IKjr7Rgvj8ipUhxc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UM8ucaZUDGk1rUChWoHaCf+kPRrmZpFcig18pa4rrBuDymqR1RazbwdWxMbNvlAFQhySoukb4kWO5RbV0ARUuw8qAc6vkOohTLjgaiE+qFe2FY9XzZLgzE/s6ZrT7rF/4ufTe5wZZzukxss4VNCZxfmQ+MmqERYeUQb8nTY5WWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pQRz7I5z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=71JUgUxs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.626512913@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=L2yR3QPkaltv7mMtMceyAHOtzkS3ODMgDt2gAJj1pxA=;
	b=pQRz7I5zXDLYWXbN/vNPO6MTwtXI5M6LUfSx5i9M6Ans7SSKil78CEaA5cdFW3TEEpEovf
	8gzdfXDXIvWOb1DLmabOPfQ7mZ6fSq6quKaE23gxOm8XNi1TXT5SWQVIM+Gv3fs1WZN7Tk
	FFO3DkCFVdZGoQcig+FYfs0RukIqLI4C/Y6yJAW0mRBMfjESAaAx2JT/xICY6oio74X+ey
	5pywxwkwbllUa8G1Pvin4+GAZHmG920CjuSYaWq9bWi0KEz8zNWlu4hJNGsFY5POlIz+Rz
	t3awguyUlH3k5b+WJOkXQTEheqI0oyyRwvzUh8o93b1BbXDYP/+w8DXTLFPnJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=L2yR3QPkaltv7mMtMceyAHOtzkS3ODMgDt2gAJj1pxA=;
	b=71JUgUxsZz3ImMgD4uJqXazo+Gaf2gnMvGlwo/bMtJ1d8ixzyXiXJc8HuFwXbvP8H78P/3
	/lXgH9OKbxYonDDg==
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
Subject: [patch V2 20/22] x86/apic: Remove the pointless writeback of
 boot_cpu_physical_apicid
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:35 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

There is absolutely no point to write the APIC ID which was read from the
local APIC earlier, back into the local APIC for the 64-bit UP case.

Remove that along with the apic callback which is solely there for this
pointless exercise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/apic.h           |    1 -
 arch/x86/kernel/apic/apic.c           |    3 ---
 arch/x86/kernel/apic/apic_flat_64.c   |    7 -------
 arch/x86/kernel/apic/apic_numachip.c  |   12 ------------
 arch/x86/kernel/apic/bigsmp_32.c      |    1 -
 arch/x86/kernel/apic/local.h          |    1 -
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    6 ------
 arch/x86/kernel/apic/x2apic_uv_x.c    |    6 ------
 arch/x86/xen/apic.c                   |    7 -------
 10 files changed, 45 deletions(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -294,7 +294,6 @@ struct apic {
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
 
 	u32	(*get_apic_id)(u32 id);
-	u32	(*set_apic_id)(u32 apicid);
 
 	/* wakeup_secondary_cpu */
 	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2485,9 +2485,6 @@ EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid
 
 static void __init apic_bsp_up_setup(void)
 {
-#ifdef CONFIG_X86_64
-	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
-#endif
 	reset_phys_cpu_present_map(boot_cpu_physical_apicid);
 }
 
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -61,11 +61,6 @@ static u32 flat_get_apic_id(u32 x)
 	return (x >> 24) & 0xFF;
 }
 
-static u32 set_apic_id(u32 id)
-{
-	return (id & 0xFF) << 24;
-}
-
 static int flat_probe(void)
 {
 	return 1;
@@ -86,7 +81,6 @@ static struct apic apic_flat __ro_after_
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
@@ -155,7 +149,6 @@ static struct apic apic_physflat __ro_af
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -38,11 +38,6 @@ static u32 numachip1_get_apic_id(u32 x)
 	return id;
 }
 
-static u32 numachip1_set_apic_id(u32 id)
-{
-	return (id & 0xff) << 24;
-}
-
 static u32 numachip2_get_apic_id(u32 x)
 {
 	u64 mcfg;
@@ -51,11 +46,6 @@ static u32 numachip2_get_apic_id(u32 x)
 	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
 }
 
-static u32 numachip2_set_apic_id(u32 id)
-{
-	return id << 24;
-}
-
 static void numachip1_apic_icr_write(int apicid, unsigned int val)
 {
 	write_lcsr(CSR_G3_EXT_IRQ_GEN, (apicid << 16) | val);
@@ -225,7 +215,6 @@ static const struct apic apic_numachip1
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip1_get_apic_id,
-	.set_apic_id			= numachip1_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
@@ -260,7 +249,6 @@ static const struct apic apic_numachip2
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip2_get_apic_id,
-	.set_apic_id			= numachip2_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -72,7 +72,6 @@ static struct apic apic_bigsmp __ro_afte
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= bigsmp_get_apic_id,
-	.set_apic_id			= NULL,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -16,7 +16,6 @@
 /* X2APIC */
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 u32 x2apic_get_apic_id(u32 id);
-u32 x2apic_set_apic_id(u32 id);
 
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -237,7 +237,6 @@ static struct apic apic_x2apic_cluster _
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= x2apic_set_apic_id,
 
 	.calc_dest_apicid		= x2apic_calc_apicid,
 
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -129,11 +129,6 @@ u32 x2apic_get_apic_id(u32 id)
 	return id;
 }
 
-u32 x2apic_set_apic_id(u32 id)
-{
-	return id;
-}
-
 static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
@@ -149,7 +144,6 @@ static struct apic apic_x2apic_phys __ro
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= x2apic_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -745,11 +745,6 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static u32 set_apic_id(u32 id)
-{
-	return id;
-}
-
 static int uv_probe(void)
 {
 	return apic == &apic_x2apic_uv_x;
@@ -769,7 +764,6 @@ static struct apic apic_x2apic_uv_x __ro
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -33,12 +33,6 @@ static unsigned int xen_io_apic_read(uns
 	return 0xfd;
 }
 
-static u32 xen_set_apic_id(u32 x)
-{
-	WARN_ON(1);
-	return x;
-}
-
 static u32 xen_get_apic_id(u32 x)
 {
 	return ((x)>>24) & 0xFFu;
@@ -131,7 +125,6 @@ static struct apic xen_pv_apic __ro_afte
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= xen_get_apic_id,
-	.set_apic_id			= xen_set_apic_id,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 


