Return-Path: <linux-kernel+bounces-35327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F478838F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20421C28E21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965245EE96;
	Tue, 23 Jan 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KKKGqRkL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HE4UlPf0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFA5FEE9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015420; cv=none; b=bmpKDple4Wl2yaWybFBbJtdVwwcpCgDkqm2WLN3iCCuwT3Kj1ZZRJ0/5TZTk3xddq0G8lfvobotwxUxSHYsAWBqVI+uoS6YJkx2N4FSt62acsRtM26HnX7qWHEedq4Jcr0GBib0ODx0L9+N+hU5stJ8XbJYmm5YfshZnu8x8T/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015420; c=relaxed/simple;
	bh=8/9AT6w0xCJzI74xv2cmdwC/cHdzGLu6XEZStquJ4yg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dS+NPjrJvRJbQ/W7T6ewF7Jzx9gGEr/QtdYglJ8Lf9hOvoGqCyZfW+IFXxTNhz0fU3S/CGPBNQ3Zv5tdZ1okxhVnc0X6DnnV+k154fXZpcHMSZIyz0MBTb1JTDoS9ULGoa3xgH1fOqFyigECcHdYK8T/8TD8Aulx+OOtR7ZJGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KKKGqRkL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HE4UlPf0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.927155781@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bRgmXs+56yJEF5PEv7SG7Fq+u7m+TGXMYIqXktbgFqw=;
	b=KKKGqRkL3dl5y5KF6LvMY4Aq7/NVXIf33dC4xBLUpU76nmQ1qMcWNsyjPjluZlN1PGXWDE
	xZcaLBITZD//b1g1p25+A2Jp+6j5Wmc8XBcYFLwVqKghcpYfTLop1KZJrCzmOBmwVEaXLI
	HjG2gy3DzUnyro4NDenqrJ9M8LMac7QTVrBmXpX61xz/l7xeUTyts0RMRxtEDGQAVJ78oz
	kaIwtgKdB2QT/Iqi2M2mDvyK5DIvzYBuoWZY7BAGRchmlvHPDxg7B0hq8wRq/q/ZgkOu4A
	iznojSjEwlepifrpvIemeemCJDvl7cZHeeNUVYc/U1Iv+Ve/18cJi/iWOl5Q6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bRgmXs+56yJEF5PEv7SG7Fq+u7m+TGXMYIqXktbgFqw=;
	b=HE4UlPf00yEpostilkTCrW8i3+JeCIHvbp4iL4iMfw3pBraxxa/h7AOQ4pTGFfatSijVrZ
	uNjp+q8X17FZQvCg==
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
Subject: [patch V2 09/22] x86/mpparse: Provide separate early/late callbacks
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:16 +0100 (CET)

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


