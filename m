Return-Path: <linux-kernel+bounces-147580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375A8A7652
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59511C21C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374713C834;
	Tue, 16 Apr 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/01KkcR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAC13B2AD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302408; cv=none; b=uVxZe0EfPL5DW+gPQM9shIWJ/M2GMYbQRGWbigZc/rSV96ETGbmK+53n2NziUwJOGuoLjYvbo0qG4tYnZOUpb/csMQpx1zkz/nUtxo7kGqhDgJy3hHW6pf3idRZHUO0fT8pGS/Ub670VTTYFBAAvYTeKKlJJdLnbcwdv+cIYlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302408; c=relaxed/simple;
	bh=PH4S/Ii609Lmbnp6CowHBve2HoFhBNoMQHmg9A/lKU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc8gycBW97DfZU0FzR1TXmz8nEiShl7QKosD52oc0VkkQa7+0uxA7md0U1UhMqE7lp0uXDo5sdKExZNIQ7mR/VuJLtiIth0EUnW2yojwcS+FUBZEW5ENgA7VPXevGMNDSKkbT60lPKLqoSuKUGS8jUp8gseeWSttwaOVrmL7iOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/01KkcR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302407; x=1744838407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PH4S/Ii609Lmbnp6CowHBve2HoFhBNoMQHmg9A/lKU0=;
  b=X/01KkcRlLkXlOk4RyBtGeesQFmf/zFvhap7QoQ/a3VgIUVu+HxFqdNk
   lJ0iS0FjxrHFyD+Y/JXC8rJ+okG4HHtyVrI2293bde/YC2XugoazFHQKy
   RUzrjuV2ZsWE5xKI4+Ubjm/9nRMBzDONeRtyH1ahSxYTSKUWYpowfossz
   Wm1vWKrrTBMQ4ooPjV3x/78sSTIer+sBG4KsVEqezHAy/xqNrKrOoGUzU
   N36rUjmYUr/ER3DdSqO095ehdFT/LT1tKF3mr8T6jfEPioLvAmNExw0mh
   UxcYCIVvAnEoWnVh23HCfVHff3X86I9wK8Kfo3copWjgg9HsuWlBx6olB
   w==;
X-CSE-ConnectionGUID: oyKcX3EjSpy6G+FaqBeq/Q==
X-CSE-MsgGUID: bCtoC52wQNap+AalEZy9rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914757"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914757"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
X-CSE-ConnectionGUID: egm7MHCnSA6HF6mzVp+mcw==
X-CSE-MsgGUID: 3K5d/Tp+Q7qbI8YVRVaKKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871944"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:59 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 20/74] x86/cpu/vfm: Update arch/x86/kernel/cpu/match.c
Date: Tue, 16 Apr 2024 14:19:22 -0700
Message-ID: <20240416211941.9369-21-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 2243083f0bc2..8651643bddae 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -25,7 +25,7 @@
  * asm/cpu_device_id.h contains a set of useful macros which are shortcuts
  * for various common selections. The above can be shortened to:
  *
- * X86_MATCH_INTEL_FAM6_MODEL(BROADWELL, NULL);
+ * X86_MATCH_VFM(INTEL_BROADWELL, NULL);
  *
  * Arrays used to match for this should also be declared using
  * MODULE_DEVICE_TABLE(x86cpu, ...)
-- 
2.44.0


