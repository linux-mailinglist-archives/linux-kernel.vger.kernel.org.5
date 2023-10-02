Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F327B4D64
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjJBIoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:44:05 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B5BF;
        Mon,  2 Oct 2023 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1696236242; x=1727772242;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RybJ2Heti/XiF4SfdeJ+zR8U8gtXfuAAevm4bAB7138=;
  b=eBw98ocgJwij5O0Ql6VBavA/N+BN8CrcDEiuwIKf7Bl2TtkgyIrWMOoV
   e3NcsAPWohsgbbN0rNvhtewJRDFHw20rOv2oyy3EAQASdBywmXQhBBER+
   +sVYif91LC8J8Hk1o0Mes1HrX03NEjJCf7l28VNRPcuVXz/V7UDTUjymg
   obvoMpB0EdKce57v+FN7szYItXB+Ui5EhWdLkF4TDyRMlRjvpB1Pc7y2J
   bMHM/sAeCXTwTZRoz2N6s/0n8nw9lBnDFZYXyA7Zi4NmR3BXD6GwaExTV
   XWTBEl3MTxb39/7cuMJ/murzLG2FhvJwCPjTAG2ZYWVMBeshl7RIlS735
   w==;
X-IronPort-AV: E=Sophos;i="6.03,193,1694728800"; 
   d="scan'208";a="33241246"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Oct 2023 10:43:59 +0200
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 57D1C280084;
        Mon,  2 Oct 2023 10:43:59 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date:   Mon, 02 Oct 2023 10:43:50 +0200
Subject: [PATCH v3 1/5] arm64: dts: ls1043a: remove second dspi node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-for-ml-tqmls10xxa-v2-test-v3-1-402819b9a29b@ew.tq-group.com>
References: <20231002-for-ml-tqmls10xxa-v2-test-v3-0-402819b9a29b@ew.tq-group.com>
In-Reply-To: <20231002-for-ml-tqmls10xxa-v2-test-v3-0-402819b9a29b@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696236239; l=1141;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=8Y3h2d6CbOubTPWfT0OO+4KeSdQaaMj2d2w1Xtw1l7Q=;
 b=QKihzRmq08L7aJuj/1ApXHGzfqs617OoF94v7PpqW/cN3kHRpFK2Zmcu22oDvf5DmkcTOYDv5
 IiFwZZ0GgDDBTOgvVWDW60NQdOlYTvlkpOYqARAPuC1sGJ4Y2Urg6qW
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

