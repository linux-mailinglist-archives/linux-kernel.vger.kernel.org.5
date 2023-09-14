Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404977A01C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbjINKfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjINKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:34:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B91BF0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694687692; x=1726223692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aN8wfY/EBvXBgqx7gt1Geu4H5jZOEEVWoImAqjfQ5So=;
  b=djSkycFBUje2xn2/OEBLqCNIfHPVHTDroabje0m6iHA32dkrfUmeevaX
   2K/YJi+N7a5XDZVF7CXfr75Aq3jSo/HkpdEvieyRNHgxRArpXwwmxILzl
   ZN3exJqKh5X/GbAcOUkTYwO9wVvV1RvUZN+VWWEXPVw8tlqUj2Z99JSCJ
   /Qis0F39c7saHq8zHWURIcvK+59+nA+vFKWFLA2t8Q18JTQ9ZCK3IbsJb
   MVs4ZhcITeyLOG75K8zpDXQMbhgq5TiIjTYp2BjyfL3lWSd4DcihknUmX
   pTOl0DnDovCig7Qvx7yzTwDp6BNcDaXD1l1E+tPWMGe48Opr3A8KvFVn5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="409867724"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="409867724"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814625070"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="814625070"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2023 03:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 205838C9; Thu, 14 Sep 2023 13:34:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH v1 1/2] LoongArch: Add missing headers
Date:   Thu, 14 Sep 2023 13:34:44 +0300
Message-Id: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header uses definitions from sizes.h, include it.
For __iomem we need the compiler_types.h, include it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/loongarch/include/asm/addrspace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index 5c9c03bdf915..eaf8ac098622 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -10,7 +10,9 @@
 #ifndef _ASM_ADDRSPACE_H
 #define _ASM_ADDRSPACE_H
 
+#include <linux/compiler_types.h>
 #include <linux/const.h>
+#include <linux/sizes.h>
 
 #include <asm/loongarch.h>
 
-- 
2.40.0.1.gaa8946217a0b

