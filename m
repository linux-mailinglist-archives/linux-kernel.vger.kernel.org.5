Return-Path: <linux-kernel+bounces-161650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EC8B4EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2001F2139E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5026FA7;
	Mon, 29 Apr 2024 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQAhwiWI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFBA624;
	Mon, 29 Apr 2024 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351444; cv=none; b=HvLz1xAg4qMV9JpofWrqN+7PMeGOAklzyroGBHxYk7978ilz6/cZVpBSFRXJPg1XkyFDdi6dAu1esDeC9o9xTiehf7+yRB5hECCVx5naGQhubDT98b1L/tAdrqR6V1HN1T1Xezu47YUq0uJRnAPyJCd87A0YI0uQr5/A8nQw8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351444; c=relaxed/simple;
	bh=Fs5Wd4bvoxAGg4B0xLOE1k0u+3+ahDP1iX1z3POoDfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jW0Mg2VaLN5FjzMM1aJ9le7ivaCSQPWjYSSgPD0XW+NLrnWLT7UFcECKtqOOJjTJcT/iPld/ybKXAC/r1Dmra0x/SrlPJAL5wIQYHt6v8ajBI80PPPUas1npPLd17qAg0+akMH14zXJjDUkK2ODAzt3pCTsc/lBKrb51X9YD1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQAhwiWI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714351444; x=1745887444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fs5Wd4bvoxAGg4B0xLOE1k0u+3+ahDP1iX1z3POoDfI=;
  b=UQAhwiWI4sakiiz1+Tia7O/qIS1O6GDT8lgkhrvi8i7AvgM93LvIN9iM
   d5RaKBEG4nMGkAo4vSPmzMrVjZ4biDzkNemSjRHhKAppGtkf7fgO78De0
   D2MVsT5mCKRP75qAoO/ybuD10J8BIlNG+zu0xQ1g0EHUOZyg4i6LK0z9o
   apheVf6KL2yhfMdf1xfU365L993kzpkMQW2mnKEVnPbUTgiL2s/0Z+mxg
   jWF9xo8YbouSoZfPrOFNHVz22L/+lpu4lag2xKtl2b3yuISAda20D0+4h
   PqVwY1DsYOw66uvOoa85rIjyZtBfDn+Qmg9xgK7T0y2YzQAtl8VxEPLEO
   g==;
X-CSE-ConnectionGUID: UY4N7wQqSg2Lfit5qJVoMw==
X-CSE-MsgGUID: eWmmuPO5RLKkbv3Lk7XHHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21152938"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="21152938"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:01 -0700
X-CSE-ConnectionGUID: cJkDek7jRwiKbmNpmtluSA==
X-CSE-MsgGUID: p2ybH0ILTqCXRYTUysW/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30423057"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:01 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 2/4] soundwire: intel_ace2x: use DOAIS and DODS settings from firmware
Date: Mon, 29 Apr 2024 00:43:19 +0000
Message-Id: <20240429004321.2399754-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
References: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Starting with LNL, the recommendation is to use settings read from DSD
properties instead of hard-coding the values.

The DOAIS and DODS values are completely-specific to Intel and are
stored in a vendor-specific property structure.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.h           |  5 +++++
 drivers/soundwire/intel_ace2x.c     |  7 +++++--
 drivers/soundwire/intel_auxdevice.c | 21 +++++++++++++++++++++
 include/linux/soundwire/sdw.h       |  2 ++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 511932c55216..b36d46319f0f 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -58,6 +58,11 @@ struct sdw_intel {
 #endif
 };
 
+struct sdw_intel_prop {
+	u16 doais;
+	u16 dods;
+};
+
 enum intel_pdi_type {
 	INTEL_PDI_IN = 0,
 	INTEL_PDI_OUT = 1,
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 32b538cd6d66..917cc79d4d85 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -25,12 +25,15 @@
 static void intel_shim_vs_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim_vs = sdw->link_res->shim_vs;
+	struct sdw_bus *bus = &sdw->cdns.bus;
+	struct sdw_intel_prop *intel_prop;
 	u16 doais;
 	u16 dods;
 	u16 act;
 
-	doais = 0x3;
-	dods = 0x1;
+	intel_prop = bus->vendor_specific_prop;
+	doais = intel_prop->doais;
+	dods = intel_prop->dods;
 
 	act = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL);
 	u16p_replace_bits(&act, doais, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 296a470ce1e0..697d64070794 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -122,6 +122,7 @@ static void generic_new_peripheral_assigned(struct sdw_bus *bus,
 static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 {
 	struct sdw_master_prop *prop = &bus->prop;
+	struct sdw_intel_prop *intel_prop;
 	struct fwnode_handle *link;
 	char name[32];
 	u32 quirk_mask;
@@ -153,6 +154,26 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
 		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
 
+	intel_prop = devm_kzalloc(bus->dev, sizeof(*intel_prop), GFP_KERNEL);
+	if (!intel_prop)
+		return -ENOMEM;
+
+	/* initialize with hardware defaults, in case the properties are not found */
+	intel_prop->doais = 0x3;
+	intel_prop->dods  = 0x1;
+
+	fwnode_property_read_u16(link,
+				 "intel-sdw-doais",
+				 &intel_prop->doais);
+	fwnode_property_read_u16(link,
+				 "intel-sdw-dods",
+				 &intel_prop->dods);
+	bus->vendor_specific_prop = intel_prop;
+
+	dev_dbg(bus->dev, "doais %#x dods %#x\n",
+		intel_prop->doais,
+		intel_prop->dods);
+
 	return 0;
 }
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 7bb9119f3069..13e96d8b7423 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -886,6 +886,7 @@ struct sdw_master_ops {
  * @port_ops: Master port callback ops
  * @params: Current bus parameters
  * @prop: Master properties
+ * @vendor_specific_prop: pointer to non-standard properties
  * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
  * is used to compute and program bus bandwidth, clock, frame shape,
  * transport and port parameters
@@ -920,6 +921,7 @@ struct sdw_bus {
 	const struct sdw_master_port_ops *port_ops;
 	struct sdw_bus_params params;
 	struct sdw_master_prop prop;
+	void *vendor_specific_prop;
 	struct list_head m_rt_list;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
-- 
2.34.1


