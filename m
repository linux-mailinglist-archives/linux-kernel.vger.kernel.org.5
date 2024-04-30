Return-Path: <linux-kernel+bounces-164442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAC8B7DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795AC1F27145
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F419DF53;
	Tue, 30 Apr 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEI21aJ7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBC180A8E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495900; cv=none; b=nA3f3JWGRjet+zzQ4OSML4ubC5JIxgd0TtRu5MUuafpVgNu4k1QRrgH/+EbaQVSu1ALYexxSBetQR6xSY9r1zcQo5DR4urNT4jbq7+tjj0bkaJOWGqFv2Oy8TcY0Vru4avp4Q3KsAaerR7kiut+P7hlHUxDnhwSzm4m2aKTKkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495900; c=relaxed/simple;
	bh=DsTxdChN/mYCzh9I4OyIgdX+q2TnrHqwbKbjQIoRaMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/fWbnfQFy2Ee5RI7uhE80wkUddEd4f2hV6Ia/wJBBUU9IUvPYEZl9xtOR0Hob8rjgXMP37bPO9ODBkU5MqxjzAOcJeg/Y1lEbjlMo952LCcsBh1crL4CBwuw6glu4/w9aXjNZrmDP9JTihgNp7HEdESJoP/ihWjhEswyHInErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEI21aJ7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495899; x=1746031899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsTxdChN/mYCzh9I4OyIgdX+q2TnrHqwbKbjQIoRaMw=;
  b=kEI21aJ7QE+T1hgfD4lDysdJ0wwihs8sr8Dplcw9MDnlMlXarES0hNMO
   mdEhLJwHTFNKHSbchX3KaFADnzUARNw0g6EFzvSMdllemdd3Y8X6ps3g7
   sWsf7ZwHhHjYLxbgBHaqOkcnY7vesE6A21Oc/vyoOeDHm+/acvFClMtXp
   Hn8LZP2MrURzQ6IVhrldAXj+cBUs5ylbCxyKxngk+AZ6NMLVzw+CKJrkb
   9QeFexDRNsYj8qI9IaMRPeItG+hZ5oyZDlj/GIL6kbD2Q3azXjTIwRCCw
   PxoVWN2WNc5BGeKI3WBOzfOF/POf3KAWr8lXdYlSrR7dlvVeHn5dq7Rcd
   Q==;
X-CSE-ConnectionGUID: RPaReYznQ+qqbmiJ/8WNaw==
X-CSE-MsgGUID: cjV68h2LRSqS07L8DS61/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075666"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075666"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: zIfRzOLYQUebOPWcl77RSg==
X-CSE-MsgGUID: oSD0ksI7S2S8/uEMliVl+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515446"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:13 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 17/47] platform/x86: intel_ips: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:30 -0700
Message-ID: <20240430165100.73491-17-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
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


