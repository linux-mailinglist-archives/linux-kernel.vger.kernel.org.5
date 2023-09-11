Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B38D79C2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbjILCbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbjILCb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:31:27 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21C11224DC;
        Mon, 11 Sep 2023 18:56:26 -0700 (PDT)
Received: from p200300ccff36fa001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff36:fa00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qfpAD-003crG-Gw; Tue, 12 Sep 2023 00:13:49 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qfpAC-006ECc-2f;
        Tue, 12 Sep 2023 00:13:48 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mturquette@baylibre.com, sboyd@kernel.org, andreas@kemnade.info,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 0/5] ARM: omap: omap4-embt2ws: 32K clock for WLAN
Date:   Tue, 12 Sep 2023 00:13:41 +0200
Message-Id: <20230911221346.1484543-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To have WLAN working properly, enable a 32K clock of the TWL6032.
In earlier tests, it was still enabled from a previous boot into
the vendor system.

Changes in V3:
- maintainer change in binding doc
- fix references to binding doc
- additionalProperties: false
- remove subdevices also from examples until
  subdevices are referenced/added

Changes in V2:
- no separate device node for the clock
- converted toplevel node of TWL

Andreas Kemnade (5):
  dt-bindings: mfd: convert twl-family.txt to json-schema
  dt-bindings: mfd: ti,twl: Add clock provider properties
  mfd: twl-core: Add a clock subdevice for the TWL6032
  clk: twl: add clock driver for TWL6032
  ARM: dts: omap4-embt2ws: enable 32K clock on WLAN

 .../bindings/input/twl4030-pwrbutton.txt      |   2 +-
 .../devicetree/bindings/mfd/ti,twl.yaml       |  67 ++++++
 .../devicetree/bindings/mfd/twl-family.txt    |  46 ----
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts  |   8 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-twl.c                         | 197 ++++++++++++++++++
 drivers/mfd/twl-core.c                        |  16 ++
 8 files changed, 299 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl-family.txt
 create mode 100644 drivers/clk/clk-twl.c

-- 
2.39.2

