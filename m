Return-Path: <linux-kernel+bounces-138544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E466E89F32D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CF51C26687
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EC915ECE8;
	Wed, 10 Apr 2024 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X42OOBzd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/OZ8txp7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A015B995;
	Wed, 10 Apr 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753484; cv=none; b=LPNtSc84VpkowrJNfM0FANoJI4SwNpRNr1geM3+dFg8kR6GDDkFYR3HU/GL7QPaWGfnIu8gKUPssrf33THZ8c+29Ludi+tngDQtBA+hCdpYTIpTYHmlFxVWQV5XG5StBYC+K/NYtGyE+/n3eaEItlttV9cvHMdcV4uPKlU3Or6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753484; c=relaxed/simple;
	bh=cM6A+Xk2OG5fISGCj0T0XNaIFkJMvw+kZGGMI+IkR/g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UtXQu7g8CrzF/utQsYypoteoZUL+VENnk5uXA4+W7uxpt636w/xGX+AfxQf5IM8FikuyqlNHyV+iJVNwiZGqBS0gZTgr9mU6LB8WnYzl5jtTWkJc2JoYa/OEvifvV5vAhdLC5eRljahMUPv+IFMKQBeMuJZFamS1RHYE20Jowx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X42OOBzd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/OZ8txp7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 12:51:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712753481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFTEqggYA6/wL0n9G9Dk02hSulCtz93zOGRV+5cK6EU=;
	b=X42OOBzdvfYzAULqzs1goXO3yHw4HcnNC2mB8Bt+DXfinzTxmn6lLTeyQnPIuizVmd0/Mf
	WzGPIywWOqB4E4tPxrXZuiKnt3eTGsAfDr1qFONh8QfGGngpcC2+LCeV9nxYic1Q2V0Avt
	ksuNEcQ76BazSUtbu0NEah4nIA/T+nC+Qpa/DNxBDi2GkaY5+Z9USo75uFwnuVEqasxVHT
	xzeX36CNHRof/Ph1s1uC8mx3u3CUWJzqqFcsNKLWR14651U86RlQtl5o0/SnGv1HC2LFNi
	oZjRbPBAhJaBOjaXtAssA0Z3D3aSz24vG0MhmSmZbzVVeJG/CrdzmmZ9DzpYWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712753481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFTEqggYA6/wL0n9G9Dk02hSulCtz93zOGRV+5cK6EU=;
	b=/OZ8txp7s+2Q48Hm1YUqhmi0VoE6yuavOeCdUPLX4Cd0VTsfOI7ODQJjzSD0sljyFKGFgP
	Q1yQCphIwVf74eBA==
From: "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Add support for Intel Arrow Lake
Cc: Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240410124554.448987-1-rui.zhang@intel.com>
References: <20240410124554.448987-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275348068.10875.8784047144132819163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fb70fe74beaa809e13e7f469b116d54ef7cd19e9
Gitweb:        https://git.kernel.org/tip/fb70fe74beaa809e13e7f469b116d54ef7cd19e9
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Wed, 10 Apr 2024 20:45:53 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 14:48:18 +02:00

perf/x86/rapl: Add support for Intel Arrow Lake

Arrow Lake RAPL support is the same as previous Sky Lake.
Add Arrow Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240410124554.448987-1-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8ef08b5..00bb6ea 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -806,6 +806,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);

