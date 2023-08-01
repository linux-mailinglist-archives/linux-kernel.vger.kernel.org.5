Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94F76A9A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjHAHA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjHAHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:00:49 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF821981;
        Tue,  1 Aug 2023 00:00:39 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37170LVv090573;
        Tue, 1 Aug 2023 02:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690873221;
        bh=zkSU2CtzXmcsgyzTHlJhNRMxm+bLRccuj5fdtTkuvuY=;
        h=From:To:CC:Subject:Date;
        b=YEhTD6l6oXTavED2or1vYA8nLrQiylRZ8/8Vhh6AmXrljittqSKPHtS+UPTDi7sn0
         QjE4+rflzSJMfo/Kn4uhedVHOc7y4sXOJVgI5bdLUANQEuhko4Tge4f4U5sbhWHDV1
         3CQq6xeZ3t174+7acvQEnpI1bm4rfXlmwxJdPxEk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37170LTW126183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 02:00:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 02:00:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 02:00:20 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37170K4F047974;
        Tue, 1 Aug 2023 02:00:20 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>, <a-bhatia1@ti.com>,
        <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v8 0/5] Enable Display for J784S4 and AM69-SK platform
Date:   Tue, 1 Aug 2023 12:30:14 +0530
Message-ID: <20230801070019.219660-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for:
- DisplayPort for J784S4-EVM
- Displayport and HDMI for AM69-SK platform

Changelog v7->v8:
- rebase on tag next-20230731
- add AM69 display support
- fix commit heading for patch [2/5]

Changelog v6->v7:
- change compatible for scm_conf to 'simple-bus'
- drop main_cpsw node due to driver dependency on [2]

Changelog v5->v6:
- Change header file according to [1].
- Add idle-state property in serdes_ln_ctrl node.
- Fix dtbs_check warning due to clock-frequency property in serdes_refclk
  node by disabling the node in main.dtsi and enabling it in board file
  when the clock-frequency node is actually added.

Changelog v4->v5:
- rebased the patches on linux-next tip.

Changelog v3->v4:
- add reg property to serdes_ln_ctrl and fix the node name again to
  get rid of dtbs_check error.
- reorder reg, reg-names and ranges property for main_cpsw1.
- correct the order for clocks in serdes_wiz nodes to fix dtbs_check
  warnings.
- fix indentation in reg, reg-names and clock property for dss node.
- add comments for the reg type in dss registers.

Changelog v3->v2:
- fix dtc warnings for 'scm_conf' and 'serdes_ln_ctrl' nodes
  (Checked all the changes of the series with W=12 option during build)
- added clock-frequency for serdes_refclk along with other EVM changes
  This refclk is being used by all the instances of serdes_wiz which
  are disabled by default. So configuring refclk when the serdes nodes
  are used for the first time is okay.

Changelog v1->v2:
- Moved J784S4 EVM changes together to the last patch
  (Suggested by Andrew)

v7 patch link:
<https://lore.kernel.org/all/20230728050859.7370-1-j-choudhary@ti.com/>

[1]: <https://lore.kernel.org/all/20230721125732.122421-1-j-choudhary@ti.com/>
[2]: <https://lore.kernel.org/all/20230605154153.24025-1-afd@ti.com/>

Dasnavis Sabiya (1):
  arm64: dts: ti: k3-am69-sk: Add DP and HDMI support

Rahul T R (2):
  arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
  arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane
    mux
  arm64: dts: ti: k3-j784s4-main: Add WIZ and SERDES PHY nodes

 arch/arm64/boot/dts/ti/k3-am69-sk.dts      | 237 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 117 +++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 285 +++++++++++++++++++++
 3 files changed, 639 insertions(+)

-- 
2.25.1

