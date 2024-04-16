Return-Path: <linux-kernel+bounces-147562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65BE8A7641
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44694B22A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0A6BFAC;
	Tue, 16 Apr 2024 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVe+n8Hm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFB5CDD0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302399; cv=none; b=u9gBfeFBJXGlJB/wXn6ONeh83cjVrM1KAWWuZ0KUt5tIORNL531saSuxK/WER78bHmZvBHXROFpGH6VahBcHzpqvX6KJTzcVpSWJ0qrIyaNk24Dv3h0bU/1JpDPNWwMGL4iCCt6rvL2r/9cN4y781YO41h0p0ZXI+pZuvYCzWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302399; c=relaxed/simple;
	bh=K7SiRP0YhghECeWcqNKJo0SVn6WHmqaUqbMmCwF7pPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHpNjA1YKqSMVxSNlgJpOurwlog6q3kXW6a6PZoKiMbgaUbCue7ZzejXb0uaI8s4xTN3Y1pDbUhxPBLrkBZr5U5e7b0PUSj6GE1UO9KR0tAfAtstDWSH6uFGlfCsao8849mIamEd803WiBJUxgOQxaXqAS7YJL55vhXRxXs89W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVe+n8Hm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302398; x=1744838398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K7SiRP0YhghECeWcqNKJo0SVn6WHmqaUqbMmCwF7pPs=;
  b=HVe+n8HmEqiJ9EVOMi+cQ5YPV2Ht8FjwUlbRfcDw2LbkKvKpHQ3Rq8//
   hP4wgVBtPnGgLqMjJCnu/1WfiVglWTRFSto1iv0wfmAnXOeJ887ovf2Dv
   u18yb/AnCw08qVO48LpwOMNyPYuubX+tc5kmisnW3mUfY7IuXOovQKClW
   q2QoA4eVJEaxoOb7wpMbOW1BtbMzVtG1NTeZ31ucAaOkCrqkKILz+kVCl
   4pVXDMvwjYhPZILs8tmrITSki/Af7lFsTLcjcCVT3UebRyJ7TBRBGz4go
   6VrgrRnJTKEYsMt0ZglDlkWHLrSfQYUzHVP/zEZX1Vzhtz34pYlQP9KRq
   A==;
X-CSE-ConnectionGUID: Crpl4DjUR1ekCkd2ABUpLw==
X-CSE-MsgGUID: yQscM3mkRLm2bTU7A4ugNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914666"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914666"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
X-CSE-ConnectionGUID: JZXsTa2cSbaCm2oPmlnayQ==
X-CSE-MsgGUID: MMNrelh+SjmDjX57T/9htw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871872"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:56 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x86
Date: Tue, 16 Apr 2024 14:19:03 -0700
Message-ID: <20240416211941.9369-2-tony.luck@intel.com>
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

Refactor struct cpuinfo_x86 so that the vendor, family, and model
fields are overlaid in a union with a 32-bit field that combines
all three (together with a one byte reserved field in the upper
byte).

This will make it easy, cheap, and reliable to check all three
values at once.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 89ed5237e79f..d13338860710 100644
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


