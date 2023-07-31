Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432447696AE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGaMpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjGaMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:45:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2761AD;
        Mon, 31 Jul 2023 05:45:26 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjDYo052721;
        Mon, 31 Jul 2023 07:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690807513;
        bh=Tq9oN5If3f4ihk1CMDcdsYNfktnGDh8v5plLuwzELsw=;
        h=From:Subject:Date:To:CC;
        b=uh66Wu9ZBL7vXWDBgY+3bR98obAISu52RakBq7kTgUzUkLsZQpmo7sGXplcDd3U1Y
         h1TuMH9aIs91+sS5u2R4+m6hZCZU2QHO0y28Q5shj64qgGmePHYQEqNaNdgGfdT0TW
         lhYnsWT1FNQ0RFn2UQRyWs69Dy3JXW8vTDMW+gFM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VCjCUI031450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 07:45:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 07:45:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 07:45:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjBWF053720;
        Mon, 31 Jul 2023 07:45:12 -0500
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 0/5] arm64: ti: Enable audio on AM62A
Date:   Mon, 31 Jul 2023 18:14:37 +0530
Message-ID: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWsx2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc2ND3dzkxOKC+MRcM6NE3cQ0QzMzAzMjkzRLcyWgjoKi1LTMCrBp0bG
 1tQBPXvzAXQAAAA==
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Jm3wva5xU4El5hjjfTCjoTAIbXbh1As2UzqxgDAcTGQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx6zVMytyEghPNsnRYv/b0kbilsM8PP5f6JKPF
 mJp/MvPq/iJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMes1QAKCRBD3pH5JJpx
 RTRLD/9ZKT/g+L/rtI0y49s/h/7+rnHa2ooW1EBtIhyU3eu5+Dmn7vuWfNyJ7O8/HhRUk9gWk9A
 odO6VeqnNAyb1EYzjxxjPSIzemiY1S9VP8gLnSOh9GyinlmKoSIk2xcaQVoQpBPpILk+YhRoIHi
 EwoOxTjiUjbewNefiOkR8r6/4FjnzV/x3Zp4bNpsFVG7OZwEmcfNRiHkXe0+cgdhC1f+gc8jz16
 FzUC87PSSHoltDz7KCJEyS0+W/NrzW+fJ+OQktr5rTOlu9yxuGAjIIvIMlm1qiZk7CmB0brdptY
 +UCCv9zky9i8LzGkKw/GeLzkVzbdn/gCa7DA+S/WwOsdHcOpWfaEC9XUe7w/oP0p8WBVY2T0Gus
 yiC5b2UAGV2n6i1z/cNDHXwHx2XprGm2GPXpMGFXH6Rdu5O0bVNBT7171WexoNRYv+mf7lh0AGF
 nQcpwfyRcBtPqDPJg3yYYCk8joNd57Kp+R0F4dUkH/AhzR0eAVBGOvMZhlwy9hRXLJi30p7pvs7
 TncyLT/SZmHn8UG6EbTWmOyUZh0LRecLcVPHlhnFd5ib3jJ7/LrNAyhuQJMlypV/FRcjq0G5wHR
 4X/q60n1iyhT2znSmKUwpMXOu+9UBDN0qaX4IbXtixPxnQ1Q7uupDNFUitBuh42haIWkkhnWOWf
 RMJEkm25n0BCaWQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
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

This patch series adds support for audio via headphone jack on
SK-AM62A-LP. The jack is wired to TLV320AIC3106 (codec), which is
connected to McASP1 (serializer) on the SoC.

The TRRS 3.5mm jack can be used for simultaneous playback and recording.

The series depends on PMIC support:
https://lore.kernel.org/all/20230727130908.10656-1-eblanc@baylibre.com/

Some of the patches have been posted (and reviewed) before as part of a
combined audio series (v9) for AM62 & AM62A:
https://lore.kernel.org/all/20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com/

Changes since v9 of last series:
- Use DVDD (1.8V) supply from TPS6594 PMIC
- Drop OCMV configuration as DVDD is present now
- Lower i2c-1 rate to 100Khz after testing on multiple boards
- Enable PMIC drivers (as modules) in defconfig

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Jai Luthra (5):
      arm64: dts: ti: k3-am62a-main: Add nodes for McASP
      arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
      arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz
      arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
      arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 60 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   | 94 ++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig              |  1 +
 3 files changed, 152 insertions(+), 3 deletions(-)
---
base-commit: 46540e8a21d310a458d28fcb77f3e4276e3c8a9c
change-id: 20230731-mcasp_am62a-af1660624f97

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

