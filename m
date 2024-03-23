Return-Path: <linux-kernel+bounces-112353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15178878CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EC3B22034
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C33F8C7;
	Sat, 23 Mar 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RTOJHLuu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v/n3MP7h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2E29D11;
	Sat, 23 Mar 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200300; cv=none; b=A56kR6ZY8hCdXJDczAljffjzyG1citPIta0eAqD8X2iBRg0nOX5QSiaRKPDkCrKIuHB606Q1tqYerRfDSDb9wtYp6nvHgZ5CvNEbjf1JZGIXPRu+a5ph0kusIvJfXJM7pGuzY4tjU0hV9KO/2vghMZV+XODzltJB5F7RBf5tIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200300; c=relaxed/simple;
	bh=Bo5oazztxt1fXowPqKZC6ZwoMifMXM2vCUlLYYsmv0o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T0GMAsz9Ool/w7eEfETqBYAqdXU11YeJDbcN3i6xH3HZE8H6ND8sQpVVrsSpQUFJU8VSNTJxRvzoakeRZJZThL7RdOW2FXcMMwirVAafViXRP1y0ZyYKTVC6EXhzhsq6ZLxDhXJXSMaiXGmyP7DmCZJjJyGVdSJutg1Jh0/KTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RTOJHLuu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v/n3MP7h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Mar 2024 13:24:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711200290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/D2a0K7Ztlqs8E+hSrYbqRDaG+XQYY3xqWmRcrimNg=;
	b=RTOJHLuuN1SoEUmoHUSS+nrm1We2jo5x/7jITnLbs73z0VIk6Ajfvp4BVBYswN27Q4TlUD
	F8KR1J1v6V+TmNNHWJnrP3Xn9i+hfKbJyoj0sqAgLPzixE1nFeQdnacYCj8zKJzGEf6P15
	6BWGf4rt4wZoeWbMdcN4F5VICohUIUtUX2wPLBPaJlhZFCw/r0d3/+WrxgVvfnxPRhN+hO
	OWvAM04Mh5Z5F9l08BIjBpnCy65mXoo6mHtLM5+qlb5BNXZdxKSZHg6pYyd/Yg1GvOAFzz
	sQh7LMJsYjeN44N8AvEBWfOYf70aKqb2rJb3GkaL0TUsjwd7AkTWyO+oFvJjAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711200290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/D2a0K7Ztlqs8E+hSrYbqRDaG+XQYY3xqWmRcrimNg=;
	b=v/n3MP7hGCeAgbhGO/ENEVLvZEh7Q6+QQFFry3ReMKxQE6zifKELKl7pcCddsFkuZgfM0p
	XWymFZWSN83OAWCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/topology: Don't evaluate logical IDs during early boot
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322185305.186943142@linutronix.de>
References: <20240322185305.186943142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171120029008.10875.1770752524543764937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7af541cee1e0eb48c6eb439bc6309175339fa96f
Gitweb:        https://git.kernel.org/tip/7af541cee1e0eb48c6eb439bc6309175339fa96f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 22 Mar 2024 19:56:36 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 23 Mar 2024 12:28:06 +01:00

x86/topology: Don't evaluate logical IDs during early boot

The local APICs have not yet been enumerated so the logical ID evaluation
from the topology bitmaps does not work and would return an error code.

Skip the evaluation during the early boot CPUID evaluation and only apply
it on the final run.

Fixes: 380414be78bf ("x86/cpu/topology: Use topology logical mapping mechanism")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240322185305.186943142@linutronix.de
---
 arch/x86/kernel/cpu/topology_common.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index a50ae8d..9a6069e 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -140,7 +140,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	}
 }
 
-static void topo_set_ids(struct topo_scan *tscan)
+static void topo_set_ids(struct topo_scan *tscan, bool early)
 {
 	struct cpuinfo_x86 *c = tscan->c;
 	u32 apicid = c->topo.apicid;
@@ -148,8 +148,10 @@ static void topo_set_ids(struct topo_scan *tscan)
 	c->topo.pkg_id = topo_shift_apicid(apicid, TOPO_PKG_DOMAIN);
 	c->topo.die_id = topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
 
-	c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
-	c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+	if (!early) {
+		c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
+		c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+	}
 
 	/* Package relative core ID */
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
@@ -187,7 +189,7 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
 		       tscan.dom_shifts[dom], x86_topo_system.dom_shifts[dom]);
 	}
 
-	topo_set_ids(&tscan);
+	topo_set_ids(&tscan, false);
 }
 
 void __init cpu_init_topology(struct cpuinfo_x86 *c)
@@ -208,7 +210,7 @@ void __init cpu_init_topology(struct cpuinfo_x86 *c)
 		x86_topo_system.dom_size[dom] = 1U << sft;
 	}
 
-	topo_set_ids(&tscan);
+	topo_set_ids(&tscan, true);
 
 	/*
 	 * AMD systems have Nodes per package which cannot be mapped to

