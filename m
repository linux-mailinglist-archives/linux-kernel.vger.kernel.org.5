Return-Path: <linux-kernel+bounces-163604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692918B6D90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7601C214C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E641BF6C3;
	Tue, 30 Apr 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGjZt5hJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD131A0B11;
	Tue, 30 Apr 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467203; cv=none; b=S+1PNt3vvT8pYVVnJibeWwg0EtLWlIpnRVNGiM7zZ/MhlrSVN5Hx2IlMpW0MeLizHcerHqO60rHrsbF17GRPrDpqXMnVnlidRMzan6c97jlopC8rSOWVAH1zULEwtX08Z3gIifpFthi4DdpdkJUPmj3fW00ZLNdkccD0kp8wmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467203; c=relaxed/simple;
	bh=xuPQa1kIsy6SGj3PJA3KBmf/9PrLBCxMl+O+pD4au58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxDl2mqPaa2KCpM/xZWbS+zz+sQYWhy4l2gHtWzmfhYIZk8r587p3C9ZOCIWx8jmp5P0ScJJZp0pAFd2JoXNXnLxR2PuER1Y1Ql6x6+MwpovkrMTfkLhyMoZMV97M5mQPJHXXxO8O8O3hMxrRGBRErguBCJahzlVQ5raJGF/YMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGjZt5hJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467203; x=1746003203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuPQa1kIsy6SGj3PJA3KBmf/9PrLBCxMl+O+pD4au58=;
  b=KGjZt5hJbWi03YjzPNjrl+F6S71uHwfgvQVMFic4/NzI5fUvj1PjeOJM
   rvDvFU4+6JtdToBZ9wspHQDX0x2LckyRyEvTM2cc8lDzAagD9pdIb5k0f
   rYqB+37C8SSSQ5TU6DlmD9zRM8+D8w7LnvsKxMjkZBsrE+Qui6uoEN78r
   PshvxGqjqz/M0wSGSUfqoEVKHoH2oXVncr6NL1Scl72To9ZmwVoUqsQuX
   nsbVr+MDXdyRETDYQzNT77RMpsd1yTL/CvwxOckyRmEBka7nyGu4VTVnC
   wcT/Fd4iZzyS+mPuIXaXZrNdyYybbdlE6iYRZN2OQjZiM8wv7l0/HxKMe
   Q==;
X-CSE-ConnectionGUID: HE3PN1daQLKjTAOM/iqyKA==
X-CSE-MsgGUID: +6mhqB5tRCG6zdlcEaxIdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311440"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311440"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:53:22 -0700
X-CSE-ConnectionGUID: oTNRknPRRKO+xvxn+CO2gg==
X-CSE-MsgGUID: 62uOnEJRTUO9q3pNfnQsxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891621"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:53:15 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v7 07/12] ice/ptp: remove convert_art_to_tsc()
Date: Tue, 30 Apr 2024 14:22:20 +0530
Message-Id: <20240430085225.18086-8-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
References: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

The core code provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

All what is required is to store the ART clocksoure ID and the cycles
value in the provided system_counterval structure.

Replace the direct conversion via convert_art_to_tsc() by filling in the
required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index c11eba07283c..c416dd2e6622 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2116,7 +2116,8 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 			hh_ts_lo = rd32(hw, GLHH_ART_TIME_L);
 			hh_ts_hi = rd32(hw, GLHH_ART_TIME_H);
 			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
-			*system = convert_art_ns_to_tsc(hh_ts);
+			system->cycles = hh_ts;
+			system->cs_id = CSID_X86_ART;
 			/* Read Device source clock time */
 			hh_ts_lo = rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
 			hh_ts_hi = rd32(hw, GLTSYN_HHTIME_H(tmr_idx));
-- 
2.35.3


