Return-Path: <linux-kernel+bounces-157462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16B8B11EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CC428DA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF21176FDB;
	Wed, 24 Apr 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CezJ7gAS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2E16DEC5;
	Wed, 24 Apr 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982510; cv=none; b=CZ470SctNwhAKaQfLQ6EtEKfhV1N2XeSXPc5nLY5KGhemX5hdzN8h4DOeY7XvPkBXRL5MMLee9ZOX5YO4ql5OE37V3zfgzd0XlwGhCksOhx06jy3HBQp3OfxxD5ZVLhv2zCTXLwObTHyr2EFxi4AqGoYS71NSqypf32zEWyJ5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982510; c=relaxed/simple;
	bh=7eZ3KCFeL78AbH6r5Dbnh9EHFylKrjKmvHvWxMZrAck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uABz70W54W/E29vWr3SIva6icevlCESLEd3ZVBFW4JQxRgRmH13qHVCYBP+Ng5fTQsc/tnT2g1sniisa0zcWeVtOcj0FDWik1pFJY+4wX42e/w4NG8r764vLM65lXjehXiYBxX9eZIrGDxMwnyFNCTZh15TcVb2seFE4ZCLhsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CezJ7gAS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982508; x=1745518508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7eZ3KCFeL78AbH6r5Dbnh9EHFylKrjKmvHvWxMZrAck=;
  b=CezJ7gASKigrsvMgxSgGDhIyGE19axf/iT0ijVUAry/n6C6civ3blzti
   DvKnTkAsdzZZs1CNnCzE1qnk3cJdeunEq8TJwBLw9NoE1BvB1+lK+fF/B
   kSaUVHWmVGPYefNSvkzC/5A0rboCd5vo7DGODGN/WV4AUS+bs+UiW4PNd
   UFZLQoxb7zLBekzF7CGNVGhYwN/ShEllY1dxRMlTWutkIjkUTxlQtfNeN
   3qHHA/eiXOaDH7DINfJjhCPH2O6r4PJi/3U/4IgGd5iSNKXOowBebTRH6
   9QptTkW8pLcBk7aTV41Ly8KZDigzkq/TaP3jP5Y5Wq4wit3QpZz3scNvB
   A==;
X-CSE-ConnectionGUID: zal8ltlATqqPdPqz71pQeQ==
X-CSE-MsgGUID: eEzAp0vfSuyfykgDyEssXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481805"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481805"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:55 -0700
X-CSE-ConnectionGUID: B8SdKDfGSY6gXIMIt+bcpg==
X-CSE-MsgGUID: amjNfRc4REOPlm9CAg1B7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262597"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:56 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Hans de Goede <hdegoede@redhat.com>,
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
	patches@lists.linux.dev,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 13/71] ASoC: Intel: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:55 -0700
Message-ID: <20240424181455.41404-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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


