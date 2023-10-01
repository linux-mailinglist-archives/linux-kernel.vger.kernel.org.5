Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5527B490C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjJASOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJASOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:14:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F7C6;
        Sun,  1 Oct 2023 11:14:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 391IELYD032646;
        Sun, 1 Oct 2023 13:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696184061;
        bh=O5rdSdlyu4updCwA3s54d2+oQ8P77FGDsfrVMd0oaJc=;
        h=From:To:Subject:Date;
        b=XHuVCaR2C+fLzVKrTQ1+YSQRtBSUiv0A1sToDjAfY6ZfqRRsf08iiMIxvyVokNDUx
         9enLUoEP+mF8LtZAnEkLb1luNquaPNlkRgIa5Ak9mzHogOhGhJDdzxQZX5hXpk2vP7
         tMiIm1HuwkL64gZvHxVjFKk9SbNALP4ZCcc+SahA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 391IELJY004802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 1 Oct 2023 13:14:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Oct 2023 13:14:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Oct 2023 13:14:21 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 391IEHtn063395;
        Sun, 1 Oct 2023 13:14:18 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v5 0/9] Add R5F and C7x DSP node for K3 J721S2, AM68 and AM69 SoCs
Date:   Sun, 1 Oct 2023 23:44:08 +0530
Message-ID: <20231001181417.743306-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series adds the R5F processor nodes and C7x DSP nodes for 
J721S2, AM68 and AM69 SoCs to align these nodes with other K3 SOC's node.

The first three patches adds the remote proc nodes to the SoC device
tree, remaining patches reserves the memory for remote proc IPCs
on K3 J721S2 EVM, AM68 SK, AM69 boards.

Note, K3 AM69 SoC derives from K3 J784S4 SoC, but is included in this
series as it was originally missed in the K3 J784S4 EVM rproc series.
(https://lore.kernel.org/all/20230502231527.25879-4-hnagalla@ti.com/).

kpv log: https://gist.githubusercontent.com/apurvanandan1997/57fcf127c118a48bd174ce36d8840329/raw/
Test log: https://gist.githubusercontent.com/apurvanandan1997/556b4148651ae74b50dda993ad07f1e5/raw/

v5: Changelog:
1) Rebased patches on top of next-20230929 tag, no other change

Link to v4:
https://lore.kernel.org/linux-arm-kernel/20230906112422.2846151-1-a-nandan@ti.com/

v4: Changelog:
1) Added R5F and C7x nodes for K3 AM68 and AM69 SoCs

Link to v3:
https://lore.kernel.org/linux-arm-kernel/20230811202252.3586926-1-a-nandan@ti.com/

v3: Changelog:
1) Disabled c7x in k3-j721s2-main.dtsi and enabled in k3-j721s2-som-p0.dtsi
   which fixes the following dtbs_check for k3-am69-sk.dts
   - dsp@64800000: 'mboxes' is a required property
   - dsp@64800000: 'memory-region' is a required property
2) Split into separate patches for C7x and R5F

Link to v2:
https://lore.kernel.org/lkml/20230808201842.292911-1-a-nandan@ti.com/

v2:Changelog:
1) Added status = "disabled"; in soc dtsi files, and removed it from som dts
2) Fixed mboxes property in for all cores in som dts

Link to v1:
https://lore.kernel.org/all/20230529220941.10801-1-hnagalla@ti.com/

Apurva Nandan (9):
  arm64: dts: ti: k3-j721s2-mcu: Add MCU R5F cluster nodes
  arm64: dts: ti: k3-j721s2-main: Add MAIN R5F remote processsor nodes
  arm64: dts: ti: k3-j721s2-main: Add C7x remote processsor nodes
  arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
    R5F
  arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
    C71x DSPs
  arm64: dts : ti: k3-am68-sk-som: Add DDR carveout memory nodes for R5F
  arm64: dts : ti: k3-am68-sk-som: Add DDR carveout memory nodes for
    C71x DSP
  arm64: dts : ti: k3-am69-sk: Add DDR carveout memory nodes for R5F
  arm64: dts : ti: k3-am69-sk: Add DDR carveout memory nodes for C71x
    DSP

 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    | 208 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 304 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 106 ++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 +++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 208 ++++++++++++
 5 files changed, 866 insertions(+)

-- 
2.34.1

