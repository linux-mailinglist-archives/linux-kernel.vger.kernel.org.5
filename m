Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D520B77BAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjHNOG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHNOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:06:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743610D0;
        Mon, 14 Aug 2023 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692022014; x=1723558014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvC5ybwWd2s2QwBOcdZZsCQYPiTGu+dFmBHjemTdC1g=;
  b=M6FHPeC9e3gvWlpNInga+dGn/SCDGRA8YeHaqY+hTjVYbECB5XcJJXp1
   5Y7Ie+a7KNCV8CZDax8dQ46mvSD6cZn4xekT2SiLpcDfM15iKVsvmWtor
   80nPgS//Tlx2hMYrR4eJ2CqDfECyuxe82Mz2ABlSYy+sVkNWwZshKjDPH
   oqp02rmIcCB28FswO6I68FnerjiTq8J0DBQOldqQpczTaVBCBzdZZ3TqG
   d9V39pZoQKL+4qSTBRaxo/2jlEucYYfeLOL7Sa6A4nOL1k20ldRr50TYM
   IPDWrydKhgPGZ9u6MfrQarWi89kyvrVgcx+wvTJSnpCCafPpJDsSFUp3s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438377203"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="438377203"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683317911"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="683317911"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2023 07:06:48 -0700
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
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: snps,dwmac: Tx queues with coe
Date:   Mon, 14 Aug 2023 22:06:36 +0800
Message-Id: <20230814140637.27629-2-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20230814140637.27629-1-rohan.g.thomas@intel.com>
References: <20230814140637.27629-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

