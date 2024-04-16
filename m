Return-Path: <linux-kernel+bounces-147591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACF8A7660
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E136D2834C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9A1411D7;
	Tue, 16 Apr 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtTW+Lu+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8213C9AD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302413; cv=none; b=PxZ0wCQ9EABYOzy80CoObU+shOE6+/xJcH10Mx/2lrBv6zyUzs6WuOA9olOCS5QT5WWhWkk5tR8NDUr+lk5VcnMpdy5kVMxreBMYC/Eer6cyWH3pJqXd8zGXRvhcmdoV5qsDy9CFzy3+gqJIvbow1UK4gnXJsXvBBpqMDDAaHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302413; c=relaxed/simple;
	bh=ps9rNqzKSGSOSSF+uk2bNTyXLGrRDgTAM95atyOJquA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjuvAKMok5CQOcssgwVswNM4xfIgGLqRHhEBNBGJO8wwP6OvVAfhCVpreKTygcqRSKu4DlMUDSYrg0oQ6fTsyrplqf1LG0ErsjZZEEeYSPk30ubgOEg8sUBEI57PbN/JlIXOid09FFkAu2+2cSa4oqmN79qWv/nKBeBhg89Hx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtTW+Lu+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302411; x=1744838411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ps9rNqzKSGSOSSF+uk2bNTyXLGrRDgTAM95atyOJquA=;
  b=AtTW+Lu+2Que5jbW/NeAILXi5HzQ6amqeja76a5waDjrCUY2h4gOmMq8
   hiDu8b2GZWGIuUbTvtBgsmBZwV27FC+HjmYHpJ8aeLQ15AG/WjVTF5clS
   /6aVHoJdflmvzwbR+F1DEgPkKlHX8ZGkjEUFpgOIjXWmTDD2v+9c8GNSs
   t+oX8E28SzX2BAqKB6Reh17LcuCPafU395TGugsnlnl8QzGbINGd9o7yf
   0rFh9Cb6C3x5dTAwBMVEn9u+zkrl7wNcHiGT2EwTe7W0GMRNJAQqVyBrL
   wL/WWAKFEAZVD1bIPBOPf4se/GbSpB2GOR3hXAsL9dMQ9w9xby0+D+m54
   Q==;
X-CSE-ConnectionGUID: U+XgRGmQT0Se2DZQc2yWkQ==
X-CSE-MsgGUID: qKM+rxihR1mQQ4qFrbHU3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914808"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914808"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
X-CSE-ConnectionGUID: 5hAYBeKxTHyakmZdUb5HpA==
X-CSE-MsgGUID: irZcxYxXSbyeXfaQxsb6pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872004"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 30/74] x86/cpu/vfm: Update arch/x86/kvm/pmu.c
Date: Tue, 16 Apr 2024 14:19:32 -0700
Message-ID: <20240416211941.9369-31-tony.luck@intel.com>
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
 arch/x86/kvm/pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c397b28e3d1b..2faa67a4bfb6 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -34,16 +34,16 @@ EXPORT_SYMBOL_GPL(kvm_pmu_eventsel);
 
 /* Precise Distribution of Instructions Retired (PDIR) */
 static const struct x86_cpu_id vmx_pebs_pdir_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
 	/* Instruction-Accurate PDIR (PDIR++) */
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
 	{}
 };
 
 /* Precise Distribution (PDist) */
 static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
 	{}
 };
 
-- 
2.44.0


