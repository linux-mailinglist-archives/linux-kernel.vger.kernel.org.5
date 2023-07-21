Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C385175BED7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGUG1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGUG1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:27:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF81BC1;
        Thu, 20 Jul 2023 23:26:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453327532"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453327532"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 23:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="727990182"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="727990182"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2023 23:26:54 -0700
Received: from localhost (pglc00300.png.intel.com [10.221.233.223])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 84E504832;
        Fri, 21 Jul 2023 14:26:53 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 839CC80F8C4; Fri, 21 Jul 2023 14:26:53 +0800 (+08)
From:   Boon@ecsmtp.png.intel.com, Khai@ecsmtp.png.intel.com,
        "Ng <boon.khai.ng"@intel.com
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Boon Khai Ng <boon.khai.ng@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@intel.com>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Leong Ching Swee <leong.ching.swee@intel.com>,
        G Thomas Rohan <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
Subject: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Date:   Fri, 21 Jul 2023 14:26:16 +0800
Message-Id: <20230721062617.9810-2-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721062617.9810-1-boon.khai.ng@intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_UNBAL1,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boon Khai Ng <boon.khai.ng@intel.com>

This patch is to add the dts setting for the MAC controller on
synopsys 10G Ethernet MAC which allow the 10G MAC to turn on
hardware accelerated VLAN stripping. Once the hardware accelerated
VLAN stripping is turn on, the VLAN tag will be stripped by the
10G Ethernet MAC.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..905de37e861f 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -487,6 +487,11 @@ properties:
     description:
       Frequency division factor for MDC clock.
 
+  snps,rx-vlan-offload:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable hardware-accelerated RX VLAN stripping.
+
   mdio:
     $ref: mdio.yaml#
     unevaluatedProperties: false
-- 
2.25.1

