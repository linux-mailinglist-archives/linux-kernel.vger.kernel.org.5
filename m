Return-Path: <linux-kernel+bounces-147624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A638A76A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C3D2821AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14A154430;
	Tue, 16 Apr 2024 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWc5ICfr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9829153BE4;
	Tue, 16 Apr 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302558; cv=none; b=bLSFBJPA13hvEas/1+5mp2VxF8SQXSCBDBBHz2KBKKEXuYKA/eINVgNUoslGhOfOpS57MmvvqXTGJGYPZK81TQDMbTqhr5MJleBHKe2RCMSabas7CTXdOl/G+eJmMBnnhWJtpyZLcCcRVLo/TeQsTaS+7qBH2u+cPzoU6HFxoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302558; c=relaxed/simple;
	bh=xr6bb9OF0NXrEF0HgBC2BNEdfy38NpnLKwUrq7aiRyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfZCvI3RCL9fazArO0sC+SIqmze2zZ1gf/sVBsCeOK0uIDmRHsLkbC2YVC9spvv+Yo18Zi28RQaBk3iBSc/IJylifKdETfpimPOCXDuMG/wR3Wz6tOzLyQlGLnVHjhvT0hAcHTUWxtGR5PT3chqHDsq0Q8EO3RPSrRJqIrGEvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWc5ICfr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302556; x=1744838556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xr6bb9OF0NXrEF0HgBC2BNEdfy38NpnLKwUrq7aiRyk=;
  b=NWc5ICfrUSYLllACuYrmOk9vUy03k7u3OYZkEkuvsnT9Q7+Snfzi7X/7
   wgWUmeE3o/sU/NRU6mnpuyB7oUZm73PuMS3daIOorSc8V1yS+vOCQkq86
   mIL9CHWn2RlWrDQ1100ai1Vf3c9B86vFSmYV0kUDD7BzqAsKSRxUmGgBI
   A6hGj1YJmRLDj5rHTHW+l6Tsah7myTI4CBpEs6n5Yg4wB6wCKAivM9K1o
   jWYSg9VGpD3sZm8HywuR/BwfhB4fXTeLyB18KX4IDTjIFj5pWs/PbxLZ8
   ViUX+OS9M93pGdODkHPAb2dZpIERs5a2O1ejl+InTAiDy4bij9U3kMf33
   A==;
X-CSE-ConnectionGUID: P/nguXhvS/mOBCQpkcaOpA==
X-CSE-MsgGUID: y6Qt85A6QFG1Rn0Kuki4cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234960"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234960"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:36 -0700
X-CSE-ConnectionGUID: 9YV+y7AuQsq0MjgeG4ClQQ==
X-CSE-MsgGUID: DwaZahe3RaWfWaY39WH22g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267157"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:35 -0700
From: Tony Luck <tony.luck@intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 61/74] x86/cpu/vfm: Update drivers/platform/x86/intel/telemetry/debugfs.c
Date: Tue, 16 Apr 2024 14:22:34 -0700
Message-ID: <20240416212234.9814-1-tony.luck@intel.com>
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
 drivers/platform/x86/intel/telemetry/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/telemetry/debugfs.c b/drivers/platform/x86/intel/telemetry/debugfs.c
index 1d4d0fbfd63c..70e5736c44c7 100644
--- a/drivers/platform/x86/intel/telemetry/debugfs.c
+++ b/drivers/platform/x86/intel/telemetry/debugfs.c
@@ -308,8 +308,8 @@ static struct telemetry_debugfs_conf telem_apl_debugfs_conf = {
 };
 
 static const struct x86_cpu_id telemetry_debugfs_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&telem_apl_debugfs_conf),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&telem_apl_debugfs_conf),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&telem_apl_debugfs_conf),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&telem_apl_debugfs_conf),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, telemetry_debugfs_cpu_ids);
-- 
2.44.0


