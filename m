Return-Path: <linux-kernel+bounces-35355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C068838FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0943AB23084
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3F5FB8C;
	Tue, 23 Jan 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvBKomLL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wB07tUSJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C3634FF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015473; cv=none; b=T3pOWgYxmUbwOx5bJTqVgMtS7sUUxyaoisO/Ad9abZz/uMbiHADez1y8NBw3q6KF4RuhMTMi/J9PqAruh2X+I5Z+ijLTf5KFpWBHB7vwCiyZan0Nt38fLgp2UoR6iVJOdMzo/SG8zMy3BlJwmMrOSx6U0SZRv5ykyBIsw8lYcb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015473; c=relaxed/simple;
	bh=pTvuAnJJThSlgdgEbCQMraBnOPSI6z92HQWugFcBTWk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UlbPxV/r0Sgd/z23w6P+aId1s7ZR1KyBjJxnKgCi68OCkL9Y2MpgCz2D4L1t2Fb92xoBhfb2q4CTh60kpb0LZX4LfgHVNgQbsGee23S5qbXPdUEBTnM2dNYVZtySAZm2cOCk+AVTXDE5x8av2qtgkRqg8iDFQqOGVciVX+FZxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvBKomLL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wB07tUSJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.231006046@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=li4w2vdbyISE1XfrgLq8xoZs22npIVzG+ptbhVSgJdk=;
	b=vvBKomLLfP2ncIAAPY0Uj+Fd2PF7YFwzolmwW5SqFon861etYQk7Q1HEFK4+yZTqG0gIfa
	qLnlKHAQMgq/dXUnQSETbznYaVfzVwcdHgKv9vu5szCG9xGJFkDXvwdfDlrO6HKpP5Mvm6
	FhQpQgNa5H845wDnFGl/Xte/WntpyFPkQ0+jsFPKCY9wR5Zc5jMFepyKJDVdWcleKgFzFt
	ZLw7QXTeIAC/jfIRym57ZfeOKaitQP8YwAyVZrEozX7y5A8gFOelQ8Buv76Xk+ezFi0z+D
	6x14djNEqsqrPG0IisfALnoQtrMQtvp7SLuPqKdg1VGviLg7ITJw+SxxhTj25w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=li4w2vdbyISE1XfrgLq8xoZs22npIVzG+ptbhVSgJdk=;
	b=wB07tUSJTGuD4NOPu+UBxyj2kfMtYyV1o9X9Pr0LMXrlzuPtJEoqZM6gw7eRhux67geJ9R
	yUhubWVnjW45MAAg==
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
Subject: [patch v2 12/30] x86/smpboot: Make error message actually useful
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:09 +0100 (CET)

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
 


