Return-Path: <linux-kernel+bounces-147604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F0E8A7677
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C522809E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61A137C40;
	Tue, 16 Apr 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9Aej/jW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14984E15;
	Tue, 16 Apr 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302526; cv=none; b=Xd3d0+vXOc9IcU3Hrl8mL+MF6+Va1PE24NY+Q/L4L7//jxbIdr6OvJMijpOmxO5A+Tmi1roLD1qVKHOMv0RWHwnPfRLzTsYpBPlHhsWQar5jv2ZuY3bYrs9d9Uso3LcZx52IdPAe2Q6f7x97dCXgqHp8Z8/K/L3j51hYh+/BsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302526; c=relaxed/simple;
	bh=frPDqt/jTGsMhuXRZP5I2aou/N9zQ6TaB6jottwpuBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LecHP2j45qM8yzza5YX09pvLTfkMFQO6+cmZxkDuHdOU7G2sPyineThB6Nxd8n8S0izUZ4Dvu1HuXbPPh+6MkJewCBF2zRPmEvVRwbUQMuPQEK4nC4HoLFBIHlXr2mcRUjp7qm+xMMd1CgFmMXUQSuWwV/dTf9YUQ0Si1iYZ6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9Aej/jW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302525; x=1744838525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=frPDqt/jTGsMhuXRZP5I2aou/N9zQ6TaB6jottwpuBM=;
  b=F9Aej/jWmd38r4iq8goolHDYnen8KhBKBhIS8pGoUNwCb7NkOXs5iJN2
   Va43rgfyxSltKfssKPxxpa9C1YRoCtbWkbnusXx/cJoMj+5FEpk/DShqq
   g0BZYPQcNmpVjciH/krjSZivZqJp2vN6u0MGFUavJzAujJJZYCQBBOqyY
   uZjuXkSexccfRKugyB0lvVJXl1ggU+9RGvIl8yGqFR+RcQt/+7PyPbAzS
   JWw5KRFVBCVVfCTLSpkfqPfcsuUX9m4hNpvc6Hb8ZIAjDqxWhE1+a0Xua
   JKJ0kYn/nJmBOwk3rA8+FBokJbKY5FEThudJcjdLLwIHtHYS9El8SJrHX
   A==;
X-CSE-ConnectionGUID: m19u8uLnRT+60W8Nq7B/KQ==
X-CSE-MsgGUID: qR32Def0RdeJ8XOvIM+UVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19328733"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19328733"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:05 -0700
X-CSE-ConnectionGUID: 3C4dj8qRT9udti3c/IsKIQ==
X-CSE-MsgGUID: 6DxEzHngQvWvdI0IksPHlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="27071896"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:05 -0700
From: Tony Luck <tony.luck@intel.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
Date: Tue, 16 Apr 2024 14:22:02 -0700
Message-ID: <20240416212202.9452-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/char/tpm/tpm.h          | 1 +
 drivers/char/tpm/tpm_tis_core.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 61445f1dc46d..895f2dba266c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -28,6 +28,7 @@
 #include <linux/tpm_eventlog.h>
 
 #ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #endif
 
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


