Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173B27B20E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjI1PRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjI1PRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:17:13 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496DE10EA;
        Thu, 28 Sep 2023 08:17:06 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEDvEp029805;
        Thu, 28 Sep 2023 17:16:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=mE2JlaThV5VogJG8NYQ/wg386Pa1kbE2axCKiF0U5ys=; b=nQ
        6vKt/6C3/LQZBZyTB45ik/eZJxmzT0nC+VpMSJLaO71YoZ9FKQ1/A2PCG0NkYC3B
        T2uPzGnXPRC1f9rH6mNiu4ppEiH1MyTrwTOaSbSsN8h2UJtbs9FdhjE4tGt2hV08
        WtftJeRHYbtONrAdmK8/ZUgNS7Ky0UOrd+6dP6pTDzzAEzNnL+ydn01pd2D12MmH
        lbvCwG/YpVj4oBj0O8Np6LJ+o77cYNnUXmtmAh1Aq+VOs9zr9EAJwam7Hgp/0uuR
        zhRUwiIIoerhCkF3lIAQpOGpSOwq6VOXfKecjt28VSYttRaWNUw6jfDU+YUv9Cqi
        FqdHIQBdZYeuyhDTmYQA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tcq63cupk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:16:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43E03100058;
        Thu, 28 Sep 2023 17:16:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 39DA024553C;
        Thu, 28 Sep 2023 17:16:33 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 17:16:32 +0200
From:   Christophe Roullier <christophe.roullier@foss.st.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/12] ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
Date:   Thu, 28 Sep 2023 17:15:09 +0200
Message-ID: <20230928151512.322016-10-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928151512.322016-1-christophe.roullier@foss.st.com>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_14,2023-09-28_02,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both instances ethernet based on GMAC SNPS IP on stm32mp13.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 31 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp133.dtsi | 30 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index ac90fcbf0c091..d8339eea05d53 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1296,6 +1296,37 @@ sdmmc2: mmc@58007000 {
 			status = "disabled";
 		};
 
+		ethernet1: ethernet@5800a000 {
+			compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
+			reg = <0x5800a000 0x2000>;
+			reg-names = "stmmaceth";
+			interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 68 1>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			clock-names = "stmmaceth",
+				      "mac-clk-tx",
+				      "mac-clk-rx",
+				      "ethstp",
+				      "eth-ck";
+			clocks = <&rcc ETH1MAC>,
+				 <&rcc ETH1TX>,
+				 <&rcc ETH1RX>,
+				 <&rcc ETH1STP>,
+				 <&rcc ETH1CK_K>;
+			st,syscon = <&syscfg 0x4 0xff0000>;
+			snps,mixed-burst;
+			snps,pbl = <2>;
+			snps,axi-config = <&stmmac_axi_config_1>;
+			snps,tso;
+			status = "disabled";
+
+			stmmac_axi_config_1: stmmac-axi-config {
+				snps,wr_osr_lmt = <0x7>;
+				snps,rd_osr_lmt = <0x7>;
+				snps,blen = <0 0 0 0 16 8 4>;
+			};
+		};
+
 		usbh_ohci: usb@5800c000 {
 			compatible = "generic-ohci";
 			reg = <0x5800c000 0x1000>;
diff --git a/arch/arm/boot/dts/st/stm32mp133.dtsi b/arch/arm/boot/dts/st/stm32mp133.dtsi
index df451c3c2a26d..aee855cd2f36b 100644
--- a/arch/arm/boot/dts/st/stm32mp133.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp133.dtsi
@@ -64,5 +64,35 @@ channel@18 {
 				};
 			};
 		};
+
+		ethernet2: ethernet@5800e000 {
+			compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
+			reg = <0x5800e000 0x2000>;
+			reg-names = "stmmaceth";
+			interrupts-extended = <&intc GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clock-names = "stmmaceth",
+				      "mac-clk-tx",
+				      "mac-clk-rx",
+				      "ethstp",
+				      "eth-ck";
+			clocks = <&rcc ETH2MAC>,
+				 <&rcc ETH2TX>,
+				 <&rcc ETH2RX>,
+				 <&rcc ETH2STP>,
+				 <&rcc ETH2CK_K>;
+			st,syscon = <&syscfg 0x4 0xff000000>;
+			snps,mixed-burst;
+			snps,pbl = <2>;
+			snps,axi-config = <&stmmac_axi_config_2>;
+			snps,tso;
+			status = "disabled";
+
+			stmmac_axi_config_2: stmmac-axi-config {
+				snps,wr_osr_lmt = <0x7>;
+				snps,rd_osr_lmt = <0x7>;
+				snps,blen = <0 0 0 0 16 8 4>;
+			};
+		};
 	};
 };
-- 
2.25.1

