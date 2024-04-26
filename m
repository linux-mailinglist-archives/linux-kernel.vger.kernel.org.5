Return-Path: <linux-kernel+bounces-160011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07CC8B37A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E2A284B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CC8147C82;
	Fri, 26 Apr 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JVHu7etS"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF76146A95;
	Fri, 26 Apr 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136391; cv=none; b=lVsBoGYxPMszVdT8aZSQRovVNIvqCTazVSUiB9BriAyZAkvcSgGoojBW5Cjh7lNkiBLFdFNfX1cP6oOaSQU4FVCL3pAV4tj2l8XRFW5mAWChI5wGzEzdw1/nwBAa3WD0zKOc8ZhXLmEqMtyLmkvP6z+9Fmrt44OlJEK713t3PTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136391; c=relaxed/simple;
	bh=P5OX/QQI1t8owlLKYXnbItzWKW3Jq53ralF3vuJMFlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV/SWIA/cgA1xymNrpFUdt/Qls+9/608BBuropxl9Kz3biTuexFWpudazhzHzYsuakgm7sq/BpFmr5tM9Vqs2SVsk/jgdFaUQdLcTnGWl7sTILRIH8tGYCCPW/DEyP4Nr/5wJZE8oYxas3iSZva7Y0wfGd1p+wW9+iEl7sTRbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JVHu7etS; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QADJwb024449;
	Fri, 26 Apr 2024 14:59:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=q5X1JGlclQugd+ulWWwuBLsSOXXvpvEt2uypWeNRnZ0=; b=JV
	Hu7etSy0i+O/S6xSt8AtVDjF5wnap1TkLmIpt3kDtigRhJKmoDAFvzahNCrc99Dj
	DEVZLP4cNlHWreveHIKT2rRZv9oIaebjudvK0SfduqqWRFCzsTFhkHwR1mcQEU+d
	7OMzjOsk+UnXJo3uu5PWF/Ts6SN5tMr/6byIv/LPm6MFz/Xx9+x3/RT1eh0TpsMU
	dGYX2j8ih3FvIAtoXMrgBznfzEEzA0W5/1x0aMUjsFoP8ezgeAPx6SRbjx4zxKKH
	5H6xBKbp8sgm4Pr3S1BXRubTBzZ7GB04S5CmslfBAaVciraROotYNf5jK6hgTyWm
	DDltwhYCZDUx43Qpif4Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cntnpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:59:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 46B9240048;
	Fri, 26 Apr 2024 14:59:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E97BA222CB3;
	Fri, 26 Apr 2024 14:59:19 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:59:19 +0200
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
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/11] ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
Date: Fri, 26 Apr 2024 14:57:04 +0200
Message-ID: <20240426125707.585269-9-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426125707.585269-1-christophe.roullier@foss.st.com>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

Both instances ethernet based on GMAC SNPS IP on stm32mp13.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 31 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp133.dtsi | 30 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index ecfa120827ba..00d258d2032e 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -854,6 +854,37 @@ crc1: crc@58009000 {
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
index 3e394c8e58b9..2796d15276df 100644
--- a/arch/arm/boot/dts/st/stm32mp133.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp133.dtsi
@@ -68,4 +68,34 @@ channel@18 {
 			};
 		};
 	};
+
+	ethernet2: ethernet@5800e000 {
+		compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
+		reg = <0x5800e000 0x2000>;
+		reg-names = "stmmaceth";
+		interrupts-extended = <&intc GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clock-names = "stmmaceth",
+			      "mac-clk-tx",
+			      "mac-clk-rx",
+			      "ethstp",
+			      "eth-ck";
+		clocks = <&rcc ETH2MAC>,
+			 <&rcc ETH2TX>,
+			 <&rcc ETH2RX>,
+			 <&rcc ETH2STP>,
+			 <&rcc ETH2CK_K>;
+		st,syscon = <&syscfg 0x4 0xff000000>;
+		snps,mixed-burst;
+		snps,pbl = <2>;
+		snps,axi-config = <&stmmac_axi_config_2>;
+		snps,tso;
+		status = "disabled";
+
+		stmmac_axi_config_2: stmmac-axi-config {
+			snps,wr_osr_lmt = <0x7>;
+			snps,rd_osr_lmt = <0x7>;
+			snps,blen = <0 0 0 0 16 8 4>;
+		};
+	};
 };
-- 
2.25.1


