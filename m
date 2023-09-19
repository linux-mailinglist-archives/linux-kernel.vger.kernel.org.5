Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC27A5F22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjISKMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjISKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:12:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B9F0;
        Tue, 19 Sep 2023 03:12:12 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38JABwsfE3430194, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38JABwsfE3430194
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 18:11:58 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 19 Sep 2023 18:11:59 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 19 Sep 2023 18:11:58 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Tue, 19 Sep 2023 18:11:58 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tzuyi Chang <tychang@realtek.com>
Subject: [PATCH v3 0/7] Add pinctrl driver support for Realtek DHC SoCs
Date:   Tue, 19 Sep 2023 18:11:10 +0800
Message-ID: <20230919101117.4097-1-tychang@realtek.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add the bindings and the pinctrl drivers for Realtek
DHC(Digital Home Center) RTD SoCs(RTD1619B, RTD1319D and RTD1315E).

Change log:
v2 -> v3:
1. Use regmap_update_bits instead of rtd_pinctrl_update_bits.
2. Remove if/then condition under the patternProperties "-pins$".
v1 -> v2:
1. Rename realtek,pdriver, realtek,ndriver and realtek,dcycle
2. Remove the wildcard in the compatible strings
3. Add the description for RTD1315E, RTD1319D and RTD1315E
4. Add the description for P-MOS and N-MOS driving strength

Tzuyi Chang (7):
  pinctrl: realtek: Add common pinctrl driver for Realtek DHC RTD SoCs
  pinctrl: realtek: Add pinctrl driver for RTD1315E
  pinctrl: realtek: Add pinctrl driver for RTD1319D
  pinctrl: realtek: Add pinctrl driver for RTD1619B
  dt-bindings: pinctrl: realtek: add RTD1315E pinctrl binding
  dt-bindings: pinctrl: realtek: add RTD1319D pinctrl binding
  dt-bindings: pinctrl: realtek: add RTD1619B pinctrl binding

 .../pinctrl/realtek,rtd1315e-pinctrl.yaml     |  188 ++
 .../pinctrl/realtek,rtd1319d-pinctrl.yaml     |  187 ++
 .../pinctrl/realtek,rtd1619b-pinctrl.yaml     |  186 ++
 drivers/pinctrl/Kconfig                       |    1 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/realtek/Kconfig               |   23 +
 drivers/pinctrl/realtek/Makefile              |    6 +
 drivers/pinctrl/realtek/pinctrl-rtd.c         |  580 ++++++
 drivers/pinctrl/realtek/pinctrl-rtd.h         |  124 ++
 drivers/pinctrl/realtek/pinctrl-rtd1315e.c    | 1439 +++++++++++++++
 drivers/pinctrl/realtek/pinctrl-rtd1319d.c    | 1609 +++++++++++++++++
 drivers/pinctrl/realtek/pinctrl-rtd1619b.c    | 1601 ++++++++++++++++
 12 files changed, 5945 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1315e-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1319d-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1619b-pinctrl.yaml
 create mode 100644 drivers/pinctrl/realtek/Kconfig
 create mode 100644 drivers/pinctrl/realtek/Makefile
 create mode 100644 drivers/pinctrl/realtek/pinctrl-rtd.c
 create mode 100644 drivers/pinctrl/realtek/pinctrl-rtd.h
 create mode 100644 drivers/pinctrl/realtek/pinctrl-rtd1315e.c
 create mode 100644 drivers/pinctrl/realtek/pinctrl-rtd1319d.c
 create mode 100644 drivers/pinctrl/realtek/pinctrl-rtd1619b.c

-- 
2.42.0

