Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3147F161B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjKTOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjKTOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:46:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2F4139;
        Mon, 20 Nov 2023 06:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700491615; x=1732027615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0SVHCxyMs+vlVsjGpSiBU8bWb2RA8tmqrElqqof/mfI=;
  b=lksr6iwWosrD7HCgwkAm2VIWWKjSB+Xbru0NQrssUI0kfMwQL5rm6y/i
   DDrkDlw8SXtv1cCc8KOp2g2AVjXGcNkuGDFjdrcWk7NP7gPo3X1ujMUd+
   1OLM9iSqEv8H5H6Y3eybUN0EjxURL6kqLEj3DFNMpvvM/fC511wiz+fxF
   TN5R9lwxCvMSx+VQgNh9o2xilpQWFIR3cl+nng06JlwCUKL18Mc+kO5cP
   O/eP7NWMNNLb613EjQ6v4zhX4uwfBx4QpdBHcYPCaZGDIglxOKXoLZp73
   e+xY/0F80pZQiZervMhVCsksES7t/XO1B/EAify21V76XmmplT0SA5Qjo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="455956474"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="455956474"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801193156"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801193156"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 06:46:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A940242D; Mon, 20 Nov 2023 16:46:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 11/24] i2c: designware: Drop return value from i2c_dw_acpi_configure()
Date:   Mon, 20 Nov 2023 16:41:53 +0200
Message-ID: <20231120144641.1660574-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c_dw_acpi_configure() is called without checking of the returned
value, hence just drop it by converting to void.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 4 +---
 drivers/i2c/busses/i2c-designware-core.h   | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 35f762872b8a..7a53a732981b 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -255,7 +255,7 @@ static void i2c_dw_acpi_params(struct device *device, char method[],
 	kfree(buf.pointer);
 }
 
-int i2c_dw_acpi_configure(struct device *device)
+void i2c_dw_acpi_configure(struct device *device)
 {
 	struct dw_i2c_dev *dev = dev_get_drvdata(device);
 	struct i2c_timings *t = &dev->timings;
@@ -285,8 +285,6 @@ int i2c_dw_acpi_configure(struct device *device)
 		dev->sda_hold_time = fs_ht;
 		break;
 	}
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_acpi_configure);
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index f8dd87cb0ae9..b7884f15e0e9 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -399,7 +399,7 @@ int i2c_dw_validate_speed(struct dw_i2c_dev *dev);
 void i2c_dw_adjust_bus_speed(struct dw_i2c_dev *dev);
 
 #if IS_ENABLED(CONFIG_ACPI)
-int i2c_dw_acpi_configure(struct device *device);
+void i2c_dw_acpi_configure(struct device *device);
 #else
-static inline int i2c_dw_acpi_configure(struct device *device) { return -ENODEV; }
+static inline void i2c_dw_acpi_configure(struct device *device) { }
 #endif
-- 
2.43.0.rc1.1.gbec44491f096

