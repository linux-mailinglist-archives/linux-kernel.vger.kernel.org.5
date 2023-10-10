Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD61B7BF5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442831AbjJJI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442828AbjJJI03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:26:29 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7DEAF;
        Tue, 10 Oct 2023 01:26:26 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39A0Ylpo012924;
        Tue, 10 Oct 2023 10:26:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=fE1n5RTIzcUozo7IYZhXqyrLMqCuRn0oukoD09IgbtQ=; b=rl
        zS9b1IU0YIu+QgoM5iLY/8vwNkgNB+zvET4bTThk97IWEqTxl0sdE8r9KEMcB+UA
        mRcddzwGcW6kOPDBq50CGs040POY9d3GVttIzPRwiGXxL1Nwq4OjZBveeozKHk8U
        6lHM0hFqx/y7C7GHz7X7uangMjh2BVfYa+ffmYjhjIdWU1bO/2wntFjkQat+5Pf0
        yJ3fuiMcu1kz5V2Lh7KAqAEAH4dwdf9+V3j6h6PvDcU/zcYT6V6cvycXtzRH+03W
        G+DHhanYPcM22ks3Cz+Ffhnu25OV7oKW5k3bbw6DY55/ruBBJ7TEGghgP29N9Bhm
        /wahRrgXWu9SM29QLOKw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhk3gs64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 10:26:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 290D0100058;
        Tue, 10 Oct 2023 10:26:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E05D218639;
        Tue, 10 Oct 2023 10:26:04 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 10:26:03 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/5] ARM: dts: stm32: add dcmipp support to stm32mp135
Date:   Tue, 10 Oct 2023 10:24:04 +0200
Message-ID: <20231010082413.1717919-5-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010082413.1717919-1-alain.volmat@foss.st.com>
References: <20231010082413.1717919-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@foss.st.com>

Add dcmipp support to STM32MP135.

Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/st/stm32mp135.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135.dtsi b/arch/arm/boot/dts/st/stm32mp135.dtsi
index abf2acd37b4e..68d32f9f5314 100644
--- a/arch/arm/boot/dts/st/stm32mp135.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp135.dtsi
@@ -8,5 +8,16 @@
 
 / {
 	soc {
+		dcmipp: dcmipp@5a000000 {
+			compatible = "st,stm32mp13-dcmipp";
+			reg = <0x5a000000 0x400>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rcc DCMIPP_R>;
+			clocks = <&rcc DCMIPP_K>;
+			status = "disabled";
+
+			port {
+			};
+		};
 	};
 };
-- 
2.25.1

