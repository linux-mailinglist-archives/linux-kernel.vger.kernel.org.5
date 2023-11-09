Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4F17E6725
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjKIJxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKIJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:53:02 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645C62D4F;
        Thu,  9 Nov 2023 01:52:59 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 0804612000E;
        Thu,  9 Nov 2023 12:52:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0804612000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1699523578;
        bh=xp76YwR5227vsBQhp1StLcVx3Q3c15aaGrkQqQFMpDw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=DbAM+tEM4keru67mCxv6RNeUBC9mN9amQY8ygWEpkR16cMz8F3FA+O5PujdWRBl7B
         osvsu9KOJI2aKo5Wz7wsp24cXg8AYZm5ws3wngovj8LU5gNjLReB2S7IM0FuVRBj4f
         /0Qijb4OtUwQQvEk4OMSsRMH2NbJOON1z1St1JZPJppsuv97Cz/WEt/vTJ0FI9j9bZ
         Seoux2BLz6W9tyyWDsWCHUSh56oOLNyS9yi2609p42v8MK+Trlua0bn8/L/xXUrfQj
         JwQyqu817nHv3VWLJ3dNuYxqZvgzGNAOeKXL7JDtLclhnsqE9CtjmDRkpwTyGheWEQ
         Blb/2oUCezaXg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu,  9 Nov 2023 12:52:57 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 9 Nov 2023 12:52:57 +0300
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
Subject: [PATCH v2] arm64: dts: amlogic: meson-axg: pinctrl node for NAND
Date:   Thu, 9 Nov 2023 12:45:04 +0300
Message-ID: <20231109094504.131265-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181233 [Nov 09 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/09 07:10:00 #22435383
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl node for the Meson NAND controller.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 Changelog:                                                             
 v1 -> v2:                                                              
  * Rename node name 'nand_all_pins' -> 'nand-all-pins'.                       

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a49aa62e3f9f..7e5ac9db93f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -432,6 +432,27 @@ mux-1 {
 					};
 				};
 
+				nand_all_pins: nand-all-pins {
+					mux {
+						groups = "emmc_nand_d0",
+							 "emmc_nand_d1",
+							 "emmc_nand_d2",
+							 "emmc_nand_d3",
+							 "emmc_nand_d4",
+							 "emmc_nand_d5",
+							 "emmc_nand_d6",
+							 "emmc_nand_d7",
+							 "nand_ce0",
+							 "nand_ale",
+							 "nand_cle",
+							 "nand_wen_clk",
+							 "nand_ren_wr";
+						function = "nand";
+						input-enable;
+						bias-pull-up;
+					};
+				};
+
 				emmc_ds_pins: emmc_ds {
 					mux {
 						groups = "emmc_ds";
@@ -1913,6 +1934,8 @@ nfc: nand-controller@7800 {
 				reg = <0x0 0x7800 0x0 0x100>,
 				      <0x0 0x7000 0x0 0x800>;
 				reg-names = "nfc", "emmc";
+				pinctrl-0 = <&nand_all_pins>;
+				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
-- 
2.35.0

