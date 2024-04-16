Return-Path: <linux-kernel+bounces-147632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04338A76B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708931F21DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD861553A2;
	Tue, 16 Apr 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLSZ4Fgb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F8156895;
	Tue, 16 Apr 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302574; cv=none; b=ndg219F8g+hkRUZiLSnvFptqdjhnPluzthwakbQzSxFBvEphuqdZWJxetwyv9XI8uMxe/3pc2Wya4IjN9M2nHT+KiTvB5y9oeUivQbrRoJun6NJJD6E/W5jKb9TNeEgISXlqNEbZuOhVXhmPjfWlIJM4Y6eiqkqs9ThKRNJc6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302574; c=relaxed/simple;
	bh=IUM4l0d+HAzrageBnuTfsgyVu/n79Su2Td/OJNGsTIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oO2K5Zo904b5VEM6AFmTqYwooeYa2ijTDZe8ZFFzLbZubGiRtPDGpqWeXvurSZz79cvdYHx2Q9I1FjK8bof7AbQFBQaAgqqprdrjdQtOlT/riqn/QYjPMBYs8lABZq6Q09MLH8Xm7fpZ/0P+3X/sN7l8ag+phBxzU9GwfGzris8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLSZ4Fgb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302573; x=1744838573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUM4l0d+HAzrageBnuTfsgyVu/n79Su2Td/OJNGsTIg=;
  b=bLSZ4FgbBGMvU73QXQ98zl0siMkg/FTZ+WrDVZ8S7wg6y1oolfzyNLC7
   JnpxvlYNlj7604A4u/RpMIHCDxtFrj8WQmGvE9og+JsavnxJ7AECjYMr9
   8L8uHdFmiJbIkP2/av742ytI+Eg4YwB5SrJuX7e0wZd/eXKhnY2bKs2eF
   bs9jcPNMsgLNkGr15JLV3Mt4gQspTNHEfl4Vbo0aydRFWcuxASZadPVdm
   sVnhCg6yZVJ5h4Rdeyni2gbj6uDzVZvUzrHc4szgOljxD4lkQxQBXEIo/
   i2s7DlRCehuBEh3MDaWt2fJstvz9GOXkfoA1oRxxXGerwqAtsmfntOCyV
   g==;
X-CSE-ConnectionGUID: 0yUp4Y96SZWCnAcUXOUKvQ==
X-CSE-MsgGUID: 85ZKYqvUTQS3SPwpXfwE1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31254718"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="31254718"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:53 -0700
X-CSE-ConnectionGUID: j2BIYU25TlKgLgO2PmyICQ==
X-CSE-MsgGUID: IdfXabIQQ7isy+ZJ4BIFgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="45677878"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:51 -0700
From: Tony Luck <tony.luck@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v3 69/74] x86/cpu/vfm: Update intel_soc_dts_thermal.c
Date: Tue, 16 Apr 2024 14:22:50 -0700
Message-ID: <20240416212250.9969-1-tony.luck@intel.com>
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
 include/linux/platform_data/x86/soc.h         | 12 ++++++------
 drivers/thermal/intel/intel_soc_dts_thermal.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/platform_data/x86/soc.h b/include/linux/platform_data/x86/soc.h
index a5705189e2ac..f981907a5cb0 100644
--- a/include/linux/platform_data/x86/soc.h
+++ b/include/linux/platform_data/x86/soc.h
@@ -20,7 +20,7 @@
 static inline bool soc_intel_is_##soc(void)			\
 {								\
 	static const struct x86_cpu_id soc##_cpu_ids[] = {	\
-		X86_MATCH_INTEL_FAM6_MODEL(type, NULL),		\
+		X86_MATCH_VFM(type, NULL),			\
 		{}						\
 	};							\
 	const struct x86_cpu_id *id;				\
@@ -31,11 +31,11 @@ static inline bool soc_intel_is_##soc(void)			\
 	return false;						\
 }
 
-SOC_INTEL_IS_CPU(byt, ATOM_SILVERMONT);
-SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
-SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
-SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
-SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
+SOC_INTEL_IS_CPU(byt, INTEL_ATOM_SILVERMONT);
+SOC_INTEL_IS_CPU(cht, INTEL_ATOM_AIRMONT);
+SOC_INTEL_IS_CPU(apl, INTEL_ATOM_GOLDMONT);
+SOC_INTEL_IS_CPU(glk, INTEL_ATOM_GOLDMONT_PLUS);
+SOC_INTEL_IS_CPU(cml, INTEL_KABYLAKE_L);
 
 #undef SOC_INTEL_IS_CPU
 
diff --git a/drivers/thermal/intel/intel_soc_dts_thermal.c b/drivers/thermal/intel/intel_soc_dts_thermal.c
index 9c825c6e1f38..718c6326eaf4 100644
--- a/drivers/thermal/intel/intel_soc_dts_thermal.c
+++ b/drivers/thermal/intel/intel_soc_dts_thermal.c
@@ -36,7 +36,7 @@ static irqreturn_t soc_irq_thread_fn(int irq, void *dev_data)
 }
 
 static const struct x86_cpu_id soc_thermal_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT, BYT_SOC_DTS_APIC_IRQ),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT, BYT_SOC_DTS_APIC_IRQ),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, soc_thermal_ids);
-- 
2.44.0


