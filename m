Return-Path: <linux-kernel+bounces-147636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC38A76BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98D01C2036E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488B13C68E;
	Tue, 16 Apr 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfsO5sMt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC313C686
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302609; cv=none; b=ilvJNwyH+o/kxk2Cm9WWAv4aDNz8UhcPJlbAmK1xCj1nQwRerHOaklE7lipfo6xd/0aU/Fx1SQH2MI+fmmgkEWBL6y5b0gLkP6+pxgYKx+5jEz5HyVp3fado829d0joJqV+BOkFdO0zpRYKosWTLMgrznshMNVCL24Z8sl/E8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302609; c=relaxed/simple;
	bh=wLIYuMGcb4MrwXd9QwN7qz1QHQIbrtQtPLaBSLGbakY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd4Aq+Xis3/SQjE9tKoc8bFIkmoWNoA9l/M1Yh8GltHvtWoia1s0+K6l3tLLa567eQiJHMRNlSZrSo1BPxSllJre09htKdDz0mterBxdwekdSaiBupJYnFMiN/QJH9jpzr+ocew8inv7VxfJOd2wuVDbzxb6IoRr0lFmVnTe5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfsO5sMt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302609; x=1744838609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLIYuMGcb4MrwXd9QwN7qz1QHQIbrtQtPLaBSLGbakY=;
  b=UfsO5sMtL/d01g8NHb4xLrZ94qD8uDq1YEYb4BV8yyNoMERjIm5rytjI
   SRrXt/ugMlX7yamb+BzE3paNmfR6fVLYfGhqW8/lRI/e//aQMCP9nRrmu
   1dnM26GsUgA3PVw2CH6RzyoszR0+YHM8c6s8Cyy8rGhu06DUpG6QLy9qm
   gVc/qWZGKbxt6NCCGBAXDFBinfsY9J9iYLHyOKc+ZXeCJ9ukwqvulQuaM
   I0qsQRA/VcVdkZjH+yjfNeGfXIl+KQxsofPxFG3LkD6+7AFgbrC6AVu9i
   Mln5SgA2asqw2EuoFsTFjX/+c5uXEEC5nFv5sudq6i7jhjtgIMTlK6B4F
   A==;
X-CSE-ConnectionGUID: SqlrcWm5RyuQ+/U8SxBkuQ==
X-CSE-MsgGUID: uxsW0azrQe2STVbyRq/81A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31254801"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="31254801"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:23:29 -0700
X-CSE-ConnectionGUID: Mjlwukr6SCyjG6XLHgx+sw==
X-CSE-MsgGUID: lqmlMoRdSXCpky9uRap7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="59815077"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:23:28 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 73/74] x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
Date: Tue, 16 Apr 2024 14:23:24 -0700
Message-ID: <20240416212325.10052-1-tony.luck@intel.com>
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

These macros have been replaced by X86_MATCH_VFM[_STEPPING]()

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpu_device_id.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 71bda84c20c3..1d4e977e64ca 100644
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


