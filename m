Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2375C739
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGUM5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGUM5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:57:50 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93D1B6;
        Fri, 21 Jul 2023 05:57:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36LCvYQt069924;
        Fri, 21 Jul 2023 07:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689944254;
        bh=uHnG2vKtVO7V5ForUaYJdSepxniJ34aD+IPhCcJjDwQ=;
        h=From:To:CC:Subject:Date;
        b=oI81r8vZhVahAypHDTK2TYWSn4EnpCVpdXszGs2Y8fGJKLomEGRuQSWoJU5jAKS61
         Obat7Ehi6CQRJbIt3eLEwLW/fc3AXsTD9wl8dx5aJJ8ACDc27tS5vOAno2oLy6YbV1
         6Ivig6lrhuO7Y+llpxI8M4fR11NPVyj/7rsGtyPM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36LCvYKR014539
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jul 2023 07:57:34 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jul 2023 07:57:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jul 2023 07:57:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36LCvXaq010973;
        Fri, 21 Jul 2023 07:57:33 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peda@axentia.se>, <rogerq@kernel.org>
CC:     <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 0/2] Deprecate ti-serdes header file
Date:   Fri, 21 Jul 2023 18:27:30 +0530
Message-ID: <20230721125732.122421-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the ti-serdes.h header to arch/arm64/boot/dts/ti/
as these constants do not have driver usage and are not suitable for
bindings as discussed in [1].

Deprecating the bindings header for now instead of dropping them based
on the discussion in [2].
We expect to remove this bindings header in the next cycle.

Changelog v1->v2:
- Fix typo in commit message
- Carry 'Acked-by' and 'Reviewed-by' tags from v1

v1: <https://lore.kernel.org/all/20230713151707.8109-1-j-choudhary@ti.com/>

[1]: <https://lore.kernel.org/all/b24c2124-fe3b-246c-9af9-3ecee9fb32d4@kernel.org/>
[2]: <https://lore.kernel.org/linux-arm-kernel/71c7feff-4189-f12f-7353-bce41a61119d@linaro.org/>

Jayesh Choudhary (2):
  arm64: dts: ti: Use local header for SERDES MUX idle-state values
  dt-bindings: ti-serdes-mux: Deprecate header with constants

 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   3 +-
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |   3 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   3 +-
 .../boot/dts/ti/k3-am68-sk-base-board.dts     |   3 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     |   3 +-
 .../ti/k3-j7200-evm-quad-port-eth-exp.dtso    |   2 +-
 .../ti/k3-j721e-evm-quad-port-eth-exp.dtso    |   2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   3 +-
 .../dts/ti/k3-j721s2-common-proc-board.dts    |   3 +-
 arch/arm64/boot/dts/ti/k3-serdes.h            | 204 ++++++++++++++++++
 include/dt-bindings/mux/ti-serdes.h           |   8 +
 11 files changed, 228 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-serdes.h

-- 
2.25.1

