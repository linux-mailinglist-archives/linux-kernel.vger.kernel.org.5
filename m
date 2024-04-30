Return-Path: <linux-kernel+bounces-164431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3218F8B7DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDC11F258B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2604517F36E;
	Tue, 30 Apr 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwrkzCbH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED8176FD8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495894; cv=none; b=iS/entokUJnKjUGdUVOGPh2uof4qey/DLVS25wwkQeedRtB5GC/sxvQVHcAAKNRbDLBB8oEA4sGFtH0iRYlXf1pK8wkhr2o6YMx0SkOUOeQiW6WD7TYNj+o9gMOioC97U0IEqvOJPSkfAIHcTWycBvkMfwwGrYrBhcieW/P/Oms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495894; c=relaxed/simple;
	bh=/S989FH+YbIptoEIz6YeaHhdHIj5oah/mXRofFi5shk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYy6TMLeWR0QwW7Qy4mIfbPx1CQqYW/kB/97vX6P/upqtV6EEKRK+TL4lqsgZ5AYPgvpIi2Ne35tFUL7DqHv8G+GRhfmvXFomJHCZREjdBpJtkIoDUqRKx7eDHmrYBSGgwrBgks8jmkNYkMMGyDH4ImEqvhOJ2+C+tQLEJjqPOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwrkzCbH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495893; x=1746031893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/S989FH+YbIptoEIz6YeaHhdHIj5oah/mXRofFi5shk=;
  b=SwrkzCbHswrbgK75/zl9XItkcc/61gs1ZBUSqFKvE61HagmPtTYv/gW2
   NFRp/rrlueQ3Vzpy0pyRQhsaXQMtxAWWMCojJN+Ua0zpwigMkTfMSv3xY
   0z3udQ0at9mQK0VF8Bj8EYJ/ciE32rycB3vQcFNls1+M7wbG8P5u16QZN
   clPK5NVkShFAsbbSz6SqczxxWEg81pRH9eVmifnLVGBwuK5aEx2qZXKj2
   o/U9D4ik9oxOfU1sh8kRxrNEeMEahTr8HnQSaZeAcHmQWGHBSiTRFZQ06
   PKi2EboLulhuyqcHckwwacFLxObHmdhIYLYGj6hOxLf2DFooOAWexmiYI
   g==;
X-CSE-ConnectionGUID: q0QcFowBR/Sxa8o8yAzRWw==
X-CSE-MsgGUID: /gCy2HABRNalsBkjf2zSgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075607"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075607"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:20 -0700
X-CSE-ConnectionGUID: 2Rnc0CfMQ2Srp5YH4qMdfA==
X-CSE-MsgGUID: 4SZNAM8oS3OV7xcXxKR/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515414"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 04/47] ASoC: Intel: avs: es8336: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:17 -0700
Message-ID: <20240430165100.73491-4-tony.luck@intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/avs/boards/es8336.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
index 5c90a6007577..3d5d4685a668 100644
--- a/sound/soc/intel/avs/boards/es8336.c
+++ b/sound/soc/intel/avs/boards/es8336.c
@@ -18,7 +18,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include "../utils.h"
 
 #define ES8336_CODEC_DAI	"ES8316 HiFi"
@@ -153,9 +153,9 @@ static int avs_es8336_hw_params(struct snd_pcm_substream *substream,
 	int clk_freq;
 	int ret;
 
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_KABYLAKE_L:
+	case INTEL_KABYLAKE:
 		clk_freq = 24000000;
 		break;
 	default:
-- 
2.44.0


