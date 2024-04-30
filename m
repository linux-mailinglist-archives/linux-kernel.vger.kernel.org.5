Return-Path: <linux-kernel+bounces-164455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D68B7DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B561F28B78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847461C6886;
	Tue, 30 Apr 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iY4cwB5y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934C181D03
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495908; cv=none; b=VsNOKHmja1w/Fx7o4PcC3dxLZV3lU+xF6YF7MIi50I5as6gxFBazaOR3bUaqJRkjTeZRJ2rBy7dyN+XQXnrks7tiVc+bpcDpC41YVgf6Cyyc5JcdG5EELBVBOu95C41pa8oPbONmwZ0YUKNHfQ2tZLqcuto8sOW73bNL2Rm3xGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495908; c=relaxed/simple;
	bh=obhXYEmt6d4ZPBEnG583vH7Ox14Ir+rTrmmNAEgF6jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emojKYgsAiy+QeL27Rmnq9d/92gjOb4xcNbb1JwM4dukt1J7j3XMVJn5gOla05BaIUzIXEtrJ1Egl8Q2npxwjhyqvyY5z3D+Ly3JP4HIlNsZRAlTgXTkYmGH6R0906Vvv+qTk+/Gu7PD6VCPC7h1Oxr6FrTDBOR4jT85PEp9uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iY4cwB5y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495907; x=1746031907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obhXYEmt6d4ZPBEnG583vH7Ox14Ir+rTrmmNAEgF6jg=;
  b=iY4cwB5yHpS5ZteuRUGHnIjx0H6ibCy20L5lhIMdelwxZ1ZJZsg50fB5
   L7hsIl0LzG+D2+PPgNiDp1f4sI3+/bAWdZ0FDzjRfy4adCAkM5EUBlevE
   ozMvVrVFOVIK/WuePaitKqB5xyH/IUUIJkotcmO1Rm/W4qoY4uelElJFx
   ge+0ka5Sx70YIw8XtD0i8YyXaBL0lCevG80Wj2QDWm2W3L+kovE1AX5sZ
   MSPp/k68/w4QSMOGfCBlpMpVB7kJi5TnFT6ivgYyKCFfI6WJQV/MAMMz3
   F/3ppWGGNyG1awvgM/oOe72DYdhGvYJ35YSTrR8vXoXPQcZcTRuie1u7y
   Q==;
X-CSE-ConnectionGUID: GMTJby9BT9CJJ5tKSzTVEw==
X-CSE-MsgGUID: WS+Abr2UQkOjT21RZcj/Ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075744"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075744"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:23 -0700
X-CSE-ConnectionGUID: 1VIQhD5STK64SEfSaYb4xg==
X-CSE-MsgGUID: I8gnMd1JT+aIYIRSAY9Agg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515488"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 27/47] x86/PCI: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:40 -0700
Message-ID: <20240430165100.73491-27-tony.luck@intel.com>
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
---
 arch/x86/pci/intel_mid_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 8edd62206604..933ff795e53e 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -216,7 +216,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 }
 
 static const struct x86_cpu_id intel_mid_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 
@@ -243,7 +243,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		model = id->model;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_SILVERMONT_MID:
+	case VFM_MODEL(INTEL_ATOM_SILVERMONT_MID):
 		polarity_low = false;
 
 		/* Special treatment for IRQ0 */
-- 
2.44.0


