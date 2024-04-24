Return-Path: <linux-kernel+bounces-157454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233858B11D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39FA284557
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F316F0CB;
	Wed, 24 Apr 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm66JzdO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD516D9D9;
	Wed, 24 Apr 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982491; cv=none; b=kpGOCNCq1aX1JmJRGKsbYcB6Kmf2RGPraYSCuLIQ70vfM9nE6NPwxD0AQGnwR/Jv8P73V7xNn2dczUL1IbIbrPTO78IXiD8wDYHHYFKY2I6knNcfzAFIonrgnQrBHiDt9o5ODNNecLX+BOZ2fdqpYTrbE3np5rpGr+LQ+XyIv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982491; c=relaxed/simple;
	bh=qqh/VHYxTuSJACNe+DTpuXgw37TddvW3ou6MW1MJcG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5SY6UKYgTR3VpFeKuBt39SY0kt44S0k3Pa7CI7jGe1zQXNN+NbuEFpZ2yCgHRKy6qvUQy3huBVmbKeEfZymxWWQNTKd6sBmdk7KqY3HRiunHl5GPFAZ1WuKjJfEgHWDwZYGe4dBhi7p/OUbNwKSI+0anjl38MygxqQytQzJBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm66JzdO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982489; x=1745518489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qqh/VHYxTuSJACNe+DTpuXgw37TddvW3ou6MW1MJcG0=;
  b=Bm66JzdO1i2kieT4Ve/xbE+xYCeXhTF40qz7EBZ+2WMnzxITxwTe4d1N
   htyclF55WISg8bnsf4CEcLsfeko3VFRLW6JoQtRclz9rnlLPEB2DHVjm+
   NWUCgmqxDpWn7276q1NLIbSLJb3REvRQd7tZWyeNKi75pWQu6jEaV7/3K
   32wooXG/TNeZZOdMOTTl1QW8xmWBTvm026Vo7fzCYCcoWmCaBxL/SRsRH
   QAkGcBlN5TMpKb0/cUD6tsG0/yoyydgPBwlqq4kdAdUBDZwUdO4ube6Q4
   3cbyT2jSewDRNSKLtydcASrYm9tFYG8dz5hMGy1trINAmPoSJpC1bpWHD
   w==;
X-CSE-ConnectionGUID: iwMu7bIIQqmxOjJ5AV4LIw==
X-CSE-MsgGUID: vqzDdE0jS6ySzZDBtRhCgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481749"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481749"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:49 -0700
X-CSE-ConnectionGUID: w/FG+NFSS2O32W04eODo/A==
X-CSE-MsgGUID: TyV1YTNzQUOZ4tB6OMugag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262548"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:49 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 05/71] ACPI: LPSS: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:48 -0700
Message-ID: <20240424181448.41250-1-tony.luck@intel.com>
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


