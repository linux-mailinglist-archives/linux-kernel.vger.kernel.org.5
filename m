Return-Path: <linux-kernel+bounces-161945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD68B53AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA01E1F21BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04928376;
	Mon, 29 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HuqMHKpi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="waS6tOoA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9D1B95E;
	Mon, 29 Apr 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381323; cv=none; b=IjBDMly80timgS1jp/EpFCC4/GiIe6Gj7cz6K6FVmtn4WWY4CvR2sz9Xw81m95jmOhCNaYB6fguH7mHUtQu01ljGCjK1u4nO8MZwguh9lUOcohWf0rS6OkpQoVv5t91mLUm5XqKnxFkRqkD/gWHgh0Y+Jt0EwIEWjSuu3/K7254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381323; c=relaxed/simple;
	bh=KfFni5AX/3VTcGa8xEVRzPBvvPHoXaZcV2TcUjS5B3w=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=KtJk7Zrx1c5QVdPLrX+NMdX/cAacKflepswYjbKAZqyOLYqhQjfNu4QaH3cLuhXxo/zF1u5HJC0woaUIoHoIWhXo+sfPYSHn4vMIdAOu5tzgFYdc3RzRfNISvQc+LGGFQh6wuu6kVCsXLGCwfVh80r9G/EPInZ9YPRSjJffFetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HuqMHKpi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=waS6tOoA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XPB5GBaC/7VIrvaNJcPSd9MoXea6ujaeLds/tiKRUEA=;
	b=HuqMHKpi/WWtoG/aTEjuX7s9eet+pc9t3OzgFnlETGkyEauyVEEI/+GzOjJqzAw+V7Lk42
	E+/BpF3FHIfL9tyo+RwthDV6IBifK0vcM5l8F/bAMQsxPKYeJcbqN/MaHDmAyU2XbFnOn4
	NGqgbY2xSb166ugFTY6578nD1dXdXz2+gOULLtnsgRTxTMjOnD1Qq1bMtg90UIrr8tRxg2
	2laaxii79PUM7vGcL8qy+TjaidGzE6dlueebmX2G3tyNHrAKuWJTMSdDErF4aWn9+mQgVG
	KJRUvNTeIjudZH9oYY7kCyBrFme+KO2a5I/OQ4qI6dnSMzDJjq0islm03anVww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XPB5GBaC/7VIrvaNJcPSd9MoXea6ujaeLds/tiKRUEA=;
	b=waS6tOoAdV4rWsX0f11Hv7a4IOdCEpmv8N2wEc0XWM4MoGmoX/ogi61l7LKKDIalyemrAS
	VZ8xu6YqdsWjSwAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/tsc_msr: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131368.10875.1798076709788645675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d9b6886cd7cda9debcaf0c33d43c87069820c7b1
Gitweb:        https://git.kernel.org/tip/d9b6886cd7cda9debcaf0c33d43c87069820c7b1
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:18 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:34 +02:00

x86/tsc_msr: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181518.41927-1-tony.luck%40intel.com
---
 arch/x86/kernel/tsc_msr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 6555a85..deeb028 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -147,13 +147,13 @@ static const struct freq_desc freq_desc_lgm = {
 };
 
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID,	&freq_desc_pnw),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_TABLET,&freq_desc_clv),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&freq_desc_byt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&freq_desc_tng),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&freq_desc_cht),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&freq_desc_ann),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_NP,	&freq_desc_lgm),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_MID,	&freq_desc_pnw),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_TABLET, &freq_desc_clv),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&freq_desc_byt),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&freq_desc_tng),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&freq_desc_cht),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,	&freq_desc_ann),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_NP,	&freq_desc_lgm),
 	{}
 };
 

