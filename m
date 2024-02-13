Return-Path: <linux-kernel+bounces-64297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA7853CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC121C230C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E780615;
	Tue, 13 Feb 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTe89Xjw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rc+ZWqrM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F127E76D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858353; cv=none; b=LFf7/m2VbUPu0VrhKFytED836/bRwoZLYbLAcr8Yoy/5vmVRQm/tq9fJL01Nx7csBo5lQi1/ybIjcAFX5ebfAEsIeNLmaE3TSS1Yvbf5n008PpGgOY2KAkvmckZ2FbZ4FW2O8bDpI3eLJaLSUPu6BVJR/zELCtUR68cZDZRQ0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858353; c=relaxed/simple;
	bh=R/gkXFCa7QGppvkzNKvypYWWUarLK4WF7H1CZllLDnI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AJlPQdFXtYF+wVpnLKUTQxe4FyZaDIlyEGKRua4nGTJlAcPd3cAPgTIbV/a58T1PfYhWeTouOY1x8PTVkMFPbcNJNV3P1bsJgO/TZY2fLVdnwRyPxDw14rWvMqO5j9dCEIjk2o/xG9eQEwdXWU+G2GvwM9ogPFzoEFWleBVdv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTe89Xjw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rc+ZWqrM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.170806023@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B36m24M4ceBkId72kqabGdQ4QnOj4P1IRr6RI4djRX0=;
	b=eTe89XjwswmLTEZXp4GBgTPgUqu7/kJ86OAYnAsJ0r+4KwmEvrE38VqJiul34/OiRpkju1
	XOsRW5ceSiPdGrSZBt5yN/m3zWS0of29JRqm4rA5qBmZeeVCfNe+x8IIPpokk2cQJnRe6z
	bi8Wxu7hm6qrBY39++yWeKw1T34Jey95jMj6J3VVhzbrTOPFwiibqTLk8xNpNRHukiqNXY
	gA9coNsaqsTVJ7k8GU779PKG/gZxJ7r0O9MfNbdgLzPjJFlRL0zk8vxMxPM095hkRANXzE
	mupfQj/8lPLAY1/yb/4uqwdu4HWE2BDjGPyHUR8jZw7PktHC1mA/yUj50Uj/1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=B36m24M4ceBkId72kqabGdQ4QnOj4P1IRr6RI4djRX0=;
	b=rc+ZWqrMgaPp6cWD5WnAtrvpaWOyNa3PPcd+03tDCUDeVyP3JPmDJhHMkrvuZBvubBi1Rd
	fIwsmFSB++O5x6BA==
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
Subject: [patch 12/30] x86/smpboot: Make error message actually useful
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:50 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

"smpboot: native_kick_ap: bad cpu 33" is absolutely useless information.

Replace it with something meaningful which allows to decode the failure
condition.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/kernel/smpboot.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
---

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1072,9 +1072,13 @@ int native_kick_ap(unsigned int cpu, str
 
 	pr_debug("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
 
-	if (apicid == BAD_APICID || !test_bit(apicid, phys_cpu_present_map) ||
-	    !apic_id_valid(apicid)) {
-		pr_err("%s: bad cpu %d\n", __func__, cpu);
+	if (apicid == BAD_APICID || !apic_id_valid(apicid)) {
+		pr_err("CPU %u has invalid APIC ID %x. Aborting bringup\n", cpu, apicid);
+		return -EINVAL;
+	}
+
+	if (!test_bit(apicid, phys_cpu_present_map)) {
+		pr_err("CPU %u APIC ID %x is not present. Aborting bringup\n", cpu, apicid);
 		return -EINVAL;
 	}
 




