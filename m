Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B279D29B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjILNqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjILNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:45:56 -0400
X-Greylist: delayed 901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 06:45:52 PDT
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F21510D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1694525447; x=1697117447;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iWF0rOOB3I/RljayAkXK/61YLtNmFVr/fJJqw6FhMuI=;
        b=FBSnPaojgN9AvOii/36wVFNUjc8Jg4VFqitZlSVx3sAUa5XVUpEXMmXOypkGPIwX
        ig2ANQoT/Pat5ObGZcsCgEFdFk/3PGnm1UUDo23urciQEd5J9WoXHKyamU1Kf+Ub
        a5xrbM+vjDynenTeGb2O0bJ9X2uslfKbpQ/eRZ4L9BM=;
X-AuditID: ac14000a-6d65670000001e37-e1-650068079156
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D6.40.07735.70860056; Tue, 12 Sep 2023 15:30:47 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 12 Sep
 2023 15:31:07 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: [PATCH] arm64: dts: ti: k3-am64: Fix indentation in watchdog nodes
Date:   Tue, 12 Sep 2023 15:30:36 +0200
Message-ID: <20230912133036.257277-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWyRpKBR5c9gyHVYFO7ssWaveeYLOYfOcdq
        sfzzbHaLvhcPmS02Pb7GanF51xw2izc/zjJZtO49wm7R/U7d4v/ZD+wOXB6bVnWyedy5tofN
        Y/OSeo/+7hZWj+M3tjN5fN4kF8AWxWWTkpqTWZZapG+XwJXx/+YntoKHPBU7P9k0MG7m6mLk
        5JAQMJF43vyLtYuRi0NIYAmTxLnJh5khnCeMEjfPTWcFqWITUJe4s+EbWJWIQDejxMkDy8Cq
        mAXaGCWePDzADFIlLOAtcez7F3YQm0VAVeLcu8dMIDavgIXEzsOdzBD75CVmXvrODhEXlDg5
        8wkLiM0MFG/eOpsZwpaQOPjiBZgtBBR/cWk5C0zvtHOvoeaESmz9sp1pAqPALCSjZiEZNQvJ
        qAWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcxguJAhIFrB2PfHI9DjEwcjIcYJTiYlUR4Sw79
        TRHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe7+HKVFIID2xJDU7NbUgtQgmy8TBKdXAaJQju947
        wN5DXeCYefjs08L238xk+z2Fhb4vuv98yho9g0d/FHKY+1K+HV5wNuzKg/B3+/ZNvCCm/b9r
        ob9YyOQ51j86A2d3bezfckCJUySkqOpcr9sP1jX2ryvvnbb2V7/HdVOx9dlLq23JW74ZuG3t
        vLJozf6AiDnTc5IKT+995XXlkaDXPSWW4oxEQy3mouJEAMTaqEdxAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use single instead of double tab.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0df54a741824..ae1e7e064a63 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1158,21 +1158,21 @@ ecap2: pwm@23120000 {
 	};
 
 	main_rti0: watchdog@e000000 {
-			compatible = "ti,j7-rti-wdt";
-			reg = <0x00 0xe000000 0x00 0x100>;
-			clocks = <&k3_clks 125 0>;
-			power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
-			assigned-clocks = <&k3_clks 125 0>;
-			assigned-clock-parents = <&k3_clks 125 2>;
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0xe000000 0x00 0x100>;
+		clocks = <&k3_clks 125 0>;
+		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 125 0>;
+		assigned-clock-parents = <&k3_clks 125 2>;
 	};
 
 	main_rti1: watchdog@e010000 {
-			compatible = "ti,j7-rti-wdt";
-			reg = <0x00 0xe010000 0x00 0x100>;
-			clocks = <&k3_clks 126 0>;
-			power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
-			assigned-clocks = <&k3_clks 126 0>;
-			assigned-clock-parents = <&k3_clks 126 2>;
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0xe010000 0x00 0x100>;
+		clocks = <&k3_clks 126 0>;
+		power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 126 0>;
+		assigned-clock-parents = <&k3_clks 126 2>;
 	};
 
 	icssg0: icssg@30000000 {
-- 
2.25.1

