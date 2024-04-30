Return-Path: <linux-kernel+bounces-164451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6AF8B7DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086F4288616
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965461C230B;
	Tue, 30 Apr 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORbwmPqO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842681C0DC7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495906; cv=none; b=B0qxzvkB+NFHnWuYT/tVMPnjg1rAKyvqeSF1Pvxj/X8QUuGGuSei1qDrUni0Lhf2uFt3l3wZiUeHDukyiqQz7YbXO4HvD+kRzhNt30y3Yn4YrK50t+hwso6MsdUOQRo5VeJJ5Osf6oEU8UesVgxhlwaTf6cTB1L905sYv84JBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495906; c=relaxed/simple;
	bh=SFMHZV/UxNJy8zM+holmrAwHdS1VJwo6fJNNlhwW/6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZSTkHX3NODK8UzcmplQil4sXc/U3MoRplSFA8U7dbOH6viogl3RsY1ohsjPwohVwbLxj2UpvZan+Wkfa0v8FAJrWkz4wEs46UZaeUxiCb+atn9t3NlPg32S60S3/8O8lslyGnTMSQROwMJFonv0syQS+P7K6Bow6x6pfF081uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORbwmPqO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495905; x=1746031905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SFMHZV/UxNJy8zM+holmrAwHdS1VJwo6fJNNlhwW/6o=;
  b=ORbwmPqO6N8hXbvO939/XXT8CQ5VUrRGvPXqPHD2LWauAW4UvXD7ONL7
   2/l1LKfwXQc6yot9+T5f7nKUFn0LowCXYPmE0K3KFWqwdaFMsplZTHYfZ
   UfngZ4J7cDbAMwg7DLReoueKtAQTs1+e1KmSyNG83673iG/6iPuXO5squ
   KrDTlvLTy+ueHRBzkMmA0QAk5EFGhTsUtqdJdhLEDJuUHbpirjg0Q6c9S
   JzJIHvM5SpPMs8VS7FgJO0X4Sr2lsAoCKR3gsF9w8A7ddIo9pV0QxOaie
   ggaXlIlz0GL87HkVUb4QXNqpz+m87my6lC3y3HeWCShlvJWOB5cf+ITUG
   g==;
X-CSE-ConnectionGUID: ONsMNKBGSuyQlr9f5caROA==
X-CSE-MsgGUID: qFtJvCqJQkifG68+SJpwSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075690"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075690"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:22 -0700
X-CSE-ConnectionGUID: +P1mMr8fQYqflBKgu9NowQ==
X-CSE-MsgGUID: JDzSzK/OTO+WUMGQj1+mXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515439"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:12 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v5 14/47] x86/platform/intel-mid: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:27 -0700
Message-ID: <20240430165100.73491-14-tony.luck@intel.com>
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
Acked-by: Andy Shevchenko <andy@kernel.org>
---
 arch/x86/platform/intel-mid/intel-mid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 7be71c2cdc83..8b8173fb0a43 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -22,6 +22,7 @@
 #include <asm/mpspec_def.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
 #include <asm/io.h>
@@ -55,9 +56,9 @@ static void __init intel_mid_time_init(void)
 
 static void intel_mid_arch_setup(void)
 {
-	switch (boot_cpu_data.x86_model) {
-	case 0x3C:
-	case 0x4A:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_HASWELL:
+	case INTEL_ATOM_SILVERMONT_MID:
 		x86_platform.legacy.rtc = 1;
 		break;
 	default:
-- 
2.44.0


