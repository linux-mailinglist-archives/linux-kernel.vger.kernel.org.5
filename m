Return-Path: <linux-kernel+bounces-10264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6866A81D1E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DC51C22EAD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C60C14B;
	Sat, 23 Dec 2023 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxdFA/Vt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CC4437;
	Sat, 23 Dec 2023 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301955; x=1734837955;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=f+dh5rZALXl/p24n8Vz32jakt6X6ur63JdX+9WjZny0=;
  b=fxdFA/VtFi3pjv5hWWtRlVFdPPZWpIzJ+eD+ugyaax44SIE0pkUyJ4RS
   4a5owJLBWuHxkaA8PvBjjEiDHfFNnX3q+S9VUnUAashhOkMAMzu1/+pBM
   NQpwFRA5UErRjT1IyUI+LDLvEiC333erHXX85pHDOOvtNv5IkfwRSnTaE
   4SqavUxZyEd2/w8Zu0Zw91q+LHVvkdyIBF5cOgKYOnq4I/pDcye/oM5yg
   iIMWHvcsepLJBBXx9ppe1E8uqGM0RPb2rv4mnLmVS1sm4zf3d97JgfdJi
   5JnomIi/PpYIAi1Q4W4Z4o5X6NK35N7xH6uRy/HhrrbZ5h0UmyF3alPGC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462619296"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="462619296"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811534587"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="811534587"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:53 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id C84C3580CC6;
	Fri, 22 Dec 2023 19:25:52 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] platform/x86/intel/pmc: Add missing extern
Date: Fri, 22 Dec 2023 19:25:48 -0800
Message-Id: <20231223032548.1680738-9-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223032548.1680738-1-david.e.box@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing extern for tgl_h_reg_map. Fixes sparse warning:

  drivers/platform/x86/intel/pmc/tgl.c:213:26: warning: symbol 'tgl_h_reg_map' was not declared. Should it be static?

Fixes: 544f7b7f651c ("platform/x86/intel/pmc: Add regmap for Tiger Lake H PCH")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ce7b1cd2b194..2a797fccf5e6 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -452,6 +452,7 @@ extern const struct pmc_bit_map tgl_vnn_misc_status_map[];
 extern const struct pmc_bit_map tgl_signal_status_map[];
 extern const struct pmc_bit_map *tgl_lpm_maps[];
 extern const struct pmc_reg_map tgl_reg_map;
+extern const struct pmc_reg_map tgl_h_reg_map;
 extern const struct pmc_bit_map adl_pfear_map[];
 extern const struct pmc_bit_map *ext_adl_pfear_map[];
 extern const struct pmc_bit_map adl_ltr_show_map[];
-- 
2.34.1


