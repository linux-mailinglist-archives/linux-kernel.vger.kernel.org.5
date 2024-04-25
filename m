Return-Path: <linux-kernel+bounces-158951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B628B2744
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82F41C240D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0414EC50;
	Thu, 25 Apr 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7Xro13e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0yKx/JnA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CF14D710;
	Thu, 25 Apr 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065042; cv=none; b=uYHlaNBMKogO+hR3zc5hiTHWgdRYY3C5f/DazR0Z8NVCSUNX8qRZb3N/ogrtr/clr9Wt/GQltaNBMYIARYEg2+FJQfsNA1rd/ONzlZ5HVBAX8E1AdKR6uiOwltBZDHFG5xpGBqAhMMbXYtt+zd4u3pZ0IpHY6YhDV7AayUX8VNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065042; c=relaxed/simple;
	bh=ByMaz/QJsYPNvii6+GdcPTurFSFN/T1hJQ//Gnb5aps=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=X9Bu97f6DkfNyTVusoN8X1X3SLsWLiO9/AXlFRwXvWKKSUgfEcGLEVzYcf8OsPLxnxJwPdPz7D+/tgziYWOXYf9Pv1Nu6w2ijAGj3qkXwsuUE6cQy+HEdgg5ijqr5xZDChzEAd4Pd1cgMTFG2FeX6YRcybxTtiCMOL9t2wiYVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7Xro13e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0yKx/JnA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 17:10:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714065036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cYQIpV2fiGQOl9lqZ/SN1dK7IjYe48S/WU8NznZb1EM=;
	b=I7Xro13eVWdh3riG1ofBP5/L3j96pbzu9uW6hTONFV89knVjbVKd7fBfatSDhywiviIqWn
	Tll/S4SHPDi6BdcofQcj/fhnBX8jb1vDvgHd6ypd+JjL4RsK0V0K8Slwre5dmVEB4bM7sa
	nyzK1nII1AVC+S/BQ2ZO56mmmnjAYflInkGIqns861PWjODL9d1G6c+tvdsamfp39vo+C8
	IiJRRoMFDn1JACsNfqHG2F1JICS0EMdNNE5N1U2rx/OoqqAXAc0B5Ec+ehaC5y8TcapTDl
	9oOQjRbT6SoJQI0xCArq8nYFbl72ESgaORYJ4RnEukatyFCICiZmSVuKzTte8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714065036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cYQIpV2fiGQOl9lqZ/SN1dK7IjYe48S/WU8NznZb1EM=;
	b=0yKx/JnAqSmf67/WRyv0wWSIQxVBaJsrRlTDtXIudZjwTRi0h8mY3ed5lSAYUHZAWiT/sL
	Bl1vIfBPEscKJBAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] perf/x86/intel/uncore: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171406503644.10875.15432533426136923358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d413a1955a8e32e4425ff4dd47f5c6fcf09427c3
Gitweb:        https://git.kernel.org/tip/d413a1955a8e32e4425ff4dd47f5c6fcf09427c3
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:02 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 25 Apr 2024 09:04:32 -07:00

perf/x86/intel/uncore: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181502.41576-1-tony.luck%40intel.com
---
 arch/x86/events/intel/uncore_nhmex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 92da8aa..4668334 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Nehalem-EX/Westmere-EX uncore support */
+#include <asm/cpu_device_id.h>
 #include "uncore.h"
 
 /* NHM-EX event control */
@@ -1217,7 +1218,7 @@ static struct intel_uncore_type *nhmex_msr_uncores[] = {
 
 void nhmex_uncore_cpu_init(void)
 {
-	if (boot_cpu_data.x86_model == 46)
+	if (boot_cpu_data.x86_vfm == INTEL_NEHALEM_EX)
 		uncore_nhmex = true;
 	else
 		nhmex_uncore_mbox.event_descs = wsmex_uncore_mbox_events;

