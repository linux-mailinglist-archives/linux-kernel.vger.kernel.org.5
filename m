Return-Path: <linux-kernel+bounces-164475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043098B7DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9874A1F24064
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7B11802B8;
	Tue, 30 Apr 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZP2nOg/+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD607201266
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495918; cv=none; b=NlGLGUnFlgG9o6qFFZ44evOzaez4nPCrAaTRSO754pubVMhpQoRV4Urd842KPOGW9RsjslF/GR6elGaVXpGrztBUgAX0Zduy4Dgbisn8bRJoLiaY/NglO+yDWHlQ+gDvziw1kYOtG2qbWqP1lNqaVTWC9MFaE8SILQfDfnzmQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495918; c=relaxed/simple;
	bh=zirzD5gjQx1LhVNoHM15DovF6WfvcOF7SWq+fCxGhz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APp1z3QCB0zgl0Vhxv517oOjXDdVNuNWWxTZPxUMdbAUAFWedTPq1sgpslCk6dYEf/0HQiTLjErV0iYy+HbCUGD9Fwb+4L4drPSU4afsBcnikl5cuUwVyIhATZmlGzjh1QBTknkzut2T7pM6ScF7hzfBxEfSQ9nfGfIUtxn2C50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZP2nOg/+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495917; x=1746031917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zirzD5gjQx1LhVNoHM15DovF6WfvcOF7SWq+fCxGhz4=;
  b=ZP2nOg/+OcbQMyKKtwpcN2WqpDJF0r8hyqQFqAsYQaVI7I0fvXsjsUZg
   Xo9szGBievONSGLhuk8H6B+AGGK1qr3+paxiYV9M4rRjR75DBc/WrqsS0
   6twxUlYJOL/f68ilf48t/8HrdRzuxggqc8wjr2WkXelfqi90JSUlP0Jqf
   PDxNOmy7g6farQ8QNVfPiEwdmHhGt8Qr64tWM1vULjm5whz2bXLPp5yfA
   Xj5zx6TQYAgx88s05T/kYcaM+OXW1hKjYaZ/3OfIL2vB6ip1M2KmG306f
   +XWLdnCxzKDTjw1YpBnnPqq54RBsemFZPuOHEkBrLeCkoZIdOUTWn8ybo
   Q==;
X-CSE-ConnectionGUID: 8vm58dS3SaKdyH7bGXaT5Q==
X-CSE-MsgGUID: gNLadH0YTcedel8kzdQk3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075817"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075817"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:24 -0700
X-CSE-ConnectionGUID: USri+hiPQxO7n9ePjoY4rg==
X-CSE-MsgGUID: lUTufSDUQwmwx8wkkwYPlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515530"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 46/47] x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
Date: Tue, 30 Apr 2024 09:50:59 -0700
Message-ID: <20240430165100.73491-46-tony.luck@intel.com>
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

These macros have been replaced by X86_MATCH_VFM[_STEPPING]()

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index cac33812c609..92b54e320294 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -187,26 +187,6 @@
 #define X86_MATCH_VENDOR_FAM(vendor, family, data)			\
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, X86_MODEL_ANY, data)
 
-/**
- * X86_MATCH_INTEL_FAM6_MODEL - Match vendor INTEL, family 6 and model
- * @model:	The model name without the INTEL_FAM6_ prefix or ANY
- *		The model name is expanded to INTEL_FAM6_@model internally
- * @data:	Driver specific data or NULL. The internal storage
- *		format is unsigned long. The supplied value, pointer
- *		etc. is casted to unsigned long internally.
- *
- * The vendor is set to INTEL, the family to 6 and all other missing
- * arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are set to wildcards.
- *
- * See X86_MATCH_VENDOR_FAM_MODEL_FEATURE() for further information.
- */
-#define X86_MATCH_INTEL_FAM6_MODEL(model, data)				\
-	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
-
-#define X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(model, steppings, data)	\
-	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-						     steppings, X86_FEATURE_ANY, data)
-
 /**
  * X86_MATCH_VFM - Match encoded vendor/family/model
  * @vfm:	Encoded 8-bits each for vendor, family, model
-- 
2.44.0


