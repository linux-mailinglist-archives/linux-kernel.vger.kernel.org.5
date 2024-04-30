Return-Path: <linux-kernel+bounces-164440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E918B7DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FAC281463
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6817B4FA;
	Tue, 30 Apr 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsGgvvzr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A47172BC6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495899; cv=none; b=kUDwQzBhY9PeR6g8fDpBoWa3T7bsC5Vi+NgokKMjygh+BkN5lHFp3f47zTQxpriE5wB9DpEnNuva2aOVxWVPTSNEY3SEXUxPkBOrCZ6RRkJ+gWTPUAU33zwsxxUkI9vyh3bsmjOSqf1I042fdy91kfNy3WqkujPeGI1ygPbFhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495899; c=relaxed/simple;
	bh=Bj1Hh9P4phH3tXz7fAUpe9Zp5qNwRqIfye9t/fF1o6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMvHTMtX01tD1tml/tI1f+D5ncnPqFex7qR0Dm8wgSqvfsmy6BQB6mjJxeVrOCzFStOP7v4jeQVBAiE7RJRBpB0sMX7nl3JH3BRoYZjtJEShoFQsmUcemffvwleJoYJcUxnKsAGh8HE5dBDXA14hC6x75FIbNJPa+GLJT+978S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsGgvvzr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495898; x=1746031898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bj1Hh9P4phH3tXz7fAUpe9Zp5qNwRqIfye9t/fF1o6k=;
  b=JsGgvvzrZTBBmcLb6bHVR0tcI9zgMvvWlCu9BBvRS9ALaONEqFdQ1Isp
   7jgkgxJYszqLLdzwOiHgFlBPJUc0/4okk9tp17Ko0jsQBnLbBoaX9UlEO
   QIN/QVUkzJWD8KhL6EYCP0JBD4+yPPkklhgDDaXHnHD9lEOdqSFN0Kni9
   Mk1epoe3hoxN91/3gUJPEiDFcELXXChRvYKFsPyRb6P8lK8dDoQAIvty7
   UZ9Z/iiGEOWpUKytRxoARHX9imXpYTRiaKCUpf1rXNdcSjjvM+BkgFNFl
   eJpZjuQlUY++24H0/BRwLcJO10tuoPcf6OrW7S5l3QUdnxFkHbka2zyMK
   g==;
X-CSE-ConnectionGUID: zwOk/hPrSVGwmfjWuWWRzw==
X-CSE-MsgGUID: bKCS0W93SniHnqECyflqCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075629"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075629"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: O+FKssEiQsmf8kRxHnkg0g==
X-CSE-MsgGUID: B/igJF10SH2+nMITYpg+yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515428"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:12 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 10/47] PCI: PM: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:23 -0700
Message-ID: <20240430165100.73491-10-tony.luck@intel.com>
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-mid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
index fbfd78127123..bed9f0755271 100644
--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -38,8 +38,8 @@ pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * arch/x86/platform/intel-mid/pwr.c.
  */
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 
-- 
2.44.0


