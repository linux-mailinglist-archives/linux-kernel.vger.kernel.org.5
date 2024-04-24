Return-Path: <linux-kernel+bounces-157504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06DD8B125A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D3B2D566
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5B1C6600;
	Wed, 24 Apr 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErBr7CUA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3E194C75;
	Wed, 24 Apr 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982537; cv=none; b=GaOMmmQNLBWUSj4XDa1EJ6FAJypdLZ6gAWOkTreOvKh39cemYWZhACgTC5arkAQO1ibevKsuETjPAJM/XPklnMKxhDrVyIwZ88dvdQsy6+pFULRvyhKV0RE/t77mssduhiG588AgRv4OvZw0lzUwxrhXLcTUSDFARUqmEk29l7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982537; c=relaxed/simple;
	bh=VOMc5HL2Yym/lNFPXw4JQY/s2kqTbaWlnvcMPB56V7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCHCIgt3xkPbM6ARCoyCcAKbL/eyTQ86b9N2PD6+1FEuIE5p6AzdKx5dRXqOQJxkbHFcnTtCTmDlbQ1b9sbMwEIioFgy6WV45QAUTsuhYMpUtTybGkKtNRnQkGCFx+XQ2bBa23H7YeF+VvgYC3d58H/9Fzsv5LTEecTR8xsT/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErBr7CUA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982535; x=1745518535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VOMc5HL2Yym/lNFPXw4JQY/s2kqTbaWlnvcMPB56V7I=;
  b=ErBr7CUAhT+8KQIjoQ8mF0t5ie4ZBvcZ+bm+uKAvYWsfxuOVk7FTlJqx
   ftQsWYeOztmjInX4YqkF2nkELY4n4jKA8s41yXgnnwgcy9Vu8uiiBffvS
   4AASfip6aCxYjRmqJr+Nu2GmkdvWr3665sQegiF6YNJNDMrlYCCSHTkqU
   dtoZdNl2nJnhcnVwakAWu2bX2JF5RciLQrhYEd4T9mzUzlA8t9HzMgUfe
   eX72ADNl/hq30Yjvbu/Qk9h4DpbA0SeEe4NKfhoEB99cgm0RtmwiKIlPG
   6/dVBVy8A0j2R366U6XHdQ2JyCz9o6QKt6i7YnzTn2d29e2Az3qYo2sGs
   g==;
X-CSE-ConnectionGUID: XcsYK0ThTRSZkyiVehgf+Q==
X-CSE-MsgGUID: SCP2wnwiTLmfNSeGmzXI5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503655"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503655"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:35 -0700
X-CSE-ConnectionGUID: Uj2SbWfbQx23lWiZ7/VFOw==
X-CSE-MsgGUID: 0KTWpr7DT6WRpayO81znJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750236"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:35 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:34 -0700
Message-ID: <20240424181534.42216-1-tony.luck@intel.com>
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
 drivers/hwmon/peci/cputemp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
index a812c15948d9..e8dafa748a41 100644
--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -361,9 +361,9 @@ static int init_core_mask(struct peci_cputemp *priv)
 
 	/* Get the RESOLVED_CORES register value */
 	switch (peci_dev->info.model) {
-	case INTEL_FAM6_ICELAKE_X:
-	case INTEL_FAM6_ICELAKE_D:
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case VFM_MODEL(INTEL_ICELAKE_X):
+	case VFM_MODEL(INTEL_ICELAKE_D):
+	case VFM_MODEL(INTEL_SAPPHIRERAPIDS_X):
 		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
 					     reg->func, reg->offset + 4, &data);
 		if (ret)
-- 
2.44.0


