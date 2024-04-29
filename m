Return-Path: <linux-kernel+bounces-161949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A742D8B53B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F02281C24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66563A1D3;
	Mon, 29 Apr 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="loTEbkse";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMmLxZFA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7E282D6;
	Mon, 29 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381325; cv=none; b=BvPO28+aa07B89aaVNtnRLlXf7ODq8jf6lSicIwr1FSu5sm5HlOTBQQKWp/M9Z8LcmjA1lUaPRqJQe0QaVAgHFYrzKmhyJXfjtJiMh+bCcqu3Qnr1Tqx114Gw2DKW7naGgK9A1bGt+0wfVUN8e2fr2IlhVyLUZq/OC8XRho5mss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381325; c=relaxed/simple;
	bh=UHDojGS9VhcWw/fPhK8vgj5Sah53B3jT7wh6P1BtcpU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=GJwecHCyytV3JeAP0XORvIvZ/KlEKTvTwAZJLD/GXNJ7p0JCdWanzOaxLMgOuIKjNM/piluHqpWDAF5U02T4gRNqPFZJZAMJTsvlnfcUJvZXrq0FUzB7uKsckjb1JqFRt+1ryLMuqxFmc13GHezzhNhXt3uMG9xzoAK2WEIia8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=loTEbkse; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMmLxZFA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1N8pPbUtQQ0SZTp4B7WP+l0NSTj7Z52stlG1INNA4wg=;
	b=loTEbkse8bypz5WuWpPP9sCq0BKMw5Y46r59WCumg4251sO4eA3DvB4UWpfJz925B2iAz8
	qLrRP4Vw4HfRrogOFjtlgZDYsE8DblvcQcnCSkYLXG82DZUjRI5Vy/lHJAYopds3IGOSOP
	DtSFVA3/AwLCXmwlAGpIkiuPWmLA6oz0ErRKCcb+75ytVYyUCUfArVrFpDTbeX4DlM8hUq
	fATpWP3VjZIXGEvk/K0nz3zDSlmGeXe33WMv4+62q3kMIjRcxs5Bx3aS+Ivf+XIsx9X8Mk
	xBEWlWU4sAnIQI6FIXf5nbKDXu0YVeew7TDO5sKBfBmNs48v7NU+5s34caNFFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1N8pPbUtQQ0SZTp4B7WP+l0NSTj7Z52stlG1INNA4wg=;
	b=gMmLxZFAx2+7UEMuzl34UkA1z6sRO1vgHUMLfeN17tl+ymW7A9nrdUCECGVnC3GkgtjuQN
	HZRdHrDVWkQQryBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu/intel_epb: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131492.10875.11705262032355320258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fe3edc524db4152c4b1672b4e0cf8183330379db
Gitweb:        https://git.kernel.org/tip/fe3edc524db4152c4b1672b4e0cf8183330379db
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:09 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:16 +02:00

x86/cpu/intel_epb: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181510.41733-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/intel_epb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index f18d35f..30b1d63 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -204,12 +204,12 @@ static int intel_epb_offline(unsigned int cpu)
 }
 
 static const struct x86_cpu_id intel_epb_normal[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
 	{}
 };
 

