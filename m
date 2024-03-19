Return-Path: <linux-kernel+bounces-107560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAAC87FE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918FF281D71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE3081746;
	Tue, 19 Mar 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HThSC1tw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7580022;
	Tue, 19 Mar 2024 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853593; cv=none; b=hkmjXD4RAvaz8S4pC7odsWhGI1f9GNSoyYW2q61kYNckc+aTHPBwfExEvmG2CJMgNwMjChr5BhLkrbBwcsdVWaBXhVbIft3EpM9hbq+0gFLYDi4ey3szYKQpcve9wWaWwqdlVOiztTrNhMo6qynZiO3jnUnM2QkD2bM3XNujxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853593; c=relaxed/simple;
	bh=uUU6Aeoh21pgVprRQuKox95GRqR5aTWn9mMsl4N1jcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5uorbBCr227V4pTMZbU2XdDjkcryZNzwCz2IwurQSb8L/sXVrLpmEx5FRpoBOSD5kS8jLRvUDw6TXH2WXxqlsUSMGshXlz4U+Uqevzy+tfSz20aPFB0TwbClEYX3GpLAHrw0hNEFm5bwCnCAZ7+KjEs/EWSjvMG18weNe9dOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HThSC1tw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710853592; x=1742389592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uUU6Aeoh21pgVprRQuKox95GRqR5aTWn9mMsl4N1jcQ=;
  b=HThSC1tw9w8S7O1hByjVwt/M5l1/yAzG/kZ84qUa5ToOk7/EvECt3BfI
   V7yIDLHd+Cn++dS3iDXImF8yVTorV86oL+dH4W5RzJCmPgZbQRTKsGFvp
   HSQqrxwHtB69YuPc1bu4D4/Y2bguUj3oLp/VJXbYCDdE5I2ekqv1ujmT5
   Tze26Kt3yGRzw+sFglc9CUZlOVtxrWZQ0VRbISBVQc5rlOdHVBggvSAUq
   NeFi0rKYjrlc369++cYCAnhNi75RopDpWqticwMY/d4Jz0jY6wRarwl/P
   2h5JD7Tq9CiqTNru8F+swEmibn+F+0Ksms1xcu93a9O4opmOSiHt888Ro
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5842971"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5842971"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 06:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="44883226"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 06:06:24 -0700
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
	mallikarjunappa.sangannavar@intel.com,
	subramanian.mohan@intel.com,
	basavaraj.goudar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v5 05/11] stmmac: intel: remove convert_art_to_tsc()
Date: Tue, 19 Mar 2024 18:35:41 +0530
Message-Id: <20240319130547.4195-6-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Remove convert_art_to_tsc() function call, Pass system clock cycles and
clocksource ID as input to get_device_system_crosststamp().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 60283543ffc8..e73fa34237d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -390,10 +390,11 @@ static int intel_crosststamp(ktime_t *device,
 		*device = ns_to_ktime(ptp_time);
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 		get_arttime(priv->mii, intel_priv->mdio_adhoc_addr, &art_time);
-		*system = convert_art_to_tsc(art_time);
+		system->cycles = art_time;
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
+	system->cs_id = CSID_X86_ART;
 	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	return 0;
-- 
2.35.3


