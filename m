Return-Path: <linux-kernel+bounces-158939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252238B2726
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763A2B21934
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081A14D717;
	Thu, 25 Apr 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gd9R/kHd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F22B9D9;
	Thu, 25 Apr 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064797; cv=none; b=oJAoxatFBtSBlMVTsvo+GAljElABvLeqCCEQzaV0RFSwXLQ3t35Ps3Aa2W8PSTdU3+ZNl0aFnPdoTKgDY9rMgNiyOzon3YV3leKHwTG+ASEB5JNyAiH0XYJ1qz+gOy19vlv859W6XM/6foFEPp1YUeHgUmauxNhXPCIY/mpPR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064797; c=relaxed/simple;
	bh=HDbhBCiqnB8FHeOVW16Nyk3NGHSsOYB/sKeG+0xp0KQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DDtn8T8I+pTNlv2TGnbutP2mBlkKRkP8o2gA60ZOm1Ge59NLK/vvyxgni3kQ8x9Gsa4pPWUlPIq8hhBPlpgv7bINMKf3dC2i5HI4YXMd6kLx03ayLJ0kntihsyZwwptLZ0jKq9hyoGl1YRqg75pJMrEAS98nEhF6ARf/8ea90EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gd9R/kHd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714064796; x=1745600796;
  h=from:to:cc:subject:date:message-id;
  bh=HDbhBCiqnB8FHeOVW16Nyk3NGHSsOYB/sKeG+0xp0KQ=;
  b=Gd9R/kHdt0uKt0EQ1X8TPoAE6GuGP9LuJ4X20x4yxnTosEVyhgyS6pY/
   RA9RZyml1Rlw8qG+imxLuDzfSdZzyRRKfh46KWD77PxOVYWZ5y1vXLxJ/
   xRFzw8oSNvkVQDl0SHZg0iPCn+hVlr5vrTzuLl/QP0gkrud04AG0IsjM+
   fimtIKtlCYFh/ie5e/MYKpAKNX67CMMl8JMmu1FRckHVBrDUSXD5kFAxF
   tOmTWKv5a2WKZESljZ14tIorr3UIH7vvJuUDV9nPJ6aGioGiZCn/CeeSt
   A1Sib/IonjRGNXtqL+qrlFXQTA2blmkNaOTzr4ezzqJHTTW4Up6nteBOg
   g==;
X-CSE-ConnectionGUID: harf3TzjQb2h31cDS6XPBA==
X-CSE-MsgGUID: TDSJkncOSJSAxaERa8Fohw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27225295"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="27225295"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:06:35 -0700
X-CSE-ConnectionGUID: 64+52qVwSeSh60HeTt8IrQ==
X-CSE-MsgGUID: DUqBEeidSGaPip9kNYEmag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25548553"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP; 25 Apr 2024 10:06:34 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v2 0/3] drivers: thermal/hwmon: intel: Use model-specific bitmasks for temperature registers
Date: Thu, 25 Apr 2024 10:13:08 -0700
Message-Id: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

Here is v2 of the patchset to use model-specific bitmasks to read TCC
offset and the digital temperature readout of IA32_[PACKAGE]_THERM_STATUS.

You can read the cover letter of v1 here [1] for details.

Changes since v1:
 * Dropped dependency on CONFIG_INTEL_TCC for the coretemp driver.
   Instead, extend the bitmask to 0xff to accommodate recent processors.
   (Bit 23 of IA32_[PACKAGE]_THERM_STATUS is likely to be zero in less
   recent processors.)
 * Renamed TCC_FAM6_MODEL_TEMP_MASKS as TCC_MODEL_TEMP_MASKS.
 * Renamed get_tcc_offset_mask() as intel_tcc_get_offset_mask().
 * Do not export intel_tcc_get_temp_mask() as it is no longer used
   outside intel_tcc.c
 * Dropped stub functions for digital temperature readout and TCC
   offset. They are not needed as users select CONFIG_INTEL_TCC.

I have tested these patches on Alder Lake, Meteor Lake, and Grand Ridge
systems.

These patches apply cleanly on top of the `testing` branches of the
linux-pm and hwmon repositories.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/linux-pm/20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (3):
  thermal: intel: intel_tcc: Add model checks for temperature registers
  thermal: intel: intel_tcc_cooling: Use a model-specific bitmask for
    TCC offset
  hwmon: (coretemp) Extend the bitmask to read temperature to 0xff

 drivers/hwmon/coretemp.c                  |   2 +-
 drivers/thermal/intel/intel_tcc.c         | 177 +++++++++++++++++++++-
 drivers/thermal/intel/intel_tcc_cooling.c |   2 +-
 include/linux/intel_tcc.h                 |   1 +
 4 files changed, 175 insertions(+), 7 deletions(-)

-- 
2.34.1


