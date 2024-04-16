Return-Path: <linux-kernel+bounces-147582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E88A7654
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF781F23150
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BAF13C905;
	Tue, 16 Apr 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij99qcls"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9C13B5AF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302408; cv=none; b=fNmGGWhRHQhfOU0XXCYMS1QpCQcYs3ZZMKyGKrNhVeSL1gmLk/kDFat8vqatxCsyKkmpkHTQZNFBy3cC2pRY5fB7rTykSh8DZxCyk+0ByjJwrI0q/9KNgIoFIjQErHayO1dAT6wamDZLIVBYcW7xUJ0XLozfKHqumcQjb5rqxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302408; c=relaxed/simple;
	bh=V7tAuIZjmFHYG3CI6ExUFzsfFSGKj73ay9CLKOtBQZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ+AUesj+MonhmZ4tAA5v/bUIUTvQ888AADsV4SF0OJ0YkCyqrKgbJfIjynGNISeCqOp3pS98a90T8az1iL9JuAg4KogeFQlztlzSSTBAl0PXjr8X/LglFntDnU9SD165Y0o9ff4Ght4MJko3IIZI7Sc6BGMfgP8RK/xbAHL6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij99qcls; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302407; x=1744838407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V7tAuIZjmFHYG3CI6ExUFzsfFSGKj73ay9CLKOtBQZI=;
  b=ij99qcls5IRJYyQ6F8fiMqZpJm+i9XIjWWgjsqx02ltRCcoiuqAFrOk3
   998DMOXWWq+uR38iIRn4LpqXD20FQA67xDBB+J0sytFYe0BbZEgs0iOp/
   dSz3aRS+ykuAx+xy27uzns4R5fEa6hH/r55v/uEhNxoiZ9YSb5JIT55Sr
   hYFeH3m4y91I9I8MKM0VcYlFtH2wmv8ZcductUlANYgxxyZH9POtY/+kU
   zC0LjuhOeUbFciScmhmRf4SWw5n1o2Wr3melX+qJ2H2OKIBoxiit3cGVq
   046mz6LfG1C2bgovDhtvXkdo1vkor1n50H8/vbxsEZU1Mv1V+vVU/EXge
   w==;
X-CSE-ConnectionGUID: oflk6i2LT9uAnVJ5fIKQbg==
X-CSE-MsgGUID: DKQqMQBpQNWRUXEjNg9KcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914763"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914763"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
X-CSE-ConnectionGUID: qHJGg+RXT+6pOTc0XTGgdw==
X-CSE-MsgGUID: 6Vk4HKArQbKfNp1Fw0o3hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871947"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:59 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 21/74] x86/cpu/vfm: Update arch/x86/kernel/cpu/mce/core.c
Date: Tue, 16 Apr 2024 14:19:23 -0700
Message-ID: <20240416211941.9369-22-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/mce/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 771a9f183260..fe9d141672ef 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -47,6 +47,7 @@
 #include <linux/kexec.h>
 
 #include <asm/fred.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
@@ -1948,14 +1949,14 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
 			cfg->bootlog = 0;
 
-		if (c->x86 == 6 && c->x86_model == 45)
+		if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
 			mce_flags.snb_ifu_quirk = 1;
 
 		/*
 		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
 		 * rep movs.
 		 */
-		if (c->x86 == 6 && c->x86_model == INTEL_FAM6_SKYLAKE_X)
+		if (c->x86_vfm == INTEL_SKYLAKE_X)
 			mce_flags.skx_repmov_quirk = 1;
 	}
 
-- 
2.44.0


