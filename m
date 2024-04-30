Return-Path: <linux-kernel+bounces-164441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD78B7DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C191F2728F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E3F19DF47;
	Tue, 30 Apr 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1cHXwAV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4F1836EB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495900; cv=none; b=C08pNTr+oWbtXkkX1bTqCvluCQnpOLHfVfXCz1V5hEueMmJt7diTG73nVD67eTflGz7auCf6IL+/CFjJA3BEpzjX+FsLbOGogqJTM2ixx9f/oIGreNK+AucnsLHjsIRHm/F+kd/GUBksEyJ/zoKX4pW8zHDIzsC0guR8ZYSz670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495900; c=relaxed/simple;
	bh=UM/R+mI/W21KnKAJqgtQCB1iHQKdULAasN6DfUW+ROs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNuDtdrDI9NqLB58TK0J4iGzlTDJRUR9YsH4LnV4mEpvZwFk5yRFpZzWr9mPWghbZh0AonfMyGIJZSCwK1LIsGi2OvuO2HOhmVMt26u93DX+BEL00E+8eoDzb5joaXs640TLEB71MsTs2/lKvuaoEmn61rlTPCLEid/hupTwBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1cHXwAV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495898; x=1746031898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UM/R+mI/W21KnKAJqgtQCB1iHQKdULAasN6DfUW+ROs=;
  b=g1cHXwAVA9Eu+SKzfWeLQiZM2SagUiZr4hRlE+wIPoRfNyjvTSiMTgZb
   tuSEMHwjdPgGYk1qZA/PYxs5D8NuR2HDPK8vzxzXpLCYCAzRpLKXyBvI3
   mhzGsKqeJoOXt0Lk5SYaAhwbhq6v+EPx1KG8WKUOrmWK6ttmTlxwIkT9H
   L8M4rc5Y1Ha1ckllGWBIPGK7ysnlvGp4TaDrdX2dy2qk2ILhjMSACqRzx
   nwNiJH+dPXX+M7dddTDzPeGjEOgudvQF6cdfQR9wULNsbYUnunfs+WwtH
   ayWIj7PV60pAeLZgAiyNXd40VP9ABMUmV+GhYTcY8aQo5n+HstL/lMLNc
   Q==;
X-CSE-ConnectionGUID: 2Yd8bjpLRf2x1lVVk1qCPA==
X-CSE-MsgGUID: BMfFaRk1Q4SmOTVBDgoL0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075661"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075661"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: 7xy4iIbwTnWB3NFrn7IskA==
X-CSE-MsgGUID: oERwbzFfTyq56//e+8I41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515441"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:13 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 15/47] platform/x86: intel_speed_select_if: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:28 -0700
Message-ID: <20240430165100.73491-15-tony.luck@intel.com>
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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
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


