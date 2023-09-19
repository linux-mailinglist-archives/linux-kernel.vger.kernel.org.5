Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F47A6395
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjISMrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjISMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:46:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB18CF0;
        Tue, 19 Sep 2023 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695127601; x=1726663601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=483saZjIsYa7t2DWzXWa5SAeA8TL33vCYTU4gUJYP6k=;
  b=1ZEnPW9zftTTdbmESIA1Ls/upRPZWbGnKryoZScPf1ipLpiCyHP29oI/
   NW3X2he8k6TmuJkrtJVz0/LzD1PwTHGo31cSCv02cvwXc3KYwB3Qj8Lmc
   BsGTlOtGXD8F9N5uP0hRenHJMhr3iL2NhxZ6IlF6G9dKHjkJincsCYwEP
   22GIvmfKru0qmra4L6mLabYL/kbT29QiNwJwfmh1j5Onn663Fj2rxjlXY
   u3zh2WGvXj+RP+dh0QUp0FBOZhxpzrZ6Ge7WYdAJDlM9DKyZmMIATkqVy
   aOTjhUFWer9/SuIITElDMZxiBj0aE71vAGb4+/5XJowTuwgBP6xUIJJpk
   Q==;
X-CSE-ConnectionGUID: ZkAba0ZkQpmXoi8BBfgMaQ==
X-CSE-MsgGUID: 58j6pbuBSa+w7qHUnypsiw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="5599481"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 05:46:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 05:46:18 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 05:46:15 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <cristian.birsan@microchip.com>,
        <alexandre.belloni@bootlin.com>, <andre.przywara@arm.com>,
        <jerry.ray@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrei.simion@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v4 0/2] Add initial support for SAMA5D29-Curiosity board
Date:   Tue, 19 Sep 2023 15:46:03 +0300
Message-ID: <20230919124606.26898-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.42.0
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

Document device tree binding of SAMA5D29-Curiosity board.
Add initial device tree file for SAMA5D29-Curiosity board.

Changes in v4:
--------------

* revert dt-bindings patch
* fix the warnings from dtbs_check

Changes in v3:
--------------

* remove i2s0 node and its pinctrl

Changes in v2:
--------------

* drop dt-bindings patch
* remove vdd_1v8 regulator
* fix flx4 node to use 1 spi node and pinctrl
* add i2s0 node and pinctrl
* remove macb0 node and pinctrl
* remove unused pinctrl
* sort in alphabetical order all nodes and pinctrl
* replace "_" with "-" in node names

Andrei Simion (1):
  dt-bindings: ARM: at91: Document Microchip SAMA5D29 Curiosity

Mihai Sain (1):
  ARM: dts: at91: sama5d29_curiosity: Add device tree for
    sama5d29_curiosity board

 .../devicetree/bindings/arm/atmel-at91.yaml   |   7 +
 arch/arm/boot/dts/microchip/Makefile          |   2 +
 .../dts/microchip/at91-sama5d29_curiosity.dts | 600 ++++++++++++++++++
 3 files changed, 609 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts

-- 
2.42.0

