Return-Path: <linux-kernel+bounces-160539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93588B3EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DE7B22FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2616DED0;
	Fri, 26 Apr 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x6w64Fum";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nu0FpzS2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866C152DEA;
	Fri, 26 Apr 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155133; cv=none; b=Bkl/i02GNv2W2UcXZHzxiL/J49zZ+87U9IM+m92wtSeaG9Nj38N7uxZG3Iz3XNEzNlEsvasETJDOVh/gNtUeQxQmYhI9c3PZ1226iqstsBRSH2NUYg1wHfA4+IA2Atj5FH7bANiKXalWmFoU/qQBJStrsgf7zqT79iKki+kacvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155133; c=relaxed/simple;
	bh=SK2w59cSHwfhFi7q1w8GPkaMVawhroet/5mpNzelPs0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=T7EJuzQPeeIVjI9BYxqKN1LoYStkJW6kleH2+8GMJkcpSxyH8xFzH7FrHL44mrBIZt+vBDeN8WchXeC2RRSFYQcJYZm4hlnh0C7HApBKusPvQAEV8qbP7rHcu2bTtbAdp4BkY00akB61HkVH788T49zlxcllIGYIOaIpZ+uXAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x6w64Fum; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nu0FpzS2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R6Pyw5EW1iqJJN3Ef6E8nhJcRnj1bcFy6ciTU7W8L/o=;
	b=x6w64Fum5RawmJHRFE9RclD2DWvrK2BBlmlPS+alXRl42ILBkR1w+kr15TFXtnuLi93OvJ
	hKC7kKkTIKbwMO7TfAHKUmgWxNbtpk5zjAFj4svDHdzNyZaiT5onUMJBinttv4NVnLcgFi
	qlF16psBaZwWw7Sr63X11+afft6psVOihYWPkQAP13X6RxFeh2OdZ92D6Q5n39+kNOVPfs
	n2pl0AlTdvQi0g5o1I/TFSoO6BX7uwRRJ5DtuxkzXUHfC8FBBsHX6vJ/0DVhaHIZye0yMj
	aGYW+pOxS4N+wscwtdvYqy+nUhJ0kVARD9V26bK7gz4eE8qt6T0TpFj/VitWcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R6Pyw5EW1iqJJN3Ef6E8nhJcRnj1bcFy6ciTU7W8L/o=;
	b=Nu0FpzS2gjfLJukcleRyE9wM9cKiOtTpqR0VtH+x+OyMBJl+tYUWHj9NEyerbWiYk0N3t4
	XZTJe35UOaJzxMDw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513074.10875.5449898962090120982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7cd2e9a9029929018857801455f48354192f2b08
Gitweb:        https://git.kernel.org/tip/7cd2e9a9029929018857801455f48354192f2b08
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:16 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 09:02:26 -07:00

x86/cpu: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

[ dhansen: vertically align macro and remove stray subject / ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181516.41887-1-tony.luck%40intel.com
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a581095..0c35207 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -438,9 +438,9 @@ static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  */
 
 static const struct x86_cpu_id intel_cod_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, 0),	/* COD */
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, 0),	/* COD */
-	X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),		/* SNC */
+	X86_MATCH_VFM(INTEL_HASWELL_X,	 0),	/* COD */
+	X86_MATCH_VFM(INTEL_BROADWELL_X, 0),	/* COD */
+	X86_MATCH_VFM(INTEL_ANY,	 1),	/* SNC */
 	{}
 };
 

