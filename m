Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7DA7797A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjHKTUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjHKTUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:20:47 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96002709;
        Fri, 11 Aug 2023 12:20:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BJKZru127921;
        Fri, 11 Aug 2023 14:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691781635;
        bh=kVW0D06/ZosFHEDLsV7SlHnJWgRbYJaaA7E+yDWUq98=;
        h=From:To:Subject:Date;
        b=h33kevHC80Pzd1R7Ps76uDYwAAd7OSHmQBBpArh5BLUIJkI9QVKrnvUj7FzvBRB/o
         +P9ouGnO3S81JHx27WpPk1R0/gb9odTSumiHZZBrl68nRF5Br4PDyjyn2rf75ICTTH
         RyYRPnEoVHwvhUT5zqhj+jjOW9MQP1l21D7oIdzE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BJKZ19002181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 14:20:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 14:20:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 14:20:34 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BJKUFv017018;
        Fri, 11 Aug 2023 14:20:31 -0500
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
Subject: [PATCH v5 0/3] arm64: dts: ti: k3-j784s4: Add phase tags marking
Date:   Sat, 12 Aug 2023 00:50:27 +0530
Message-ID: <20230811192030.3480616-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
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

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
This series adds it to Linux to be aligned with bootloader requirement
for TI K3 J784S4 EVM and TI K3 AM69-SK EVM.

This series will be ported to the k3-j784s4 u-boot support patch
series for syncing, and was requested in its review process:
https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/

Bootlog:
https://gist.githubusercontent.com/apurvanandan1997/fe793a7d03e3375af698b20b5bf1c36d/raw/

v5: Changelog:
1) Removed bootph-all from reserved status dts nodes (wkup_uart0)

Link to v4:
https://lore.kernel.org/all/20230811151644.3216621-1-a-nandan@ti.com/

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

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 12 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 24 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    |  2 ++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  9 +++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |  2 ++
 5 files changed, 49 insertions(+)

-- 
2.34.1

