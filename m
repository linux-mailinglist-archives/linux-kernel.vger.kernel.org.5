Return-Path: <linux-kernel+bounces-161718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB92F8B501E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ADD282C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7499468;
	Mon, 29 Apr 2024 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+PalhWm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA918F7A;
	Mon, 29 Apr 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714363490; cv=none; b=D+WU3bDi2daxR9HC9xS6fXbeZnhmbxJN//EzrNtG/kFV1zpYGrq4I1HWXsZkX7OHdM5EXL/RIdbAtfF8op6IhZqYeQYKkkcTXUcTnQS/CQc8WCISiRex5h1mT4vJ8aRAN8JzpZXDPn7zEdpypeijmoF9PfOtwQSqjl//5YlxUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714363490; c=relaxed/simple;
	bh=iZm0usd8atUAN8OAiOAVACJyVWUpT+dQO9Unn+MZ+fI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LP+EB5ReyugI9rNmei9CcOmnoq9y32U3BM/WErajAZ+4bGdAiPr+EDwtlGh3qSIaMy0xEx6f7zLDqmHpO0tDoonykmIZfHYJNGUtySw+54i1jpIqkvB3It+irrDTkw65yE59CUhhOMjqz7fXTGX+LsmcE3Vc2cx/Ve5+nOEQhUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+PalhWm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714363489; x=1745899489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iZm0usd8atUAN8OAiOAVACJyVWUpT+dQO9Unn+MZ+fI=;
  b=K+PalhWme/5h3T9FhseMQmTtBEpgCtfiqDdDSLZVdik9IHvz2nvg067J
   BVgUbirg1j5uVyEQgTp2H4iwOMx/GEcF/uUCWyik6VNo6s9hBuzLwAgmK
   SdZCwSyYMva0TTpTIc4KzJ4vU/EOQYgpxArjjAEp5qWl/fgk7vAoT2E35
   SqTIOJQCGiSQmXtfXYHvc4pBVz44/0egWwb6v1VCh3NQ6sCDk9G8GFleB
   a+N7gDa82dACD3MocyjCgxfQ7VcZ+fwLBRAIGK2terbLLvq7w7iflDk/O
   cSHY48DbAJfNy7OlLlrDjfxMEdozwTilhdMaGy1Rfm/A/yo15FnPqnEBH
   w==;
X-CSE-ConnectionGUID: Fec77ktfQWekzgtolE1dJQ==
X-CSE-MsgGUID: KpTrUnZYSUukcL7Zl693kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20629045"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="20629045"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 21:04:48 -0700
X-CSE-ConnectionGUID: I/R3vOiNSPqt7Vk/Cr+dxw==
X-CSE-MsgGUID: ZIUStbLiQf2ce+1tFur4UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30442671"
Received: from kscheema-mobl.amr.corp.intel.com (HELO skuppusw-mobl3.amr.corp.intel.com) ([10.251.17.13])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 21:04:48 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] ACPI: Move acpi_blacklisted() declaration to asm/acpi.h
Date: Sun, 28 Apr 2024 21:04:41 -0700
Message-Id: <20240429040441.748479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function acpi_blacklisted() is defined only when CONFIG_X86 is
enabled and is only used by X86 arch code. To align with its usage and
definition conditions, move its declaration to asm/acpi.h

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
- v1 link: https://lore.kernel.org/lkml/ZhQS6uYmpsxFD3gn@smile.fi.intel.com/T/
- Changed the title to "ACPI: Move acpi_blacklisted() declaration to asm/acpi.h"
- Removed the declaration from include/linux/acpi.h

 arch/x86/include/asm/acpi.h | 2 ++
 include/linux/acpi.h        | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index f896eed4516c..5af926c050f0 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -56,6 +56,8 @@ static inline void disable_acpi(void)
 
 extern int acpi_gsi_to_irq(u32 gsi, unsigned int *irq);
 
+extern int acpi_blacklisted(void);
+
 static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
 static inline void acpi_disable_pci(void)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c517a..576e75b4529a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -421,7 +421,6 @@ extern char *wmi_get_acpi_device_uid(const char *guid);
 
 extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
-extern int acpi_blacklisted(void);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
-- 
2.34.1


