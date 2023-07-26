Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B948776315E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGZJMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjGZJMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:12:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E39CA196;
        Wed, 26 Jul 2023 02:08:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36Q966Gl8008069, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36Q966Gl8008069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 26 Jul 2023 17:06:06 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 26 Jul 2023 17:06:18 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 26 Jul 2023 17:06:18 +0800
From:   TY Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Add pinctrl driver support for Realtek DHC SoCs
Date:   Wed, 26 Jul 2023 17:04:02 +0800
Message-ID: <20230726090409.16606-1-tychang@realtek.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-KSE-Antispam-Frontend-Serialized-Headers: RnJvbTogVFkgQ2hhbmcgPHR5Y2hhbmdAcmVhbHRlay5jb20+DQpUbzogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPiwNCglSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPiwNCglLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+LA0KCUNvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz4NCkNjOiBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZywNCglkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZywNCglsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbUEFUQ0ggMC83XSBBZGQgcGluY3RybCBkcml2ZXIgc3VwcG9ydCBmb3IgUmVhbHRlayBESEMgU29Dcw0KRGF0ZTogV2VkLCAyNiBKdWwgMjAyMyAxNzowNDowMiArMDgwMA0KTWVzc2FnZS1JRDogPDIwMjMwNzI2MDkwNDA5LjE2NjA2LTEtdHljaGFuZ0ByZWFsdGVrLmNvbT4NClgtTWFpbGVyOiBnaXQtc2VuZC1lbWFpbCAyLjQxLjANCk1JTUUtVmVyc2lvbjogMS4wDQpDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0DQoNCg==
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add the bindings and the pinctrl drivers for Realtek
DHC(Digital Home Center) RTD SoCs(RTD1619B, RTD1319D and RTD1315E).

TY Chang (7):
  pinctrl: realtek: Add common pinctrl driver for Realtek DHC RTD SoCs
  pinctrl: realtek: Add pinctrl driver for RTD1315E
  pinctrl: realtek: Add pinctrl driver for RTD1319D
  pinctrl: realtek: Add pinctrl driver for RTD1619B
  dt-bindings: pinctrl: realtek: add RTD1315E pinctrl binding
  dt-bindings: pinctrl: realtek: add RTD1319D pinctrl binding
  dt-bindings: pinctrl: realtek: add RTD1619B pinctrl binding

 .../pinctrl/realtek,rtd1315e-pinctrl.yaml     |  165 ++
 .../pinctrl/realtek,rtd1319d-pinctrl.yaml     |  163 ++
 .../pinctrl/realtek,rtd1619b-pinctrl.yaml     |  162 ++
 drivers/pinctrl/Kconfig                       |    1 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/realtek/Kconfig               |   23 +
 drivers/pinctrl/realtek/Makefile              |    6 +
 drivers/pinctrl/realtek/pinctrl-rtd.c         |  568 ++++++
 drivers/pinctrl/realtek/pinctrl-rtd.h         |  124 ++
 drivers/pinctrl/realtek/pinctrl-rtd1315e.c    | 1439 +++++++++++++++
 drivers/pinctrl/realtek/pinctrl-rtd1319d.c    | 1609 +++++++++++++++++
 drivers/pinctrl/realtek/pinctrl-rtd1619b.c    | 1601 ++++++++++++++++
 12 files changed, 5862 insertions(+)
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

