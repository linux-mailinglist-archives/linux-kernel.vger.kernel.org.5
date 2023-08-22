Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC0783BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjHVI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjHVI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:28:48 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BF19F;
        Tue, 22 Aug 2023 01:28:04 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Tue, 22 Aug 2023
 16:27:56 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V10 0/4] Add S4 SoC PLLs and Peripheral clock
Date:   Tue, 22 Aug 2023 16:27:46 +0800
Message-ID: <20230822082750.27633-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add S4 SoC PLLs and Peripheral clock controller dt-bindings.
2. Add PLLs and Peripheral clock controller driver for S4 SOC.


Yu Tu (4):
  dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
  dt-bindings: clock: document Amlogic S4 SoC peripherals clock
    controller
  clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
  clk: meson: S4: add support for Amlogic S4 SoC peripheral clock
    controller

V9 -> V10:
1. Change the relevant S4 CLK patch based on Neil's recently modified
patch.
2. Change patch 0003/0004 clocks comment, format and clock flags suggested
by Jerome.

V8 -> V9: Add patch 0001/0002 dt-bindings tag. Suggested by Krzysztof.
V7 -> V8:
1. Change patch 0001/0002 dt-bindings title description, remove "meson".
Suggested by Dmitry, Neil.
2. Change patch 0003/0004 clocks comment, format and clock flags suggested by
Dmitry, Neil, Jerome.

V6 -> V7: Change send patch series as well change format and clock flags
suggested by Jerome. Change dt-bindings suggested by Krzysztof.
V5 -> V6: Change send patch series, as well change format and clock flags.
V4 -> V5: change format and clock flags and adjust the patch series
as suggested by Jerome.
V3 -> V4: change format and clock flags.
V2 -> V3: Use two clock controller.
V1 -> V2: Change format as discussed in the email.

Link:https://lore.kernel.org/linux-amlogic/20230517070215.28463-1-yu.tu@amlogic.com/

 .../clock/amlogic,s4-peripherals-clkc.yaml    |   96 +
 .../bindings/clock/amlogic,s4-pll-clkc.yaml   |   49 +
 drivers/clk/meson/Kconfig                     |   23 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/s4-peripherals.c            | 3787 +++++++++++++++++
 drivers/clk/meson/s4-peripherals.h            |   57 +
 drivers/clk/meson/s4-pll.c                    |  867 ++++
 drivers/clk/meson/s4-pll.h                    |   38 +
 .../clock/amlogic,s4-peripherals-clkc.h       |  236 +
 .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   43 +
 10 files changed, 5198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/s4-peripherals.c
 create mode 100644 drivers/clk/meson/s4-peripherals.h
 create mode 100644 drivers/clk/meson/s4-pll.c
 create mode 100644 drivers/clk/meson/s4-pll.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h


base-commit: bd0f6c57c2b324b6f92ccfe13a8005ff829287b8
-- 
2.33.1

