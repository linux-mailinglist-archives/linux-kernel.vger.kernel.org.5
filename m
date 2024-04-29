Return-Path: <linux-kernel+bounces-161653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208708B4F03
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68CD28208D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBCC624;
	Mon, 29 Apr 2024 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDuLk0u9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C058387;
	Mon, 29 Apr 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351794; cv=none; b=ozIEdindAZK9hqUldCJS61pDzk7gxouf5JvbUJYD9WVzHRl91HkXF05x4ukE5aaobGQH/vRUHi3HOySrNMNPPjHxirkG/DdHjdLo7aGRDywg1r4oCJa38iAHiUCsqfD5uTKfMJu5x2q7tGJo72ab0dKzRpFc3f780n8qQy7TjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351794; c=relaxed/simple;
	bh=1rI/fnVnynJWNj6Vi5pboqNL2tveQmZtoQ6jcLlCZw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDekGSERb6JDcqvECMTETgZpnxo1HM7SEzEXG+dYAKmNyyZzD2nNK1fT/aMgyAZ92YhSVbkL3JBzybvdBl5cYGrMaCFvbNCJ3xeYrHDJszDBuF1oG2OCZ/Ug1ST/BBXk1SNq2lxceTJliPrzT0djz0SWdxTsvJmj4ljiTpj9ahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDuLk0u9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714351793; x=1745887793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1rI/fnVnynJWNj6Vi5pboqNL2tveQmZtoQ6jcLlCZw8=;
  b=lDuLk0u9Fk5rhedkzY+lDwOwK3KT7COigwNPjJcbVphUwD0d+G042fr7
   ScptVPiwFhTpgTJCECZoRN3si3Vz9RTACZn1KoyJL3yBPyVrkTsfulWHz
   XD2latdESmdh0/UzJqo3jNug1QAL2X4eyllvq5GFH7jQxKHrBLtOvL855
   BV4mZZV70fTcaGGTuvtKHmajEWv1OVCT3qquRJABbbMFTBq60v83yvLbC
   MgqCteikP9W7vgTMFyPqXDQJvD29qBPma3/YZRMH8Y5dOaOswTB86+8AT
   UBuIZH0eIvfrn138peAglW1PSu2DwkGQPoBe+Sh4qBhmUp1m1+HwYgGnJ
   A==;
X-CSE-ConnectionGUID: X6+ztJG9RIec0BSVUcGh0w==
X-CSE-MsgGUID: NVm4pMCiTpmqpL+o+zAHPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12939232"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="12939232"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:49:52 -0700
X-CSE-ConnectionGUID: BcyywiTCSweBTPqSHrROVQ==
X-CSE-MsgGUID: 8r3iYPLORSCw6dk1UJV0Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30770804"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:49:52 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: fix usages of device_get_named_child_node()
Date: Mon, 29 Apr 2024 00:49:35 +0000
Message-Id: <20240429004935.2400191-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The documentation for device_get_named_child_node() mentions this
important point:

"
The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer.
"

Add fwnode_handle_put() to avoid leaked references.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/amd_manager.c     |  3 +++
 drivers/soundwire/intel_auxdevice.c |  6 +++++-
 drivers/soundwire/mipi_disco.c      | 30 +++++++++++++++++++++++------
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 1066d87aa011..14bc624bc6b5 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -558,6 +558,9 @@ static int sdw_master_read_amd_prop(struct sdw_bus *bus)
 	amd_manager->wake_en_mask = wake_en_mask;
 	fwnode_property_read_u32(link, "amd-sdw-power-mode", &power_mode_mask);
 	amd_manager->power_mode_mask = power_mode_mask;
+
+	fwnode_handle_put(link);
+
 	return 0;
 }
 
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 17cf27e6ea73..18517121cc89 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -155,8 +155,10 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
 
 	intel_prop = devm_kzalloc(bus->dev, sizeof(*intel_prop), GFP_KERNEL);
-	if (!intel_prop)
+	if (!intel_prop) {
+		fwnode_handle_put(link);
 		return -ENOMEM;
+	}
 
 	/* initialize with hardware defaults, in case the properties are not found */
 	intel_prop->doaise = 0x1;
@@ -184,6 +186,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 		intel_prop->dodse,
 		intel_prop->dods);
 
+	fwnode_handle_put(link);
+
 	return 0;
 }
 
diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 55a9c51c84c1..e5d9df26d4dc 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -66,8 +66,10 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		prop->clk_freq = devm_kcalloc(bus->dev, prop->num_clk_freq,
 					      sizeof(*prop->clk_freq),
 					      GFP_KERNEL);
-		if (!prop->clk_freq)
+		if (!prop->clk_freq) {
+			fwnode_handle_put(link);
 			return -ENOMEM;
+		}
 
 		fwnode_property_read_u32_array(link,
 				"mipi-sdw-clock-frequencies-supported",
@@ -92,8 +94,10 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
 					       sizeof(*prop->clk_gears),
 					       GFP_KERNEL);
-		if (!prop->clk_gears)
+		if (!prop->clk_gears) {
+			fwnode_handle_put(link);
 			return -ENOMEM;
+		}
 
 		fwnode_property_read_u32_array(link,
 					       "mipi-sdw-supported-clock-gears",
@@ -116,6 +120,8 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	fwnode_property_read_u32(link, "mipi-sdw-command-error-threshold",
 				 &prop->err_threshold);
 
+	fwnode_handle_put(link);
+
 	return 0;
 }
 EXPORT_SYMBOL(sdw_master_read_prop);
@@ -197,8 +203,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 						    dpn[i].num_words,
 						    sizeof(*dpn[i].words),
 						    GFP_KERNEL);
-			if (!dpn[i].words)
+			if (!dpn[i].words) {
+				fwnode_handle_put(node);
 				return -ENOMEM;
+			}
 
 			fwnode_property_read_u32_array(node,
 					"mipi-sdw-port-wordlength-configs",
@@ -236,8 +244,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 						       dpn[i].num_channels,
 						       sizeof(*dpn[i].channels),
 						 GFP_KERNEL);
-			if (!dpn[i].channels)
+			if (!dpn[i].channels) {
+				fwnode_handle_put(node);
 				return -ENOMEM;
+			}
 
 			fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-number-list",
@@ -251,8 +261,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 					dpn[i].num_ch_combinations,
 					sizeof(*dpn[i].ch_combinations),
 					GFP_KERNEL);
-			if (!dpn[i].ch_combinations)
+			if (!dpn[i].ch_combinations) {
+				fwnode_handle_put(node);
 				return -ENOMEM;
+			}
 
 			fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-combination-list",
@@ -274,6 +286,8 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 		/* TODO: Read audio mode */
 
+		fwnode_handle_put(node);
+
 		i++;
 	}
 
@@ -348,10 +362,14 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 		prop->dp0_prop = devm_kzalloc(&slave->dev,
 					      sizeof(*prop->dp0_prop),
 					      GFP_KERNEL);
-		if (!prop->dp0_prop)
+		if (!prop->dp0_prop) {
+			fwnode_handle_put(port);
 			return -ENOMEM;
+		}
 
 		sdw_slave_read_dp0(slave, port, prop->dp0_prop);
+
+		fwnode_handle_put(port);
 	}
 
 	/*
-- 
2.34.1


