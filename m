Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF880C1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjLKHEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:04:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11973B4;
        Sun, 10 Dec 2023 23:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702278288; x=1733814288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eycrN+2SMQbQvqjnQ9FUFJl13AO8/O4TTKQpb5ZVjfg=;
  b=ykEPcfdCEP9YN0gqv90tqBm7ITmkevbjsNk0BPufOjfcRi66XljDZ4eH
   shKAxkwvNhtLVzgOfqIMW6yxOQgAIFmj3vpPFbVPtFZ94RcFL7dfk+8nA
   M1og7xqik46eI7G5LGrZkv0T1LTFysUJe8tN3q1MmW7lgioUVgXSWjmyb
   YyWEdt75Ig8EKzOptjnFiJnoErfpUmH7Btd+MLJM+ilVxxZRmF+QYjTS5
   QBS+9lrGMMkNj6t83N0kWIMamC3WnQtGvtF2q0lBM9tiyvYwxnnyCNuqO
   kLJEjkcyQUuzOE/DdHSrtOKV1bXyGgBymNAH0pDB8IwWli01gxtwbV4g6
   A==;
X-CSE-ConnectionGUID: ETLlBqw4QxiQeqDLsFgGxg==
X-CSE-MsgGUID: aMSB84vDQVKtY0ROW3NjzA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="13045706"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2023 00:04:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 00:04:12 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 00:04:10 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cristian.birsan@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: dts: microchip: sama5d27_som1_ek: Remove mmc-ddr-3_3v property from sdmmc0 node
Date:   Mon, 11 Dec 2023 09:03:45 +0200
Message-ID: <20231211070345.2792-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On board the sdmmc0 interface is wired to a SD Card socket.
According with mmc-controller bindings, the mmc-ddr-3_3v property
is used for eMMC devices to enable high-speed DDR mode (3.3V I/O).
Remove the mmc-ddr-3_3v property from sdmmc0 node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
index d0a6dbd377df..f3ffb8f01d8a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
@@ -54,7 +54,6 @@ usb2: ehci@500000 {
 
 		sdmmc0: sdio-host@a0000000 {
 			bus-width = <8>;
-			mmc-ddr-3_3v;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc0_default>;
 			status = "okay";
-- 
2.43.0

