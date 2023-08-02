Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4747C76C392
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjHBDds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjHBDd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:33:27 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D30127;
        Tue,  1 Aug 2023 20:32:46 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 2 Aug 2023
 11:32:27 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH V2 0/4] Add watchdog support for Amlogic-T7 SoCs
Date:   Wed, 2 Aug 2023 11:32:18 +0800
Message-ID: <20230802033222.4024946-1-huqiang.qin@amlogic.com>
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

Based on the original Amlogic-GXBB watchdog driver, support
for Amlogic-T7 watchdog is added.

[PATCH 1/4]: 
  V1 -> V2: Unchanged.

[PATCH 2/4]:
  V1 -> V2: Rename rst_shift to rst and use the BIT() macro
            to build its initial value.

[PATCH 3/4]:
  V1 -> V2: Use the BIT() macro to build rst initial value.

[PATCH 4/4]:
  V1 -> V2: Unchanged.

Huqiang Qin (4):
  dt-bindings: watchdog: Add support for Amlogic-T7 SoCs
  watchdog: Add a new struct for Amlogic-GXBB driver
  watchdog: Add support for Amlogic-T7 SoCs
  arm64: dts: Add watchdog node for Amlogic-T7 SoCs

 .../watchdog/amlogic,meson-gxbb-wdt.yaml      |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |  6 ++++++
 drivers/watchdog/meson_gxbb_wdt.c             | 21 ++++++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)


base-commit: 6f048cc7a635b8736b4c7ae0e5230a92e3e648eb
-- 
2.37.1

