Return-Path: <linux-kernel+bounces-157450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ADC8B11CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342881C22D36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96C16DEAC;
	Wed, 24 Apr 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nV1Mcb4r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD54216D9B8;
	Wed, 24 Apr 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982488; cv=none; b=RCfNXC+0bdirx6/K7ryCVnh0TAg5gBVX/2xBFbaVwkyVy/NCjFisUxUhu5C7lJWIa/quJ8pa6MjR/+dL11x5X1KfVproi+c6eM7XXBKGRNSvxHFtXEf169ZzNTRh+3g9+q81aBOuC1sGyf8T6321riAk1oJlClhaovJEWmfBhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982488; c=relaxed/simple;
	bh=/rcxfZFq/If/iTRicqHHlhcazvtiWYDXEQfNN+mI/L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFbl8zyx4H4dAZdJmJizi3DQOZu8l11/9ApBHjPSgh9UcsuU7wBOg16+UTUD4hIMS4+DwDaogNb4SamDFUthzNh8/5YhCgZqanWKYgzFkIWwpjP58HnU0GVvw1g77AW+4L/nb+VTbSaxfgu1Nm2x2xAQPiKicsTwQwhzQybTIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nV1Mcb4r; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982487; x=1745518487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/rcxfZFq/If/iTRicqHHlhcazvtiWYDXEQfNN+mI/L8=;
  b=nV1Mcb4rcCUmK8JD4aUajHq93x1lVE3COeCEbrisPgO/n2hBHFELmL8O
   73GBjiV5RftFAGvOxbrj+pmFJCK8JG7VelSPYQJo9ncuRWrvDUF1lYPIe
   PAUor+qu6fDQCUhDepd6tlTnLAD86hwCtDYVDfPCfJWH37Bhvl7MYX8+z
   yPD4pEfpnX6VD5cd0GYIX3bxujGPsfKuU9kA0Vp3o0acKWjYyHJMRE5hJ
   ZtVGUMCgS95+6yHKmsi/9jAJOjOaPivsBhIzB4yo1016wbs4fhvmjXE+6
   +Yy6vfxrShS0wxo8PdBbACJ6kOXHKcZmY7GiGHWdFXZz7+ASaSpmYPxO/
   w==;
X-CSE-ConnectionGUID: LWIis1T5R9azUSBFzohPzg==
X-CSE-MsgGUID: NZlkd1huSr2VQg3dXkS9tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503359"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503359"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:45 -0700
X-CSE-ConnectionGUID: Mfu24fcYRIKkqr0c4/Ro3g==
X-CSE-MsgGUID: vyJyAnfjRqG8FTeojm3WLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24683647"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:45 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 01/71] tpm: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:44 -0700
Message-ID: <20240424181444.41174-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm.h          | 2 +-
 drivers/char/tpm/tpm_tis_core.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 61445f1dc46d..7b38ce007bdc 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -28,7 +28,7 @@
 #include <linux/tpm_eventlog.h>
 
 #ifdef CONFIG_X86
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #endif
 
 #define TPM_MINOR		224	/* officially assigned */
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 13e99cf65efe..c940fd18988e 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -210,7 +210,7 @@ static inline int tpm_tis_verify_crc(struct tpm_tis_data *data, size_t len,
 static inline bool is_bsw(void)
 {
 #ifdef CONFIG_X86
-	return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1 : 0);
+	return ((boot_cpu_data.x86_vfm == INTEL_ATOM_AIRMONT) ? 1 : 0);
 #else
 	return false;
 #endif
-- 
2.44.0


