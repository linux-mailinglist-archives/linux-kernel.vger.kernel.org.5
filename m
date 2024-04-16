Return-Path: <linux-kernel+bounces-147623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49DE8A769D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216551C20DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8813BC06;
	Tue, 16 Apr 2024 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmtYdD5r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34A15383A;
	Tue, 16 Apr 2024 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302555; cv=none; b=F6MU8NEUTkLjFdHnoztAyvSjeZ9uIAX2agvq7VvJOPa7D3WmQGX3xYAmS5uSWKiPKFMjGfNAIAqY8k1jnJQCyJVKNyVMHI2b3gw/b2rhu7TWAnECRt+7FB1YMtfq8dQRsvibo+vsSwBqQxkzSdtOHNV1WDZu97+Mr1xzg+1cO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302555; c=relaxed/simple;
	bh=i5bcoBcmvU7uXKCZja5nQG8SX5zG7nFXavF27vF+S+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1ZMz0h92K5ep7o636lxUP7cFLvQ55ExXWZ2lZzt7JwX+rJunbbH6uApY9ExbQ7DE2I2JXTlswZAbbycEimnGnz2Fx4teYVZAyd/g4mJfAS0LdBmtUiJeGPSsDhPx1t9nuKJDbyAnCSefoyy0KqX/SMu9ZCrvKsBoNwLjAoJE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmtYdD5r; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302555; x=1744838555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i5bcoBcmvU7uXKCZja5nQG8SX5zG7nFXavF27vF+S+o=;
  b=UmtYdD5rGMWTITiE5X18SCK0Clw4tCis0VhLECzsaf8Z1elhdbtN54kE
   4e4hKXRJLSzbpGM2xxR/oV56aZOJNFWFcMsDOMujmI8sa7HFxfNqaRypo
   vjxGsoaAtRGbWt+0/yh0+RcQRFdcgqacM1f6LJiwNC6yhGAGF0B6++z51
   EjU3PNTcRoi5du0L2mnl8+LvKzSAlqxYYKj+z5RcJZD0h127ddI8r+OBe
   ZeCOLZmCkB/hFJFlZKfLFgkR3MI4V3qrRVsCuefLyAiVCNgunb1wxQnJ5
   m9GXXZwggKd7uY6aCrLvbavPLeRvCvK7xt5xixw6tIjmnrAVLTSLBqGXM
   w==;
X-CSE-ConnectionGUID: /IO04sZERMaKK88h7Pb3yQ==
X-CSE-MsgGUID: oc6QxcqqTY+/YNvgjeAo2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234954"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234954"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:35 -0700
X-CSE-ConnectionGUID: oJHsGQsVSmuFgveTonn+kg==
X-CSE-MsgGUID: 1a4/EYkcQHCPBhbEZD0iUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267148"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:34 -0700
From: Tony Luck <tony.luck@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 60/74] x86/cpu/vfm: Update drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
Date: Tue, 16 Apr 2024 14:22:32 -0700
Message-ID: <20240416212232.9795-1-tony.luck@intel.com>
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
 drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
index 1b6eab071068..6c36f7704fe7 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
@@ -161,7 +161,7 @@ static struct notifier_block isst_pm_nb = {
 };
 
 static const struct x86_cpu_id isst_if_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, isst_if_cpu_ids);
-- 
2.44.0


