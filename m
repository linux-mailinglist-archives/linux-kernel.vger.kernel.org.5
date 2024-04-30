Return-Path: <linux-kernel+bounces-164437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEB78B7DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9F286D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B8E190663;
	Tue, 30 Apr 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXjkM/6J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56124180A77
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495898; cv=none; b=iacoRzAxyELsbidcARjYB6+QguL/5OIo85pn1KsGDc/EmEUtKX3U/otuLvKmX6hYKRXw0Z35ZsDKlQpNLP2utvQM93sZDc9JWnww8YjIJKJxTOqpCHPk+tZj32Pe5Lwt19Ug/X/sV4we/H9DQXE971zrLJf3RNi/kUYNoMoaQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495898; c=relaxed/simple;
	bh=sNx6nxhHZv+F6DxdU5u7m6Mfq8h17NXlRvSdlpt7fxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNGpq3Nw3yZaQk/EnQlNckqFAWwhse/Ooh221fPSogftFmTp9BsGsgDhUfi6Ki4tRrc5YV8Bj064BC1EAdoC1N19s6eiFHMA8810jV83kvt5wcV1TCvPrAIKkOFpl9EJv6K9+H5ZNeClJ8CrqL7sUYoFLzPHqiJGB3ic102ZlI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXjkM/6J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495896; x=1746031896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sNx6nxhHZv+F6DxdU5u7m6Mfq8h17NXlRvSdlpt7fxI=;
  b=PXjkM/6JKPkj3T1FWJj+BCTSipQL/BafH9NEb3vOoPZfmOVdYHMw62Dx
   mQkAX4bpJZpAd+hbr0/UeuF0L4i4KoD2T1KHJMwIij9zLi0Y4lKLx7Bkp
   mwLuvgyqHbAFuzOqGxmHIy1p5U1PxAIFsZNs7pEoJyzmmGQgGN23OxmUR
   pyJRSS6/Rin0JPKhoemH7gzxyF1CI7RCDYT3wwZgHj+VOZEhI6UHFlVWT
   dRio6jAat16YSNiUyISWMNCIs9Fjoy/9Tv/cfMfpC/L+nXVx3aCx+StY+
   SzmHdrUJrPiWcJUrjBC3LpgRFFMvRQYzqNhtA1KGevEztc+DWH62J4Xsb
   w==;
X-CSE-ConnectionGUID: VwGGhzK3QKSEUdS6v6EU9g==
X-CSE-MsgGUID: tNoWBUUSS5WsJo6A20/ZDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075647"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075647"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: poa/lXA/R/GcHKcaxMWGyQ==
X-CSE-MsgGUID: FNpaYdJrTFy+xeO1/Gcyyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515436"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:12 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 13/47] thermal: intel: intel_tcc_cooling: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:26 -0700
Message-ID: <20240430165100.73491-13-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
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
 drivers/thermal/intel/intel_tcc_cooling.c | 30 +++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 6c392147e6d1..63696e7d7b3c 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -49,21 +49,21 @@ static const struct thermal_cooling_device_ops tcc_cooling_ops = {
 };
 
 static const struct x86_cpu_id tcc_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
 	{}
 };
 
-- 
2.44.0


