Return-Path: <linux-kernel+bounces-164430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCFD8B7DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092CC1C23B13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38C317BB11;
	Tue, 30 Apr 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icR0xPDD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C178173351
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495894; cv=none; b=IZc8C+XYPsrDGKTfbXvAAgxgvMLjcvin0e3Ra5HVzt8rzPi3JEteFyK4AnBNNhA3OZHMULlT8dy6JIvrdvv9OARN1kER2mHluryzbSFYXx8tNww+LttWuhuCcZbOdLZjP+XuVLY6PZTv4AIKyuM2oY6Ofx0oxlphefzQBPkLJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495894; c=relaxed/simple;
	bh=FNDk+Y1KxLeWN61tKBHWfeTJDDwq/i1NWZWqLk1y3G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W98vGXoyfGnjBbb6JRRy60AOREdhUZxUyFr2lrwwXMSng/5z47U8J9MRQJ4Mk0KtBynCOe+OuXEjbEqjOH8RzKrbuSh8TgWwTi5aHABYtqsLQMwpvEFGJ8BKi+Nr2TzaQELab7U/hhZsUAkgsi3EzaMyGspsJ3Mud1t2oPPozsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icR0xPDD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495893; x=1746031893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNDk+Y1KxLeWN61tKBHWfeTJDDwq/i1NWZWqLk1y3G4=;
  b=icR0xPDDNJih/Ld5axWAhCww46gcAAd/nDVj/fAi6IZnXO8Y0tM8aUlh
   Z3x9jIhOEgIEmrRrbv0G5jEMyLdOF5qr3WFtXXRztCSYUuZfqeutDp3qj
   3MN6SRuBGvcaGicaJGT2Lzy+2NVF40T0rFRegkSg0Ex3/b9ZNqM8Fo9hZ
   MPK1iCXiURhZyuzCr+iG9F3O7Fp6HxZpvdloSObNvqtUmb4ydBQslIeUj
   d2zfhbVwnwa0FWToSXf2AFPqY5xbYgoHjDe7mPWCn49yODHFVUH5prU9T
   FJgCQU+eb3qLNFjMuF71aHn7qRDCzB7S1KwJ2wYfus/+7ZoVx3CBM6H8E
   g==;
X-CSE-ConnectionGUID: aZYVh/D/Sfmurx1yDiCtkg==
X-CSE-MsgGUID: 0cjE8cssRzmTbkjZcBYh9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075597"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075597"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:20 -0700
X-CSE-ConnectionGUID: hOLFabK/QM6mzNVA7la6Vw==
X-CSE-MsgGUID: JkT0Kl6XR5eXpq+tbWcE/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515408"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v5 01/47] tpm: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:14 -0700
Message-ID: <20240430165100.73491-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430164913.73473-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
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
index 13e99cf65efe..690ad8e9b731 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -210,7 +210,7 @@ static inline int tpm_tis_verify_crc(struct tpm_tis_data *data, size_t len,
 static inline bool is_bsw(void)
 {
 #ifdef CONFIG_X86
-	return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1 : 0);
+	return (boot_cpu_data.x86_vfm == INTEL_ATOM_AIRMONT) ? 1 : 0;
 #else
 	return false;
 #endif
-- 
2.44.0


