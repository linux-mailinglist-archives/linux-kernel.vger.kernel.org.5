Return-Path: <linux-kernel+bounces-158562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A33F8B220D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABE4B220C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7A1494C7;
	Thu, 25 Apr 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNot6EmC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59CB1494C0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049793; cv=none; b=MeoH4PRqGCibZmVHrwatjCn6FufFX897nO828Y8CB2eFQdtArHhYRWrN/ZjaEZjfheddxgStLSPcifP4Kpb4L3Pacs0tx23T+NOc/ju8jY4GB2AZgQ0gmzKyBIQd1j+V5eRMOTdBq5DnmBoDxIk2FlfOsZL0ykmFfBD2zjtsAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049793; c=relaxed/simple;
	bh=PNoj1MIfk8TeZSxThxuQAL8m73MC3/EFgmLZCQqIs/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ru+gqJjGus3grAciiHbqFxWoXfEfYfo4ngTwjieY2Dyrd8LrCvHvyhpVWOlzIPKRT4ByQxaJowW+ASf5b17uKJfn9vqRWyI2Sjq4Gp5sUT9hsB26YDXLcq9pny7XSMYsgChkWof/ibuUDTxIQ4pCdZnrw/1dAvsMf2RGXX00Kyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNot6EmC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714049791; x=1745585791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PNoj1MIfk8TeZSxThxuQAL8m73MC3/EFgmLZCQqIs/M=;
  b=JNot6EmCUXv9RoRQeKf/cV5qrE+rrAkMgAYS5ARlQjuGXBDOPArMOguw
   Z4/m7l+tMI6uMawkTeoZXwztpIzOQD2TSUJSFakphMwW6etiL4cgigq7L
   gNi8gTH19QmMXnVCkp78y4ZVH2Vs2zrRelPEo3AziQ3UTb6HQ+tbNWw0W
   SI+Va26+1ZRfUZfRdYc62gR2i0UgfA2NZVQFI1ba5R32QCfbpEzdmiONx
   Rc++V3mNW7S7s+3eIA+nVa5Y/ZKqsAHAP6J+EpTf9VysNOzXnTpvb26J5
   Qf3kMZd0wjaSLzO5AMyC9T20vqUwrCZl0u2Xif+MEmMJWpsCUBk1kn2Dn
   g==;
X-CSE-ConnectionGUID: AVO15zazTemZbDFaEBpdUw==
X-CSE-MsgGUID: 2FiiuAWGSxm9Wt1dkNHaGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9843308"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9843308"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 05:56:31 -0700
X-CSE-ConnectionGUID: YX+4DFKDRyCnSFndfN4pCQ==
X-CSE-MsgGUID: RdalsdeoRf+p/FneSHnwRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25127583"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 25 Apr 2024 05:56:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C7DC4586; Thu, 25 Apr 2024 15:56:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/mipi-dbi: Add missing MODULE_DESCRIPTION()
Date: Thu, 25 Apr 2024 15:56:26 +0300
Message-ID: <20240425125627.2275559-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modpost script is not happy

  WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_mipi_dbi.o

because there is a missing module description.

Add it to the module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index daac649aabdb..ee6fa8185b13 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -1475,4 +1475,5 @@ EXPORT_SYMBOL(mipi_dbi_debugfs_init);
 
 #endif
 
+MODULE_DESCRIPTION("MIPI Display Bus Interface (DBI) LCD controller support");
 MODULE_LICENSE("GPL");
-- 
2.43.0.rc1.1336.g36b5255a03ac


