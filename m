Return-Path: <linux-kernel+bounces-81303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FAA867416
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078E7B25D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFC31EEEA;
	Mon, 26 Feb 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQiNLdI6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gKGLj7yO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845041D54B;
	Mon, 26 Feb 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948090; cv=none; b=tm9bvL6fw4AAAnX3RxUuhPcCVZZAPNFx26aW+cgyfLOkCaAVIK0u/Yer6fUjXG0LVyjLeqc+cPfSxZHmeYocWRPY03OrOeH4snycsVovAXTuij3vYVSYCRp/EfggX6zyOljCPbXZ/x+rPwm3mAsOOdAx/2Pl5x/BMX/s8fyCUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948090; c=relaxed/simple;
	bh=B/tkQbR9U4S9kEOpfs0djvn9pb0/iN+UsrDa6kyyQYw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=iI3uaATSCUmUjQslECesNv2gV6ly2hpk5b+4Mkp4PnldC5ejZvFGP5xIE5kD/umTCHEky3WMB0ppjmmEvpcuuKU/+KB6xa1Pqur/ZzVZFdz3EfmzWm1vNCDLI1/uP9dCcogGFT/uZNVXM19fweLCgxOGIplv1GWtctRi43SgfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQiNLdI6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gKGLj7yO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 11:48:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708948086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gtCLZIY7ypiDdoCqSBLWsntMRCB2Ts4tl7NPSt9FmyM=;
	b=AQiNLdI6Tnuz409Y0t2B/s5zpAa3oiObB8VEYpv+0PxmMT5vVkbP4xGljdP6vzw9SpVXmW
	HKpap+ZfYTxqrVRKy5Kr1KkjJfB2anbqR9C3cZG5UMX4bIJZ3MiUYj05BikRIuoC+CxYIo
	6i/KtwTJV0/ZBjx/BiuXIVLTN94mFCWIGdTRuJ3PFD2gFrvZq73Z5CZN4b3MVKaXEN2tTm
	yifkIiqyMLPJ9xnT1PKPoRRKO1cEaFE/mU3Z7qV4ryf9+RBEbhBIf4Db26a/P5Ysu0oQGI
	P/CrsOtS33nQvqnOWiPAFjSczDOAaTNLAwHltf2HHbarfTdgKcG3F9h5ZnsYEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708948086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gtCLZIY7ypiDdoCqSBLWsntMRCB2Ts4tl7NPSt9FmyM=;
	b=gKGLj7yOrtoQmHvHmH8syIgKDgLAwG3x4o2iJypSIFc/om+hvIk32ZOqOOyzp2jr53xvgK
	mS+XxUdndG0p+yBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Build the x86 topology enumeration
 functions on UP APIC builds too
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170894808573.398.6836010228517643879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     62aaed88843a9a69b5614f99ec4a2930edd09658
Gitweb:        https://git.kernel.org/tip/62aaed88843a9a69b5614f99ec4a2930edd09658
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 26 Feb 2024 12:07:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Feb 2024 12:14:42 +01:00

x86/apic: Build the x86 topology enumeration functions on UP APIC builds too

These functions are mostly pointless on UP, but nevertheless the
64-bit UP APIC build already depends on the existence of
topology_apply_cmdline_limits_early(), which caused a build bug,
resolve it by making them available under CONFIG_X86_LOCAL_APIC,
as their prototypes already are.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 41dd8e0..43650fe 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -344,7 +344,7 @@ void topology_hotunplug_apic(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_LOCAL_APIC
 static unsigned int max_possible_cpus __initdata = NR_CPUS;
 
 /**

