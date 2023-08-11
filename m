Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2128779772
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjHKTBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjHKTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:01:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1530CF;
        Fri, 11 Aug 2023 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691780469; x=1723316469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvC5ybwWd2s2QwBOcdZZsCQYPiTGu+dFmBHjemTdC1g=;
  b=ETD7oddRuH80MOGWTzgTcw/aFSQdzCaLVcKbQaMHHrwuJMvq1QhEAh5J
   ulkZLFdGhSfO6DpQiFFn7sPviik4OuR3jajwc+pdGEECRBi+SJ+SulwVS
   unoxzQ68XufeX2AwPgA7WxAonsc0ZwhjUUuWfKoVuaOlCYvdmsrIMUMrI
   b4/JBttf7VRQeR94wtru9etd05Wk0NerVdP2SRKT+MMju9QiMYpJFSCdl
   LLAPhlg+IVYesj2CMMM+H8EK7AJg+mksX4t0b1u3QwgQmWZOYP7EtBveG
   SgIHK3Y2qj3jTYLZibcIap+B7cTaYilwAd1GV+wppDMu0HIyF1a91zG97
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402718877"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="402718877"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 12:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="802768053"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="802768053"
Received: from pglc00052.png.intel.com ([10.221.207.72])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 12:00:44 -0700
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: snps,dwmac: Tx queues with coe
Date:   Sat, 12 Aug 2023 03:00:31 +0800
Message-Id: <20230811190032.13391-2-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20230811190032.13391-1-rohan.g.thomas@intel.com>
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
 <20230811190032.13391-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for the number of tx queues with coe support. Some
dwmac IPs support tx queues only for a few initial tx queues,
starting from tx queue 0.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..0c6431c10cf9 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -313,6 +313,9 @@ properties:
       snps,tx-queues-to-use:
         $ref: /schemas/types.yaml#/definitions/uint32
         description: number of TX queues to be used in the driver
+      snps,tx-queues-with-coe:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: number of TX queues that support TX checksum offloading
       snps,tx-sched-wrr:
         type: boolean
         description: Weighted Round Robin
-- 
2.19.0

