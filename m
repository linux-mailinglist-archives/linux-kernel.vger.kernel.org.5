Return-Path: <linux-kernel+bounces-157505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9008B1230
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76A828833E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F971C65FF;
	Wed, 24 Apr 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZmNV8vB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163F16EC1E;
	Wed, 24 Apr 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982537; cv=none; b=BG5NHY4fdC56F8oSvndZ4ISIlWWklF5UDupyH2HsAm6y5aIOwZvP08+CvJqB98XEdkzf/tX6nRxChQcfuQXinz/RNdfyQqdWFdwOpbdLFEx0hlhxRzHcU1wUWKA1Dp/bCOeU9dK5smz6COy8GFuTlr27yjb7y75KdJ++Pb9kwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982537; c=relaxed/simple;
	bh=26W7AK4Uyulx7e8OguFS/2MgsGW9fO1MZTL4z9xDJQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJJNp8gpErDfDhMKZqw862cd/Pgad+zViv1n7enkffRcK45wdH6txSPXgL+ty6RZzN1cgQo3Ultyizj3ecuUZtnRNa9QNuKGW8hwS9S9SDEziQnyrf1xCW2F6pPWg+Fakj+uT7bzEAaekN0xEE9AWZGjqBdoePmpLjGe7B2yhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZmNV8vB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982536; x=1745518536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=26W7AK4Uyulx7e8OguFS/2MgsGW9fO1MZTL4z9xDJQs=;
  b=LZmNV8vBqNBfcy9eQhepdO/nx4e8sMDeKoDCQePPPIsDHa/8fcsSmjo8
   y+/uVSRf8Hsh8iIQU4nYU4D/Wn5Qk4lkFReRFFZlsw8EniBIRv+dTeKhJ
   wL6gQHoFlRd1/1yxMySV98Nu3Cep9KiNtWkuq28msy+DflsRaEx7LMym3
   sF5DKyM7BYTH50dVbuEOVeskdZihQ0wQBUONn8NdIr94fZu9tX+cfPo7m
   fBwv39+cpgNOEUG7K64p6g/k5gaJR+svTgpSrNaemKM3rh+2vkvhE88qj
   E1DdFTTUe6POt4dECIRBBDZ41rjj7sTFIxbpqgYR7TRV7KUoUrrJ8GLz1
   w==;
X-CSE-ConnectionGUID: 9TsKiSfHTC2uItNPwX0IWA==
X-CSE-MsgGUID: /Roi13xRTXKXlqS7ZteNwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503662"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503662"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:36 -0700
X-CSE-ConnectionGUID: TpvtKG0xTJ2uPfmB6lYM4Q==
X-CSE-MsgGUID: KiS/7+AmRAGQhXgz8JQpYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750258"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:35 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 56/71] platform/x86: intel_ips: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:35 -0700
Message-ID: <20240424181535.42235-1-tony.luck@intel.com>
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
---
 drivers/platform/x86/intel_ips.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index ba38649cc142..d95f686e0515 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -62,6 +62,7 @@
 #include <drm/i915_drm.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
+#include <asm/cpu_device_id.h>
 #include "intel_ips.h"
 
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -1284,7 +1285,7 @@ static struct ips_mcp_limits *ips_detect_cpu(struct ips_driver *ips)
 	struct ips_mcp_limits *limits = NULL;
 	u16 tdp;
 
-	if (!(boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model == 37)) {
+	if (!(boot_cpu_data.x86_vfm == INTEL_WESTMERE)) {
 		dev_info(ips->dev, "Non-IPS CPU detected.\n");
 		return NULL;
 	}
-- 
2.44.0


