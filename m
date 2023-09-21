Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AAC7A99F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjIUSet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIUSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:34:39 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB3400E0;
        Thu, 21 Sep 2023 10:15:04 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 21 Sep 2023
 16:34:57 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <brgl@bgdev.pl>, <andy@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH V2 0/3] Add pinctrl driver support for Amlogic T7 SoCs
Date:   Thu, 21 Sep 2023 16:34:05 +0800
Message-ID: <20230921083407.1167510-2-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pinctrl driver support for Amloigc T7 SoC (A311D2)

[PATCH 1/3]: 
  V1 -> V2: Rename amlogic-t7-gpio.h to amlogic,t7-periphs-pinctrl.h

[PATCH 2/3]:
  V1 -> V2: Include header file changed to amlogic,t7-periphs-pinctrl.h

[PATCH 3/3]:
  V1 -> V2: Unchanged.

Huqiang Qin (3):
  dt-bindings: pinctrl: Add compatibles for Amlogic T7 SoCs
  pinctrl: Add driver support for Amlogic T7 SoCs
  arm64: dts: Add pinctrl node for Amlogic T7 SoCs

 .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |    1 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |   16 +
 drivers/pinctrl/meson/Kconfig                 |    6 +
 drivers/pinctrl/meson/Makefile                |    1 +
 drivers/pinctrl/meson/pinctrl-amlogic-t7.c    | 1612 +++++++++++++++++
 .../gpio/amlogic,t7-periphs-pinctrl.h         |  179 ++
 6 files changed, 1815 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-amlogic-t7.c
 create mode 100644 include/dt-bindings/gpio/amlogic,t7-periphs-pinctrl.h


base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
-- 
2.42.0

