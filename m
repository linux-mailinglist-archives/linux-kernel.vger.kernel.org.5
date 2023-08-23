Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B31786289
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbjHWVg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbjHWVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:36:48 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC910DA;
        Wed, 23 Aug 2023 14:36:46 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 990C810000E;
        Thu, 24 Aug 2023 00:36:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 990C810000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692826604;
        bh=cj5w73KncvGgK+EkIFR2p79nE4hpqg2L3XNfF1ARXKg=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=c3nutuRUC1btZJHMoCdlsb3C9WzIF49T+JWAAy17gQRHQjvkCsh2LfXmDE8dDMU4R
         g5jCxFlYXoEu3O+XPZO7fvn1I4PI2eOomJa5u4zkNcfRUeF1lKVvFNEXg8iniEAW3R
         vmti2LFhWxGK5w9M6cG9d8jM0g/PqYSnlhP0u3OVD8Z19ci02bysLyVGkJYiDCz+ak
         LArEcVe8dOuGJlqrqQQ3iR7CH+HkNb+UFgyfiCaE3SMusUWSO/OjnKbH39e0ZDxMxO
         p0Ry2KkAvs5d1LFlc1FA4SZkO2zcBy6gk/JQQ88G7uuibeNSxnr+zgDQPmLFWot7Ak
         HYsGCAmCHWZzA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 24 Aug 2023 00:36:44 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 24 Aug 2023 00:36:40 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>
CC:     <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v2 08/15] arm64: dts: meson: a1: introduce SPI Flash Controller
Date:   Thu, 24 Aug 2023 00:36:23 +0300
Message-ID: <20230823213630.12936-9-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230823213630.12936-1-ddrokosov@sberdevices.ru>
References: <20230823213630.12936-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179413 [Aug 23 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/23 18:49:00 #21688451
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kurbanov <mmkurbanov@sberdevices.ru>

This controller can be used for spinand flash connection.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index d46275a25bfa..8d479bc8e677 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -88,6 +88,16 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		spifc: spi@fd000400 {
+			compatible = "amlogic,a1-spifc";
+			reg = <0x0 0xfd000400 0x0 0x290>;
+			clocks = <&clkc_periphs CLKID_SPIFC>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			power-domains = <&pwrc PWRC_SPIFC_ID>;
+			status = "disabled";
+		};
+
 		apb: bus@fe000000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xfe000000 0x0 0x1000000>;
-- 
2.36.0

