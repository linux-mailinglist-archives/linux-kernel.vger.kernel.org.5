Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32DA79FC39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjINGlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjINGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:41:17 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252FBCCD;
        Wed, 13 Sep 2023 23:40:25 -0700 (PDT)
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 14 Sep 2023
 14:40:21 +0800
From:   zelong dong <zelong.dong@amlogic.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <yonghui.yu@amlogic.com>,
        <kelvin.zhang@amlogic.com>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH v4 0/3] reset: amlogic-c3: add reset driver
Date:   Thu, 14 Sep 2023 14:40:15 +0800
Message-ID: <20230914064018.18790-1-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.69]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelong Dong <zelong.dong@amlogic.com>

This patchset adds Reset controller driver support for Amlogic C3 SoC.
The RESET registers count and offset for C3 Soc are same as S4 Soc.

Changes since v1:
- remove Change-ID
- run scripts/checkpatch.pl and fix reported warnings
- sort dts node by base reg offset

Changes since v2:
- replace keyword "meson" with "amlogic"

Changes since v3:
- rebase on v6.6-rc1

---
v1:https://lore.kernel.org/all/20230630121059.28748-1-zelong.dong@amlogic.com/
v2:https://lore.kernel.org/all/20230718123550.13712-1-zelong.dong@amlogic.com/
v3:https://lore.kernel.org/all/20230719060954.14864-1-zelong.dong@amlogic.com/

Zelong Dong (3):
  dt-bindings: reset: Add compatible and DT bindings for Amlogic C3
    Reset Controller
  reset: reset-meson: add support for Amlogic C3 SoC Reset Controller
  arm64: dts: amlogic: add reset controller for Amlogic C3 SoC

 .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   |   7 ++
 drivers/reset/reset-meson.c                   |   1 +
 include/dt-bindings/reset/amlogic,c3-reset.h  | 119 ++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h

-- 
2.35.1

