Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8BC7819C9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjHSNoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:44:06 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0439E55;
        Sat, 19 Aug 2023 06:42:07 -0700 (PDT)
Received: from p200300ccff2bce001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2b:ce00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qXMDF-002nxd-C4; Sat, 19 Aug 2023 15:41:57 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qXMDE-001ue8-2n;
        Sat, 19 Aug 2023 15:41:56 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, andreas@kemnade.info,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 0/3] ARM: omap: omap4-embt2ws: 32K clock for WLAN
Date:   Sat, 19 Aug 2023 15:41:44 +0200
Message-Id: <20230819134147.456060-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To have WLAN working properly, enable a 32K clock of the TWL6032.
In earlier tests, it was still enabled from a previous boot into
the vendor system.

Andreas Kemnade (3):
  dt-bindings: clock: add TWL6032 32K clocks
  clk: twl: add clock driver for TWL6032
  ARM: dts: omap4-embt2ws: enable 32K clock on WLAN

 .../bindings/clock/ti,twl6032-clk.yaml        |  38 ++++
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts  |  12 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-twl.c                         | 205 ++++++++++++++++++
 5 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
 create mode 100644 drivers/clk/clk-twl.c

-- 
2.39.2

