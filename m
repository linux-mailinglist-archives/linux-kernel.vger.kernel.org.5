Return-Path: <linux-kernel+bounces-147598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9268A7667
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EBC2839EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C521487D6;
	Tue, 16 Apr 2024 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfoaOC8I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552B13FD7E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302416; cv=none; b=n4iP73olY80vh4d71Rrcc0LQ/lROEZaEYwFRQ9iv5zYjy0swAyA9fQ0Vg3azeHTK3kqUVDX/8TbjSTe6O3uOoTyQ8lD3VqE9XV/ZXGhz6v8kaDcPmPEYh+RfSpzjafIP5Pl2mvC0JBFg9eUWgzv0LMNk46EDm0ca6v4/a9S4k+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302416; c=relaxed/simple;
	bh=xXGsSwUGJv8u8+15mKqC9kFQ7leMnNCPWaElrpBEOfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN+2zamfjWgg6mp0pwWpWZ/vIiwtK1OKyVVW/C/IrDSBmUTB+5+L/1nim1N7w96SedGsy95mXEHLjHyGLaKYtBJXkcblYwcDLVrXU+hm2DPHIDDWihSRteMg1QsqXhTr5t5JLhdhyx3G4xzmDQNh4LqYGJN5mOQnHKZ4LmgS+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfoaOC8I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302414; x=1744838414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXGsSwUGJv8u8+15mKqC9kFQ7leMnNCPWaElrpBEOfk=;
  b=LfoaOC8IGUWNWOdJUIrgGe3qYh1mcYtDJIMlsAoj8TAV07DykT9+PpjY
   s8f4YXQSKVvzyk38B8+FaTG9af6ZFS8ns7PbiJb/rLb9gE4V3t4wsx0G7
   5TJrA+XjtL6RdSaVoFWYDH0IyIKddWCOhs9G8HOXlS+uwvBaugHL7EQM8
   8yv6Wb76XBXfZg2JydxeoU3nswBSHOQwgQA4xI65TJLmGvUzGPiCRg3Jl
   Cp9lsTk06DZtPDeoxD3nqynWHiqc6/61I8ZSm8PA+5WOnoWXNg55rUrqP
   voPLgC+JHbI4zaaSh+MmH0xjrwrIdzPZ08eqjlfKzzVxPvcUm9wQUSTtz
   Q==;
X-CSE-ConnectionGUID: 3uqsV188QAeyUK5D0zniDw==
X-CSE-MsgGUID: /RDm+H2LRpSo4hzgRSE/uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914838"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914838"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
X-CSE-ConnectionGUID: Jm8oSg1tRlK6S7/S47jH1w==
X-CSE-MsgGUID: gh/5s8S/RRSa2dSQM2BjNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872053"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 36/74] x86/cpu/vfm: Update arch/x86/platform/intel-mid/intel-mid.c
Date: Tue, 16 Apr 2024 14:19:38 -0700
Message-ID: <20240416211941.9369-37-tony.luck@intel.com>
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
 arch/x86/platform/intel-mid/intel-mid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 7be71c2cdc83..8b8173fb0a43 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -22,6 +22,7 @@
 #include <asm/mpspec_def.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
 #include <asm/io.h>
@@ -55,9 +56,9 @@ static void __init intel_mid_time_init(void)
 
 static void intel_mid_arch_setup(void)
 {
-	switch (boot_cpu_data.x86_model) {
-	case 0x3C:
-	case 0x4A:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_HASWELL:
+	case INTEL_ATOM_SILVERMONT_MID:
 		x86_platform.legacy.rtc = 1;
 		break;
 	default:
-- 
2.44.0


