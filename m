Return-Path: <linux-kernel+bounces-138437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB589F13F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0111285774
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790215B96B;
	Wed, 10 Apr 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OV8Lz07U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA915B553;
	Wed, 10 Apr 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749732; cv=none; b=uWAD9A3KIvbY9bhFtcj4Q0jeNnmt06JMOPcPzUaocR/icP1s3vBWptq+ZLK86FhSk5sww4AJT2cL4D2KK9G2D7P6s4EkpnmTXVXYYXpzOdiHwluVVxeww8TtxqCCiYACdVVnXFb6LamcF28d07O6xiQJ9DZFoIITGePgKkD7Pzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749732; c=relaxed/simple;
	bh=9bM3pFe73YGrSI7VbFylL5q703Z79WRvHVA5lUksMX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pT5qP53LGikdAFcJa+1uhd4HShBMbZQUZvbVt67RksluZ4ZLAwKRom+RtHJvTdgg4LsPUf6pV67ILeDVs/7lGzqGUUJ9Mh7WbNDoA/1ixkx9Qi/9kg8k2yDc4MB88QvU7grpXSZCx68e9g78TdpCQWwkmS4MIcLRPrR8hNOZyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OV8Lz07U; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749732; x=1744285732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9bM3pFe73YGrSI7VbFylL5q703Z79WRvHVA5lUksMX4=;
  b=OV8Lz07UBX/MeizjGCoEtdOb/dINtLBJRz6mbVMRMp+4O74qGewMhmaK
   RyfcjAufuCUKSKcppS2yD00R1arCMoIzFTFyfRfmPyPZ/IqYf7LVmYYHJ
   1HKPJ+kjmrrLcu5MzosDQG2X/X7uhwFtBD36UOkqCKUvR/pF8/I8weRlM
   GUjexsD/4b7qp333op0tLJZgzMELS08B1xaBeT74P7lCAlKCSmz0/7y72
   bIeC17dpRsiE+3SryooNjTJw5UUpJMvf0mIyMFrAo+WEKojblqL76tJg1
   ttVFBvKZT52seqYFFqi69Hg+wBTMoc3VshqT1ScdF+xwFbkBrtrBMhjH2
   Q==;
X-CSE-ConnectionGUID: v6I49n8tSlm+I21JQi8UpQ==
X-CSE-MsgGUID: 0HyTkH1YSgayllOHYxiMLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11944083"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11944083"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:48:50 -0700
X-CSE-ConnectionGUID: QJH6IMdpTXu2SncDEgABkw==
X-CSE-MsgGUID: gDsYZPgtR2W7s9Z7JzU/NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43769245"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa002.fm.intel.com with ESMTP; 10 Apr 2024 04:48:43 -0700
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
Subject: [PATCH v6 02/11] e1000e: remove convert_art_to_tsc()
Date: Wed, 10 Apr 2024 17:18:19 +0530
Message-Id: <20240410114828.25581-3-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
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


