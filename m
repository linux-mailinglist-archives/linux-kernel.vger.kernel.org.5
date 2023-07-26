Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFCD763F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjGZT3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGZT33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:29:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092ED2D7D;
        Wed, 26 Jul 2023 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690399758; x=1721935758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeEGqpvtDT+7iTCOG+Fl7R/2EclFppBGdUDQfhYalbc=;
  b=ClWDwPoz4E4GQFMuS3IEKstdtzrMTtD/al7oJa17ln5F8GsMTT2F/caB
   Rm6u7F9fCdVzXTnmDhT+GgkFpJ/h84qB2eMQlEsYi2+ViBQXck4mmhZXg
   oe72QfaIA2rHTif18jkIWPnm+vwAc7q5LObld6t1Nq3syhDY6yen3EM2Z
   EGhr65kFdwXVM0HqYSV+ktrZyywRXbL99OPyYHYskal7oDTgcFp0BrxrY
   fNuN5EXnCr8I/0AGYbqI9is008ByLPYZO5nkKcXqJpWRU5mSi9K4a97Yj
   ae2joG3aF9VuNsbkfobWUZ4Xwyuk9bmtlDtj4vAIbjiiXJbPb0/fiVVlw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371722808"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="371722808"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 12:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900554813"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="900554813"
Received: from wfryca-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.133.1])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 12:29:14 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v2 4/4] arm64: dts: nuvoton: Add PECI controller node
Date:   Wed, 26 Jul 2023 21:27:40 +0200
Message-Id: <20230726192740.1383740-5-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726192740.1383740-1-iwona.winiarska@intel.com>
References: <20230726192740.1383740-1-iwona.winiarska@intel.com>
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

Add PECI controller node with all required information.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index aa7aac8c3774..b8326bbe9fde 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -68,6 +68,15 @@ apb {
 			ranges = <0x0 0x0 0xf0000000 0x00300000>,
 				<0xfff00000 0x0 0xfff00000 0x00016000>;
 
+			peci0: peci-controller@100000 {
+				compatible = "nuvoton,npcm845-peci";
+				reg = <0x100000 0x1000>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk NPCM8XX_CLK_APB3>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
+
 			timer0: timer@8000 {
 				compatible = "nuvoton,npcm845-timer";
 				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.40.1

