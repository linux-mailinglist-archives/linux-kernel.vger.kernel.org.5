Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24BB80F3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjLLQ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjLLQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:58:45 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284AE3;
        Tue, 12 Dec 2023 08:58:51 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGwfIf014936;
        Tue, 12 Dec 2023 10:58:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702400321;
        bh=AAObtteDlREppe6u22sirOLiU6N/UMnprGyG07IwvAI=;
        h=From:To:CC:Subject:Date;
        b=UYQogR7D++T9VGSLlwCYfmeMnZqNBNYZJl9UJkrinbKnUBKa9eq/wFewR1Y8c1Q/X
         ajLXm2gI2pubpC/+s4m2ETMnoqkugcj1IOOA7z5gY+UG//d/taynpL8CnunEKw697/
         zrtyfnjAj1lLtbcyznH3T2cBi4UG6200Cnw0R4QQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCGwfOA060134
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 10:58:41 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 10:58:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 10:58:41 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGwfPK125706;
        Tue, 12 Dec 2023 10:58:41 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BCGweBc018962;
        Tue, 12 Dec 2023 10:58:41 -0600
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <afd@ti.com>, <andrew@lunn.ch>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v2 0/3] Add AM64x ICSSG Ethernet support
Date:   Tue, 12 Dec 2023 22:28:29 +0530
Message-ID: <20231212165832.3933335-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series adds support for ICSSG ethernet on AM64x. 
This series is based on the latest next-20231211 linux-next.

AM64x EVM has three ethernet ports. One is dedicated to CPSW and one is
dedicated to ICSSG1. The remaining port is muxed between CPSW and ICSSG1
ICSSG1 ports. The ICSSG1 node is added in the k3-am642-evm.dts. By default
the muxed port is used by CPSW so 2nd ICSSG1 port is disabled in the
k3-am642-evm.dts. But overlay k3-am642-evm-icssg1-dualemac.dtso can be
applied to use muxed port as ICSSG1.

This is the v2 of the series [v1]. This addresses comments made on v1.

Changes from v1 to v2:
*) Fixed aliases section in k3-am642-evm.dts
*) Fixed firmware-names in k3-am642-evm.dts
*) Changed icssg1_phy1 to ethernet-phy@f from ethernet-phy@0 as suggested
   by Andrew L.
*) Changed makefile to handle overlays using CONFIG_OF_ALL_DTBS as
   suggested by Nishant and Andrew Davis.
*) Fixed aliases section in k3-am642-evm-icssg1-dualemac.dtso
*) Fixed pinctrl in k3-am642-evm-icssg1-dualemac.dtso
*) Updated commit message of patch 3/3 of the series to warn about adding
   label name to 'mdio-mux-1' node.

[v1] https://lore.kernel.org/all/20231207081917.340167-1-danishanwar@ti.com/

Thanks and Regards,
MD Danish Anwar

MD Danish Anwar (2):
  arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
  arm64: dts: ti: k3-am642-evm: add overlay for icssg1 2nd port

Suman Anna (1):
  arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 arch/arm64/boot/dts/ti/Makefile               |   7 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  24 ++++
 .../dts/ti/k3-am642-evm-icssg1-dualemac.dtso  |  75 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 104 +++++++++++++++++-
 4 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso

base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
-- 
2.34.1

