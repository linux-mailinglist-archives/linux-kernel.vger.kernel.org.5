Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C37A01C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjINKe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbjINKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:34:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D01BFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694687692; x=1726223692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2FKCjcQ5u9vQaNDLGxcLVznEbCTrMpPIzmp+AvNgKs8=;
  b=fFHFStqoqaJ9jJJSgNRksPFQW9sVKKX4vZArYcUUdVq5DDwMr98S6vbl
   1NSva6hn64ZClfZSjHEf3KPAYxYF0R6s1YiESda6isHvh78dqoV8AcIu7
   n2qQUzpD69CEz8JVxH61VRiZnBpg1cF+mfp60JWUjk1pSoagDNVZxttuA
   Sg21fGPbvfZKdqAx/vAQ+TJQf7DhImpTOJj1Vl5ns9roIoghGm6nJF7v7
   8AXt3ZgDF1H9YB3CiAKwSQMIKLDl9gbIXg0ayV1JKHKrR+hVcUbkZu2n1
   HKqzs4jllfULn03b3dRNBdPhS9B2AToDK1A2iBn3hfW1oS2ve0bE4F2bi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="409867728"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="409867728"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814625073"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="814625073"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2023 03:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A9E5FBC0; Thu, 14 Sep 2023 13:34:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH v1 2/2] LoongArch: Use _UL() and _ULL()
Date:   Thu, 14 Sep 2023 13:34:45 +0300
Message-Id: <20230914103445.511285-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
References: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use _UL() and _ULL() that are provided by const.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/loongarch/include/asm/addrspace.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index eaf8ac098622..818077f62db8 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -21,7 +21,7 @@
  */
 #ifndef __ASSEMBLY__
 #ifndef PHYS_OFFSET
-#define PHYS_OFFSET	_AC(0, UL)
+#define PHYS_OFFSET	_UL(0)
 #endif
 extern unsigned long vm_map_base;
 #endif /* __ASSEMBLY__ */
@@ -45,7 +45,7 @@ extern unsigned long vm_map_base;
  * Memory above this physical address will be considered highmem.
  */
 #ifndef HIGHMEM_START
-#define HIGHMEM_START		(_AC(1, UL) << _AC(DMW_PABITS, UL))
+#define HIGHMEM_START		(_UL(1) << _UL(DMW_PABITS))
 #endif
 
 #define TO_PHYS(x)		(		((x) & TO_PHYS_MASK))
@@ -67,16 +67,16 @@ extern unsigned long vm_map_base;
 #define _ATYPE_
 #define _ATYPE32_
 #define _ATYPE64_
-#define _CONST64_(x)	x
 #else
 #define _ATYPE_		__PTRDIFF_TYPE__
 #define _ATYPE32_	int
 #define _ATYPE64_	__s64
+#endif
+
 #ifdef CONFIG_64BIT
-#define _CONST64_(x)	x ## UL
+#define _CONST64_(x)	_UL(x)
 #else
-#define _CONST64_(x)	x ## ULL
-#endif
+#define _CONST64_(x)	_ULL(x)
 #endif
 
 /*
-- 
2.40.0.1.gaa8946217a0b

