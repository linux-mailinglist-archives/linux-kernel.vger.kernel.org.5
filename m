Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9A7742E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjHHRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjHHRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:51:09 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B2DB5E81;
        Tue,  8 Aug 2023 09:22:54 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3788jZQ1008146;
        Tue, 8 Aug 2023 11:31:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=RFrhqxY+1JPbM3Si0hysdjsFhaVnalme3KqSl5ihKaA=; b=PX
        xq1Dc9ItnpmF78PBMNyGisc5k/ITi2Q95TNXYW3y/Dl8q2aiGRhbpCdSUdTPYBqR
        O+5AL8fYHgb2IKB1PSSc+mG3kJ8gvTcNiUIugPiWaStfIPq8hJ/F6Xh98Q7gwTB/
        +O3nHB7caixmtKM5vzw7k0J8p+FDC8M7Eyqg36ibi79wrAmVAmR12d7imiE7WwFt
        UB9Sb0g4E8hmo9qAoHCDwvzwPN2omqdn7/UpgFqNyQXhweZ2NXuyDsRlQYLmy/hs
        CFsrpmoif8PX+U5EY4oDg7jczyHxQNfDqhoCOQ1A7iDg0fRGzTD4SHLFQzYKVEwM
        e6oaSeN2k90wJ7VJ+H4g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sbjfn09nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:31:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B986C100061;
        Tue,  8 Aug 2023 11:31:39 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B0045216850;
        Tue,  8 Aug 2023 11:31:39 +0200 (CEST)
Received: from localhost (10.201.20.38) by EQNDAG1NODE4.st.com (10.75.129.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 8 Aug
 2023 11:31:39 +0200
From:   <patrice.chotard@foss.st.com>
To:     <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: Add gpio-ranges for stm32f746-pinctrl
Date:   Tue, 8 Aug 2023 11:31:18 +0200
Message-ID: <20230808093119.714224-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808093119.714224-1-patrice.chotard@foss.st.com>
References: <20230808093119.714224-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_08,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Since commit 913a956c4363 ("pinctrl: stm32: use dynamic allocation
of GPIO base"), it's impossible to retrieve gpios from phandle,
for example, mmc driver can't retrieve cd-gpios.
Add missing gpio-ranges properties to fix it.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi | 44 +++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
index 781197ef42d6..139f72b790c0 100644
--- a/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
@@ -8,4 +8,48 @@
 
 &pinctrl {
 	compatible = "st,stm32f746-pinctrl";
+
+	gpioa: gpio@40020000 {
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@40020400 {
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@40020800 {
+		gpio-ranges = <&pinctrl 0 32 16>;
+	};
+
+	gpiod: gpio@40020c00 {
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@40021000 {
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@40021400 {
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
+
+	gpiog: gpio@40021800 {
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
+
+	gpioh: gpio@40021c00 {
+		gpio-ranges = <&pinctrl 0 112 16>;
+	};
+
+	gpioi: gpio@40022000 {
+		gpio-ranges = <&pinctrl 0 128 16>;
+	};
+
+	gpioj: gpio@40022400 {
+		gpio-ranges = <&pinctrl 0 144 16>;
+	};
+
+	gpiok: gpio@40022800 {
+		gpio-ranges = <&pinctrl 0 160 8>;
+	};
 };
-- 
2.25.1

