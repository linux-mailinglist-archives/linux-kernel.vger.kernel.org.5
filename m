Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493CE7721EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjHGL04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjHGL0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:26:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D830E1;
        Mon,  7 Aug 2023 04:23:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377BJGfW130057;
        Mon, 7 Aug 2023 06:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691407156;
        bh=Pialzk4xc8UGsA0M2InFr9yj7iGuJ1L6KF+ie/Whcb4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EciJOhIJgRU8QkYeNLI+q/d+Q7lIfGeNAEoo+I8Ux5zpZPr+plyX59A8vh9EpLt98
         Av8GSUln30NXGxzi8ZIq0potpyzJCExCwCIxoo14yj27AjR1lE8Nk1uGSIGJ3I9frO
         WWlroz670znP/qW1q+zMYy0spjqqd0U6HlwRDxU8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377BJGGY086346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 06:19:16 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 06:19:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 06:19:16 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377BJF94107064;
        Mon, 7 Aug 2023 06:19:15 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 377BJE69031099;
        Mon, 7 Aug 2023 06:19:15 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: [PATCH RFC 2/3] arm64: dts: ti: k3-am65-main: Add PRU system events for virtio
Date:   Mon, 7 Aug 2023 16:48:54 +0530
Message-ID: <20230807111855.2614761-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807111855.2614761-1-danishanwar@ti.com>
References: <20230807111855.2614761-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

A PRU system event "vring" has been added to each PRU and RTU
node in each of the ICSSG0, ICSSG1 and ICSSG2 remote processor
subsystems to enable the virtio/rpmsg communication between MPU
and that PRU/RTU core. The additions are done in the base
k3-am65-main.dtsi, and so are inherited by all the K3 AM65x
boards.

The PRU system events is the preferred approach over using TI
mailboxes, as it eliminates an external peripheral access from
the PRU/RTU-side, and keeps the interrupt generation internal to
the ICSSG. The difference from MPU would be minimal in using one
versus the other.

Mailboxes can still be used if desired, but currently there is
no support on firmware-side for K3 SoCs to use mailboxes. Either
approach would require that an appropriate firmware image is
loaded/booted on the PRU.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 0265f5defbae..10e69947019e 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1198,6 +1198,9 @@ pru0_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_0: rtu@4000 {
@@ -1207,6 +1210,9 @@ rtu0_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_0: txpru@a000 {
@@ -1225,6 +1231,9 @@ pru0_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_1: rtu@6000 {
@@ -1234,6 +1243,9 @@ rtu0_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_1: txpru@c000 {
@@ -1352,6 +1364,9 @@ pru1_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_0: rtu@4000 {
@@ -1361,6 +1376,9 @@ rtu1_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_0: txpru@a000 {
@@ -1379,6 +1397,9 @@ pru1_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_1: rtu@6000 {
@@ -1388,6 +1409,9 @@ rtu1_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_1: txpru@c000 {
@@ -1506,6 +1530,9 @@ pru2_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru2_0-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu2_0: rtu@4000 {
@@ -1515,6 +1542,9 @@ rtu2_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu2_0-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru2_0: txpru@a000 {
@@ -1533,6 +1563,9 @@ pru2_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru2_1-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu2_1: rtu@6000 {
@@ -1542,6 +1575,9 @@ rtu2_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu2_1-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru2_1: txpru@c000 {
-- 
2.34.1

