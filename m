Return-Path: <linux-kernel+bounces-64290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4290853CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F77289D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF866281F;
	Tue, 13 Feb 2024 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLxYehef";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1s+/pqMo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5E6281A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858345; cv=none; b=HO0arEU2HIzNDpQyYCoZC7imsxFpoEGGLV2hONB6O7jri/o7ZN6RCfoe1AfPvRZrH4B1xHgSF+h+DEKkPFZ6TpXWV4h+9ITJLPAUSK7IqhR2JFYoh/+PJHXcJZHUjryAEZsMWHReXOCuEDUqUYsp5PCLqIGFP00Uk6Zey9uRSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858345; c=relaxed/simple;
	bh=H+sFDbIcixHvFwoCWW7yHeVhJ3NEd3vsw/iUdXIypEI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lzub9jU/Xgi1x6lwK7Qov0klvDsZvrm/KHZnh7D1u+2WMO2Dns4AgpVGPcQPuoqVnYZgwwiCBAhbwpF9aVjCmUikBu46u7WRe60mFn5SaQbzpK4uzZRk3qdM9Fw82yGaVa9mOlX1ObvjYf3XkVD1O/ViaT8c21Ztxd7BwBp61GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLxYehef; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1s+/pqMo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210251.776009244@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=s6fgiMIEgPG7owWaaV7G3Dyc3ZHmfeJa/L4kuQIYeNY=;
	b=SLxYehefZ3oWP5c9SW7HtdB6e1H2ETs7uQFvNCqJ47Zzdip/Mk7nJ7QsFLuHEzqWlYtLN5
	aKnFOaqWhiJGfpo3ec5JM/d0k7FwKniKT7Nrz83UscojjuNV2QrnG/FarjVg2W72JLGl4L
	LvR+pdUhGhG3rTzjvYlPoz4/hYD1uSOgPZrevKMr9n4BlC9LYkw4SOoh3roe+ZCTYPNA80
	KSiSSHs+CtMhq52TRBhleL7BYDt76enW7Td4OI2S2Fml+AZLJRwWC/nwjeoXJ+p4bgKz7i
	amhQ+MbMAL5SkcdgzpoCNsqCBPXdTPadskjyKoLiSrQoMLN+8wtz3kADKaraBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=s6fgiMIEgPG7owWaaV7G3Dyc3ZHmfeJa/L4kuQIYeNY=;
	b=1s+/pqMo3AlYkf+YkEiiQfhZMvo8yhh6aO2HwAJg0GH4T1VoHGl09WdPxJ7Cg4i9C55qbj
	L0sN4RBo0iQau3Cw==
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
Subject: [patch 05/30] x86/of: Use new APIC registration functions
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:40 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/kernel/devicetree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---

--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -136,7 +136,7 @@ static void __init dtb_cpu_setup(void)
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-		generic_processor_info(apic_id);
+		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 	}
 }
 




