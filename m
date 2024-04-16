Return-Path: <linux-kernel+bounces-147607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD808A767C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCCE2809A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199C13A86B;
	Tue, 16 Apr 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3o0jK2b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB213A415;
	Tue, 16 Apr 2024 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302529; cv=none; b=EWOXSCv1j6MxcTY7E0IXe/0vzXRIE47iulMo0ZxM9ov9cWk32K231hGtbgCu2mqBacpspRxR3WEYNqW0vEcqokblUfNtmU9t1bBQCd5Vr6yWQcIJrCyO7Fu6ORuepwijIkbGfh8la64c6LLy0wJlv2mAR+L2lmu+e0s/KIDYKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302529; c=relaxed/simple;
	bh=D4u+14rLptzvw7vl6botFXd6uhzNw369NTgf6IDkOUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3BwClzin4m26PUjb8I3P4ZSI57WdHdVGSDk7SK7tJ7Affdv2JQn+91hst3e3VyDIqUa4kb6OxgT4RkL1AIhTksB1pwPMSEEsqx043kmu7z2jLQ4SE3h17D1YdxPHaSUxvEhsK1HtVdH+uC3lIROHEjnP3L+7W2fNavGSbPulQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3o0jK2b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302528; x=1744838528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D4u+14rLptzvw7vl6botFXd6uhzNw369NTgf6IDkOUs=;
  b=U3o0jK2beLiJ4PIZyYt8ZzuI3XUORsdvI7pq7PoiXKDsF4Z4c1ge03KP
   Z4CCL9iVb1p873mPQ+eps+K0O59yUeFSUiN7whDNpELI7dISBM9py4pDE
   Pzc7ob9XduxKO2L2ZHgD/FQv//qFaG1QHLx/4ggZkn2emjbaQ+DRp+nqa
   Zs/usmf/xLA9ARdTp9CM1ARzEz0jh09KXmgWGQUVDpA4l8hgfM6TeHH1R
   UI4oAZCamSBL1p1osgMKctepIX8lJJ7VNCRVC25niYXfgyzRTJw8+wrA5
   FwR5H6kR/9B2tZpFeSrRpLRLbZ1gJAB3BDIhDyiww1uG0JCU+5xZv4FDK
   g==;
X-CSE-ConnectionGUID: dCEN6X8jTn+VzF6+9vLGsQ==
X-CSE-MsgGUID: gKR+M3I6S0e7Ojv48Y8e/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19328750"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19328750"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:08 -0700
X-CSE-ConnectionGUID: 8dA7kYi5RQSWyoQWFnlVTw==
X-CSE-MsgGUID: FgivpmWCSSeB4SbsKn1KPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="27071905"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:08 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 44/74] x86/cpu/vfm: Update drivers/cpufreq/speedstep-centrino.c
Date: Tue, 16 Apr 2024 14:22:06 -0700
Message-ID: <20240416212206.9490-1-tony.luck@intel.com>
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
 drivers/cpufreq/speedstep-centrino.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 75b10ecdb60f..ddd6f53bfd2a 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -520,10 +520,10 @@ static struct cpufreq_driver centrino_driver = {
  * or ASCII model IDs.
  */
 static const struct x86_cpu_id centrino_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6,  9), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6, 13), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  3), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  4), X86_FEATURE_EST, NULL),
 	{}
 };
 
-- 
2.44.0


