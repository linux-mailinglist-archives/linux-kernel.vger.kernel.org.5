Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF975C800
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGUNjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjGUNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:39:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9FD1BDC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689946771; x=1721482771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NkUrPuisbIFulQyMWqUtCvT40Kfi6q+a3Q6zjh8r0po=;
  b=dx+HoGA5urIbfoBvEOG7q+RX3QvrM94/r9bABHNudN1ZHwMnjWlkZeN9
   DtCo3PPBm2DiKTSU0iDTWT958tLB42FJTpUEdKfUBtIhf0y9l/8GEqvMH
   TBkxk4AGeoykOSR+vrnSVh0QUflZDLrq2JPTbWye1QspcGLaGJ7nP2L8S
   fFIYEyO5IdsX2t/y/d0/gNF8f10BonT1FDuoN8jk4RvzMNoQ93uKpQuZE
   Q0YiKnXkPODs1vMkNzEw0HZ14yNWwHfAAvFYU3nFxxafWv9vFGHElbDEQ
   Kld/LwJf9swyxcYzTea040tUFi1qiW+do9QF+93dLxz8yifnuV5pUus0p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453399308"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453399308"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="754461242"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="754461242"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 06:39:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC796370; Fri, 21 Jul 2023 16:39:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] minmax: Fix header inclusions
Date:   Fri, 21 Jul 2023 16:39:32 +0300
Message-Id: <20230721133932.12679-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUILD_BUG_ON*() are defined in build_bug.h.
It also provides __UNIQUE_ID() that is defined
in the compiler.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/minmax.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 798c6963909f..049480235e53 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MINMAX_H
 #define _LINUX_MINMAX_H
 
+#include <linux/build_bug.h>
 #include <linux/const.h>
 
 /*
-- 
2.40.0.1.gaa8946217a0b

