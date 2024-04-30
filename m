Return-Path: <linux-kernel+bounces-164457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DBA8B7DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA462873AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A941C0DD7;
	Tue, 30 Apr 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fu0UYF7n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFF1C230A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495909; cv=none; b=G0e6eFKhNv8V7Pta0VNEgn6vj/ESWkhJHT9jIHO04L/9IIyMPrrpOYAdGdkmNFfrluyyUCytPfOpT5hpz4GTeZybAKu8r4XDNUHu59s66HjIZ1sOOwq/nlJU03V8vfllsgQbbKA1CSHO3L5AXsPxssnrudopOoqNmhYXeShaOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495909; c=relaxed/simple;
	bh=EzHNCGkFW4pzZxYwMtbicWPPZh4LNVsfxDMf79eOOok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWMrBAPpWNxiMhti4RZCxF4W1aE/zC0ikLuEvRMmxRVQ7P5SbkZ1Y5iVK7b672TAU9VLydTaHTlntFQsytCRu7dDlXSVMn6nX2RpADpC7xPjVZaf0qVudVEoi0WA+pO+5g+LqM7ve6Rtr02Zob4XTB5x9FvHkSVtey9PXJj4yZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fu0UYF7n; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495908; x=1746031908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EzHNCGkFW4pzZxYwMtbicWPPZh4LNVsfxDMf79eOOok=;
  b=Fu0UYF7njvVHVwr3d33mFKWTbDvbYREYYZJSStey3QjnULGK6mhXWpmU
   h6MewpOxO9lfJ+m+oFT3CNaY7QQEmfDe9gZ3GHiMFOzLK2Om1YpzWDmme
   +/EN7m/rJY+I3GeexF6dDTwMouorpj5qMLiOwe9GQJ5TQ8f/u5l5eoDK4
   UmOv/LQvwnucuPfDy3tXr3l+HpOfbTi5Hzdi9ksvoZU5smztrW6hi/fZo
   soTyw6JQ5Yd6DKJOmAhuq9jwSX4gUGJiaGLMYgdTvGv41CoMhx2XFPNC+
   HuT0iE3N0vZxnz8UJd00Ndk7dYEta7/hqe4njdqPvNBxpRlOMibnwsvma
   w==;
X-CSE-ConnectionGUID: qye7ZsHAQUK6PALkqpxtwQ==
X-CSE-MsgGUID: SEFSxFOyTb+yD/UV4N5jkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075769"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075769"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:23 -0700
X-CSE-ConnectionGUID: 0VLHcjPJTOCTYD8CqY/1zA==
X-CSE-MsgGUID: OaNTei8vTqKF+koxjRmoJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515499"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:19 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 32/47] x86/boot: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:45 -0700
Message-ID: <20240430165100.73491-32-tony.luck@intel.com>
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

New CPU #defines encode vendor and family as well as model but
boot code doesn't have all the infrastructure to use them. Hard
code the one CPU model number used here.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/boot/cpucheck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index fed8d13ce252..0aae4d4ed615 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -203,7 +203,7 @@ int check_knl_erratum(void)
 	 */
 	if (!is_intel() ||
 	    cpu.family != 6 ||
-	    cpu.model != INTEL_FAM6_XEON_PHI_KNL)
+	    cpu.model != 0x57 /*INTEL_XEON_PHI_KNL*/)
 		return 0;
 
 	/*
-- 
2.44.0


