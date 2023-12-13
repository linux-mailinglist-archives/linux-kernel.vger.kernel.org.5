Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5418113E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjLMN6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjLMNzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:55:22 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6240126BE;
        Wed, 13 Dec 2023 05:51:55 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDpiJd082150;
        Wed, 13 Dec 2023 07:51:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702475504;
        bh=dZ2Jh3HTa0NlKfCTntLUZnihgnEwMB+dhWOM8iyd4+g=;
        h=From:To:CC:Subject:Date;
        b=jR2xfqry6IhrL+7CMtZQbCRdsD/ahpE8lr1p1WYhii5tZ6bF26d4j1FmppSKp3ooo
         PVN7DtG/wKwz5bcpuGu92DB66qRzWePyMDs8C9MsDyqfwLsqAhqtFgaWL37YaOVzQG
         a76z1huFUh26TXUExHPu9TZBNhDu7cfkhMcwXX0c=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDDpijr120572
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 07:51:44 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 07:51:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 07:51:43 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDpeLB101220;
        Wed, 13 Dec 2023 07:51:41 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-luthra@ti.com>
Subject: [PATCH v2 0/3] arm64: dts: ti: k3: Add additioal regs for DMA components
Date:   Wed, 13 Dec 2023 19:21:35 +0530
Message-ID: <20231213135138.929517-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds additional reg ranges which are not directly used by Linux but
by other components like U-Boot

Binding is accepted via dmaengine tree and is in linux-next[0]

[0] https://lore.kernel.org/dmaengine/170083278148.771517.1841889156174413563.b4-ty@kernel.org/

v2:
Extend register ranges to match TRM as pointed out by Jai

v1: https://lore.kernel.org/linux-arm-kernel/20231212111634.3515175-1-vigneshr@ti.com/

Manorit Chawdhry (2):
  arm64: dts: ti: k3-am65: Add additional regs for DMA components
  arm64: dts: ti: k3-j7*: Add additional regs for DMA components

Vignesh Raghavendra (1):
  arm64: dts: ti: k3-am6*: Add additional regs for DMA components

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 18 ++++++++++++++----
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 18 ++++++++++++++----
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi      | 18 ++++++++++++++----
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 18 ++++++++++++++----
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  8 ++++++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        |  8 ++++++--
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi      |  8 ++++++--
 .../arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  8 ++++++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi      |  8 ++++++--
 .../arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  8 ++++++--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi     |  8 ++++++--
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi      |  8 ++++++--
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi     |  8 ++++++--
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi      |  8 ++++++--
 14 files changed, 116 insertions(+), 36 deletions(-)

-- 
2.43.0

