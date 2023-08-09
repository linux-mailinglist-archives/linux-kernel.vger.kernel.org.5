Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFBC7766DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjHISB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHISBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:01:54 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F01B19A1;
        Wed,  9 Aug 2023 11:01:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379I1mhX120401;
        Wed, 9 Aug 2023 13:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691604108;
        bh=2usZmKyVgW1mdRa5QRVK5RY6Nv02Qnm4mTipu25bUuU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SS1LjWUAH+mcm1ZWDNy8IOMNsC4jtzFdu0TcPXW90T6IbMCGSN6c4a8poOwdUJyND
         EJ/dY/eoztdkGk6QiBq9YEbLGqz8PjHA4X99ahj1ow06XifOOvs4jAK05aUr8PJesq
         llI2JPApFzTobgZoOV/7q7nYIZslY0BnRXFbCFf4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379I1mXg111371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 13:01:48 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 13:01:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 13:01:48 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379I1k57103030;
        Wed, 9 Aug 2023 13:01:47 -0500
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j784s4: Enable C7x DSP nodes at the board level
Date:   Wed, 9 Aug 2023 13:01:44 -0500
Message-ID: <20230809180145.53158-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809180145.53158-1-afd@ti.com>
References: <20230809180145.53158-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C7x DSP nodes defined in the top-level J784s4 SoC dtsi files are incomplete
and will not be functional unless they are extended with both mboxes and
memory-region information.

As theses only known about at the board integration level, these nodes
should only be enabled when provided with this information.

Disable the C7x DSP nodes in the dtsi files and only enable the ones that
are given the required mboxes and memory-region on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index a04c44708a09a..c2e505f3affcc 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1524,6 +1524,7 @@ c71_0: dsp@64800000 {
 		ti,sci-proc-ids = <0x30 0xff>;
 		resets = <&k3_reset 30 1>;
 		firmware-name = "j784s4-c71_0-fw";
+		status = "disabled";
 	};
 
 	c71_1: dsp@65800000 {
@@ -1536,6 +1537,7 @@ c71_1: dsp@65800000 {
 		ti,sci-proc-ids = <0x31 0xff>;
 		resets = <&k3_reset 33 1>;
 		firmware-name = "j784s4-c71_1-fw";
+		status = "disabled";
 	};
 
 	c71_2: dsp@66800000 {
@@ -1548,6 +1550,7 @@ c71_2: dsp@66800000 {
 		ti,sci-proc-ids = <0x32 0xff>;
 		resets = <&k3_reset 37 1>;
 		firmware-name = "j784s4-c71_2-fw";
+		status = "disabled";
 	};
 
 	c71_3: dsp@67800000 {
@@ -1560,5 +1563,6 @@ c71_3: dsp@67800000 {
 		ti,sci-proc-ids = <0x33 0xff>;
 		resets = <&k3_reset 40 1>;
 		firmware-name = "j784s4-c71_3-fw";
+		status = "disabled";
 	};
 };
-- 
2.39.2

