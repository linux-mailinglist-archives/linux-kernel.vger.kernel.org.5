Return-Path: <linux-kernel+bounces-15801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C17823336
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56E11C213D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27671C6B4;
	Wed,  3 Jan 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AzZ9ubI+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECF1C2BB;
	Wed,  3 Jan 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4032Sq93004808;
	Wed, 3 Jan 2024 09:28:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=NCOi8MK/oxzSNBqqVOUYfqHk/FOhqRWG+Gpz8Bzjx9I=; b=AzZ
	9ubI+12xrSMdKfxQ2euVzgUOYoYNdgO4sDrPfbWVJhB0vG8i7oMC7h+eaXs6/6DF
	kNE1eD8AYNncgxf7qnTHQLD/cz27lzG3a4NUoP++bUUPRjxKPjwWvjNblQ1hJxit
	BEvJBIy15PLJhTnYIOViBoxkWt9XGUo/0yr+NNJIOZSMCKthsX562dDR3YeRTaoz
	IeyCymImW87HGjhfdmlmu0/72qQER1VijWeOvApU3pV/1wJEr52GZcrtCECHBP/O
	ok/ZbN/Sb5yjf4AoKFlA1pTTrdVsbiXxpTGR5pKerRxFLozuko1WA53sauab/PZT
	/4BK6C7kbIS6HRuJoOg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vcxu5umjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 09:28:16 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 3 Jan
 2024 09:28:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 3 Jan 2024 09:28:14 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id AA88F5B6933;
	Wed,  3 Jan 2024 09:28:11 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <huziji@marvell.com>,
        <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 2/2] arm64: dts: ac5: add mmc node and clock
Date: Wed, 3 Jan 2024 19:28:03 +0200
Message-ID: <20240103172803.1826113-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103172803.1826113-1-enachman@marvell.com>
References: <20240103172803.1826113-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RdWnCnkYxNb3y4FkkXMh44Hr1tz6OkzZ
X-Proofpoint-GUID: RdWnCnkYxNb3y4FkkXMh44Hr1tz6OkzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add mmc and mmc clock nodes to ac5 and ac5x device tree files

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 31 ++++++++++++++++++-
 .../boot/dts/marvell/ac5-98dx35xx-rd.dts      |  4 +++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
index b5e042b8e929..5591939e057b 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -77,7 +77,6 @@ soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		dma-ranges;
 
 		internal-regs@7f000000 {
 			#address-cells = <1>;
@@ -204,6 +203,30 @@ gpio1: gpio@18140 {
 			};
 		};
 
+		mmc_dma: bus@80500000 {
+				compatible = "simple-bus";
+				ranges;
+				#address-cells = <0x2>;
+				#size-cells = <0x2>;
+				reg = <0x0 0x80500000 0x0 0x100000>;
+				dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
+				dma-coherent;
+
+				sdhci: mmc@805c0000 {
+					compatible = "marvell,ac5-sdhci",
+						     "marvell,armada-ap806-sdhci";
+					reg = <0x0 0x805c0000 0x0 0x1000>;
+					interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&emmc_clock>, <&cnm_clock>;
+					clock-names = "core", "axi";
+					bus-width = <8>;
+					non-removable;
+					mmc-ddr-1_8v;
+					mmc-hs200-1_8v;
+					mmc-hs400-1_8v;
+				};
+		};
+
 		/*
 		 * Dedicated section for devices behind 32bit controllers so we
 		 * can configure specific DMA mapping for them
@@ -335,5 +358,11 @@ nand_clock: nand-clock {
 			#clock-cells = <0>;
 			clock-frequency = <400000000>;
 		};
+
+		emmc_clock: emmc-clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts b/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
index f0ebdb84eec9..0c973d7a215a 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
@@ -99,3 +99,7 @@ parition@2 {
 		};
 	};
 };
+
+&sdhci {
+	status = "okay";
+};
-- 
2.25.1


