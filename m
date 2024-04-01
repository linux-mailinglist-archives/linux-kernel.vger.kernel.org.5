Return-Path: <linux-kernel+bounces-126945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D98944C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707EB1F21E5F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822E4F602;
	Mon,  1 Apr 2024 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXGhCOdG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0F4F1E5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995840; cv=none; b=QMoL1n2ByvE9PJ/FYSTalwAruWJ0zOscFGhlT7UGQGj5AdKQqGr65nI2JNJ+qV0Y5sVvuHo5Xgh+rRuSV01el/DehcdAhQaGF1DV+XpoZ/ACHWLuaZZ39n8ebdcgNu9yBojsJj5Ya4YYp3z2JlplvO5pseOtwcl1nU8AmfroeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995840; c=relaxed/simple;
	bh=levUNnPr8AlP3VGmUxIs5WxgRAF0SDf2QhTaPnCNFNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxH+PtUorKOjCNJlJo0iE9Hvk6wLIFI6mWBhBrLF1tcuQr6OpRo3XFKa/rtgxxDPYqhD0axd55e0Bh+AnRrkM30V1gREvUNxxYfi90nDJrU8PJIVSFrpZJuEOssxnViOWWe7bR+1RbbTXmwWB87yIr1AIwIGEtr4QcQJJMGh834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXGhCOdG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711995839; x=1743531839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=levUNnPr8AlP3VGmUxIs5WxgRAF0SDf2QhTaPnCNFNM=;
  b=gXGhCOdGxGzkh8B8F1eymADlsIOHvwKviKmpYFCi2c71xWA2hKX6gRpP
   V8cgi9VJzzEfMqmod8Eg/Ca/ApG+GSzkgxG2hqAdC46oKWN+KYBhsL9tU
   J49TwN2Lk1Rcabk1y0qO1SnuBkl2pvX1LM6ureg3a1LV/XRprJm8rayba
   LvG+gQvLGlhjIqDriqHEOs6EAgD8E6NMz2SsSRDQu9izti6jLyhp9KUGs
   eESWYDCFWNaxPH/7f2aNK0B2U6BRbIWsfsiASbnb3d8+lJ/SZXA5iUvJu
   ORFzwig5kwRw5KHMUWwVQHMBgJtMx3i2HJavl0p8KlOHB++kQntDRmUXg
   g==;
X-CSE-ConnectionGUID: JNedZfnQTaCQw8vkB6s8pA==
X-CSE-MsgGUID: kKXmZlKPTBqu+22ZXj1O2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18287123"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18287123"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17615392"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 11:23:58 -0700
Date: Mon, 1 Apr 2024 11:23:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Message-ID: <Zgr7vfS4ArMh4kWx@agluck-desk3>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328163746.243023-2-tony.luck@intel.com>

Refactor struct cpuinfo_x86 so that the vendor, family, and model
fields are overlayed in a union with a 32-bit field that combines
all three (together with a one byte reserved field in the upper
byte).

This will make it easy, cheap, and reliable to check all three
values at once.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/processor.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..4c5d166aa473 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -108,9 +108,15 @@ struct cpuinfo_topology {
 };
 
 struct cpuinfo_x86 {
-	__u8			x86;		/* CPU family */
-	__u8			x86_vendor;	/* CPU vendor */
-	__u8			x86_model;
+	union {
+		struct {
+			__u8	x86_model;
+			__u8	x86;		/* CPU family */
+			__u8	x86_vendor;	/* CPU vendor */
+			__u8	x86_reserved;
+		};
+		__u32		x86_vfm;	/* combined vendor, family, model */
+	};
 	__u8			x86_stepping;
 #ifdef CONFIG_X86_64
 	/* Number of 4K pages in DTLB/ITLB combined(in pages): */
-- 
2.44.0


