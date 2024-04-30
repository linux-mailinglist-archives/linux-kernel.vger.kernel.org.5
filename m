Return-Path: <linux-kernel+bounces-164464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3338B7DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34271F24ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B871CB305;
	Tue, 30 Apr 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMdSR6P6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59FE1C233D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495913; cv=none; b=Wgc3puH8JksV442g/UaiWJRKAbaQmwfPB67gcNEoF2yfmUN5XNirM1vFYLWV8X6E/ExV8gx1eDNhNx/Hd2y7qWD8NZMm2gnWxhlJyEpL/j4+4JkJdtRTsZ8JVmN2UnqT+h5QabwAK+WgnoEd4uGP1SIZcitghe5gaviFCK2RhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495913; c=relaxed/simple;
	bh=qqh/VHYxTuSJACNe+DTpuXgw37TddvW3ou6MW1MJcG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phOVOa0W4lA2GTgGXfsKdVtx5GP/Rh1sW34mbD607Yh7+mJnnw1a+rmzrgyIwdXc9L8bPl7ixdJAbL751yTkt2kvIRtzFYG3oliH+uTmPEw073834dxKXJcYbFW2kn8xXOYFjNmcaryZZ5HpqiLZT9L2qJc/sj33QZ3OoXSrNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMdSR6P6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495911; x=1746031911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qqh/VHYxTuSJACNe+DTpuXgw37TddvW3ou6MW1MJcG0=;
  b=XMdSR6P6iMdzNMSpGW4XbFI2pvSJT+A5pgxcktnzlCpwM96jVgHwu2li
   Dm/2tXec5j+Kof6aYlE1VX/Lj9DUko1Oi0Fpe9qPJE9l2VxsnDOyfgVkf
   9BWAcmb0TQP1H4njmUD1YajfbJb54Bjy+9ZXPZzJCV6L4xFcZiW6wRGqr
   hffU5O5AINQKxqShwWdPxdhHUU/jXRzZRpH83vwaXJtSQ1XFvLbF4VCst
   zSaPTcEBadFld4oUjmQ0Qof9nAVcZaqLV/CeYyoFvKvwIx01ejEendRNh
   kt6ClcoyQOvHCi63ghVpcdn/kgdRd4Qkdv6obItGd/KPbU2R+oEQzwK5Q
   Q==;
X-CSE-ConnectionGUID: me/EkmXKS32ysQrgs2XR0w==
X-CSE-MsgGUID: S07+zd34QKSBypjSOexuhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075799"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075799"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:24 -0700
X-CSE-ConnectionGUID: iAU0A4HJSsSWcKKvzoSMgw==
X-CSE-MsgGUID: GFz/sRt3TiGBH9MFfDilnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515513"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:20 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 38/47] ACPI: LPSS: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:51 -0700
Message-ID: <20240430165100.73491-38-tony.luck@intel.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 04e273167e92..e7b57dcce146 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -337,8 +337,8 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
 };
 
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	NULL),
 	{}
 };
 
-- 
2.44.0


