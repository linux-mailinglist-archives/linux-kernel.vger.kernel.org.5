Return-Path: <linux-kernel+bounces-147626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D192F8A76A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60298B259C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784891552E3;
	Tue, 16 Apr 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cykm9dbg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94467154425;
	Tue, 16 Apr 2024 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302561; cv=none; b=CW0BVA59bxihVu0i5SqWyic4N8FXUV244SsrpTRh6DO9iHEGyqBgTzstXAL03P8l9taAbK7nY3gt/aW3yPXTv1a/hul6xkJTbWk99KQPPFzbgUvtKB3s1yc/sQePz8jq0Yg1IXS/yQUvTXmxuqgUCteb5x9edcT0RHYeTMd4J3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302561; c=relaxed/simple;
	bh=UGEw2wLj1K8vQaWrX5dXU0U1OAJhcpCUAILxYE5zspA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1RgQcdpkOCGWKcDS+EUSH1HOE77u0R3MYf9+i54dmBIXHGuToRj6rwynAYyjerkKe8eV8HRuQ5wDOydb9F1IfQww5wv1rYpP57zvhnYAwVYdHthohJz+m5M/qO5Rs1oUvoLNZSKjSr6zBNe3OiAbLJdJAuN6unnlV3/U+Mp1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cykm9dbg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302561; x=1744838561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGEw2wLj1K8vQaWrX5dXU0U1OAJhcpCUAILxYE5zspA=;
  b=cykm9dbg+q8JQK+bOxs5AWqUlftmYjtg5SN5euUnlAqtsgxOyze/Mowb
   hMdaGHvqfDtzEd+mt1HdQwPy31LOZgOw0sV7iqH01NzUSnmvODqnunVCP
   7A3Pc0DGKBTOa8xtXCSHUWXufGnAUZKVs10a1LVsP+5/7+sid27BssBSj
   VBhUeQ325YhrlbALz5vVyTHqjfWWQTH+gNIo2lCbAW2UdHdOOk1IR9k8J
   sC8ezZIE060D65BH4dsjmnqtK+6ntoR02PtRiw3kgdcVN1MmgVxdxJvaD
   VDpTrnV71BdVBvOWV9ftczblFAuiLBDNgLxbOmVhA/L08oGf1qSP2QeIf
   Q==;
X-CSE-ConnectionGUID: srw1/7WsRt2m0DBblVmH4A==
X-CSE-MsgGUID: R0KirWHdTeGijbw1fcVHHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234972"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234972"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:40 -0700
X-CSE-ConnectionGUID: GYLbcdlJQ3SFVubVqXwIMw==
X-CSE-MsgGUID: z5wWVXzGTISjNuHB9wcLFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267166"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:40 -0700
From: Tony Luck <tony.luck@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v3 63/74] x86/cpu/vfm: Update drivers/platform/x86/intel/turbo_max_3.c
Date: Tue, 16 Apr 2024 14:22:38 -0700
Message-ID: <20240416212238.9853-1-tony.luck@intel.com>
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
 drivers/platform/x86/intel/turbo_max_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
index 892140b62898..79a0bcdeffb8 100644
--- a/drivers/platform/x86/intel/turbo_max_3.c
+++ b/drivers/platform/x86/intel/turbo_max_3.c
@@ -114,8 +114,8 @@ static int itmt_legacy_cpu_online(unsigned int cpu)
 }
 
 static const struct x86_cpu_id itmt_legacy_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,	NULL),
 	{}
 };
 
-- 
2.44.0


