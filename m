Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78675772F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGRI5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGRI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:57:33 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4FA103;
        Tue, 18 Jul 2023 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689670651; x=1721206651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1CIePB0Tkz3mVBA+8yB/2k1niDiwUcmmzD9kC005/O8=;
  b=ebkO0gxOvsQY6TcVHsBfpI6/WQeTAlam0az2YSISQRJ7rKnWFlr3+HtP
   OTD0OQjfMtnN8i+4knia4hsKFZd/tvqQe2HTDudx0smJ8i4kml0CDYqbG
   ysDFr66pQ9CMTq8xon3VKybqO32ilTrrhNOJhGb3dn8O3ZaOwjUC6CwH5
   bnOxgDHU8p7AUB/yHIWYRIPucHwo0+/RmgyUrlOIyZDBkT85OIHpT55OZ
   JP/r+ls/xy9q8xHpOUb3bGSBWHtFnm2AMGDdlrFIRseAKDQe1qq2xFvhd
   lq8fVuCumJtsl7r/vgaqlqX/r4/6sHRiUgc0c12z+GebzCVI3MVM+X2cs
   A==;
X-IronPort-AV: E=Sophos;i="6.01,213,1684792800"; 
   d="scan'208";a="31981425"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Jul 2023 10:57:29 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 10EAF280078;
        Tue, 18 Jul 2023 10:57:29 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH v3 0/3] TQMa93xxLA support
Date:   Tue, 18 Jul 2023 10:57:19 +0200
Message-Id: <20230718085722.1198862-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as before thanks for any feedback.
This series adds initial support for TQMa93xxLA soldered on MBa93xxLA.
As the name indicates this is an i.MX93 based SBC board. The initial
support includes typical interfaces like UART, eMMC, I2C, Ethernet.
Support for USB, LVDS and PMIC is still pending, which require additional
patches.
Patch 1 adds the compatible to dt bindings
Patch 2 adds .dts[i] files for module and sbc board support
Patch 3 adds more i.MX93 drivers to arm64 defconfig

As the question occurred: xx in TQMa9xx is an actual wildcard indicating
the mounted SoC, while xx in MBa9xx is part of the regular name of the
mainboard.
There is an ordering number called MBa9352, but this is just indicating
the soldered module, the mainboard is still MBa93xx.

Changes in v3:
* Rebase to next-20230718
* Collected Krzysztof's A-b on Patch 1
* Renamed fixed clock name (for DSI-DP bridge input)
* Sorted properties to name vendor specific ones below common ones
* Add missing properties for DSI-DP bridge, update compatible as well
* Add missing pinctrl settings for DSI-DP bridge
* Move compatible first for QSPI flash node

Changes in v2:
* Fix dt-bindings patch subject

Best regards,
Alexander

Alexander Stein (2):
  arm64: dts: freescale: add initial device tree for MBa93xxLA SBC board
  arm64: defconfig: Enable i.MX93 devices

Markus Niebel (1):
  dt-bindings: arm: add TQMa93xxLA SOM

 .../devicetree/bindings/arm/fsl.yaml          |  19 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 641 ++++++++++++++++++
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 213 ++++++
 arch/arm64/configs/defconfig                  |   4 +
 5 files changed, 878 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi

-- 
2.34.1

