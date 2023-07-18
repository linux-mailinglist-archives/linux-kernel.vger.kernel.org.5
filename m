Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C4757BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGRMf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGRMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:35:57 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C0FE56;
        Tue, 18 Jul 2023 05:35:55 -0700 (PDT)
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Tue, 18 Jul 2023
 20:35:41 +0800
From:   zelong dong <zelong.dong@amlogic.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <kelvin.zhang@amlogic.com>,
        Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH v2 0/3] reset: meson-c3: add reset driver
Date:   Tue, 18 Jul 2023 20:35:47 +0800
Message-ID: <20230718123550.13712-1-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.69]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelong Dong <zelong.dong@amlogic.com>

This patchset adds Reset controller driver support for Meson-C3 SoC.
The RESET registers count and offset for C3 Soc are same as S4 Soc.

Changes since v1:
- remove Change-ID
- run scripts/checkpatch.pl and fix reported warnings
- sort dts node by base reg offset

---
v1:https://lore.kernel.org/all/20230630121059.28748-1-zelong.dong@amlogic.com/

Zelong Dong (3):
  dt-bindings: reset: Add compatible and DT bindings for Meson-C3 Reset
    Controller
  reset: reset-meson: add support for the Meson-C3 SoC Reset Controller
  arm64: dts: meson: add reset controller for Meson-C3 SoC

 .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   |   7 ++
 drivers/reset/reset-meson.c                   |   1 +
 .../reset/amlogic,meson-c3-reset.h            | 119 ++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-c3-reset.h

-- 
2.35.1

