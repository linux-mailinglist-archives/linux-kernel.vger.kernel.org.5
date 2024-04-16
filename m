Return-Path: <linux-kernel+bounces-147602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECDD8A7671
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878031C22139
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA61780C14;
	Tue, 16 Apr 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMtyydpK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77FB6EB4B;
	Tue, 16 Apr 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302522; cv=none; b=g3TqukLHX4Wo5b7DQBoU+XgVsyKIuf04kaGXENbUmVrbxuRmGpQViSvF1Wi9kBnnUwrTj2w+iAn+2gqNASWy7i3nXYyNL6uFjOyHDWrit5TEru6U+alOxBexI96S7eZoaRUx4PQ8LUIK6z6W69AtbDOtGmNvsC/b/SSEpLD9Ric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302522; c=relaxed/simple;
	bh=L3+S4gA2ORuFzeK6+sQEVl45VQr8XCUrqX1gADKQOqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFbB/18CSR6cKXuQYJvFvWMZv8H13xfm5YNajMOYrfkMq3aocbcZDCD5ZloyTkjMhTAqWjQ4Ch6aKnZqy+/LQDm8lmRNGPwsvNfSlITC6VqkFO2Dxj8iRWAHvMAJLluENPNEaNf/UnNyJVPoKTsPlZlekDRMsd2d39tSwE6mq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMtyydpK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302521; x=1744838521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3+S4gA2ORuFzeK6+sQEVl45VQr8XCUrqX1gADKQOqw=;
  b=EMtyydpK97YtFqLDOwnA8RQclw+jibOx51LxKqk6LpnFq94fCY+widh5
   bTXCZF8STaEJTG883ybYkxU/vZNsiJiPDH66A/S9vBJGLPfnG9PLeGMaf
   DUqo9dv8qOJbJa27cuU5EEdDP5LNRTzY5tKqBXdoiyH1KuaUDcr68aeVa
   x8zJ3wkMNzPXBtt/aqkeO8GFt0L6Ue9tdgHVR1YrVTEJLCb4nLJe8yFAv
   6Cfs3zlYInrzpKFj/V7iioYHjo768W0V2qpk+ZMjs1SSETzvT8TpIChlm
   XW0mXtfg+yovkcWtw9mJ3v5gdsSwCQxuHA0x3GuVbM1evN+TX5ZG/dl0r
   w==;
X-CSE-ConnectionGUID: dLhjDXQHRaOmsvi0kn6uuQ==
X-CSE-MsgGUID: 5Dsjp6rqQRGghg+UAJHGDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19328716"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19328716"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:01 -0700
X-CSE-ConnectionGUID: RsfR0U60Q/qbglDtkCNXZg==
X-CSE-MsgGUID: ba+zrprNT0GSPVCj5IVCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="27071888"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:00 -0700
From: Tony Luck <tony.luck@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 40/74] x86/cpu/vfm: Update drivers/acpi/acpi_lpss.c
Date: Tue, 16 Apr 2024 14:21:56 -0700
Message-ID: <20240416212156.9413-1-tony.luck@intel.com>
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


