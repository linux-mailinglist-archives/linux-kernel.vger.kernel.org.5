Return-Path: <linux-kernel+bounces-157495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD85D8B1222
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9621328C935
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C81A38ED;
	Wed, 24 Apr 2024 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqU0zncR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42C199EA8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982530; cv=none; b=g9TfzmpSDzEo2ZAALn42k6PIc7INWepwsI2jAHZHzvJ/eDCuavrjHeTGlEfD2Odb+yNalridvUwCBibSUevyTeFDdRl5CA+Zm8BDSJmboocy2UxfxZOf4sHU0lSFanAvSFtIBWl4SWfXjXv2aMzgIk4WgiMR5LlR78+iIVup6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982530; c=relaxed/simple;
	bh=SjDrddwDQ8m+JUNUG8jvwL/rt2m+IPc+8Q7+cCziZRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKOXKyARi/YLV79Ip9mReezRhrSa9KkzN5iaZb3WVJCL4OW+5rtSCtWngeSI43graaZuE6VZ3kaK2XukGmhLuFzPtK94hHFB4eFIIoi3BVNMxCBAOYwyo++2Tul6qnfALMJz/rd6Gqgx3ZuBOOpA8W8VnN3Md79BCl/tm2lDHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqU0zncR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982529; x=1745518529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SjDrddwDQ8m+JUNUG8jvwL/rt2m+IPc+8Q7+cCziZRw=;
  b=gqU0zncR/0KP7lfF/XyGMJiL8x2GUo43T4Y5x2g+hye5xWjPedviOmfs
   tes4DDjI6DyaOD1cSEKDAF64SnFUcAf7TNO0gvb7cRmhyULtHJJhwTOx8
   rM1GrHZ4pf+uDyFxBgy5ooglRlEo0m8KR7hNXcl4yx7ghaNB1jP6OFDRj
   HkUdFuiYUTTLVNovizFVTgTsj59pOlmhrKDzzUtEe9Xg0KqDohzXBRvRK
   MsjU61dd5dORlHvgScqZbQNoG2s9DVeqyAa7CNJ44SsKQ1D4UhsbhptfQ
   Jv3sC4JoxugrlQSpXl3tRTNiAplzUe0dxBa5oIt4PS5XSSSbgEWIyS2Xi
   A==;
X-CSE-ConnectionGUID: DNS3jGkfQQmp5aOquKzRfg==
X-CSE-MsgGUID: wmVl+/ZHSb6FdzAe17MG6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503607"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503607"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:28 -0700
X-CSE-ConnectionGUID: p6MhI9E4QqOZDsamrT1KAA==
X-CSE-MsgGUID: BUVgtU+oTcSqz9f/bRVNAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750175"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:28 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 48/71] x86/boot: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:28 -0700
Message-ID: <20240424181528.42083-1-tony.luck@intel.com>
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

New CPU #defines encode vendor and family as well as model but
boot code doesn't have all the infrastucture to use them. Hard
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


