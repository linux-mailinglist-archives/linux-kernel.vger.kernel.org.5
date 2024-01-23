Return-Path: <linux-kernel+bounces-35348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE601838F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B84B2955C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F20B629EB;
	Tue, 23 Jan 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMBN3aBi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsT/JbH9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DD5F579
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015460; cv=none; b=aWR1WqpV7t3biIsjs0QF2vFKdlDU/e0Md8NaXHvJzYP7sqUhtFLnkf+ZowJQzWr4Du6bnKD/cYvtIm/BtsSb4Pa1gf8dtVUFtIs0JF1sM6bsSgwuvHNbbpGP+u5Y0aXO0jRepyfhvqyHoq7DMImHPtOEERFaaF1DR54s0Rtjp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015460; c=relaxed/simple;
	bh=/BwHRCS+CLYxiYrDKtOabx9ENMJKOBslstVgo9aIw54=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=I23T36+R1qQ12Ur9uh9zxPfJ2cJoDorRVTpKkjsxvEJYDwKTlHNt1Osp7c8ZtNCRiwd/FnkhHCtIQ+RjcS6o2a6WDgpqBs7QszvgL7Ei3z8YD4R787aUXbVZvgdFU69MPzQn1lXxrDU/c0j+21WSTwutZFzK3qZPwTg0BvQglmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMBN3aBi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gsT/JbH9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123648.836545448@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=maxs2TKeF/0tW1+HW118Yxp9IM/22p0xUJceBYRgAg4=;
	b=LMBN3aBiuZo4PBUyhOaxBa2YMXeATFlTnIUt/cPWyzWwbVBFRiHVpOvyi1ek3uVgUlPT4T
	sbNRsLnk18wM18+vA3RrRrX704ijm89Mhvyd0An/O4M5eyCRGb6B4jrBjfho8IPHXz3PUJ
	/htwzTWhON+bqccDFQf81DapQoBer5EiqiRt6wrfhTddirwzqKonzbSDVYhSHS1YiWwLOl
	2luTkCMGk1vdfCbQYTU7vma4p9PCpgwCQMEoqQXHBxILp4fUubrBvDW8DyD1tGeAI+CidF
	LgC5NsQ7gyeIIFvnusgwAlNZIY9q3rOtql2FmQCrKb72MLXxgU+ZxT/fxJHHYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=maxs2TKeF/0tW1+HW118Yxp9IM/22p0xUJceBYRgAg4=;
	b=gsT/JbH9NyAPlfh05SdzLxjOxHXoce7DHybt8Aexrs3MkN5f3kOgxsBen+5i8C72T6bsI4
	3kaYdQatGRUz6uAQ==
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
Subject: [patch v2 05/30] x86/of: Use new APIC registration functions
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:57 +0100 (CET)

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
 


