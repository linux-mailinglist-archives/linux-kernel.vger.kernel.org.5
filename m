Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EB793E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbjIFN71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbjIFN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:59:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BBD7;
        Wed,  6 Sep 2023 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694008763; x=1725544763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y9lRs6u125Ju9s0lSOQYqjZMLCQm5SbnBhb3xgQcXDA=;
  b=Z5JbRNAxzpgEyl4UlTwsstartDVptGZLyOIhQ6D3/UxJsVyZjlhXhXuZ
   TnjcjlFhe/FjPgG0YXGbi8R9qsLkt/3Vm0G15bv+tWBy6E+D1qv08zJge
   C/hL9pgkKJQGLF5JaWZ6rkYQspPz8rPRJb9zQwQMdMrCyHhCNXU9H5GS/
   LEEMMtkWIexRUw7bpJABF/XojZ76kAFU5tfvjU4IhnTPgLkZHEpnHMFzh
   5Ix2nzNRXnqyuNh1fwH+TSWTkkfjVA7AxDyLH0yM32gskbo/oQ7zrOYHd
   ReA7ZedQ/D3rjSusY02UF64scRNWVWf56FRqcSoVX1W5aTDkUQ7iD6zcF
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="3331868"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2023 06:59:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 6 Sep 2023 06:58:59 -0700
Received: from ROU-LT-M43238L.mchp-main.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 6 Sep 2023 06:58:58 -0700
From:   <nicolas.ferre@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: dts: at91/trivial: fix typo in crypto DT naming
Date:   Wed, 6 Sep 2023 15:58:38 +0200
Message-ID: <20230906135838.59247-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Fix typo in DT name for TDES node.

Fixes: 4b6140b96dfe ("ARM: dts: at91: Use the generic "crypto" node name for the crypto IPs")
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/microchip/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/sama5d4.dtsi b/arch/arm/boot/dts/microchip/sama5d4.dtsi
index 41284e013f53..cbfc60fed37c 100644
--- a/arch/arm/boot/dts/microchip/sama5d4.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d4.dtsi
@@ -694,7 +694,7 @@ aes: crypto@fc044000 {
 				clock-names = "aes_clk";
 			};
 
-			tdes: crpyto@fc04c000 {
+			tdes: crypto@fc04c000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xfc04c000 0x100>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.39.2

