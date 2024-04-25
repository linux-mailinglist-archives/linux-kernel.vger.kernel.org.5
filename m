Return-Path: <linux-kernel+bounces-158941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0798B272D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DFA1C23060
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571EF14E2FF;
	Thu, 25 Apr 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jy775qv/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14E14D707;
	Thu, 25 Apr 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064798; cv=none; b=WZUmZf+Y8mS9kQCZnX2xwU4uQu/u5Vk0tC8qACEsyL5kvOQPe0IvBZ64t9B9/5YygD7+2I/kGgZ23/RxQEK6F9FgQKCwStVY+4WVfYVLq9QCzeXkePX963HHEMrXraLlcjkT5POz2hYGND8fN6rIhi/kzvBgc26W3myShl5bDMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064798; c=relaxed/simple;
	bh=pAfVKWKU49Dwg4CmC+F0pJ1yRNXxR8Fmblsw2vpiToo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IeoZVdlkROX6lsqXBjwkNiCizuj2eWFucrk+VzQJrSkGbLwr9GAmV7NLUqut6z674EDFjkHQeejsP7Vx7SfA3hBYFLH4bixZpTAquWPVig9SJKb9zTqjNUhzV57EG5iY6crTRUJORSfyFpWOOc7xTEgpg9GZW/fGenpZgi9Rak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jy775qv/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714064797; x=1745600797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pAfVKWKU49Dwg4CmC+F0pJ1yRNXxR8Fmblsw2vpiToo=;
  b=Jy775qv/qNXZR6FbwX7KJmDNwrdXHoo8DEjzeeNaqWizNflaR6+CgEJF
   goAfgKCVoJV2jYX0ODOlDumCkoihzWfmk25MjN/MvsMvKpCLflPAgirqr
   IuHBE/9o0X39v35XZE/SUYauDzVoJbsogSX1XB5jOukgNRzg3XKZeQA7b
   97DTtFuIa4TOebs4uOxYu+FG9x5g7RlJuktukG4UoJaQxjlmUpOGXWVWD
   MeKy9HNTdPolv+6rVwU/ox+xTDHqlP8cMRqrF7d3kHpqYvux/VzarrHwE
   8FhBo5tvvLGU6K2uyNgSOrWiDZlU+q5y9nxTrgfQdi9dlDxC6/mucUxGk
   w==;
X-CSE-ConnectionGUID: qx/32lGoT0mDMJ7s4IXqyQ==
X-CSE-MsgGUID: QFsICatmSBa9pIy9UUsW7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27225307"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="27225307"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:06:36 -0700
X-CSE-ConnectionGUID: 1FFUenbyQxav3CT1uCoNFw==
X-CSE-MsgGUID: By4Xz9NSRkGw1rS2nLcZzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25548560"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP; 25 Apr 2024 10:06:35 -0700
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
Subject: [PATCH v2 2/3] thermal: intel: intel_tcc_cooling: Use a model-specific bitmask for TCC offset
Date: Thu, 25 Apr 2024 10:13:10 -0700
Message-Id: <20240425171311.19519-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com>
References: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The TCC offset field in the register MSR_TEMPERATURE_TARGET is not
architectural. The TCC library provides a model-specific bitmask. Use it to
determine the maximum TCC offset.

Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v6.7+
---
Changes since v1:
 * Used renamed function intel_tcc_get_offset_mask().
---
 drivers/thermal/intel/intel_tcc_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 6c392147e6d1..5bfc2b515c78 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -20,7 +20,7 @@ static struct thermal_cooling_device *tcc_cdev;
 static int tcc_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
 {
-	*state = 0x3f;
+	*state = intel_tcc_get_offset_mask();
 	return 0;
 }
 
-- 
2.34.1


