Return-Path: <linux-kernel+bounces-157510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAAA8B123C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7661C214AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D2416F0D4;
	Wed, 24 Apr 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2Af/BWh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124C1C9EA2;
	Wed, 24 Apr 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982543; cv=none; b=N249SdG3vxs+TSmZkCP0HW59NI+uXpWy9zQhxMx0UKxUMUMMZmF8mgoO+POT6usQUOZONaz0R2CYAGdoYaIjeJKLF/ZFXD3Y/qBLbDt8JLwDrSP7G7gYtVMIcG/3r1KXaolrH+XOOwW8EwzcMrhOqhViTAANLUr4EM4a3utmXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982543; c=relaxed/simple;
	bh=i5bcoBcmvU7uXKCZja5nQG8SX5zG7nFXavF27vF+S+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrUCRz+I6XnF4KnozuWJCgyiMt0WG0oXh/TvtQG7F5b9D7vVHt5rivBGuxGVGmDtj4PfivYn9IgHB+N5brpravRzoTlY4xOixW5fku2XlGi0fjn0VnzqW4gEycwc1P9vtqbbfl0cy2tKNMe52OKME/14K21G71xrAJF0FrBgp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2Af/BWh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982542; x=1745518542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i5bcoBcmvU7uXKCZja5nQG8SX5zG7nFXavF27vF+S+o=;
  b=T2Af/BWhZ4pPZskSkHzLcZmzVJAEyYfG0bcQilEnhP+u6x5m9WdAndOW
   s2GsuMwca3TfXCQC3gcji+zxTEnHhY+v6mUOqgPzqOThnZjY8FC2oT2sz
   njij/CurHVI1j8eknz8oSBk6m9eEjVJr8RuaoEo1MwpSzMsu+AIozbO1Y
   4VShgrhD0w2R+cA7QkAPVE8WhMu3JJ6atEdYwi+YcYerZ4hChGHgLFdvq
   jaT9lkrTOqiNrogsd2AdbTtDYnxe9x6i20vTENWcNJuzFi/QAIr4FlPpT
   cDEDs7GfvVYZJKsDzA2FlRDxIqDlvYnEI7OtIP3N4/bf1/vipSBud7KSG
   Q==;
X-CSE-ConnectionGUID: fGsLIN9BTg+9bNPQEYZUjQ==
X-CSE-MsgGUID: tlSXBgrWRM2/iwvoMJrRJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503691"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503691"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:40 -0700
X-CSE-ConnectionGUID: vv4dO+6LShGBxGm3l8f26A==
X-CSE-MsgGUID: LP9lbvWLTHC4cdj+nEcVww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750309"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:40 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 61/71] platform/x86: intel_speed_select_if: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:40 -0700
Message-ID: <20240424181540.42330-1-tony.luck@intel.com>
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


