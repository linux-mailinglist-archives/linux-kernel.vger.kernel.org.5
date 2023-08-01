Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD776A5F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjHABGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjHABGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:06:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19166171B;
        Mon, 31 Jul 2023 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690851959; x=1722387959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZZm64ITvXBzesnZhVTHqUbu1ipk4ym1rIVVjHPXy88=;
  b=XJsKTnuiG4ffyjxHNlZ8UgMYRKty2yFfXi8DZUJ4oYnJzYrXfNvUNNjH
   04MW3XcsU1znplkueylIxU0byaTFj56kPdk2si43BhyaeWjJs1BZFbgDZ
   f4T5sCgt3z/1xXQedAwEadOgAYgtcC23FbX3wMEWKl7C2KvPn3RQLuHYN
   eDX/7K8OmdXe7rAw5sXgRMnYrFSh44zA+0IDxXo2jSeES+/8F0XEg8tap
   KtdbeAWsR/twpUiXbsKYfCObqcuc6D/fOrWmWJ8ejp+gJAXnWGaZCTB70
   zmQFDKtgmkxCBX72Jm69L2Wvyn0zrpWOj2ca0UihrRSeAOlTvZbnLOjqe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372788111"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372788111"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="818587536"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="818587536"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2023 18:04:00 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        wen.ping.teh@intel.com
Subject: [PATCH v2 2/5] dt-bindings: reset: add reset IDs for Agilex5
Date:   Tue,  1 Aug 2023 09:02:31 +0800
Message-Id: <20230801010234.792557-3-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add reset ID definitions required for Intel Agilex5 SoCFPGA, re-use
altr,rst-mgr-s10.h as common header file similar S10 & Agilex.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 include/dt-bindings/reset/altr,rst-mgr-s10.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/reset/altr,rst-mgr-s10.h b/include/dt-bindings/reset/altr,rst-mgr-s10.h
index 70ea3a09dbe1..04c4d0c6fd34 100644
--- a/include/dt-bindings/reset/altr,rst-mgr-s10.h
+++ b/include/dt-bindings/reset/altr,rst-mgr-s10.h
@@ -63,12 +63,15 @@
 #define I2C2_RESET		74
 #define I2C3_RESET		75
 #define I2C4_RESET		76
-/* 77-79 is empty */
+#define I3C0_RESET		77
+#define I3C1_RESET		78
+/* 79 is empty */
 #define UART0_RESET		80
 #define UART1_RESET		81
 /* 82-87 is empty */
 #define GPIO0_RESET		88
 #define GPIO1_RESET		89
+#define WATCHDOG4_RESET		90
 
 /* BRGMODRST */
 #define SOC2FPGA_RESET		96
-- 
2.25.1

