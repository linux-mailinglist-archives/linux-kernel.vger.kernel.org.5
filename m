Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B53753AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjGNM3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjGNM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:29:08 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9B43593;
        Fri, 14 Jul 2023 05:28:37 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 14 Jul 2023
 20:24:44 +0800
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
Subject: [PATCH V3 0/2] Add pinctrl driver support for Amlogic C3 SoCs
Date:   Fri, 14 Jul 2023 20:24:39 +0800
Message-ID: <20230714122441.3098337-1-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pinctrl driver support for Amloigc C3 SoC (C308L and C302X)

[PATCH 1/2]: 
  V1 -> V2:
    Unchanged.
  V2 -> V3:
    Updated commit message, and compatible are sorted alphabetically.

[PATCH 2/2]:
  V1 -> V2:
    Added a comma to the last item of the array and a period to
    the commit message.
  V2 -> V3:
    Ditto, and corrected license.

Huqiang Qin (2):
  dt-bindings: pinctrl: Add compatibles for Amlogic C3 SoCs
  pinctrl: Add driver support for Amlogic C3 SoCs

 .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |    1 +
 drivers/pinctrl/meson/Kconfig                 |    6 +
 drivers/pinctrl/meson/Makefile                |    1 +
 drivers/pinctrl/meson/pinctrl-amlogic-c3.c    | 1108 +++++++++++++++++
 include/dt-bindings/gpio/amlogic-c3-gpio.h    |   72 ++
 5 files changed, 1188 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-amlogic-c3.c
 create mode 100644 include/dt-bindings/gpio/amlogic-c3-gpio.h


base-commit: fe57d0d86f03a8b2afe2869a95477d0ed1824c96
-- 
2.37.1

