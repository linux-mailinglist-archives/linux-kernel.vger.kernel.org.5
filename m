Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FDA7FAC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjK0VLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0VLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:11:41 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18133D59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:11:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <auto@pengutronix.de>)
        id 1r7itI-0004lF-8W; Mon, 27 Nov 2023 22:11:40 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <auto@pengutronix.de>)
        id 1r7itH-00C1px-FB; Mon, 27 Nov 2023 22:11:39 +0100
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <auto@pengutronix.de>)
        id 1r7itH-00FAHf-1H;
        Mon, 27 Nov 2023 22:11:39 +0100
From:   Roland Hieber <rhi@pengutronix.de>
Subject: [PATCH 0/5] ARM: dts: add support for Gossen Metrawatt Profitest
Date:   Mon, 27 Nov 2023 22:11:01 +0100
Message-Id: <20231127-b4-imx7-var-som-gome-v1-0-f26f88f2d0bc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUFZWUC/x2N0QqDMAwAf0XyvMDaiZX9ythDWzMN2HYkKIL47
 wt7vIPjTlASJoVnd4LQzsqtGrhbB3mJdSbkyRj83T+c8wFTj1yOgHsU1FZwboXQhTAOrqdhnDJ
 YmqISJok1LxbXbV1NfoU+fPxfr/d1/QAZK/gMewAAAA==
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Roland Hieber <rhi@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: auto@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to add initial support for the Gossen Metrawatt
Profitest MF board (internally known as e143_01), as well as the
Variscite VAR-SOM-MX7 System on Module that it is based on.

The resulting device tree has been dt-schema-validated, and the
necessary fixes have been submitted in the following patch series:

http://lore.kernel.org/r/20231127-b4-dt-bindings-serial-v1-1-422a198fd91a@pengutronix.de
http://lore.kernel.org/r/20231127-b4-dt-bindings-mxsfb-v1-1-922e4e71c838@pengutronix.de
http://lore.kernel.org/r/20231127-b4-dt-bindings-timer-v1-1-e06bd6b2370b@pengutronix.de
http://lore.kernel.org/r/20231127-b4-imx7-dt-v1-1-6ecbd0471cc4@pengutronix.de

It builds on top of this series adding MIPI-DSI support to i.MX7:

http://lore.kernel.org/r/20231127-b4-imx7-mipi-dsi-v1-0-7d22eee70c67@pengutronix.de

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
Marco Felsch (2):
      ARM: dts: add Variscite VAR-SOM-MX7 System on Module
      ARM: dts: add support for Gossen Metrawatt Profitest

Philipp Zabel (3):
      dt-bindings: at24: add ROHM BR24G04
      dt-bindings: vendor-prefixes: add Gossen Metrawatt
      ARM: dts: imx7d-pinfunc: add mux for OSC32K_32K_OUT via GPIO1_IO03

 Documentation/devicetree/bindings/arm/fsl.yaml     |   7 +
 Documentation/devicetree/bindings/eeprom/at24.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/nxp/imx/Makefile                 |   1 +
 arch/arm/boot/dts/nxp/imx/imx7d-gome-e143_01.dts   | 559 +++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx7d-pinfunc.h          |   1 +
 arch/arm/boot/dts/nxp/imx/imx7d-var-som-mx7.dtsi   | 607 +++++++++++++++++++++
 7 files changed, 1178 insertions(+)
---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231127-b4-imx7-var-som-gome-1778614e68dc

Best regards,
-- 
Roland Hieber, Pengutronix e.K.          | rhi@pengutronix.de          |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |

