Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B0768738
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjG3S4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjG3S4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:56:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3910F5;
        Sun, 30 Jul 2023 11:56:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36UIuAst001274;
        Sun, 30 Jul 2023 13:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690743370;
        bh=yG/C1vbEErBlqYLn5hHGKIm0ols70MLrcZtSkgmvJic=;
        h=From:Subject:Date:To:CC;
        b=ZCttN7hdARyCLRCqFTy1CyIY73o2EWl9QxW8BVe1DppRtKQZFAwsAp/3Z/D2amwYX
         QG+e08SOw9DF6b7uBrx6ox0Fxmu0A/f7GB1nniBgovWa86mc2qDQmH2h2E18gTjOBu
         lNJ/Dbk8TJEeONFZX1g3Zi6MFloC/ADGqc9xbM3I=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36UIuA6L124302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Jul 2023 13:56:10 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Jul 2023 13:56:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Jul 2023 13:56:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36UIu9Zg015546;
        Sun, 30 Jul 2023 13:56:10 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH 0/5] Add support for Texas Instruments MCRC64 engine
Date:   Mon, 31 Jul 2023 00:25:53 +0530
Message-ID: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmyxmQC/x2NywqDQAwAf0VyNuCDsthfEQ/ZNNUcdiuJloL47
 649DsMwB7iYisOzOsDkq66fXKCtK+CF8iyor8LQNV3fhHbAxMa4r76ZUMJAMlB4MMU+QGkiuWA
 0yrzcVSLfxG6xmrz19x+N03leeUoT6XgAAAA=
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690743368; l=1888;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=6RXzhJuPKeQVT8yLoZOXGWG94dhuDQSE8rTpk961348=;
 b=jwvxNJyk0a+aMYzVanzcXvyehNYsQJdWePIz/+o/sCCT/07HIFTvMa3m8AQqkwx6Yyfvpzk1e
 DQ+nUXijCgADfC/XP1BL70vN4fklgYGgaJYGvN1tyJRlThAriGWPSLT
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MCRC64 engine to calculate 64-bit CRC in Full-CPU mode

MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
according to the ISO 3309 standard.

Generator polynomial: x^64 + x^4 + x^3 + x + 1
Polynomial value: 0x000000000000001b

Tested with

and tcrypt,
sudo modprobe tcrypt mode=329 sec=1

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
Kamlesh Gurudasani (5):
      crypto: crc64 - add crc64-iso test vectors
      dt-bindings: crypto: Add binding for TI MCRC64 driver
      crypto: ti - add driver for MCRC64 engine
      arm64: dts: ti: k3-am62: Add dt node, cbass_main ranges for MCRC64
      arm64: defconfig: enable MCRC module

 Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml |  42 +++++++
 MAINTAINERS                                             |   7 ++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                |   7 ++
 arch/arm64/boot/dts/ti/k3-am62.dtsi                     |   1 +
 arch/arm64/configs/defconfig                            |   2 +
 crypto/tcrypt.c                                         |   5 +
 crypto/testmgr.c                                        |   7 ++
 crypto/testmgr.h                                        | 401 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/Kconfig                                  |   1 +
 drivers/crypto/Makefile                                 |   1 +
 drivers/crypto/ti/Kconfig                               |  10 ++
 drivers/crypto/ti/Makefile                              |   2 +
 drivers/crypto/ti/mcrc64.c                              | 360 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 846 insertions(+)
---
base-commit: d7b3af5a77e8d8da28f435f313e069aea5bcf172
change-id: 20230719-mcrc-upstream-7ae9a75cab37

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

