Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657337B2047
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjI1O5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjI1O5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:57:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F81A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695913052; x=1727449052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E5+tmPZYwvTypdMShXuSxHArtHxRd4fHU6kmi+JT+Xw=;
  b=CeMwrtQemnGnxXNt9AdmweQGcXTtffbzLXty2/WvHpFHB1+RGa90vSqB
   KyK3ig45WLVZqhSm12uD+IvBCbmckJcYhgRnF6YbsFU7pYfcDTosLAntS
   e0q+huUuNcvFCuCgWNlPyCXGOoA6cdcTw2xjMoonD29sqlKu4itn3pZvX
   YkwkfRqZgEvKTwERRXzzJJjqqLOIVYLE+N8Ve+Ziiric+ZLt29DbO7s50
   UoMRW+r9fkiv3DZYatQ3HqmRttNKznaOR4I95vSLMUKOF6TLFm/CzEzBO
   s4eCUet72IFvrmdCzbNhmcJ89QNTC8XcdvmrQR2i5e2MGF4rYmAgm2p65
   w==;
X-CSE-ConnectionGUID: x0+RDp7zQXe4gBpngNFbLg==
X-CSE-MsgGUID: QdNHBAbySVGQvUtFhKmypg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="174116571"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 07:57:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 28 Sep 2023 07:57:20 -0700
Received: from ROU-LL-M43238.home (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 28 Sep 2023 07:57:18 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        <jerry.ray@microchip.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [RFC PATCH] ARM: dts: at91: sama5d3_eds: remove TDES use
Date:   Thu, 28 Sep 2023 16:56:55 +0200
Message-ID: <20230928145655.215481-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

TDES doesn't probe because of lack of DMA channels left on this
controller. As we don't need TDES HW engine, we prefer to keep DMA
channels for other usage.
Disable TDES for this board.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Hi,

Tell me what you think about this move. I think it makes sense but tell me if
application could suffer from this lack of TDES engine.

Regards,
  Nicolas

 arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
index c287b03d768b..fddd786f8483 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
@@ -284,6 +284,10 @@ timer1: timer@1 {
 	};
 };
 
+&tdes {
+	status = "disabled";
+};
+
 &usb0 {	/* USB Device port with VBUS detection. */
 	atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
-- 
2.39.2

