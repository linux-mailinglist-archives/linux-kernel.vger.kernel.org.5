Return-Path: <linux-kernel+bounces-152466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9378ABED9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5E7280EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D13E567;
	Sun, 21 Apr 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNcswA7A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E2205E26
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713690442; cv=none; b=bam18eKmqXyuDpZz0QTpoS11K0O6YcuGDg8jxN/IQ9DCYv2rGD5peUQpmQNdvZ4Wp4nEuzx9rHe0m1OzCo+ywjOdFVfQ5LQnyb0XQ1V4MBvr+Ef6NRrNogz0OcusXO+XA3TqLivSE/uHRj3qG/4CqWPUcw+6v+vEUrfU6fwoQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713690442; c=relaxed/simple;
	bh=3x+Eg0DhyZ2twNLDp9xQW901B/ToxhBaZkvAN23ra0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wm/I7uUVCpWiC6rhGUl/BsDO5xjqvl5qA9t4wZMMvAoCHu51etN3nWSTwaewNpNi02k9ydaIyMX3f5nQHsqMjNLQZoE2cjWQgtgAeIVHHGUIufmAzJgtQMdFhpv9ZSk2ZXfGE8K5jL6hnfWRIua4NwHiVzlXoIhNdp9kz8LR7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNcswA7A; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713690440; x=1745226440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3x+Eg0DhyZ2twNLDp9xQW901B/ToxhBaZkvAN23ra0k=;
  b=fNcswA7AagN8mMVICWJxqISMuFHKtt9yZzI0dnIy0iPMi9s9JtWslmcv
   7J9jE9rX54eHErW1T0UKKV92OAOK5R9nBBm7yRAGgZQnipLZiBqb50saI
   ucR+sI/XovGNEzG5jpouix9haF0Ewpnb3APuR3qzjtxejXF53pIS+y5rt
   /0TlPIfXB3nIytx6FyYmIcsZbXlgxYbV0xzPRCDs4Rc+/ma3fLKHXYMgZ
   NS1I8+pyMgmfGs+FUQ/bTIsXPodxlV47HWXpyxC16a9WsA7CQdFM86uB1
   R8Ubp4XpVnyN+TPI1N2/fgDqxOWPHNxzPkvv4Gyf49F7aAs2Jer/3p7hs
   Q==;
X-CSE-ConnectionGUID: eTOp4UrpTOinS05jnVJp4A==
X-CSE-MsgGUID: vC9qOzt3TimRv1353p795A==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="19936884"
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; 
   d="scan'208";a="19936884"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 02:07:19 -0700
X-CSE-ConnectionGUID: gzbzL2rLQiqqpis0t5dnng==
X-CSE-MsgGUID: kf31Wgc3R5Cd7EF7ZhHUYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; 
   d="scan'208";a="23802110"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 02:07:17 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: pxp: match against PCI_CLASS_DISPLAY_OTHER
Date: Sun, 21 Apr 2024 12:07:01 +0300
Message-ID: <20240421090701.216028-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

The ATS-M class is PCI_CLASS_DISPLAY_OTHER instead of
PCI_CLASS_DISPLAY_VGA, so we need to match against that class as well.
The matching is still restricted to Intel devices only.

Fixes: ceeedd951f8a ("mei: pxp: match without driver name")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pxp/mei_pxp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index b1e4c23b31a32957c616f0ed..49abc95677cdac6a74d673cb 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -236,8 +236,11 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
 
 	pdev = to_pci_dev(dev);
 
-	if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8) ||
-	    pdev->vendor != PCI_VENDOR_ID_INTEL)
+	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return 0;
+
+	if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8) &&
+	    pdev->class != (PCI_CLASS_DISPLAY_OTHER << 8))
 		return 0;
 
 	if (subcomponent != I915_COMPONENT_PXP)
-- 
2.44.0


