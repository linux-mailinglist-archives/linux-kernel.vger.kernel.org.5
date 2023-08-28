Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1A78B22C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjH1Nnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjH1NnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:43:24 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C1B91;
        Mon, 28 Aug 2023 06:43:20 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D2769100005;
        Mon, 28 Aug 2023 16:43:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D2769100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1693230196;
        bh=PdBVE+1DEWWUYFrS8SRgT2KGE33BoBLbqE+EMHtbU/U=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=uPWpFfTkY5oCV0GcA7TP1v0RoEzhz0CM/wjUwPatiiDxg09JqwR/IfVXLCG8ZIwQu
         qFQS0LrnSXvI3Z6aE/Wu4fghWGLsUmIenyPfypFcQjDSt4mHTwXzp8us2RS4gBdGIT
         t2KJ/UH7zSaPFkbFhS+lA4uwJage2v8kQhPWMUKaTdKNdvcvj+xK8DBg8miWkA2oIr
         FWZhuUEFju179UzjXTlSGjf+gm487ySKgrm5UnxQ7ZVCvCPxftPSDjF49UQB1JSFR6
         WRlDXZ7sX3bOv+xfinAH1QEDdtjhPzcsGRF/3t0DEyIBsWiyU0d4hIVJeqSRTkP+oE
         wjWulBCYlg3OA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 28 Aug 2023 16:43:16 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 28 Aug 2023 16:43:09 +0300
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] arm64: dts: amlogic: meson-axg: Meson NAND node
Date:   Mon, 28 Aug 2023 16:36:47 +0300
Message-ID: <20230828133647.3712644-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179484 [Aug 28 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 528 528 4b912e27f7408903f04ab5d0a88bd271cc7c0a60, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/28 11:35:00 #21756980
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of the Meson NAND controller node.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 768d0ed78dbe..a49aa62e3f9f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1908,6 +1908,19 @@ sd_emmc_c: mmc@7000 {
 				resets = <&reset RESET_SD_EMMC_C>;
 			};
 
+			nfc: nand-controller@7800 {
+				compatible = "amlogic,meson-axg-nfc";
+				reg = <0x0 0x7800 0x0 0x100>,
+				      <0x0 0x7000 0x0 0x800>;
+				reg-names = "nfc", "emmc";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_SD_EMMC_C>,
+					 <&clkc CLKID_FCLK_DIV2>;
+				clock-names = "core", "device";
+			};
+
 			usb2_phy1: phy@9020 {
 				compatible = "amlogic,meson-gxl-usb2-phy";
 				#phy-cells = <0>;
-- 
2.35.0

