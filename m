Return-Path: <linux-kernel+bounces-157516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734A8B1247
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39C01F21A08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709E201261;
	Wed, 24 Apr 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ravdf/jN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFD200133;
	Wed, 24 Apr 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982549; cv=none; b=AYI18x8l9qg2OdeGaaRKp5zU5JOBmIjzIGipKfrYN5mL2iroxeqJdi+IqtbjTxwFEk6b4sdmvRzOEdTOCkYnpAU9WPWF8lvIPGLL5BGFtgNSJq1b+s9mRNftQri/xAj38hIRth8sdaPEGyG5AXzFz3kf1rbA9W+Vb6Y1TveWPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982549; c=relaxed/simple;
	bh=NHkS+PLB8tCqh4PRqBz9xJFe66d4//WHYse1TcAmK38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPM7VGEqOMOp63HhYOHW86p1J7RLXqyDACXeTBaXQdKhIbyaNMOjRbINrEu9+VEUa2FpSw7c8uzSVGxV3L4YR532uv89o7GD3243neoj1t18pston89oWjT4szwG/FgMOZ24UGUemWg1KMrvPpFJM6fMHTJ55L3sQh/pz2Zjpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ravdf/jN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982547; x=1745518547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHkS+PLB8tCqh4PRqBz9xJFe66d4//WHYse1TcAmK38=;
  b=Ravdf/jNxi2EP7URQVv32z+yD3tsyPCLTWHWcscsHnH+z4VBvRy/IrEm
   sh6QvuyzUkaYq+e5q/O4p++NURUGl1k+xOc/cnkxVJWV+ItCZZJkBlohj
   GwDwl5n7OZ5bc2riZWtNx3iu6U4XSfD5XL3CV2gXnG6fvJS9cxqj6KtQm
   QYZN5OyN5QYxOZ88fha/tHYNr7ZKdik3lOOD6qTPBD2ow70Ml+PM3OvvT
   TWzw9Y3UdSwig2zbSbotl0zqR7R13K2MmlJo7hW39jfa+jA3+/w6C+JEY
   H+4IjVnRfhn/aFHDFbwvU4Ye8Qlq8vKVGVgQL1nrEnlpgwSpKo3PAotOj
   w==;
X-CSE-ConnectionGUID: iEo6PAHLRj6nxVJZxlIJhQ==
X-CSE-MsgGUID: wA+ZRRdYSDi1MmjK0Q2Epg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503728"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503728"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:45 -0700
X-CSE-ConnectionGUID: 1cjMMjg4Rli3jg+Vz0SoNA==
X-CSE-MsgGUID: K0SEcFSdQnaSOJ0+wWee3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750355"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:45 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 66/71] platform/x86: p2sb: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:45 -0700
Message-ID: <20240424181545.42426-1-tony.luck@intel.com>
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
 drivers/platform/x86/p2sb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 3d66e1d4eb1f..8cfbf0bbd346 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -24,7 +24,7 @@
 #define SPI_DEVFN_GOLDMONT	PCI_DEVFN(13, 2)
 
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
 	{}
 };
 
-- 
2.44.0


