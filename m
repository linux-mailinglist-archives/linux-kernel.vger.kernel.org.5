Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B07792AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjHKPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:17:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAD830C1;
        Fri, 11 Aug 2023 08:17:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BFGnra018791;
        Fri, 11 Aug 2023 10:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691767009;
        bh=JmMQhUREOQa6KGHlxqAkg3x3ViuI9RwMct8Dw2Glxmc=;
        h=From:To:Subject:Date;
        b=by0t5DtzueKU82dBhN/x4YfyQWD2zlOZtnfW598M10/CwtbqWv124VP/jyO0NvG4w
         eQCgt214qnx/+xWoBNxW0VMMG2wklpSXy5e3rSmSJdikx2jOeBZT6r0zURbHbqnaAT
         i4NBXKn2Pn55nPD2kgOp5j8CWjwTG+zVKCqqdCP4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BFGnOs071886
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 10:16:49 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 10:16:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 10:16:48 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BFGicc121323;
        Fri, 11 Aug 2023 10:16:45 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
Subject: [PATCH v4 0/3] arm64: dts: ti: k3-j784s4: Add phase tags marking
Date:   Fri, 11 Aug 2023 20:46:41 +0530
Message-ID: <20230811151644.3216621-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
This series adds it to Linux to be aligned with bootloader requirement
for TI K3 J784S4 EVM and TI K3 AM69-SK EVM.

This series will be ported to the k3-j784s4 u-boot support patch
series for syncing, and was requested in its review process:
https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/

v4: Changelog:
1) Reworked commit title and description

Link to v3:
https://lore.kernel.org/lkml/20230810184302.3097829-1-a-nandan@ti.com/

v3: Changelog:
1) Changed all the bootph-pre-ram to bootph-all, as only
   secure_proxy_mcu and secure_proxy_sa3 are exclusively used by R5 SPL.
   Rest of the nodes are also used by later boot stages.
2) Merged SoC dtsi changes in single patch.
3) Moved cbass_main and cbass_mcu_wkup bootph-all to k3-j784s4.dtsi

Link to v2: 
https://lore.kernel.org/lkml/20230807185645.128751-1-a-nandan@ti.com/#t

v2: Changelog:
1) Added k3-am69-sk.dts bootph-pre-ram patch
2) Added bootph-pre-ram for wkup_pmx0 and ospi0
3) Added bootph-pre-ram for mcu_timer1

Link to v1:
https://lore.kernel.org/linux-arm-kernel/20230806164838.18088-1-a-nandan@ti.com/


Apurva Nandan (3):
  arm64: dts: ti: k3-j784s4: Add phase tags marking
  arm64: dts: ti: k3-j784s4-evm: Add phase tags marking
  arm64: dts: ti: k3-am69-sk: Add phase tags marking

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 13 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 25 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    |  2 ++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  9 +++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |  2 ++
 5 files changed, 51 insertions(+)

-- 
2.34.1

