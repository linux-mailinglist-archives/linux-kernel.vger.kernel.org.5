Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB4F7BAAD9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjJET4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjJET4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:56:07 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD338126;
        Thu,  5 Oct 2023 12:56:00 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E38F6100004;
        Thu,  5 Oct 2023 22:55:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E38F6100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696535758;
        bh=zo/sNzc/dG5eUQxSK5eEp9sui2QCDHTpqSqmdqaMwdk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=lQwgJXoeDwWqBOgHtcDSkH+oNP8R6+fiiErYDvJ5SSKgSMOPvsrU7cdCdNJP/aEqt
         5aSVrzBVpMpKnPlvouQiTen/xvqRtrXsB52G3qsjDPtxS1w3vUcHAPqtR/NFMncYwE
         SC7JynKnc4dEybpiHR2pQFkaM4FvLVrbZErlaWJTillnqvKpfq5OFM3ZDQsDWvlPnc
         EmoZwCK7eondFpt2zzbo7ejB6mwPFDg9R/3aF+fsf9p4NMlW38OlW0QwqzOC2bBrJd
         iBtLPozYqs/dS1PzH2dDiD1wH+pKgW/uLZtlWAW3GrVkd0zyf7dpilAIY8CZ9IhdhE
         XLshAZ39PY73A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu,  5 Oct 2023 22:55:58 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 5 Oct 2023 22:55:58 +0300
From:   Igor Prusov <ivprusov@salutedevices.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
CC:     <prusovigor@gmail.com>, <kernel@sberdevices.ru>,
        Igor Prusov <ivprusov@salutedevices.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] arm64: dts: meson: a1: Add SPIFC mux pins
Date:   Thu, 5 Oct 2023 22:55:42 +0300
Message-ID: <20231005195543.380273-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005195543.380273-1-ivprusov@salutedevices.com>
References: <20231005195543.380273-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180400 [Oct 05 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/05 18:34:00 #22065600
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI Flash Controller uses multi-function pins, so add missing mux
definition.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 5c6f93ddf7b4..6cd50187896a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -168,6 +168,18 @@ mux {
 						bias-pull-down;
 					};
 				};
+
+				spifc_pins: spifc {
+					mux {
+						groups = "spif_mo",
+							 "spif_mi",
+							 "spif_clk",
+							 "spif_cs",
+							 "spif_hold_n",
+							 "spif_wp_n";
+						function = "spif";
+					};
+				};
 			};
 
 			gpio_intc: interrupt-controller@440 {
-- 
2.34.1

