Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25AD7E6B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjKINMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjKINMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:12:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC811FEB;
        Thu,  9 Nov 2023 05:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699535539; x=1731071539;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FRHtlYt1gPiLb/xfI70NyDEluyL/eoHMZX2jKm06y+U=;
  b=wkO+TP4P16qcR+KjvXu475Z196BccZthHkao9WE+4NWtinM0f/OQBF93
   SaM0v79bt6n1XGuXdHAqjw5vKQXgQSntpOy4hIg9ws1sLMGN3VopmoOmO
   TrMWHn3EvvgVGy2RkqoAt6I00eHEnljyeDMdM85/zxmRJIJH6bh2Uf6oL
   IdGe/SL6UNYFRXLG8njU1Xj0x/uoJMzadQhqKCh9rz0/1molcLKU0P6GD
   nXzxngB6kk1B6ItBsK2yVNn38yoXxI8140tEZugVsdUFYFwoBeUaopNac
   mT3URadIEcFDebp82sbHoKKv++iIMRkg8/9M75cLVw79gyNMClKH1bJqN
   Q==;
X-CSE-ConnectionGUID: b8HNUWnxTBWR9Gotu1JdxA==
X-CSE-MsgGUID: 6oxv50lDQLicAwB3enIh1A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11697744"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2023 06:12:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Nov 2023 06:12:06 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 9 Nov 2023 06:12:03 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cristian.birsan@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 0/2] Add IRQ support for ethernet PHY on SAM9X60 boards
Date:   Thu, 9 Nov 2023 15:11:47 +0200
Message-ID: <20231109131149.46397-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IRQ support for ethernet PHY on SAM9X60-Curiosity board.
Add IRQ support for ethernet PHY on SAM9X60-EK board.

Mihai Sain (2):
  ARM: dts: at91: sam9x60_curiosity: Add IRQ support for ethernet PHY
  ARM: dts: at91: sam9x60ek: Add IRQ support for ethernet PHY

 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 3 +++
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts         | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.42.0

