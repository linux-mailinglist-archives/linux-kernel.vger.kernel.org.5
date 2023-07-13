Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3AE75268F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjGMPR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjGMPRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:17:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7C35A2;
        Thu, 13 Jul 2023 08:17:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DFH9iD043736;
        Thu, 13 Jul 2023 10:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689261429;
        bh=ieohx3tLkSrhqFCCmL1fPR3qQcppwtDe4P/IAlqJgKU=;
        h=From:To:CC:Subject:Date;
        b=wCCb5JSmCMQVsv33J0kc8+qIbg7ytAZ7MrxSNTxyjyk1LoN29LDy50k6BvetZxPC9
         AAQLRQKcoMJnXCwsWN2QXPgSHDt4j2PmCWG+hKkEt91dsoGm+8LB6G43LPbR3dR+14
         H3Ix6co3l6e5Lv4k6KHl8w2EQY/4GrfPeLcyJ82c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DFH9LQ028193
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 10:17:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 10:17:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 10:17:08 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DFH76H014048;
        Thu, 13 Jul 2023 10:17:08 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peda@axentia.se>, <rogerq@kernel.org>
CC:     <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 0/2] Deprecate ti-serdes header file
Date:   Thu, 13 Jul 2023 20:47:05 +0530
Message-ID: <20230713151707.8109-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

