Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089167EF43D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbjKQOPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbjKQOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:14:59 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB3210D;
        Fri, 17 Nov 2023 06:14:41 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHEEZGe025317;
        Fri, 17 Nov 2023 08:14:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700230475;
        bh=5IZGhD8qiFLW80/WHs2uw+ggCMSQKu+5yarcT+OzTAc=;
        h=From:To:CC:Subject:Date;
        b=Ohk4aDsDRYD/guA8NnXaPmbvUWd4Sdvx0oHagMlEZnGaNVjhSEuFf+tdUMYOesx3y
         U/VkilShuVFp2oNAYOcEZn5BRmPmxz9W+CdU+ig6mrxL9dgr+UigWB3ipszmgFBhSV
         XEhaqASUHumufC848C1/YomuA0UPuMENm9f29/6w=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHEEZku075515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 08:14:35 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 08:14:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 08:14:35 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHEEYG2018120;
        Fri, 17 Nov 2023 08:14:34 -0600
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-am65: Add full compatible to dss-oldi-io-ctrl node
Date:   Fri, 17 Nov 2023 08:14:33 -0600
Message-ID: <20231117141433.9461-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This matches the binding for this register region which fixes a couple
DTS check warnings.

While here trim the leading 0s from the "reg" definition.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
---

Changes for v3:
 - Resend now that dt-binding is merged

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 5ebb87f467de5..7eacb74498a75 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -498,8 +498,8 @@ serdes_mux: mux-controller {
 		};
 
 		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
-			compatible = "syscon";
-			reg = <0x000041e0 0x14>;
+			compatible = "ti,am654-dss-oldi-io-ctrl", "syscon";
+			reg = <0x41e0 0x14>;
 		};
 
 		ehrpwm_tbclk: clock-controller@4140 {
-- 
2.39.2

