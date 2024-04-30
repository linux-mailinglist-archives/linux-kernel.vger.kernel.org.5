Return-Path: <linux-kernel+bounces-164473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8261E8B7DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22F81C20A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215521018B;
	Tue, 30 Apr 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apYULvZt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3420011C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495917; cv=none; b=QHYAqOU+SqweDoxQq22mqcU8gFDlA83EzkB+GKw7HjIh1RMZcxmx8KTW2AeA5OhDkxmeo4pBppZxUkmTl3YJQvLjqUUxIto/FK5VTT7UZXtMeQHYeSHiv8E+UzG2KtaCp5IUYJKK4LqM4domg9YwmE3SdKDUt0JPiFjTRF2e3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495917; c=relaxed/simple;
	bh=P/jfG3oJQnxJWF8y4/FRhX5DE6yIHQm3rt2+JP3bIkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/7p7OZDzNbKY7TfJjgLMayyFqlyxgIkzEnwsueTWgxb3Z2KRcZA4MddU4NIpE9kczpZ+Loy3yO4MK+t9XCUp9lhGqneWIY3Pv/WxgC6cr7p9CjF/pXkrBvMzVfOotUnIaXOCuwJbvomZnquLcZSOHIZJXPaILVrBhgmzkfZV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apYULvZt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495916; x=1746031916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/jfG3oJQnxJWF8y4/FRhX5DE6yIHQm3rt2+JP3bIkc=;
  b=apYULvZtZOuun9c+LLVYXkXQs8JgW372mSRCwic5MXLKk/SOinEaoJ3P
   UL567JpRPJqONMIMctbDyxdqzFKYtDE1FhkswqMVM74PQ6sFWLKVtmhL4
   OKl8o3AerdQs25AU9INvIS8+vY3M4ER8bW5ciGRzv5GDZwK3Qqhz4P3y0
   FoTna/P+g/Ok6EEu1qJWq4VwiuuE7BBkycCt3UGF4m1nvEdSdJ6y7O55w
   qQIqxPh/YDuQAHkihcCqEyhsNtLUiEasZP9ieDxpf9sKkTB65I3G2YsNJ
   BecHfzO9JW8t7f7ll/03BgnZ862C/i+LnnJ4JZ3fTFm0B41c4zR683BOI
   A==;
X-CSE-ConnectionGUID: ksB4rzqHSC+oDcCUWdPTLA==
X-CSE-MsgGUID: 1fodbaDDS2KnGFZYrd1ORQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075824"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075824"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:24 -0700
X-CSE-ConnectionGUID: 6o9jFqaiQ4+hzuwM6EpCyQ==
X-CSE-MsgGUID: JlaGPKsHQk6QaSJvCu3SoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515504"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:19 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 34/47] EDAC, pnd2: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:47 -0700
Message-ID: <20240430165100.73491-34-tony.luck@intel.com>
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

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/pnd2_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2afcd148fcf8..f93f2f2b1cf2 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1511,8 +1511,8 @@ static struct dunit_ops dnv_ops = {
 };
 
 static const struct x86_cpu_id pnd2_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&apl_ops),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&dnv_ops),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&apl_ops),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&dnv_ops),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
-- 
2.44.0


