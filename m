Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D52F776F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjHJEyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjHJEyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:54:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306FB2111;
        Wed,  9 Aug 2023 21:54:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A4rlvP001781;
        Wed, 9 Aug 2023 23:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691643227;
        bh=29DxiGouTr/exCnGJCCcLoEiW0H6Td5B0TmF3Ynap24=;
        h=From:To:CC:Subject:Date;
        b=OMOePgo4GdYWUUqnt/oIIxk0JVBNUs0vAfMT/aY76qK2NZlptulsHnL+QGKw939ON
         foSKhFMI+ivUXaIvmCc6/BW+G4fDjldlL6ilb6sqTXeGSL+FjCgO+jpkTihQNfA4IQ
         jODktiJU6FEfbFR7qiA/FeZvJ5ctt4ATxYaORfaI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A4rlio080662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 23:53:47 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 23:53:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 23:53:47 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A4rick118558;
        Wed, 9 Aug 2023 23:53:44 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] arm64: dts: ti: Introduce AM62P SoCs
Date:   Thu, 10 Aug 2023 10:23:11 +0530
Message-ID: <20230810045314.2676833-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for AM62P family of SoCs and specifically
AM62P5 variant. Also adds AM62P5-SK EVM support with basic peripheral
like UART.

TRM at [0] and Schematics is at [1]

[0]: https://www.ti.com/lit/pdf/spruj83
[1]: https://www.ti.com/lit/zip/sprr487

Bryan Brattlof (3):
  dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
  arm64: dts: ti: Introduce AM62P5 family of SoCs
  arm64: dts: ti: Add support for the AM62P5-SK

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 129 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi      |  16 ++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi   |  30 ++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          | 109 +++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       | 169 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         | 107 +++++++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
 9 files changed, 572 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5.dtsi

-- 
2.41.0

