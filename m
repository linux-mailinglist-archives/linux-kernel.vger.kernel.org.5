Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB17DBB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjJ3OKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3OKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:10:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3211BC0;
        Mon, 30 Oct 2023 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698675045; x=1730211045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyhDZlVvoZgL6YwfFJ3a7ANMHT3BRYGYddeuTV3c88M=;
  b=OWRPlBzO/vAFBGa+eEZ3QHkTDA8kmX44//2c4TcMUnt8SWkywDPwsl2A
   Y87JOEryje7DSCt2SlrzvDsH9ILUfEy6jv6/Oj7LdmdB66HEK1+aCxzH0
   0yDovpUXRYRpg4HAhkoXdj6zdR57ogqyi7Hj2BeizTx50sM8O0l3nU+kh
   +L3rrnFqGNKV1Gt6CFS/nEFgb+MXac898IbD0tOPqKgJOycurV2pX3mOb
   htBFly13rsbQyQGQvoo08fZWA3nbGyryw6ms3p8hiBiogDTBl03pYwJI1
   ZlHKQtDtx8sW2TBtNsIHtvsP4hj2VhNTatjLGN9GkED8I2ewqU8xSsgqQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378447164"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="378447164"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710102224"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710102224"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2023 07:10:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95163331; Mon, 30 Oct 2023 16:10:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/3] pinctrl: intel: Add ACPI ID to the generic platform driver
Date:   Mon, 30 Oct 2023 16:10:34 +0200
Message-Id: <20231030141034.3241674-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
References: <20231030141034.3241674-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INTC105F is an ACPI _CID that reflects compatibility with
the _DSD shema supported by the generic Intel pin control
platform driver. Add it there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel-platform.c b/drivers/pinctrl/intel/pinctrl-intel-platform.c
index 2305d8befdd3..5605583b1a34 100644
--- a/drivers/pinctrl/intel/pinctrl-intel-platform.c
+++ b/drivers/pinctrl/intel/pinctrl-intel-platform.c
@@ -203,6 +203,7 @@ static int intel_platform_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id intel_platform_pinctrl_acpi_match[] = {
+	{ "INTC105F" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, intel_platform_pinctrl_acpi_match);
-- 
2.40.0.1.gaa8946217a0b

