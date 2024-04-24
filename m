Return-Path: <linux-kernel+bounces-157511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1E8B123D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C8F1F21ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4876A1CB306;
	Wed, 24 Apr 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKqJttDK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4416F0CE;
	Wed, 24 Apr 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982543; cv=none; b=MF+urVn528l+2unrPOO9Oy5FpyKSLN/rRTI7gVkxlCAyk8zVIwEkbMK8/zOWfm3/q/sawiEiYJvzQW6RMMDNHip0lHFO/T2xds5+A0s5OOFCtKA7bc5FG4+G18hLPI1fc+++OV10dRExKNO2aWgDY73L46F1H2EhVYfNFNnA5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982543; c=relaxed/simple;
	bh=xr6bb9OF0NXrEF0HgBC2BNEdfy38NpnLKwUrq7aiRyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDWuyRd11bZ7KiYGB3Bo+bIg2Hu+FSHHpYFdn3Qsvy52WDJ/p2yAp6tyEYylLxW9W9EuCnFJFRHahC1brM1HsTjrXZa1JpkBnoVWdXe6BHvTpAEMgKehor9ap0heRI0nYB2DAb8lW6tlzpFhnxgq/bKSM0pNNHirPKpNmaESBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKqJttDK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982542; x=1745518542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xr6bb9OF0NXrEF0HgBC2BNEdfy38NpnLKwUrq7aiRyk=;
  b=LKqJttDK9oNJhYMFvlFQRa4mF1/21CDCRBR+ZA06nC537UE4QmKhtZnf
   dxVvK4jA5dqMR9iXBtG3aYVSkJNWTbYWJ0bYYrxUx53u7WnGbLt+Wo5dY
   dxH3hQnuhl4GAYVrpPOixsuB11lloaqn6VoUSgiwee2cZyfJgA4lOIIRV
   24yYURx2oprU7tUKIGudiPmmxvAA9gKMk7uyc9Zjbjr0Tcoz0vCeTfQ9I
   redWSoRsJE7IkdQLTKfAwHwGKq1iJZrTFTCTkVpH47pUn8lMQUQPP0z+l
   bR7t0QXzOpnolEgKvlyhmIuFpIOvwKRE66SjGc/KqJlLZpTlGaVa2+msd
   g==;
X-CSE-ConnectionGUID: roFs/0MQSf6jKwXYXOxZkg==
X-CSE-MsgGUID: BTvwKCOKT72p29IY2+RrOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503700"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503700"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:41 -0700
X-CSE-ConnectionGUID: DFM+7oIXQaqCWdjnsJ+Khg==
X-CSE-MsgGUID: fmDO2iL+S5aakTboRJ4C9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750313"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:41 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 62/71] platform/x86: intel_telemetry: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:41 -0700
Message-ID: <20240424181541.42349-1-tony.luck@intel.com>
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


