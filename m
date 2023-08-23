Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC117857A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjHWMK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjHWMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:10:55 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DBEE71;
        Wed, 23 Aug 2023 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692792637; x=1724328637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvE0awutiQ6Vu22OGS7WvePTbl+o03EgO2yuyEWNusA=;
  b=RQ2zfvvIk4yYyYEpQNX7a9SlPAm5PT8gYtlcoWfjnmy2N2uHNrYAs9vv
   b3lmVMR1LYJvN6PFrwBot7W0Fn5E88ed9BH8WZJekY6CfsC8vWlp2NDLi
   +i0wn/5BR0NgVZtOGmt0pFgpysfqt1t1qvhd7CBn1W8urZ/GaaOOjhZ6W
   XYUp/1umPMUF2glzlY4hyMhSDDGmvDfjNUDHQZZ8AbnIDMo6Y/xFOyafJ
   9x6v47Z1ZMQ4PrA+lY6bl8Qqx34M/M6pRcWFRM+FUcg1qEtEXH+lof4n0
   CkaQpBKLAZcV+Lh5XnBuCjItFRtWocsdQkiPWnixc70GLEn1yAWVsYUlO
   g==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="32586562"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 14:10:01 +0200
Received: from herburgerg-w2.tq-net.de (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5E189280084;
        Wed, 23 Aug 2023 14:10:01 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 1/6] arm64: dts: ls1043a: remove second dspi node
Date:   Wed, 23 Aug 2023 14:09:47 +0200
Message-Id: <20230823120952.317740-2-gregor.herburger@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
References: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation the ls1043a has only one spi controller.
So remove the second one.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index f8acbefc805b..229bb4bebe42 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -526,20 +526,6 @@ dspi0: spi@2100000 {
 			status = "disabled";
 		};
 
-		dspi1: spi@2110000 {
-			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x0 0x2110000 0x0 0x10000>;
-			interrupts = <0 65 0x4>;
-			clock-names = "dspi";
-			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
-					    QORIQ_CLK_PLL_DIV(1)>;
-			spi-num-chipselects = <5>;
-			big-endian;
-			status = "disabled";
-		};
-
 		i2c0: i2c@2180000 {
 			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
 			#address-cells = <1>;
-- 
2.34.1

