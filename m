Return-Path: <linux-kernel+bounces-3106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C56816788
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8884D1F222D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A06D514;
	Mon, 18 Dec 2023 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sgc5uQRc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2AD308
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702885174; x=1734421174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GEmWAWVomHWCdUBZyAIApou36iIe4S6MFVaagJvlxvs=;
  b=Sgc5uQRcK4M47JLUAg7L4/WZtpPqyYBOA/3CmFXs7Tp/7r4l4zkfaXEc
   elCpBn9eJxXMeS/MgA5LWaePgXoFE3w/gNNqEpcSaBjKplNaBl5b1rOeI
   pXClMpn7s80t+SEXYCzMo/e6x0vnnKZ4RJpLmAZvaeT9kzg54Qq6TRBmk
   thPXWqkZR7vm16LNTAWjFSz8LcA9Pls5BeoIRopqhx9QSpIJIfvRpb4sX
   nxSI2WRjj5RU0VTqTWJzrbHSITZetzgOr1Zhqaq6bbulgQVXmI+Vi7flC
   SlgH8kogs0ao+9Omo0Z+JYkxSUe/+27+8sZ+pKXNGT8HYQtrn+5z8YC0Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="459793917"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="459793917"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:39:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893723241"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="893723241"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2023 23:39:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.8
Date: Mon, 18 Dec 2023 15:34:41 +0800
Message-Id: <20231218073445.142401-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following patches have been queued for v6.8:

 - Cleanup and refactoring

All patches are based on v6.7-rc6. The series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.8

Please consider them for the next branch.

Best regards,
Baolu

Lu Baolu (4):
  iommu/vt-d: Refactor device_to_iommu() to retrieve iommu directly
  iommu/vt-d: Remove unused parameter of
    intel_pasid_setup_pass_through()
  iommu/vt-d: Remove unused vcmd interfaces
  iommu/vt-d: Move inline helpers to header files

 drivers/iommu/intel/iommu.h   | 179 +++++++++++++++++++++-
 drivers/iommu/intel/pasid.h   | 223 +++++++++++++++++++++++++--
 drivers/iommu/intel/debugfs.c |   3 -
 drivers/iommu/intel/iommu.c   | 239 +++--------------------------
 drivers/iommu/intel/pasid.c   | 274 +---------------------------------
 drivers/iommu/intel/svm.c     |  20 +--
 6 files changed, 415 insertions(+), 523 deletions(-)

-- 
2.34.1


