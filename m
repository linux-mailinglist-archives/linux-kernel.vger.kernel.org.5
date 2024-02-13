Return-Path: <linux-kernel+bounces-64289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DEC853CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86BC1C254A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179FE7AE77;
	Tue, 13 Feb 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzBUithN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aMweeaWZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56B7A715
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858342; cv=none; b=X96EqO8Yncg2W9lz13oN3U4NrjkGmR39jni8ixKphhYfIBdwDgFvmIthMW/EdwB5bRgCfEv2WGAKAjHbf49XmZwhXpABvrKUwn6Nq78i2NJJM10OYZYDKfLFL7ixkLtm6qFJlspHTxhGETWH1guMjyM4dCl6S/kbwsCUqaWFjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858342; c=relaxed/simple;
	bh=sO4nt/82A5dDjzT8pZrak8tpN6TVYee6qxAhdOaWWMQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=k7o5OoLlNxQdDhtmAEGBzpZ3Nwog9P49z7pP2aEJKyoiyTFKk/bpKxBlJugiI61oOQocyqqsSJvPcwrfw9Nxkz45spK62EuOyoSv4urd67CTdPo3yCc5v1nkix7uLx13KIsp3y9Sq0YYj0qt6A1AU9li2AOxbe5J3cpRjl13k/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzBUithN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aMweeaWZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210251.720970412@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/kiMUzKyScheTGqyDyzfFDVZrHCgxAZbeMclOVhEQjg=;
	b=TzBUithNCvsi+Ks5REh1gdzTykb/s/xHOINnvNaJk5fwdNm7CUNZ2suPIqkr3/u5EKK68m
	6JSGKzPPz6TKDfqai95T9NA3DZPKpk/2dD7T9a31k686pQ4SWoClmJqKyrxvrmNkao/BQI
	fr5rnwoHdH/DigfzAjurjb/scQMIv74vfjXSKsSnHrGlCzCcOCG8V4ixhbD5RHIXvINrPG
	kRmcrnZFhslYT8Fdpok2kyuhjmS55NPRoc2QauvlxfytifskzW+j/2U16ycwIcObMeDEmb
	vXBo5fPiOfhZMf3pOVwBolsOxjcDUm+HU1cvOqHbYEpC56qN1MOUyBx70S3eVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/kiMUzKyScheTGqyDyzfFDVZrHCgxAZbeMclOVhEQjg=;
	b=aMweeaWZCO41dEGT5qQYA0Hx2jNeNVqI6CzLzQe1HvqFR0GrqaQxReIqHBm0q7uzChplJ4
	RCVcGcdNM2ARUrCA==
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
Subject: [patch 04/30] x86/jailhouse: Use new APIC registration function
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:39 +0100 (CET)

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
 




