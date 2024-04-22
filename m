Return-Path: <linux-kernel+bounces-154177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2A8AD8DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC811F21AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA00153824;
	Mon, 22 Apr 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmhVXLvL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23A1C287;
	Mon, 22 Apr 2024 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826992; cv=none; b=oYjMH2N1CDef+0a+5yomj6uabFytMn5kzI52u7mgYPZ1TREPHN/4FcpZFwLhf8WiFWOiSVlwGAqWWmOvmXqkqTMCN+E2vngaLVfnVkeG4nFUg4WwnSTIYz7c2D8+SlkzTWEooLuKlBpnBE1fUjckdsu0oA0zWPyItzdvykon1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826992; c=relaxed/simple;
	bh=hU3tih+CYLkWcqELt+cdSLFQH3WOoHaPLUqROgE6iEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLBNvWLsFqSiLa5PAV/WYgZaSGjWKW4DCxq0BM3FUJXPoZ0G2cOyv9g3+oyHGnlF1Ai9Ti9BTQWq+0+DgMlASn0momEvTY/u4JJrZTPnO4LXDVDHR3HdUuq70DX7tUy1NRgJclucu1XLTKUp6bt6I4KOWMqMadoK716+XE5G7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmhVXLvL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713826990; x=1745362990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hU3tih+CYLkWcqELt+cdSLFQH3WOoHaPLUqROgE6iEQ=;
  b=fmhVXLvLtnqYn9J1sZFx7bVNhiuG2NmdY+UVTv/A/jTnUuEsPRte6v9h
   MkUrdLMoPKoWjSrLOsqeU5PuOyWa4HNEfw5Iqp//gdlFMGpuC/vbiMe7U
   2qwR2O5BY63lXAYiV/EPoM03/Bdv4lZEfi7vU+Zj5P1r8p9etQKj6veig
   kkwUdpLgsGqzS5TxYt7QmeW+EWHSJEitBCNZ5Gr+ucgVs4lk/Zv6KLqWM
   eBJdhvIa/ask5lY8JwzawwMR+450kAAiaujP4drBwpNH9Cr3NZKMQbfJF
   27djJ3SMtjc0R2mNhEj6GQqmc2z9VyfMXs9nyvvtJUBw6S030HV6Q8I5z
   w==;
X-CSE-ConnectionGUID: Y0s9aKHeSgGUFXHfJlDNEA==
X-CSE-MsgGUID: qWfM14juQGKqrhLfLf+o1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13222252"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="13222252"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:03:09 -0700
X-CSE-ConnectionGUID: Zq8OeGzUTKSBtMCnfKTF/g==
X-CSE-MsgGUID: veEMAIAqRbqx8I6lengsWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55102270"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:03:08 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH] fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card
Date: Mon, 22 Apr 2024 19:02:57 -0400
Message-ID: <20240422230257.1959-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCI subdevice ID for the Intel D5005 Stratix 10 FPGA card as
used with the Open FPGA Stack (OFS) FPGA Interface Manager (FIM).

Unlike the Intel D5005 PAC FIM which exposed a separate PCI device ID,
the OFS FIM reuses the same device ID for all DFL-based FPGA cards
and differentiates on the subdevice ID. The subdevice ID values were
chosen as the numeric part of the FPGA card names in hexadecimal.

Link: https://github.com/OFS/dfl-feature-id/pull/4
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
This patch was applied to Linux v6.9-rc5 and tested on an Intel D5005
card flashed with the latest released OFS 2024.1-1 D5005 FIM.

# fpgainfo fme D8:00.0
Intel FPGA Programmable Acceleration Card D5005
Board Management Controller, MAX10 NIOS FW version: 2.0.12 
Board Management Controller, MAX10 Build version: 2.0.8 
//****** FME ******//
Interface                        : DFL
Object Id                        : 0xED00002
PCIe s:b:d.f                     : 0000:D8:00.0
Vendor Id                        : 0x8086
Device Id                        : 0xBCCE
SubVendor Id                     : 0x8086
SubDevice Id                     : 0x138D
Socket Id                        : 0x00
Ports Num                        : 01
Bitstream Id                     : 0x4010002183C88A9
Bitstream Version                : 4.0.1
Pr Interface Id                  : a195b6f7-cf23-5a2b-8ef9-1161e184ec4e
Boot Page                        : user

Link: https://github.com/OFS/ofs-d5005/releases/tag/ofs-2024.1-1
---
The missing subdevice ID 0x138d was noticed while testing the patch
series "fpga: dfl: fix kernel warning on port release/assign for SRIOV"
applied to v6.9-rc4 on an Intel D5005 card. The absence of the subdevice
ID was shadowed by an internal patch in the downstream Linux DFL kernel
("fpga: dfl: Add wildcard sub-device ID for intel DFL devs").

Link: https://github.com/OFS/linux-dfl/commit/27d3d71824f086acae86e41a87b591838b7fa9d1
---
 drivers/fpga/dfl-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 98b8fd16183e..80cac3a5f976 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -78,6 +78,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
 #define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
 /* PCI Subdevice ID for PCIE_DEVICE_ID_INTEL_DFL */
+#define PCIE_SUBDEVICE_ID_INTEL_D5005		0x138d
 #define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
 #define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
 #define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
@@ -101,6 +102,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_D5005),},
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
 			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
-- 
2.44.0


