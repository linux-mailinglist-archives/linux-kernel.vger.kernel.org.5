Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287B87FC24D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345487AbjK1RoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjK1RoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:44:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC367B4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701193457; x=1732729457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T7lCwvuWnBL9JGTIol0SSSdAIV5XfI5MplTNjSiz61M=;
  b=HxabNe95v7ltz9jD7FgSJkisBhyj2lzfVv00NKWoUomuvpdePAlKJv1F
   /C6bk3v9YUEQvkfUBwjUr6BlE1zzvxgRr+RxYs+HL/aG6Ps4DH220p5M8
   srlpomaR26R5RQ9JTR7Sczk41dDd70K+0Gtwnn5ueFaUIty7HRD7xSMsx
   3fK1qOGPnrBzmL/6swuE2m90oNsiG0C3zMLjyypVEU41PQ750EDo9GJFC
   2Xi7VqWflXOxROPRZ7SgBewVDMvoXeF0vJ4D0u02vSz2CtG+XvadNRbSG
   nr69HHBEeaE7LUbf3TAD1HRb07DNGEjRvkzMWcpGroGNxYTBASAvAL08N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="11681884"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="11681884"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:44:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1100184548"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1100184548"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Nov 2023 09:44:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20D7523E; Tue, 28 Nov 2023 19:44:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damian Muszynski <damian.muszynski@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] units: Add missing header
Date:   Tue, 28 Nov 2023 19:44:03 +0200
Message-ID: <20231128174404.393393-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BITS_PER_BYTE is defined in bits.h.

Fixes: e8eed5f7366f ("units: Add BYTES_PER_*BIT")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/units.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index ff1bd6b5f5b3..45110daaf8d3 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_UNITS_H
 #define _LINUX_UNITS_H
 
+#include <linux/bits.h>
 #include <linux/math.h>
 
 /* Metric prefixes in accordance with Système international (d'unités) */
-- 
2.43.0.rc1.1.gbec44491f096

