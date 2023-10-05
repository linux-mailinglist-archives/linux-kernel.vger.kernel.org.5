Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336F77BAB5D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjJEUTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjJEUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:19:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE593;
        Thu,  5 Oct 2023 13:19:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3959bftX100014;
        Thu, 5 Oct 2023 04:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696498661;
        bh=pAK+O+fbcaQtTB1xUFodX2LLzg4zDaj/rNS7RTWye+M=;
        h=From:To:CC:Subject:Date;
        b=t7ieV23YDAsOzI7VfVGb6aJFKFjWTCTLDWj0vdqu9VW0vE6NmjjTJt/XJrDzRRYwt
         VvoA43SN6oWw0znWKKK9LQXM87u8OCw5u9OuV8sy52EQ7PVw0toU7LflnNHa5ZkEFc
         UiKHVKK+wVA4CCaa3Q9U15xObMjlH/yf4Yos+H7I=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3959bfGk014575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 04:37:41 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 04:37:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 04:37:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3959bdXu012840;
        Thu, 5 Oct 2023 04:37:40 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <rogerq@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Add support for GPMC NAND
Date:   Thu, 5 Oct 2023 15:07:36 +0530
Message-ID: <20231005093739.4071934-1-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for GPMC NAND on AM62x LP SK
board.

v2: https://lore.kernel.org/all/20231004111238.3968984-1-n-yadav@ti.com/

v1: https://lore.kernel.org/all/20230913114711.2937844-1-n-yadav@ti.com/

Change Log:

V2 -> V3:
 - Add blank line before gpmc0 node in device tree.
 - Document reason to disable gpmc0 & elm0 node by default.
 - Sort GPMC entries in ranges of cbass_main.
 - Update Makefile.

V1 -> V2:
 - Rearrange device tree properties in recommended sequence.
 - Move status property at last place in the node. 
 - Fix commit message and commit descriptions. 

Nitin Yadav (3):
  arm64: dts: ti: Add GPMC support for AM62x LP SK
  arm64: dts: ti: Add overlay for NAND daughter card
  arm64: defconfig: Enable GPMC NAND support

 arch/arm64/boot/dts/ti/Makefile               |   3 +-
 .../arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso | 119 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  30 +++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   2 +
 arch/arm64/configs/defconfig                  |   3 +
 5 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso

-- 
2.25.1

