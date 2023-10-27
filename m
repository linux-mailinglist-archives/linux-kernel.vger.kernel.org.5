Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6907D8F12
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbjJ0G7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjJ0G7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:59:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B9A1AA;
        Thu, 26 Oct 2023 23:59:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39R6xVFC116157;
        Fri, 27 Oct 2023 01:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698389971;
        bh=A2qToJcfGjTF+R3p1imREJPAf1MBed3l26i7ZEQB+qk=;
        h=From:To:CC:Subject:Date;
        b=s3NqIHoBU5JagNcteciL1c4yzxSkrh6XcluzRYIJgQKct5VIl+9JD8csCWB6gS5wG
         3AGOPDwaC5a7rzip89A9Ze8kJGaYEOn+hybDpLbbOtkklHRWYC/6hQ0wzjvyw9mQBk
         n3jpOGHknMhuzPTStQFmlcmhrhfU4yBXMPftQATk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39R6xV9R081792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 01:59:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 01:59:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 01:59:31 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39R6xUIf007003;
        Fri, 27 Oct 2023 01:59:31 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] arm64: boot: dts: ti: k3-am62a-main: Fix GPIO pin count in DT nodes.
Date:   Fri, 27 Oct 2023 12:29:30 +0530
Message-ID: <20231027065930.1187405-1-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix number of gpio pins in main_gpio0 & main_gpio1 DT nodes according
to AM62A7 datasheet[0].

[0]https://www.ti.com/lit/gpn/am62a3 Section: 6.3.10 GPIO (Page No. 52-55)

Fixes: 5fc6b1b62639c ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---

v3:
 - Updated AM62A SK -> AM62A7 in commit description.

v2: https://lore.kernel.org/all/20231027061833.1185703-1-n-yadav@ti.com/
 - Updated commit msge to include links.
 - Updated fixes tag

v1: https://lore.kernel.org/all/20231025110252.1089979-1-n-yadav@ti.com/
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 3198af08fb9f..de36abb243f1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -462,7 +462,7 @@ main_gpio0: gpio@600000 {
 			     <193>, <194>, <195>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		ti,ngpio = <87>;
+		ti,ngpio = <92>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 77 0>;
@@ -480,7 +480,7 @@ main_gpio1: gpio@601000 {
 			     <183>, <184>, <185>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		ti,ngpio = <88>;
+		ti,ngpio = <52>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 78 0>;
-- 
2.25.1

