Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6377E389
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbjHPO04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbjHPO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:26:39 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC541999;
        Wed, 16 Aug 2023 07:26:37 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37GDHGWA002228;
        Wed, 16 Aug 2023 16:26:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=szXQJpt
        kKizXSfwXSxIj1fEKQa8MbeyLm6VyELkCJP8=; b=eDXXTE+kNc8l575O6SYJRbx
        Q64U+Q2QfzVvBMbbcsz/6S8w395jRmLR8VkA2xerleMO4xW2D09rsYq4/36avVM2
        5oCAXH4Fy9wFyaNxqE26563DkeQxzekw8GXDJqZtp8iBSMnQL0Sh4EuzZOQFkZu8
        jWzW0umKGWEyoGvB7ChfVoX/l8g0V11y3LeHoROQSWs/mbgNfax0tt4KOQ5/siZV
        UpPaT9BQMd8OOKIPu3XOW9lctPrblJ8y7AZmjJr8+IklNcGRbPz47xDce4viyyx4
        TIT/++f0Vu7Ya2/6NzOQMS/XuXMELH/cZMYgJ2Zowt3AOZy9Ev/c9nOncfB+svA=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgth628tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 16:26:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E382100061;
        Wed, 16 Aug 2023 16:26:22 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 35C3824C447;
        Wed, 16 Aug 2023 16:26:22 +0200 (CEST)
Received: from localhost (10.252.20.29) by EQNDAG1NODE4.st.com (10.75.129.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 16:26:21 +0200
From:   Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Lionel Debieve <lionel.debieve@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: add HASH on stm32mp131
Date:   Wed, 16 Aug 2023 16:26:17 +0200
Message-ID: <20230816142617.2625802-1-thomas.bourgoin@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.20.29]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_14,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lionel Debieve <lionel.debieve@foss.st.com>

Add the HASH support on stm32mp131.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 672f3b7735a2..4e4f64cfb75b 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1210,6 +1210,17 @@ timer {
 			};
 		};
 
+		hash: hash@54003000 {
+			compatible = "st,stm32mp13-hash";
+			reg = <0x54003000 0x400>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc HASH1>;
+			resets = <&rcc HASH1_R>;
+			dmas = <&mdma 30 0x2 0x1000a02 0x0 0x0>;
+			dma-names = "in";
+			status = "disabled";
+		};
+
 		mdma: dma-controller@58000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x58000000 0x1000>;
-- 
2.25.1

