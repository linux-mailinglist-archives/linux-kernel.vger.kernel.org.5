Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103EB78DBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbjH3Shp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344195AbjH3SUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:20:55 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB138198;
        Wed, 30 Aug 2023 11:20:51 -0700 (PDT)
Received: from p200300ccff199c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff19:9c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qbPo2-003BYg-W8; Wed, 30 Aug 2023 20:20:42 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qbPo2-003gTw-1f;
        Wed, 30 Aug 2023 20:20:42 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, mturquette@baylibre.com,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/5] ARM: omap: omap4-embt2ws: 32K clock for WLAN
Date:   Wed, 30 Aug 2023 20:20:33 +0200
Message-Id: <20230830182038.878265-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To have WLAN working properly, enable a 32K clock of the TWL6032.
In earlier tests, it was still enabled from a previous boot into
the vendor system.

Changes in V2:
- no separate device node for the clock
- converted toplevel node of TWL

Andreas Kemnade (5):
  dt-bindings: mfd: convert twl-family.tx to json-schema
  dt-bindings: mfd: ti,twl: Add clock provider properties
  mfd: twl-core: Add a clock subdevice for the TWL6032
  clk: twl: add clock driver for TWL6032
  ARM: dts: omap4-embt2ws: enable 32K clock on WLAN

 .../devicetree/bindings/mfd/ti,twl.yaml       |  72 +++++++
 .../devicetree/bindings/mfd/twl-family.txt    |  46 ----
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts  |   8 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-twl.c                         | 197 ++++++++++++++++++
 drivers/mfd/twl-core.c                        |  16 ++
 7 files changed, 303 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl-family.txt
 create mode 100644 drivers/clk/clk-twl.c

-- 
2.39.2

