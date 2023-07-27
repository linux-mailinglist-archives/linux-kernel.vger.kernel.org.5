Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDD765E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjG0VyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjG0Vxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:53:31 -0400
Received: from qs51p00im-qukt01080302.me.com (qs51p00im-qukt01080302.me.com [17.57.155.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290435BC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494779; bh=m40TTdzUJgBT59AnP9PsBahkFfWecCyHP3ln170ZB58=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=GcD7aKhxI99Fz/Jf/VgmfP70t9bGrJkA0mYxZW4KiylLb4arx3fXy849ewttmtJTQ
         G+J4IUFYPahoQGqmNlC2R27qgLvn7ssAq8d6towHzpAeGnG1ZSKMa92MTJb0NQX4pL
         X5Jn5irZgj3R40Ok92JgL6+sPmmiY66p84FkL9HjmRzrWhYg0r7ojSEy9lCbfPT4oZ
         h4L7tqzrJNKE2GLHRuFX++48aDu/7khar80ka4oU8jOD+gTnyT44l6ODztGOlSTo23
         209P9WzL1meteUEBHSLQQhXbJaTBZ+lJtD0m9qBO+MUmZRh7xv5z5FTl/u4/AFUs9k
         KAWsjX6ujPr/Q==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080302.me.com (Postfix) with ESMTPSA id 932B811403EF;
        Thu, 27 Jul 2023 21:52:58 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] ARM: dts: sti: add the gpu node for the MALI-400 on stih418.dtsi
Date:   Thu, 27 Jul 2023 21:51:37 +0000
Message-Id: <20230727215141.53910-14-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _dD8OySoFpugRYp-dxMmbch864BM7qHt
X-Proofpoint-ORIG-GUID: _dD8OySoFpugRYp-dxMmbch864BM7qHt
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=598 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270199
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gpu node for the MALI-400 found on stih418 soc.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih418.dtsi | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
index b41de235fffa..965931da5a3f 100644
--- a/arch/arm/boot/dts/st/stih418.dtsi
+++ b/arch/arm/boot/dts/st/stih418.dtsi
@@ -268,5 +268,39 @@ vtg_aux: sti-vtg-aux@a800200 {
 
 			status = "disabled";
 		};
+
+		gpu: gpu@9f00000 {
+			compatible = "arm,mali-400";
+			reg = <0x9f00000 0x10000>;
+			/* LIMA driver needs 2 clocks, use the same for both */
+			clocks = <&clk_s_c0_flexgen CLK_ICN_GPU>,
+				 <&clk_s_c0_flexgen CLK_ICN_GPU>;
+			clock-names = "bus", "core";
+			assigned-clocks = <&clk_s_c0_flexgen CLK_ICN_GPU>;
+			assigned-clock-rates = <400000000>;
+			resets = <&softreset STIH407_GPU_SOFTRESET>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pp2",
+					  "ppmmu2",
+					  "pp3",
+					  "ppmmu3";
+
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1

