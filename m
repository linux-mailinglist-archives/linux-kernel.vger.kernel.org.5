Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB61802C03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjLDH0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjLDH0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:26:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB906109;
        Sun,  3 Dec 2023 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701674768; x=1733210768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OnA7/tb/qn6bAGUzgTDAT2ga2PQa5Pg9LbgHUXsCOok=;
  b=DFuLY5tjoDQ0JuEdIuCFTK2/OZeBFNcT7A6DCoivle5tp2l3Ao0lHisS
   F7d6N/uKwrhSxeC9tvmGZafCDCh5/pTsKh8+FrOlQ3X6mn4FC8AY7k8bs
   0a2gYUfCEi2UV2DRG6ifi8lOvBHBRTfjfIjCOntauDq1saZO5jcPIQg+B
   IDWrYgJ2PIHuauudPnyNZJmlCyRATNbnr3oA2Yg02REp/jtRTIi5hx2xo
   6r9iqn+N8G4uminpQnmHijA6eCtlY2WOgoC0v56QXfQ+Pv9CABzPjPqjC
   myQzzpl7/XASmPyOEWyMnD1dMMNdCCKwCaz9z7ATjFNVKnTcUoFN1BWZN
   A==;
X-CSE-ConnectionGUID: 0Vk3FHtMTeWoDESsJ/0r0A==
X-CSE-MsgGUID: 338xrwkrRcqrIiydXkIT0A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="13528937"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2023 00:26:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 00:25:50 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 00:25:48 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cristian.birsan@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: dts: microchip: sama5d27_wlsom1_ek: Remove mmc-ddr-3_3v property from sdmmc0 node
Date:   Mon, 4 Dec 2023 09:25:37 +0200
Message-ID: <20231204072537.2991-1-mihai.sain@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index e055b9e2fe34..15239834d886 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -197,7 +197,6 @@ qspi1_flash: flash@0 {
 
 &sdmmc0 {
 	bus-width = <4>;
-	mmc-ddr-3_3v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
 	status = "okay";
-- 
2.43.0

