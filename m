Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB427765E77
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjG0Vxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjG0Vx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:53:26 -0400
Received: from qs51p00im-qukt01080301.me.com (qs51p00im-qukt01080301.me.com [17.57.155.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB77935A3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494773; bh=HXQLqgiZg4lwSg7yuJp70xhHYQeGMquqwwsl6uxX+/s=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=iWSH1EJWwkMfSRqn9vJtLQPTLaZ45ToCmc5035Zl4yf9t6z4GcEA75Q5iEj5/fxsv
         rzI8ULoVds72y8jayIA8pvf0IslVNASIwoOS4/flQrYfIsh6HPC9mB4EE1FxIbNhJ9
         o4lDZRViIyBF6y1Ow2ZgtiXApM3UvIKu10DYr8EePi7CreB9vLTK3XgxizKq6554GJ
         bYXuQxJVyhPuQu0PFc6w9wzu0epGloaMnSvrqLG2gMW3hP/CGanqPOBvITBXlA2mdQ
         P60FNgyU56tScM9fAEzmBNYGTDVVnzwPGCIuJx3xgpZ7xfKKsd3Cd/sonKqJBtkRLr
         T6Rq+voTi8D2w==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080301.me.com (Postfix) with ESMTPSA id EE2DA5F00408;
        Thu, 27 Jul 2023 21:52:52 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] ARM: dts: sti: move vtg_main / vtg_aux into stih407/stih410 dtsi
Date:   Thu, 27 Jul 2023 21:51:35 +0000
Message-Id: <20230727215141.53910-12-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: H5CenQRAQ1tfGLGPSffjITEBYJ75K4oo
X-Proofpoint-ORIG-GUID: H5CenQRAQ1tfGLGPSffjITEBYJ75K4oo
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=907 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of introduction of display support in stih418, move
the vtg nodes into stih407.dtsi and stih410.dtsi since vtg nodes
will differ in case of the stih418 and thus cannot be kept as part
of the stih407-family.dtsi.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih407-family.dtsi | 13 -------------
 arch/arm/boot/dts/st/stih407.dtsi        | 12 ++++++++++++
 arch/arm/boot/dts/st/stih410.dtsi        | 12 ++++++++++++
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
index 3f58383a7b59..6133c9934651 100644
--- a/arch/arm/boot/dts/st/stih407-family.dtsi
+++ b/arch/arm/boot/dts/st/stih407-family.dtsi
@@ -292,19 +292,6 @@ syscfg_lpm: lpm-syscfg@94b5100 {
 			reg = <0x94b5100 0x1000>;
 		};
 
-		/* Display */
-		vtg_main: sti-vtg-main@8d02800 {
-			compatible = "st,vtg";
-			reg = <0x8d02800 0x200>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		vtg_aux: sti-vtg-aux@8d00200 {
-			compatible = "st,vtg";
-			reg = <0x8d00200 0x100>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		serial@9830000 {
 			compatible = "st,asc";
 			reg = <0x9830000 0x2c>;
diff --git a/arch/arm/boot/dts/st/stih407.dtsi b/arch/arm/boot/dts/st/stih407.dtsi
index aca43d2bdaad..69430556edc4 100644
--- a/arch/arm/boot/dts/st/stih407.dtsi
+++ b/arch/arm/boot/dts/st/stih407.dtsi
@@ -8,6 +8,18 @@
 #include <dt-bindings/gpio/gpio.h>
 / {
 	soc {
+		vtg_main: sti-vtg-main@8d02800 {
+			compatible = "st,vtg";
+			reg = <0x8d02800 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		vtg_aux: sti-vtg-aux@8d00200 {
+			compatible = "st,vtg";
+			reg = <0x8d00200 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		sti-display-subsystem@0 {
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/st/stih410.dtsi b/arch/arm/boot/dts/st/stih410.dtsi
index 29e95e9d3229..141db3dcaf1f 100644
--- a/arch/arm/boot/dts/st/stih410.dtsi
+++ b/arch/arm/boot/dts/st/stih410.dtsi
@@ -99,6 +99,18 @@ ehci1: usb@9a83e00 {
 			status = "disabled";
 		};
 
+		vtg_main: sti-vtg-main@8d02800 {
+			compatible = "st,vtg";
+			reg = <0x8d02800 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		vtg_aux: sti-vtg-aux@8d00200 {
+			compatible = "st,vtg";
+			reg = <0x8d00200 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		sti-display-subsystem@0 {
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
-- 
2.34.1

