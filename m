Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56B7A1BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjIOKET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjIOKEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:04:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FED3592;
        Fri, 15 Sep 2023 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694772167; x=1726308167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SNz9ScF+wt804GivI3ixasEzsFqTt1XAXDDCOHpojXU=;
  b=S6Zn2VKdeTr7lLpNvU1QmttEvVUO/Jt+JFEPPfA8YJRW/ffc1u13H+z5
   JGuzCwt804I3LIbVgGJ0Rgkl17FtuorlhYmARPJVv5ruIl5G/cViSuvc3
   WWJttCMUcsGBfSod/drqJTYVMlwqKp6raTDiBQVO+JR0tIXyBQl59QG+5
   QCZnuty+GYK/Yss/CINOzx4Gz4KavTB93INzVTwB9iApobxLbiEf4cSPC
   Sn4NQNiDqCd84ab94FrBpEUPNmeAARQJ48RPJUAEmsit/0IxwUKuOHtbJ
   xoq9ufpOSukEE9dJOyA03f4qHn44Wrdvo8kYOAjLu3aW1+B3AFLcwoYYp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381938691"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="381938691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744916306"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="744916306"
Received: from pglc00032.png.intel.com ([10.221.207.52])
  by orsmga002.jf.intel.com with ESMTP; 15 Sep 2023 02:54:27 -0700
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
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        fancer.lancer@gmail.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v6 1/2] dt-bindings: net: snps,dwmac: Tx coe unsupported
Date:   Fri, 15 Sep 2023 17:54:16 +0800
Message-Id: <20230915095417.1949-2-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915095417.1949-1-rohan.g.thomas@intel.com>
References: <20230915095417.1949-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for coe-unsupported property per tx queue.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..365e6cb73484 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -394,6 +394,9 @@ properties:
               When a PFC frame is received with priorities matching the bitmask,
               the queue is blocked from transmitting for the pause time specified
               in the PFC frame.
+          snps,coe-unsupported:
+            type: boolean
+            description: TX checksum offload is unsupported by the TX queue.
         allOf:
           - if:
               required:
-- 
2.25.1

