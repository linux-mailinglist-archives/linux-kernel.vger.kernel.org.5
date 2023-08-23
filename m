Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD878579C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjHWMKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjHWMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:10:38 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC310CF;
        Wed, 23 Aug 2023 05:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692792611; x=1724328611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zRwhbvyoE4o+kBN8VRoHSwh+ofQVrjm6xzCTcDWH780=;
  b=k4v4GCiiWTvHoqo9ZBtacAR5FxqRknYtoCELFEsc4abL0ZS/AXLjl5Df
   lV9NtseAzpJB+YSxmpQa84lUqLZ1CSwpbdVZ7dEmefR52mk0PfcYxU1d1
   1XbgxgJAk8alxlKSy/81uodibVLgjaHIyJqYR6V/D2BGIfn2l82uaQXRh
   aY1JifuZlMv1ay86vrXmgewx44nJP3WoC7uVEMQ9fmTYnigYL7YxFb6ak
   iPoHBE2MCCKwS/1Ldhg7wIMQjrE1fm5NaPDMNWXkI6douYR9HLVZamIIG
   hmvcRAa11BYhZr59uChQ6H7zdG1X5SlqsCGXKS0ZcckXK74WNNWHqJSoP
   g==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="32586561"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 14:10:01 +0200
Received: from herburgerg-w2.tq-net.de (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4E822280075;
        Wed, 23 Aug 2023 14:10:01 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 0/6] TQMLS10xxA support
Date:   Wed, 23 Aug 2023 14:09:46 +0200
Message-Id: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds initial support for the TQMLS1043A, TQMLS1046A and
TQMLS1088A SoM on the MBLS10xxA baseboard. These three modules share a
common layout and a common baseboard.

Patch 1 removes an non-existing spi controller
Patch 2 and 4 add the the compatible to dt bindings
Patch 3 and 5 add the .dts[i] files for SoMs and baseboard
Patch 6 updates MAINTAINERS

Gregor Herburger (6):
  arm64: dts: ls1043a: remove second dspi node
  dt-bindings: arm: fsl: Add TQ-Systems LS1043A/LS1046A based boards
  arm64: dts: freescale: add initial device tree for
    TQMLS1043A/TQMLS1046A
  dt-bindings: arm: fsl: Add TQ-Systems LS1088 based boards
  arm64: dts: freescale: add initial device tree for TQMLS1088A
  MAINTAINERS: add tqml device trees to TQ-Systems entry

 .../devicetree/bindings/arm/fsl.yaml          |  21 +++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   3 +
 .../fsl-ls1043a-tqmls1043a-mbls10xxa.dts      |  49 ++++++
 .../dts/freescale/fsl-ls1043a-tqmls1043a.dtsi |  32 ++++
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  14 --
 .../fsl-ls1046a-tqmls1046a-mbls10xxa.dts      |  56 +++++++
 .../dts/freescale/fsl-ls1046a-tqmls1046a.dtsi |  42 +++++
 .../fsl-ls1088a-tqmls1088a-mbls10xxa.dts      |  64 ++++++++
 .../dts/freescale/fsl-ls1088a-tqmls1088a.dtsi |  43 ++++++
 .../freescale/tqmls104xa-mbls10xxa-fman.dtsi  | 104 +++++++++++++
 .../freescale/tqmls1088a-mbls10xxa-mc.dtsi    | 146 ++++++++++++++++++
 .../dts/freescale/tqmls10xxa-mbls10xxa.dtsi   | 136 ++++++++++++++++
 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi |  59 +++++++
 14 files changed, 757 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls104xa-mbls10xxa-fman.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls1088a-mbls10xxa-mc.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi

-- 
2.34.1

