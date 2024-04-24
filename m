Return-Path: <linux-kernel+bounces-157518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1F8B1275
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA7AB2F142
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512F16F0E7;
	Wed, 24 Apr 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrGOG2KV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B520FA88;
	Wed, 24 Apr 2024 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982552; cv=none; b=NH8wCy0jBcMrdRGdNGeNhtcBkPPnt3g8Bsx2sLeP0bG1jqTFSEBm3tnmIxmwKs6y7S27pnch/PHuwRPy/2jfCE9S3cb+WpSojGH3M59itwZhY1dkE/cxPrc9bua4zHuYXuZmGiamdATn6BSGcka63iDp+9f6043FjDauUmivIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982552; c=relaxed/simple;
	bh=O/JDw8NfkaF9jcVHcgdlz6maAm+xtjFyjDd9Vr0iZSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAl9X08D2xwdt8rbt69w5LhUWePLip3Vi9Vm8IvXNr4YRmuvM6ljxIYRyfCVVADp9qs6DSdhrlgkNj2dZtwhBLaxdeIl1Ax7iNz9EHyKE6T1EGVvihxa8BZ8G8lGPM+bAZTXcCo+UqZZIMY6+UUpHyl9o3ZeZ2vi8pYgEV1tr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrGOG2KV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982551; x=1745518551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O/JDw8NfkaF9jcVHcgdlz6maAm+xtjFyjDd9Vr0iZSM=;
  b=IrGOG2KV27KWbhn1UfOTQeOr1GFCZoQjaxQQxoTOUU4rqw73Dtvb6Bzo
   BJ7JlojFLC4YkeOlyC1QVKrFRCwrMnoDS3QPQBBlGEQHjxrcmA+MFIZNF
   nRtkdbNyv5naoSQLjsO+fqZenbJ2q6nd64m+bGQg+p9IEXxtzN5q9aHCl
   NEdSASY0GVZtvovC2tWtgUheb+1SMGWpTbKw6J4GVVCoTT2Ou6rdOZEDN
   92M6AEmDoSzhZ1641p9DdHmBVlDr/rASqXx7l5wcv2uF0oX6f75o+HjRv
   URZRjnX0mSi4lpjnpiNogYdpXrxGSaRptQNgtpNXsVgFiqcC1VKNXX0AM
   A==;
X-CSE-ConnectionGUID: lf9Xai+vRKus9H/kSQgspA==
X-CSE-MsgGUID: UVJCZjJHRbWYF7OiTlKlfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9756053"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9756053"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:51 -0700
X-CSE-ConnectionGUID: T9nCikZuQKGmObTt2tD5Xw==
X-CSE-MsgGUID: DLFKgAyLRaOzpNGLtJ2BRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24751186"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:51 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Tony Luck <tony.luck@intel.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 68/71] ASoC: Intel: avs: es8336: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:50 -0700
Message-ID: <20240424181550.42466-1-tony.luck@intel.com>
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


