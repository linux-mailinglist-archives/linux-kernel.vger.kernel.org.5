Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6D77690E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjHITrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjHITrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:47:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9510DC;
        Wed,  9 Aug 2023 12:47:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379JkuoG011894;
        Wed, 9 Aug 2023 14:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691610417;
        bh=MsZHTTVuQCUoh95X071bxNmfsKCpVWc+nfv5ohY/Lnk=;
        h=From:Subject:Date:To:CC;
        b=j/zWLdcfj4UR/PzHgbDXX+a09j2JvDjuwJJ5gnLnm4GZ6/cNciWSrFJe0gya6ZsVn
         HUR7xRXSVVRRV4lGqb1Yh0BiGFdmv18tcBtQy24t7VgjbR5P/HzKNtCsNH/MZNoXUC
         BXNuaj6GRex/5tN0OSnDriJv3M3pKuChGguDOkt4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379JkuIB069528
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 14:46:56 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 14:46:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 14:46:55 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Jks8Y065101;
        Wed, 9 Aug 2023 14:46:55 -0500
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v6 0/7] Add TPS6594 PMIC support on several boards
Date:   Thu, 10 Aug 2023 01:16:18 +0530
Message-ID: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAArt02QC/2WOywqDMBQFf0WybuRqzMOu/I/iItFrDaiRJEhF/
 PdGN110OXDOMAcJ6C0G8swO4nGzwbolgXhkpBv18kZq+8SkhJKBgprGNQheVxQrDoZLplAIkta
 rx8F+btOrTTx4N9M4etS/vyxlwaAGlRcguKAFRTPppWuM3idrPOadmy/ZaEN0fr+rNn4p/wM2T
 oFWig896wUTEppo7397nucXjLV4J9gAAAA=
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3820; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=01aLfxD9vioUKGZ7tBuEkxohVI4kIHTM2e1ZUKbBmhA=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk0+0sBLzyGqiUO61Jg6/RXCPB7GlvbJ9dfBPfG
 7vFDotPKICJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNPtLAAKCRBD3pH5JJpx
 RZhpD/987QU6KKvAaHPFSgSbTi++OCq6yF2Pdq/6+41FDJyN50e2VJm6M/kUaU1M+drl9sacQiT
 Si/V7SiGELvVi1DkiReAu6ym1nOOyZEVJsJFR3853w9Q1jkVke8zLts31Ru6RDKYTzDwn5cqa0Z
 E/1AY47uZrEfK5Gdg7dnLPDif7E/y5JMJrcK4PtVvY4yBi8ow8yIYnYyqJn2o9cvALY3q40QXt1
 PRwqgKgKM8D3E5sWmk3IHQUnbkw3BQf4tmvlgyJ7M8REFpjR/3uiSXBPr2zfImqZ10ySQsDLMIy
 tGTi6ETkEAGlwasUe5HaWDO05ouJDoXGMgYEgDh1gphg2sG21bI/1e3NyJk7v8Z0ij0SQtR8XFB
 PVOMkHozHGzgTMPLIeSbf2tzcPYh3WopDt0xVCNoFwFIAmLKojynrGoWTZNAk6mSzSmbkxeELuZ
 SPVDqDZ0mBwvVgZY+tnOAGt8w5qm0sY73y87qt94cGTGn/gKrPZ7drzG+cZAJmFY4En4AzoutAK
 Fo66dqv0LWvAQpehvCMWlr0APgTwwAhtpLdb7pIwfG3xRzCysh6Y4PH7wLtO4m5jD3pH5GF5eiB
 Jpe7SPYWjzpleJxCjG5Q860ITxVsbw8FBfAog1QdFqVUz0qxaNhR1WYG6dv0gAZw0okskeafPTp
 MZ8e7yjVUVBS3ZA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
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

TPS6594 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
communicate through the I2C or SPI interfaces.
TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.

This serie adds device tree nodes for TI TPS6594 PMICs found in the
following boards:
- J721EXSOMXEVM:
  Link: https://www.ti.com/tool/J721EXSOMXEVM
- J721S2XSOMXEVM:
  Link: https://www.ti.com/tool/J721S2XSOMXEVM
- J7200XSOMXEVM:
  Link: https://www.ti.com/tool/J7200XSOMXEVM
- AM62A-SKEVM:
  Link: https://www.ti.com/tool/SK-AM62A-LP
- J784S4XEVM
  Link: https://www.ti.com/tool/J784S4XEVM

---
Changes from v5:
https://lore.kernel.org/all/20230809-tps6594-v5-0-485fd3d63670@ti.com
- Range-diff: http://0x0.st/H_fD.diff
- Reword the patch fixing interrupt ranges for mcu domain gpio intr, and
  add Fixes: tag
- Also fix interrupt ranges for main domain gpio intr in the same patch
- Change pinctrl node names to end in -pins to fix dtbs_check warnings
- (New Patch) Enable TPS6594 in defconfig

Changes from v4:
https://lore.kernel.org/all/20230727130908.10656-1-eblanc@baylibre.com/
- Range-diff: https://0x0.st/H_L7.diff
- Rebased on top of linux-next
- Fix min voltage on vdd_usb_3v3 regulator (ldo2) on j721e-som
- Use 3-hex-digit format for pinctrl values

Changes from v3:
https://lore.kernel.org/all/20230417154832.216774-1-eblanc@baylibre.com/
- Rebased on top of v6.5-rc1.
- Change pinctrl number for irq pin as wkup_pmx0 was split on some boards.
- Use already present wkup_i2c0 node instead of creating a new one.

Changes from v2:
https://lore.kernel.org/lkml/20230414112843.1358067-1-eblanc@baylibre.com/
- Change node name as per Krzysztof review.
- Add a fix for the interrupt range of wakeup gpio used by TPS6594 pmic
  on J784S4.
  The interruptions of the PMIC were not working before that.
- Remove dependencies on other patch series as that was a mistake, see
  https://lore.kernel.org/lkml/CRYY2V3HJ0CP.96JQ18PLZB3C@burritosblues/

Changes from v1:
https://lore.kernel.org/lkml/20230329142948.833800-1-eblanc@baylibre.com/
- Harmonize regulators names across the different boards.
- Adjust AVS voltage range.
- Remove some outdated comments.
- Add PMIC to J784S4 board.
- Compatible string modified to match dt-bindings.
- Add gpio-controller and gpio-cells properties.

---
Apelete Seketeli (1):
      arm64: dts: ti: k3-j784s4: Fix interrupt ranges for wkup & main gpio

Esteban Blanc (2):
      arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
      arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs

Jai Luthra (1):
      arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A

Jerome Neanne (2):
      arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
      arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC

Julien Panis (1):
      arm64: dts: ti: k3-am62a7-sk: Add support for TPS6593 PMIC

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts          |  95 +++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi      | 157 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi      | 163 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi     | 199 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 104 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |   2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi |   2 +-
 arch/arm64/configs/defconfig                     |   1 +
 8 files changed, 721 insertions(+), 2 deletions(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230809-tps6594-e450b5738e66

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

