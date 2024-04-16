Return-Path: <linux-kernel+bounces-147589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491F58A765E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CB11C20E11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DC113F457;
	Tue, 16 Apr 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDQoqMJq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4313C90A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302412; cv=none; b=MKK8kLeYNS8Z+7zkL231jQpfzobR2OIq1O+SRyNU1COQGRwdjnfu81XC8d+Vkef7YXzVWCXDbCgoSF5j3ksklR/5mt9QUiLo2oEzEmkjD80fO4WCdsu3Msi60CmzkDVPL7W3cSFu+UDgVROitAmu78HtpkGJZIGSTKjPyNkkg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302412; c=relaxed/simple;
	bh=8M2SFiR0eeJoB2hyu0DFxRJsXGAe0l8jRLt1CWXdxW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3sc3orrecvHeEXZQ84X+qgkCfBOYOWmpZnOQwzxsFFWqppmPFPL5JGPWS248EaE89G6OCOrZekOipjwV/zRlkP1V/UpFgaIxia36P6tyZTkzXgC9VJxV/kJCpMmjm9BF6sNbgbtCPypZ9d/wE+ziiTOk+fl4mD6jEDd8J/0ahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDQoqMJq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302411; x=1744838411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8M2SFiR0eeJoB2hyu0DFxRJsXGAe0l8jRLt1CWXdxW0=;
  b=RDQoqMJq4pSy77UKB89nmt4EyVvAGpVBb7qXwttjN299tAL7odXeUkRC
   g6CwOkRcoxibUaGoKMEUy6nSiUAU3pQ1PaaT0puCv30lX63RVqTtAI4Kx
   Oh7bftI35uRSwI1sQ/u7OjJVs/Ic25X3Anjlt6hPgxXP10rKo6OYeZBSb
   sT3U69wlm8CwbJDbPAD5yomtkbg60jEwgu8XjYjJ9wNaEKKNGU3eG+8OU
   ggrXKBuo9yR1VEiU3wKDgBZy8DHpKOoSrwWzRCzCrIO8P9tCITXhbO8fJ
   QXpw95fDocGtxuS8/dbTIR5oqXZXFtu6ar+Bv9wKkdX+WcpBdlfgvMgC2
   Q==;
X-CSE-ConnectionGUID: V2qX5JGQTbCXO9PQFAA/iA==
X-CSE-MsgGUID: ldj+T39/ROG4PYK89X4iVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914798"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914798"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
X-CSE-ConnectionGUID: iND14f7QToa7on9st+VdjQ==
X-CSE-MsgGUID: 6rz3qIp8TzWCVNBgXrPYcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871991"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 28/74] x86/cpu/vfm: Update arch/x86/kernel/tsc.c
Date: Tue, 16 Apr 2024 14:19:30 -0700
Message-ID: <20240416211941.9369-29-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/tsc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 0f7624ed1d1d..a0ad786b4aac 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -26,6 +26,7 @@
 #include <asm/x86_init.h>
 #include <asm/geode.h>
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/i8259.h>
 #include <asm/uv/uv.h>
@@ -682,7 +683,7 @@ unsigned long native_calibrate_tsc(void)
 	 * clock.
 	 */
 	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
+			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
 		crystal_khz = 25000;
 
 	/*
@@ -713,7 +714,7 @@ unsigned long native_calibrate_tsc(void)
 	 * For Atom SoCs TSC is the only reliable clocksource.
 	 * Mark TSC reliable so no watchdog on it.
 	 */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
+	if (boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-- 
2.44.0


