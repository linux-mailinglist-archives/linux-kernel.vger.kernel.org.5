Return-Path: <linux-kernel+bounces-140672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1CA8A179A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2901C20D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CAC20DE7;
	Thu, 11 Apr 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="feQ1UZcg"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543181CA8F;
	Thu, 11 Apr 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846416; cv=none; b=di+qyEGYdWXzCAnh/QhSP0lhylJV6359PoUIHsl4kZQgSOLm48/GOjoFfDgaCV/STJOZ701+da9cKtGV534DIerwQc/V1SAKkebH41nTyAe95X5yDSlvCwZERU0SxWzCbVacToq7300MO4sYzQXrKmedN870uz4KmRcavFWN5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846416; c=relaxed/simple;
	bh=5xj57YNGkTD+cWLan6AIw/SH3B+6aULBCDDDfXg3Jow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLD0udbp/zkv/RdD3ZL/CK/qzjbKrkxk8NeQTD7Vv9PH2g3Y+uqbhf8AKQi2wEyNqUbTjY4mo4RwhB74e5bcKziY0J2XQf+DtMkpUr9zHGXNFdWvKygvVTvM4VYaOIAw9g+U57Pu08AEJJF9J2LuP8IaW8eB67CZykqozpWKmoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=feQ1UZcg; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BCBImq019272;
	Thu, 11 Apr 2024 16:39:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=t5IVkMm8iQ9dYkTqReVJbSCFucX8LM6H2hUPYVIdyno=; b=fe
	Q1UZcg6uhS8NG0jjRknV0C7rFki+LGmq5y89vTmjgT2AgwewiCo3oeX/OJ+Xn7ZQ
	bx75iyEgtaOCRzOz3EMG1PQk/l5qbEm0I7mn9sRZ19M+gLUY085pWhwvsPH3Xcxs
	N/K8htbMRngNX1hH6FM+FGcYsUXPT7OpsdqN3wLktJShdlf8QxyFWwP01Q/bHlj+
	YkLK3ZuYXHfXI4uqiaFXJ9K9iTcn4zUJEcehRe5P1InaQXx3SafyGQvzTOaYmwWK
	vPZXypB5YaR5tH3PIrDs2AZfXTW8Cs2C6oZaY6EPhCWE6J1mBCz/w6zB4SndgnUh
	JuTeRa8SSJChXAqlJnRQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbhbjb8kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:39:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 180B140045;
	Thu, 11 Apr 2024 16:39:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AEE5021BF5A;
	Thu, 11 Apr 2024 16:38:38 +0200 (CEST)
Received: from localhost (10.48.86.106) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 16:38:37 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
Date: Thu, 11 Apr 2024 16:36:55 +0200
Message-ID: <20240411143658.1049706-9-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
References: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02

Both instances ethernet based on GMAC SNPS IP on stm32mp13.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 31 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp133.dtsi | 30 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 3900f32da797b..8ee3f212c0873 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1322,6 +1322,37 @@ crc1: crc@58009000 {
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


