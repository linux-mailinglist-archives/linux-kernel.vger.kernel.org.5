Return-Path: <linux-kernel+bounces-35281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F41838EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954B3B24331
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852A2605D7;
	Tue, 23 Jan 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xsTodtkB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ixWbFge"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E119604D6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014438; cv=none; b=DkZ9DWhyOSeq2vbk4jSwbBqQzbHwTuOEklSmyFWtaa28fvb76l7kSe5/BMl1ub646MJ/jRkr/ESxdkJBmESSekxerfxY/dFnBuSLE33/5uuQ9w+MPQmL5Nb3xExJT6UHCgcktuHURLQbrp/GoR1fkFX1wVTJUyHPQcrnR92K60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014438; c=relaxed/simple;
	bh=AEkyGqvQxZvvnLheJ+2RsHCBjK//W9SgFIwdXPvgaWs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=q4DUprjhbaeODkdoGG9Ll1LzAAKu7GySmyeIIe06G/WxP3oC8a5dl+q4stOQT0gjK1y8HEVc6smC9eZbq5THtLsVnEKtJjSHGt4gFLKRseGqnjmVH6sb2Bvl56QS1TapglPMZxUPo3oinEiTslxLK7zbx7nkqbjq8F2kSB4NJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xsTodtkB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ixWbFge; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115909.337697156@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uV+ip67x+Ju70E82zPTuRlEtqmL25y3HTAwmTVToZH8=;
	b=xsTodtkBe+S8NIX3G5ZldqUFBkqsEehEY96jhuFD7OdLXgbNdJuHKaaYDrMV7GFnhNq+vv
	SdcrwVQgHgNY4VcOl7nOApSoDN4GYAw8LIvZoxKUIBvSSUra1vkmoasOGKE5RM4QgcrD6g
	SwahfZOMuWQ65fqIfg43v6KjQl/cUpz8eeVi4AbexhJ4YNdX3AN7Zgb/1xRfLF96CYCVww
	QttvSLNoys8UtFYQj8zG03kD7lrII/oBEvv9oXCUpFSX3hP73JQLmGuQ+s+bXRXrc8t41B
	uHFbJP/qU+FrsamXeRDBgMQuDN2JdTzuy/T82v8WTSD6K66vdGcsoyZ2tlHSTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uV+ip67x+Ju70E82zPTuRlEtqmL25y3HTAwmTVToZH8=;
	b=3ixWbFge7/xPU/BX6nHvWPaNlvw6PFzA/W0mxlfQPb++cTYz5iCLKE3YjL5wWJBSNjpjmO
	5dDKfJkI0ds5i2CA==
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
Subject: [patch v5 16/19] x86/cpu: Remove x86_coreid_bits
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:55 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/include/asm/processor.h |    2 --
 arch/x86/kernel/cpu/common.c     |    1 -
 2 files changed, 3 deletions(-)
---
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -122,8 +122,6 @@ struct cpuinfo_x86 {
 #endif
 	__u8			x86_virt_bits;
 	__u8			x86_phys_bits;
-	/* CPUID returned core id bits: */
-	__u8			x86_coreid_bits;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1752,7 +1752,6 @@ static void identify_cpu(struct cpuinfo_
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
-	c->x86_coreid_bits = 0;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;


