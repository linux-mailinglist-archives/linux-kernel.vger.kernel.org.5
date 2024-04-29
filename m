Return-Path: <linux-kernel+bounces-161651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7658B4F00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1631F1C20E68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA88BEA;
	Mon, 29 Apr 2024 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGCCSj84"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613117F3;
	Mon, 29 Apr 2024 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351446; cv=none; b=RVBJSp3gtvKmYQZxURpIqnpcJnE0bZc/oI4XEGBXZCyEGnPdLjl1KUIReVB8zC2+RM+Uo5LcjFD67cUy/CSkf1mrmZcxIgHmZNc+RxQTxjbb7PRyjleH+85qOMlMBEH3uNSolDgHxP+g+cUZkC/hs0kVBjE53dGP6uluNo/oW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351446; c=relaxed/simple;
	bh=XTpqSGb/WqBKDfIU+/PC7PAjWXtA2Wwy9iv70sB2u+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMwEm3U/GxxdDVR5ilDvjhw/+rjyJuMkR80fNTAl823U1ILG3AT9cKPwBugiLRnlsRGTTtrl7FN5/2yHN/Z17vwLqPwAnJAJPcVk4nm/Ti3A/N5OYJ6TOYwGDeXYflyFcNOWwood0TwqKJkB4BsSJ/pTdpxF9RXQtTTM+GlCj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGCCSj84; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714351445; x=1745887445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XTpqSGb/WqBKDfIU+/PC7PAjWXtA2Wwy9iv70sB2u+o=;
  b=nGCCSj84pVEZo/XNb9ogRb1zSyaEJIMoqfjdGdmxF2JKSnJ0yBNZCArM
   JtFSio4jG3qbqtHEiPPVJTMHZdGwX52G3C/crdJd8RjS+wGn7b1Gg4qG3
   gTQKKpPv25VD2PmKPDp0UoQ6JG9A+tBlKcAh0JDbd/hre3qQ3MAIMYaBJ
   p2LDRF5iSQgXATEN0UTtVq5qWRqYYDHvXTtZtgUZw/5B8j6LtEWaO+MUx
   BuFv61yaiXfW3oPX5Nkxqf/bVoOWaOuz+009CqOJBjFufiayTORurA37p
   ip8GL27dop2+CnEwrMc5MAk4ZsgN8FLVuaxPmu7BvWrgG7tSJBr2AB8J/
   w==;
X-CSE-ConnectionGUID: sIwObsKmS6y2Z2b6xoYPEg==
X-CSE-MsgGUID: zNmJzB+uTA+UvA5BRejXRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21152941"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="21152941"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:02 -0700
X-CSE-ConnectionGUID: pNFB6MG7SmCgKMIOLxf/ew==
X-CSE-MsgGUID: 75hynvahSnmqlOzlMvlYyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30423060"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:01 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 3/4] soundwire: intel_ace2.x: add support for DODSE property
Date: Mon, 29 Apr 2024 00:43:20 +0000
Message-Id: <20240429004321.2399754-4-yung-chuan.liao@linux.intel.com>
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

Extend previous patches with the DODSE field and property.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.h           | 1 +
 drivers/soundwire/intel_ace2x.c     | 3 +++
 drivers/soundwire/intel_auxdevice.c | 7 ++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index b36d46319f0f..f58860f192f9 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -60,6 +60,7 @@ struct sdw_intel {
 
 struct sdw_intel_prop {
 	u16 doais;
+	u16 dodse;
 	u16 dods;
 };
 
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 917cc79d4d85..a07fd4a79f00 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -28,15 +28,18 @@ static void intel_shim_vs_init(struct sdw_intel *sdw)
 	struct sdw_bus *bus = &sdw->cdns.bus;
 	struct sdw_intel_prop *intel_prop;
 	u16 doais;
+	u16 dodse;
 	u16 dods;
 	u16 act;
 
 	intel_prop = bus->vendor_specific_prop;
 	doais = intel_prop->doais;
+	dodse = intel_prop->dodse;
 	dods = intel_prop->dods;
 
 	act = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL);
 	u16p_replace_bits(&act, doais, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
+	u16p_replace_bits(&act, dodse, SDW_SHIM2_INTEL_VS_ACTMCTL_DODSE);
 	u16p_replace_bits(&act, dods, SDW_SHIM2_INTEL_VS_ACTMCTL_DODS);
 	act |= SDW_SHIM2_INTEL_VS_ACTMCTL_DACTQE;
 	intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL, act);
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 697d64070794..7310441050b1 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -160,18 +160,23 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 
 	/* initialize with hardware defaults, in case the properties are not found */
 	intel_prop->doais = 0x3;
+	intel_prop->dodse  = 0x0;
 	intel_prop->dods  = 0x1;
 
 	fwnode_property_read_u16(link,
 				 "intel-sdw-doais",
 				 &intel_prop->doais);
+	fwnode_property_read_u16(link,
+				 "intel-sdw-dodse",
+				 &intel_prop->dodse);
 	fwnode_property_read_u16(link,
 				 "intel-sdw-dods",
 				 &intel_prop->dods);
 	bus->vendor_specific_prop = intel_prop;
 
-	dev_dbg(bus->dev, "doais %#x dods %#x\n",
+	dev_dbg(bus->dev, "doais %#x dodse %#x dods %#x\n",
 		intel_prop->doais,
+		intel_prop->dodse,
 		intel_prop->dods);
 
 	return 0;
-- 
2.34.1


