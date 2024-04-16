Return-Path: <linux-kernel+bounces-147618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D98A7692
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C83282E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA8153502;
	Tue, 16 Apr 2024 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TL4SzQK7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8641534E3;
	Tue, 16 Apr 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302547; cv=none; b=KjZm33uqqOoW5fA6pAVjxVrkcdSXn6ayhe6sbWQDLVSwW2OtZWwaOsxz4IasgOcHk3GAsgGkQLiOJkc4Luiqw0LSeGdh1v5vVFbwTHcy7ckH/1Mr6tvwRKrfdbw14BDkpMbytI4X2gL9wq3hv38K0usm13kyX4Aj0jk1Ao8H9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302547; c=relaxed/simple;
	bh=26W7AK4Uyulx7e8OguFS/2MgsGW9fO1MZTL4z9xDJQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxk3HuU+pD/uozq4Nn2fN+lgkdMy4idR2OriphZzwHJzFPwF/zwASA5MMmX+sv8RGtpuj4yVnjeJtaQq6Ty+/iF5xVm0HozKc9rCcfDFpax3h98pkWsP4Htz+iN4YSKyzyL8FvVc4uR95U6zUCsO2pezSPmlklMLibExg1QVmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TL4SzQK7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302547; x=1744838547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=26W7AK4Uyulx7e8OguFS/2MgsGW9fO1MZTL4z9xDJQs=;
  b=TL4SzQK7xG806DGfC2ji9bZEGDFiwXqbdEjZpjKttF2IZlJUFaY7e12k
   WxnknUDNvXaNEkZKnbzxZKhsbgflbTeAtbJj1V7QsI7j0JKHMdeeZUkhg
   0J9M+ohUbH8nELsV8scGNwjTc/BlrzwlHgeXzQZmnemSfxSeKA8MJcJf2
   3hDcAaAdG3EBS8fzPyPNTNNHZ76gCnXcXlSMrGEg3KR8MXtK5thQVBAqJ
   HMbTfYKDNSpqmedSxpocCfOX6GtqeCgV0cNR0cIKRCg9pEjvdyA63K71v
   EJVg6uV6NBI2qR9utUR7Gajc32HW3uu7sX4FqWmRj9rXT/RdfrnmkbLfi
   A==;
X-CSE-ConnectionGUID: dxd8YH6vSbqXbrz7ISfKbQ==
X-CSE-MsgGUID: DFYzq6+0Rh+FO24I21yoAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234930"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234930"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:26 -0700
X-CSE-ConnectionGUID: veC1QxnpTbmIS/izpR8dvA==
X-CSE-MsgGUID: 9tVGp7LxT3encNmfEzEh3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267110"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:26 -0700
From: Tony Luck <tony.luck@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 55/74] x86/cpu/vfm: Update drivers/platform/x86/intel_ips.c
Date: Tue, 16 Apr 2024 14:22:24 -0700
Message-ID: <20240416212224.9700-1-tony.luck@intel.com>
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


