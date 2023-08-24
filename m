Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E580D786D48
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbjHXK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbjHXK5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:57:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98B5010F9;
        Thu, 24 Aug 2023 03:57:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37OAujkF7014164, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37OAujkF7014164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 18:56:45 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 24 Aug 2023 18:57:07 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Thu, 24 Aug 2023 18:57:07 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] Add pinctrl driver support for Realtek DHC SoCs
Date:   Thu, 24 Aug 2023 18:56:56 +0800
Message-ID: <20230824105703.19612-1-tychang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add the bindings and the pinctrl drivers for Realtek
DHC(Digital Home Center) RTD SoCs(RTD1619B, RTD1319D and RTD1315E).

Change log:
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

 .../pinctrl/realtek,rtd1315e-pinctrl.yaml     |  191 ++
 .../pinctrl/realtek,rtd1319d-pinctrl.yaml     |  189 ++
 .../pinctrl/realtek,rtd1619b-pinctrl.yaml     |  188 ++
 drivers/pinctrl/Kconfig                       |    1 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/realtek/Kconfig               |   23 +
 drivers/pinctrl/realtek/Makefile              |    6 +
 drivers/pinctrl/realtek/pinctrl-rtd.c         |  568 ++++++
 drivers/pinctrl/realtek/pinctrl-rtd.h         |  124 ++
 drivers/pinctrl/realtek/pinctrl-rtd1315e.c    | 1439 +++++++++++++++
 drivers/pinctrl/realtek/pinctrl-rtd1319d.c    | 1609 +++++++++++++++++
 drivers/pinctrl/realtek/pinctrl-rtd1619b.c    | 1601 ++++++++++++++++
 12 files changed, 5940 insertions(+)
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
2.41.0

