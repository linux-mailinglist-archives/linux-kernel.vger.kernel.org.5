Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19575BFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGUHfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGUHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:35:34 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7519A1;
        Fri, 21 Jul 2023 00:34:46 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 21 Jul 2023
 15:34:31 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH 0/3] Add binding header file for GPIO interrupt of Amlogic Meson-G12A
Date:   Fri, 21 Jul 2023 15:32:11 +0800
Message-ID: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding this binding header file, you can intuitively find
the interrupt number corresponding to each GPIO, and apply it
in the format of IRQID_XXX where it needs to be used.

Associated platforms:
- Amlogic Meson-G12A
- Amlogic Meson-G12B
- Amlogic Meson-SM1

Huqiang Qin (3):
  dt-bindings: interrupt-controller: Add header file for Amlogic
    Meson-G12A SoCs
  pinctrl: Replace the IRQ number in the driver with the IRQID macro
    definition
  arm64: dts: Replace the IRQ number with the IRQID macro definition

 .../boot/dts/amlogic/meson-g12-common.dtsi    |   1 +
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |   2 +-
 .../dts/amlogic/meson-g12b-bananapi-cm4.dtsi  |   2 +-
 .../boot/dts/amlogic/meson-g12b-bananapi.dtsi |   2 +-
 .../amlogic/meson-g12b-odroid-go-ultra.dts    |   4 +-
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     |   2 +-
 .../boot/dts/amlogic/meson-g12b-w400.dtsi     |   2 +-
 .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts |   2 +-
 .../boot/dts/amlogic/meson-sm1-bananapi.dtsi  |   4 +-
 .../boot/dts/amlogic/meson-sm1-h96-max.dts    |   2 +-
 .../boot/dts/amlogic/meson-sm1-odroid.dtsi    |   2 +-
 .../boot/dts/amlogic/meson-sm1-sei610.dts     |  12 +-
 .../dts/amlogic/meson-sm1-x96-air-gbit.dts    |   2 +-
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  35 ++---
 .../irq-meson-g12a-gpio.h                     | 126 ++++++++++++++++++
 15 files changed, 164 insertions(+), 36 deletions(-)
 create mode 100644 include/dt-bindings/interrupt-controller/irq-meson-g12a-gpio.h


base-commit: c58c49dd89324b18a812762a2bfa5a0458e4f252
-- 
2.37.1

