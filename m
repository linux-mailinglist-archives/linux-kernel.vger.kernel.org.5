Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F107A23FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjIOQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjIOQzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:55:11 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A1211E;
        Fri, 15 Sep 2023 09:55:06 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FFCZZc013831;
        Fri, 15 Sep 2023 16:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=kCP5NyPxTO7BWAoK67gZ/+nzaZUT8fuKl3dvUH5trzA=;
 b=OTS+qO9OEkWOGsotQoOyzELvRfr3aB/cLHD1txsD6GWOELyY09tnhuJY6YaAFF89oIHr
 8fox8IRN14Nk2GyNFFt2g/HwMd92pFwGKjh5Bdo/MgvQQqNfyPYej3j/VBtrCw5Cc7fa
 XLMEnQkOhln5BcJbAlPzyxR8zWsPT2Y5vgKpMqeGsLOVR2mk3EYl8duCW9YbAdoYMmiI
 Gh1aEm6pKsMkX+ywqSnonx/VAuXIOdu5OHiAjgf7NUPz88simGrM2j6sH+C3yBc60cCM
 y+raIQ/qQKMg6NsyxmdIrzmuf+Xv3zyKHi4+FVwb4gYLuHZWGgHBQr0TYs8T6YzBQhJi WA== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t44m9c29s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 16:54:54 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 56962805E79;
        Fri, 15 Sep 2023 16:54:53 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 881D6817A91;
        Fri, 15 Sep 2023 16:54:51 +0000 (UTC)
From:   charles.kearney@hpe.com
To:     charles.kearney@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] ARM: dts: hpe: BUG: Correct GXP register ranges
Date:   Fri, 15 Sep 2023 16:54:36 +0000
Message-Id: <20230915165436.3118284-2-charles.kearney@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915165436.3118284-1-charles.kearney@hpe.com>
References: <20230915165436.3118284-1-charles.kearney@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gzaso_YDJo8pWeEmPOjSNzCSTF6Ti4Ew
X-Proofpoint-GUID: Gzaso_YDJo8pWeEmPOjSNzCSTF6Ti4Ew
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_11,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=752
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150150
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Kearney <charles.kearney@hpe.com>

Bug fix to correct memory ranges on GXP to include host registers. This
corrects a issue where the host interrupt controller is not available.

Signed-off-by: Charles Kearney <charles.kearney@hpe.com>
---
 arch/arm/boot/dts/hpe/hpe-gxp.dtsi | 39 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/hpe/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe/hpe-gxp.dtsi
index cf735b3c4f35..18230a4754a6 100644
--- a/arch/arm/boot/dts/hpe/hpe-gxp.dtsi
+++ b/arch/arm/boot/dts/hpe/hpe-gxp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree file for HPE GXP
+ * Device Tree for HPE
  */
 
 /dts-v1/;
@@ -52,73 +52,74 @@ L2: cache-controller@b0040000 {
 			cache-level = <2>;
 		};
 
-		ahb@c0000000 {
+		ahb@80000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0xc0000000 0x30000000>;
 			dma-ranges;
+			ranges = <0x0 0x80000000 0x20000000>,
+			<0x40000000 0xc0000000 0x3fff0000>;
 
-			vic0: interrupt-controller@eff0000 {
+			vic0: interrupt-controller@4eff0000 {
 				compatible = "arm,pl192-vic";
-				reg = <0xeff0000 0x1000>;
+				reg = <0x4eff0000 0x1000>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
 
-			vic1: interrupt-controller@80f00000 {
+			vic1: interrupt-controller@f00000 {
 				compatible = "arm,pl192-vic";
-				reg = <0x80f00000 0x1000>;
+				reg = <0xf00000 0x1000>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
 
-			uarta: serial@e0 {
+			uarta: serial@400000e0 {
 				compatible = "ns16550a";
-				reg = <0xe0 0x8>;
+				reg = <0x400000e0 0x8>;
 				interrupts = <17>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			uartb: serial@e8 {
+			uartb: serial@400000e8 {
 				compatible = "ns16550a";
-				reg = <0xe8 0x8>;
+				reg = <0x400000e8 0x8>;
 				interrupts = <18>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			uartc: serial@f0 {
+			uartc: serial@400000f0 {
 				compatible = "ns16550a";
-				reg = <0xf0 0x8>;
+				reg = <0x400000f0 0x8>;
 				interrupts = <19>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			usb0: usb@efe0000 {
+			usb0: usb@4efe0000 {
 				compatible = "hpe,gxp-ehci", "generic-ehci";
-				reg = <0xefe0000 0x100>;
+				reg = <0x4efe0000 0x100>;
 				interrupts = <7>;
 				interrupt-parent = <&vic0>;
 			};
 
-			st: timer@80 {
+			st: timer@40000080 {
 				compatible = "hpe,gxp-timer";
-				reg = <0x80 0x16>;
+				reg = <0x40000080 0x16>;
 				interrupts = <0>;
 				interrupt-parent = <&vic0>;
 				clocks = <&iopclk>;
 				clock-names = "iop";
 			};
 
-			usb1: usb@efe0100 {
+			usb1: usb@4efe0100 {
 				compatible = "hpe,gxp-ohci", "generic-ohci";
-				reg = <0xefe0100 0x110>;
+				reg = <0x4efe0100 0x110>;
 				interrupts = <6>;
 				interrupt-parent = <&vic0>;
 			};
-- 
2.25.1

