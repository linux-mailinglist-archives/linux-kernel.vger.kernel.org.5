Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448A4779739
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjHKSoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjHKSow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:44:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD3530DC;
        Fri, 11 Aug 2023 11:44:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BIigLZ067462;
        Fri, 11 Aug 2023 13:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691779482;
        bh=SWu3DfrGFRo0EAHRl3gjrAXV+2jq+HmqoCJF024Wy6g=;
        h=From:To:CC:Subject:Date;
        b=EvcgD4sQvFWFRU13wmFUCNNBSUmcHZ6OhxhnC1dGnXVtv4znpVsniTBxigqkJ/vFX
         MsvIqJpCs4g6brrE5q88oU0B6UqsuJ3T7q5YgENgNDcD8kC+2DMVDUJpggVTfajhGW
         kxmuh1CM4UDv5prm3hnDlxZ+BFbZRez3zp/tYRek=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BIig1g001368
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 13:44:42 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 13:44:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 13:44:41 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BIicWq018168;
        Fri, 11 Aug 2023 13:44:39 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>
Subject: [PATCH v2 0/3] arm64: dts: ti: Introduce AM62P5 SoC and board
Date:   Sat, 12 Aug 2023 00:14:29 +0530
Message-ID: <20230811184432.732215-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for AM62P family of SoCs and specifically
AM62P5 variant. Also adds AM62P5-SK support with basic peripheral
like UART.

TRM at [0] and Schematics is at [1]

[0]: https://www.ti.com/lit/pdf/spruj83
[1]: https://www.ti.com/lit/zip/sprr487

Bootlog:
https://gist.github.com/r-vignesh/edae006877fe8e51370f3cea9bf8ddfc

Change log
v2:
* Fix binding doc to talk about SoC and board
* Fix comments by Andrew on v1, enable main pmx by default, use
  bootph-all and move it to dtsi as appropriate etc
* Collect Acks and R-bys

Bryan Brattlof (3):
  dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
  arm64: dts: ti: Introduce AM62P5 family of SoCs
  arm64: dts: ti: Add support for the AM62P5 Starter Kit

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 136 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi      |  15 ++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi   |  32 +++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          | 122 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       | 117 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         | 107 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
 9 files changed, 541 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5.dtsi

-- 
2.41.0

