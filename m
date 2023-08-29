Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8719978BF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjH2HVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjH2HVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:21:18 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2759C1A6;
        Tue, 29 Aug 2023 00:21:15 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 78AEC200924;
        Tue, 29 Aug 2023 09:21:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 06D9C20028B;
        Tue, 29 Aug 2023 09:21:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0973518002A2;
        Tue, 29 Aug 2023 15:21:10 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de, a.fatoum@pengutronix.de,
        u.kleine-koenig@pengutronix.de
Cc:     hongxing.zhu@nxp.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 0/3] Add i.MX8Q PCIe PHY driver
Date:   Tue, 29 Aug 2023 14:45:31 +0800
Message-Id: <1693291534-32092-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QM HSIO(High Speed IO) module has three instances of single lane
SERDES PHYs, an instance of two lanes PCIe GEN3 controller, an
instance of single lane PCIe GEN3 controller, as well as an instance
of SATA 3.0 controller.

The HSIO module can be configured as the following different usecases.
1 - A two lanes PCIea and a single lane SATA.
2 - A single lane PCIea, a single lane PCIeb and a single lane SATA.
3 - A two lanes PCIea, a single lane PCIeb.

Add i.MX8Q PCIe PHY driver to support these different usecases, and had
been verified on i.MX8QM and i.MX8QXP MEK boards.

[PATCH v1 1/3] dt-bindings: phy: Add i.MX8QM PCIe PHY binding
[PATCH v1 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for
[PATCH v1 3/3] phy: freescale: imx8q-pcie: Add i.MX8Q PCIe PHY driver

Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  70 ++++++++++-
drivers/phy/freescale/Kconfig                                |   8 ++
drivers/phy/freescale/Makefile                               |   1 +
drivers/phy/freescale/phy-fsl-imx8q-pcie.c                   | 562 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                      |   7 ++
5 files changed, 645 insertions(+), 3 deletions(-)

