Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA9762BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjGZGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGZGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:54:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BEB2132;
        Tue, 25 Jul 2023 23:54:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36Q6sDwY007939;
        Wed, 26 Jul 2023 01:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690354453;
        bh=FrEx/bOy1/gQCYi00Le6XUiLNro3I286bRzQgqiu9Ow=;
        h=From:To:CC:Subject:Date;
        b=KICg53Ni88yq3/DUil+WOL5Y/I+Oi9XZ8ylCdTk2/Uy5MixyqV2eljfiMqdgLA1mW
         ReeMRKJt3enY5SLFelny3ylQvajqJCPQALgSsy3oSLuRwILOQzW8yVyzp3CZhAOew3
         Wxe9eKZ8aP7peyMSkB8JGxgIC5d27oXclIZfFhNA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36Q6sCvB048105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 01:54:13 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 01:54:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 01:54:12 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36Q6s8Td013490;
        Wed, 26 Jul 2023 01:54:09 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/2] Add MAIN CPSW2G DT support for J721S2
Date:   Wed, 26 Jul 2023 12:24:05 +0530
Message-ID: <20230726065407.378455-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds devicetree node for MAIN CPSW2G instance of CPSW
Ethernet Switch on TI's J721S2 SoC. Also, a devicetree overlay is added
in order to enable MAIN CPSW2G in RGMII-RXID mode using the GESI
Expansion Board connected to the J7 Common-Processor-Board.

Regards,
Siddharth.

---
NOTE: This series is based on linux-next tagged next-20230725.

v2:
https://lore.kernel.org/r/20230710094328.1359377-1-s-vadapalli@ti.com/
Changes since v2:
- Collect Reviewed-by tag from Ravi Gunasekaran <r-gunasekaran@ti.com>.
- Rename main_cpsw_mdio_pins_default and rgmii1_pins_default to:
  main_cpsw_mdio_default_pins and rgmii1_default_pins respectively.
- Rename main-cpsw-mdio-pins-default and rgmii1-pins-default to:
  main-cpsw-mdio-default-pins and rgmii1-default-pins respectively.
- The above changes are performed to follow the updated json-schema
  patch at:
  https://lore.kernel.org/all/169021456020.3622493.10284534202541859578.robh@kernel.org/
- Rebase series on next-20230725.

v1:
https://lore.kernel.org/r/20230529104913.560045-1-s-vadapalli@ti.com/
Changes since v1:
- Rebase series on next-20230710.

RFC:
https://lore.kernel.org/r/20230426105718.118806-1-s-vadapalli@ti.com/
Changes since RFC:
- Add GESI board product link in the device-tree overlay file.

Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-j721s2-main: Add main CPSW2G devicetree node
  arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 85 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 69 +++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso

-- 
2.34.1

