Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE607574B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGRG57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGRG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:57:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54B21A2;
        Mon, 17 Jul 2023 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689663473; x=1721199473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KB6wQi2fSkHzaNEB8uUFd6EhlNuh6Xp2A6Y58nxMss0=;
  b=D80q7/QZ3vJvftcynOekJbUHbFnM4XFUETdqyjpD17eusU/ZJA2v3RBj
   MlB2pBWGIQjEbsiANHjJ1F1l8AQNk6R1axDHOTr/zFOMigebJmcyjCCOR
   pBJnhI3OniJhQM6ooti4CCehcthToPKfcNYP/D52sfU9vfAoStDOw7GxK
   BMvBYTWSTJJ+ADyeBU8BVpW/j4AUdmPDWovEbKh6Xt3M/OQFIpCV7agf1
   cXAREcYSPXTn2DU75v844koz3Wmd19noZrpQj3SBt9K6gnhDKOpddypqr
   pD/iwx/NuQ7lX12eHz9sBeaNyOaGYnKZGueL9I21Aw2bQ3GBRCGmnFeov
   g==;
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="224388338"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2023 23:57:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Jul 2023 23:57:50 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Jul 2023 23:57:39 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <Hari.PrasathGE@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        <manikandan.m@microchip.com>, <varshini.rajendran@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>, <cristian.birsan@microchip.com>,
        <nicolas.ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <jerry.ray@microchip.com>,
        <conor+dt@kernel.org>, <jesper.nilsson@axis.com>,
        <andre.przywara@arm.com>, <ada@thorsis.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCHv3 0/2] update at91 usart compatible for sam9x60
Date:   Tue, 18 Jul 2023 12:27:33 +0530
Message-ID: <20230718065735.10187-1-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one debug unit in the sam9x60 SOC and it has the chipid 
register. So defining these dbgu compatible strings to the flexcom usart
is not correct and causes the SOC detection failure. So removing these 
dbgu compatible strings defined under the flexcom usart and updating 
the yaml file accordingly.
---
v2 changes:
1. Updating the dt-bindings documentation and send one more patch for
the yaml file.
---
v3 change:
1. Explained the issue in the commit message rather than in the cover
letter. Added the detailed commit message for the changes done.
---
Durai Manickam KR (2):
  dt-bindings: serial: atmel,at91-usart: update compatible for sam9x60
  ARM: dts: at91: sam9x60: fix the SOC detection

 .../bindings/serial/atmel,at91-usart.yaml     |  4 ++-
 arch/arm/boot/dts/microchip/sam9x60.dtsi      | 26 +++++++++----------
 2 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.25.1

