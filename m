Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7988765D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjG0UXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjG0UXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:23:37 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD530E4;
        Thu, 27 Jul 2023 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690489406; x=1722025406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dkGJm5iG8le/XoYOxBxQniOIy2iGaYjjjM3wmjqRvPs=;
  b=MVdmu0ai9uP5c/pyhQt5r7VoX5PHSo+KbiEsGbXKP0b0dwATbnWpggsn
   oIN2Va7mXqVgUOO4wFpNTkUptz8CCwX39Wy6ZHXHm0ZXwQ5f56S3MNZmb
   iNTCFlW3IZQyUAADPsMKWheruJ+O/qmDaVfim6OO0VwbwNJM0MvZor9bc
   T/brU6Rgd9L6mpbQtxgpexEfPiRaTgmjMbVtdLeKHvOg5LmCCXog8H1V4
   WnX3jP/xHUKrpLkfgYJTipK2W9dAQ31XPq4vWnCHeF2fh8hfL8XT0XhaY
   20DK9qi+w14gK2PQLYMEEEY4S0LZNeIddI5IsczOF9kDiPAXA1kzTmC6y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368442778"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="368442778"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="900980512"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="900980512"
Received: from mtyszka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.133.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:23:22 -0700
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
Subject: [PATCH v3 3/4] ARM: dts: nuvoton: Add PECI controller node
Date:   Thu, 27 Jul 2023 22:21:25 +0200
Message-Id: <20230727202126.1477515-4-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230727202126.1477515-1-iwona.winiarska@intel.com>
References: <20230727202126.1477515-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PECI controller node with all required information.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..cccc33441050 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -220,6 +220,15 @@ kcs3: kcs3@0 {
 				};
 			};
 
+			peci0: peci-controller@f0100000 {
+				compatible = "nuvoton,npcm750-peci";
+				reg = <0xf0100000 0x200>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
+
 			spi0: spi@200000 {
 				compatible = "nuvoton,npcm750-pspi";
 				reg = <0x200000 0x1000>;
-- 
2.40.1

