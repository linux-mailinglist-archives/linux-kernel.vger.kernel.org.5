Return-Path: <linux-kernel+bounces-150423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949A58A9F05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506612840DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B31B16F904;
	Thu, 18 Apr 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVH8D3sW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16016EBFB;
	Thu, 18 Apr 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455376; cv=none; b=pyGEurNiNP06VFa4GLHo7c/dQGe+BthwgeUaF79UENvJBivbSuf+UO7rv5e8YIXAy6hf8k9ztCmi92x8uc/f60ImXqN2segoOf72p6vr5zlzOO4xBewEvR5e4T5GemuTlOt/4Zwnec+IUnmGOCWzeSO+DxmueOsRYITyQE9Qhpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455376; c=relaxed/simple;
	bh=cgOxz3t5+D06EepcrvAFwiMe6M9c4cdtC73ERv6sXc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTEjzrxJ/0b4TaUYdeR5w68qQc8tLhxt2th0AFz1wYwIFe+fQJqn0Zu5EIfouezhWbf5G7wwMwdVM+HpPHBeb7vczRzdKbQZNDYnavNjgnl7SHk+In0YMJnxhc8G3ygylWu7e69shL0JgFgE/qduQDQJ/grP0ZqK/eXrpwgzOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVH8D3sW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713455376; x=1744991376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cgOxz3t5+D06EepcrvAFwiMe6M9c4cdtC73ERv6sXc8=;
  b=lVH8D3sW9LRb6BzDNj7vrdibsNb8dW+oDkwexpZa/ewGZobhf2oRrSGm
   CsblU3cMNPseWnWeccq/89IhOjHdD3w6nKtPev0a3HqYRPBfVh4y837/o
   a38fMlLfwRRytExK9y1B+JzRq1ACxdwKU0h+BsB78BH9VTF0j9iMJDZ4O
   Pae8jFS9GfWf3BvGF9f36srcEeTeSHfyLKiTq6elWf60FHlLxGOguPTj6
   ALgQWyEsZ5sQW0c3/uc0ogapC8pYDvy7oMYd4DeyOj4mXixsiD7VzE5Yo
   EkaCDF/pRVCbMKmUVJLYNXfUS+XNf7xOQmMc6CGQjQ38QSxP2P0rFxqf1
   A==;
X-CSE-ConnectionGUID: kVr5l4SmRL2XaAsScqNfKA==
X-CSE-MsgGUID: KaWSfV5IRIStaNIhlmSFow==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12800840"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12800840"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:49:34 -0700
X-CSE-ConnectionGUID: YxxEDX90TnWQkLlIcxgu9A==
X-CSE-MsgGUID: Noj5MdCyRMOyZy2OciXg/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23102507"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2024 08:49:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 92E1C3A6; Thu, 18 Apr 2024 18:49:29 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Niklas Neronin <niklas.neronin@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] xhci: pci: Group out Thunderbolt xHCI IDs
Date: Thu, 18 Apr 2024 18:48:34 +0300
Message-ID: <20240418154928.3641649-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240418154928.3641649-1-andriy.shevchenko@linux.intel.com>
References: <20240418154928.3641649-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's better to keep track on Thunderbold xHCI IDs in a separate group.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 70bf318fd7ef..332c5843ada5 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -46,6 +46,15 @@
 #define PCI_DEVICE_ID_INTEL_BROXTON_M_XHCI		0x0aa8
 #define PCI_DEVICE_ID_INTEL_BROXTON_B_XHCI		0x1aa8
 #define PCI_DEVICE_ID_INTEL_APOLLO_LAKE_XHCI		0x5aa8
+#define PCI_DEVICE_ID_INTEL_DENVERTON_XHCI		0x19d0
+#define PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI		0x8a13
+#define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
+#define PCI_DEVICE_ID_INTEL_COMET_LAKE_XHCI		0xa3af
+#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
+#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
+
+/* Thunderbolt */
+#define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI	0x15b6
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_XHCI	0x15c1
@@ -54,13 +63,6 @@
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI		0x15e9
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI		0x15ec
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI		0x15f0
-#define PCI_DEVICE_ID_INTEL_DENVERTON_XHCI		0x19d0
-#define PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI		0x8a13
-#define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
-#define PCI_DEVICE_ID_INTEL_COMET_LAKE_XHCI		0xa3af
-#define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
-#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
 
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
-- 
2.43.0.rc1.1336.g36b5255a03ac


