Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4DB75FB98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGXQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGXQNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:13:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD310C1;
        Mon, 24 Jul 2023 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215199; x=1721751199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mQmhwRMCX+2VlBlAQk2QrEayonYigV1tJYv2ecQydMk=;
  b=a2PhMs8IoPPnDCTOpFffWyj1li7XSuA0USklQxzXjNp8p7XJzMVmZkGx
   1dpUaA/Hpx2Kjvp4YIZxABjHcPuNr/x4qz/1lOnQdXkmsAM8GwCI8+kna
   5EQKl6jgq8TbJ4PGf/t35QHOLYktxCb26A3xCn8qYwyB1fWKKucajaP0+
   VlSDciwXs+WWzWLinT4KNrv1I9pPda4HGfivoiUvBZ003dIO9ylcnBR1C
   3/Gqi8K8qipW7+CGaRToJFandyr5syOIMMyeNNcDK5AUBaQS4D/V/Fp6F
   0in2svQ7po7rUX8qLBRMw0PpJrCTjgwJNm1rk5nvEbzmBtp1tXZqLC9W5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="364945380"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364945380"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="702949237"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="702949237"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2023 09:13:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9D99330D; Mon, 24 Jul 2023 19:13:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 5/6] gpio: ge: Replace GPLv2 boilerplate with SPDX
Date:   Mon, 24 Jul 2023 19:13:19 +0300
Message-Id: <20230724161320.63876-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
References: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the GPLv2 boilerplate text with a nice and short
SPDX header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-ge.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 268de5496fcb..5dc49648d8e3 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Driver for GE FPGA based GPIO
  *
  * Author: Martyn Welch <martyn.welch@ge.com>
  *
  * 2008 (c) GE Intelligent Platforms Embedded Systems, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 /*
-- 
2.40.0.1.gaa8946217a0b

