Return-Path: <linux-kernel+bounces-157479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F128B120C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33E1B21E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A63181D03;
	Wed, 24 Apr 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwksgWQN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878D181329
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982523; cv=none; b=AvvYlM/Lp7rWSqH+tSmoqqEGh6lT/lckr+ZmoyplE6eb618gcvTcs6ie2nPFkGIMKSY1guKDjY1lLhRGr+wuYanhBKdb/UMWOAZBEgHDRtNkY2DQbEPT/1psNw5ckHATeJLbYxCWD9pRvB0oh4LpU0OJjtJUUQOutBr4y1ZreVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982523; c=relaxed/simple;
	bh=PH4S/Ii609Lmbnp6CowHBve2HoFhBNoMQHmg9A/lKU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhIiJZ7DRWowSSyaKulcj45da7MoEzmpZ/vsFfpnlO5v2Bfq7MMJUTtm61mzgokNvyHWDqpsZHrjRXyTlu7EOs9qax5eufVMduhXP61b8RHbE4ImJWYz0HcTIPAlraIBv8UfzotzI6GzD/7bH1VQeSGVPNkTVL3IBCwcEOKsNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwksgWQN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982521; x=1745518521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PH4S/Ii609Lmbnp6CowHBve2HoFhBNoMQHmg9A/lKU0=;
  b=WwksgWQNnC992Y2n93Rnk3BhfeJfjJKYP7H8BPU0vXkOJNq1EOX5FRKC
   gh1hbzrvEirZ1reuBqcoW5QhZYNHdYAA1gcU1ZqL10pvn5Bz8BnXdwqAP
   cxcZscf1bkaqf4FODyD29hKgQcDjbITio6xjIKearVOfKgIV2d9icVpkE
   hfWT+unb87V41YPqXi3Pwzw67sNIUun3QPcRIwzl3GomPbY4PATvJH6lN
   78gseTt1n9w5BEzE2gT4Ob9dKDsNu7wfSkknGJwZz/gfA4Klp3PDhHqSV
   G11ZnkfwGle8UX5o8b7MzR1jOoAWI1lN/hlXUBN2hZdcCwmkoZP4Tec6M
   A==;
X-CSE-ConnectionGUID: Q7hwYCQaQ5qF9XKVYMGXfw==
X-CSE-MsgGUID: GTPDdibGRLiZDbGXJZIfKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481987"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481987"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:11 -0700
X-CSE-ConnectionGUID: S0SzPpkVTTiK11GDlb5eIA==
X-CSE-MsgGUID: y+qNwmC9SpO/79qqtW+3QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262738"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 31/71] x86/cpu: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:11 -0700
Message-ID: <20240424181511.41753-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 2243083f0bc2..8651643bddae 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -25,7 +25,7 @@
  * asm/cpu_device_id.h contains a set of useful macros which are shortcuts
  * for various common selections. The above can be shortened to:
  *
- * X86_MATCH_INTEL_FAM6_MODEL(BROADWELL, NULL);
+ * X86_MATCH_VFM(INTEL_BROADWELL, NULL);
  *
  * Arrays used to match for this should also be declared using
  * MODULE_DEVICE_TABLE(x86cpu, ...)
-- 
2.44.0


