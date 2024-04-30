Return-Path: <linux-kernel+bounces-163598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960D8B6D80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E98E1F22150
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEED5199E87;
	Tue, 30 Apr 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO3+690k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1004190682;
	Tue, 30 Apr 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467176; cv=none; b=Iq94sLmIPSVP9EcOoIDxUEsHYuQjpAtKXfUYe9YSJX3PjnYYkgh1Lh4BNbpx59IEhh09aFcVpRYv4a5U+fcPSaG82txhod7mPscdFfOSggdTa/S6ncQtXQipE/y4FlM4T8GguNIQHQ6t2aUsyUxMxxIjtxv5+SennK0f7vQaug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467176; c=relaxed/simple;
	bh=4F1lxedZEM3s7N7Auk2OfI1FJs1f0oZxEqwluHiKK4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCwQ5DCs0Kpf9fWjFs+G0/7W4/lbdFd3X/nBxOs4ilVewpX3tEcKjkoCP15qyyFiLOjmHiWetXGGZRAnzqD4QaQZB15pdLYsL3mhk72Sge+kXdDQ5WGzS1599bs10QibsLG2MikcNDPbgEErTpzUaTOK0jO09Pyae4dIrJDJgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO3+690k; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467175; x=1746003175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4F1lxedZEM3s7N7Auk2OfI1FJs1f0oZxEqwluHiKK4Q=;
  b=AO3+690kXDbsdhz6t4OVl4wIv2VBs05TH42p20m4ZgFPxqwg95hfk0Zw
   ZBzG9WC3f7g+k+kWso5fw/+TxIk+TtGBpQCYqjHIoJCuNSeMKvC2ZrGyQ
   SIMWtby96TKLlaf9L0Ja/yXzUALAQSrPykuGeWIwFYWxG0wHC9nIZrj83
   9K3TArknrMwmpi/chTk1+E6aF4ZMVP8yVxJw4QIF6FNcz+vdK0WTtW+5V
   sP6WL7fRcwAvxIrPYnuAjw5M0yOol/YiGP3LiFD4mRBOB7lzPazzUA8FY
   ZH6Y0AuxWDTQSUcThgKoqX+koBgR2NeKpEfmbxD22LULWKFYb4wcTjHGs
   w==;
X-CSE-ConnectionGUID: 3nD7zGT+REygmp5J6fTgNQ==
X-CSE-MsgGUID: I7r+7iAOTru+jDTjgxZBDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311334"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311334"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:52:54 -0700
X-CSE-ConnectionGUID: MUWH9i2rSeG7onmR7tigcw==
X-CSE-MsgGUID: B+FpvNxWQpm9X9W5AblC6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891504"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:52:47 -0700
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
Subject: [PATCH v7 03/12] e1000e: remove convert_art_to_tsc()
Date: Tue, 30 Apr 2024 14:22:16 +0530
Message-Id: <20240430085225.18086-4-lakshmi.sowjanya.d@intel.com>
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

Store the ART clocksoure ID and the cycles value in the provided
system_counterval structure.

Replace the direct conversion via convert_art_to_tsc() by filling in the
required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index bbcfd529399b..89d57dd911dc 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -124,7 +124,8 @@ static int e1000e_phc_get_syncdevicetime(ktime_t *device,
 	sys_cycles = er32(PLTSTMPH);
 	sys_cycles <<= 32;
 	sys_cycles |= er32(PLTSTMPL);
-	*system = convert_art_to_tsc(sys_cycles);
+	system->cycles = sys_cycles;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
-- 
2.35.3


