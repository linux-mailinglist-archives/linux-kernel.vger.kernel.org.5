Return-Path: <linux-kernel+bounces-130102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EBD89741C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B812E28A7A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273C14A621;
	Wed,  3 Apr 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAhq0+RG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A814A4D2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158514; cv=none; b=qMXHjW0agxeqFjmTZp371FoIjy50BQIgamJxFkncmF8MWPZPflDO20uRIEFpAWYa6qPcCVTpUm32iyQwZWnC+gnTtD3FqdPFRgwxQH0v81EQ6CHYy9rB7mdpPDDlVBdfvHc6oAPAS5nbQ4wcnuIO1+77toGpZ/uLZyc7aUIftgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158514; c=relaxed/simple;
	bh=pRQ8ZuMeNG77xydBJ2pbyG/Gah/4v+e/Ti98iEFoDos=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=RXjptmWMJDqBaie7NISYYsntZgnh94RDuJnP1D4QNMi+eYAEkH9tqVxX9cW9qxGGzpEkPk+UxqZem4Mq2rm9ZE2dnJS2nOoK3KIDyl950CkIAup5WgYdZzskmyXJP6lYkMyigkXRG81bqXTUtPSacuYJNZyV5uPtd8QW8hzpOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAhq0+RG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712158513; x=1743694513;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=pRQ8ZuMeNG77xydBJ2pbyG/Gah/4v+e/Ti98iEFoDos=;
  b=MAhq0+RGq2fbgFb9wS56ML1LZ5hJ0+/DRp7O9qavPJYx7JFUVLB3x2Ak
   CjAN81IZYRPZtRq+vcjmgHpSTq332yGm+DnBost0ytBZlNH+WK/kz52lq
   lJVCz8JuAWhjGrVbXgXUPPeaC5rhfkGKRB8ZqzGjGavZavt4A6sMTHDt0
   jje3RJwYDmei0W0yRF6LlBZO0K5dEkQfp1U1AQltN8DGsoxMXE71UQGyP
   qfcdsEI+Dd3tbu2m/Dt/CtZk0nWD3r2BfYp/GptVFPpAW5AKC1LnMQBL/
   RQx+2of2O7biTWFMUz76ofLK9KDXTEnJTH0bk44uZcz16nyziCXHDvnoY
   A==;
X-CSE-ConnectionGUID: BfeIgOi+Tu24Aurrn3gAgA==
X-CSE-MsgGUID: +BBGhaW1Toyi4NNmunc0wA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18556321"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18556321"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:35:12 -0700
X-CSE-ConnectionGUID: BO8SpLMqQK+kTvPsb+QeBQ==
X-CSE-MsgGUID: nz+SPtROTNuoCsqGpiUpaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18395608"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2024 08:35:12 -0700
Subject: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 03 Apr 2024 08:35:11 -0700
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
In-Reply-To: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
Message-Id: <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

IBS details are enumerated in an extended CPUID leaf.  But
the support has an open-coded CPUID region check.  Use the
new helper to trim down the code.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
--

Note: this cleanup could take another form:

        if (boot_cpu_data->extended_cpuid_level >= IBS_CPUID_FEATURES)
                caps = cpuid_eax(IBS_CPUID_FEATURES);

that would be one fewer CPUID invocations, but one more
line of code.
---

 b/arch/x86/events/amd/ibs.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff -puN arch/x86/events/amd/ibs.c~ibs-region-helpers arch/x86/events/amd/ibs.c
--- a/arch/x86/events/amd/ibs.c~ibs-region-helpers	2024-04-02 15:22:59.262912595 -0700
+++ b/arch/x86/events/amd/ibs.c	2024-04-02 15:22:59.262912595 -0700
@@ -1278,18 +1278,13 @@ static __init int perf_event_ibs_init(vo
 
 static __init u32 __get_ibs_caps(void)
 {
-	u32 caps;
-	unsigned int max_level;
+	u32 caps = 0;
 
 	if (!boot_cpu_has(X86_FEATURE_IBS))
 		return 0;
 
-	/* check IBS cpuid feature flags */
-	max_level = cpuid_eax(0x80000000);
-	if (max_level < IBS_CPUID_FEATURES)
-		return IBS_CAPS_DEFAULT;
+	get_cpuid_region_leaf(IBS_CPUID_FEATURES, CPUID_EAX, &caps);
 
-	caps = cpuid_eax(IBS_CPUID_FEATURES);
 	if (!(caps & IBS_CAPS_AVAIL))
 		/* cpuid flags not valid */
 		return IBS_CAPS_DEFAULT;
_

