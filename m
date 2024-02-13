Return-Path: <linux-kernel+bounces-64270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AEC853CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDD11F2828A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B3626AE;
	Tue, 13 Feb 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jk0AdUFr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gh8GYSqI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF926A003
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858306; cv=none; b=IpmoRrYEbAsYxzmLUoQIKWXphH36xdN4xlzSv6D0SLdX8qF/9AYAfj6Ahr1PE7ecH2269Vqg1B0RqFmFzqf9fwKeDuCJ/O34rj9XR41PWCxiNr3LeNeRyS/kmoY543Y1nVETBl9/ZhAwLk46h+YFo8g1PfJSzL9gIFH1J+1Psls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858306; c=relaxed/simple;
	bh=l8RGkcvzLsk2LCgfDaH9KarHeGep9iiW1glCenrkBZw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KUnnyeD/YVeilSYP923FcOXefMD+WDdL1KguYlELr9VTIn4Io+YlX0rL2IS3D2JSW6Wy2OTR38Y0aFR+977dO22LQ5gFi/J+GBAkf1XZnltt4TqsuCAlerTaa6892b6LsPEx87gBjVej0r8RhvW5pdFix4eoZJpvvAse3tKp+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jk0AdUFr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gh8GYSqI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.370491894@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=leAgJYGrQx2PkdvwA0CP55/0I6UB8M3kIZtPOLsqfyA=;
	b=Jk0AdUFr4KzsWc64OldGE6xCnQRGQJEokacsRLlY76ngasnU2nl/myQglZRcw+PCx4RAkS
	DHUHNaVLmGwjJQpUu3Y3q6VdCpIWvaQQRx1HZsckYodBFxnDcGHgzNMqHaiRu+aYOMWwHB
	ig5QpIr+nvTZcqXPsXp5Eb/AGD8y7rUPcaBNGEhnLM5pWE81l0bQnVA2YB8MRKhAHDbmuY
	ZxegM2wEG1JdKLSRIQgaCoDHgMs37EDluZmAcIx1ikQ8oBFzwmYtLvMTRSRYCmbK7AYwGk
	D3l/zO617LJqqM0g7MV+oPRLg6VCQyDe+7MB/Rf15Vs22NfzijvLtKg3Mr99GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=leAgJYGrQx2PkdvwA0CP55/0I6UB8M3kIZtPOLsqfyA=;
	b=Gh8GYSqIiu4iNKfYLbfzNlB6SQtIYnQ/uEK7LgeksHGlDxVDNKzGsuXe83CYAZkD6F+voy
	z7bWBnOezW3PvXCA==
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
Subject: [patch V3 09/22] x86/mpparse: Provide separate early/late callbacks
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:03 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The early argument of x86_init::mpparse::get_smp_config() is more than
confusing. Provide two callbacks, one for each purpose.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/x86_init.h |    4 ++++
 1 file changed, 4 insertions(+)
---

--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -17,11 +17,15 @@ struct irq_domain;
  * @setup_ioapic_ids:		platform specific ioapic id override
  * @find_mptable:		Find MPTABLE early to reserve the memory region
  * @get_smp_config:		get the smp configuration
+ * @early_parse_smp_cfg:	Parse the SMP configuration data early before initmem_init()
+ * @parse_smp_cfg:		Parse the SMP configuration data
  */
 struct x86_init_mpparse {
 	void (*setup_ioapic_ids)(void);
 	void (*find_mptable)(void);
 	void (*get_smp_config)(unsigned int early);
+	void (*early_parse_smp_cfg)(void);
+	void (*parse_smp_cfg)(void);
 };
 
 /**



