Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A907762F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjHIOsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjHIOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:48:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C7EE;
        Wed,  9 Aug 2023 07:48:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Elofg075440;
        Wed, 9 Aug 2023 09:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691592470;
        bh=+SHZ0VX0A1vTGEOmnxGEV8PwPlcJlstr9CYNQjgVHlo=;
        h=From:Subject:Date:To:CC;
        b=KId+FlEVVeda+0iab/4PfYYevYQGcyuF4uRnhNjItVec1i01smFe0jjGIoMyaq7XN
         Ef6J6NQsLqYxlUvF8KkqgZKkUkHhlZvLVaJ2sHVYqvsWAgKfh+3f5PS6XaFLmwROF1
         ZCYwSLs9VonDaFXOAc02We2ad87HOjU4nveFbTVE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379ElokO007874
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 09:47:50 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 09:47:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 09:47:49 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Elnpq030722;
        Wed, 9 Aug 2023 09:47:49 -0500
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v5 0/6] Add TPS6594 PMIC support on several boards
Date:   Wed, 9 Aug 2023 20:17:01 +0530
Message-ID: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWm02QC/0XMywqDMBCF4VeRWTcyUXPRVd+jdJHYsQY0kYmUF
 vHdG7rp8oP/nAMycaAMQ3UA0yvkkGKBulQwzi4+SYRHMTTYtGixF/uWteo7QZ1Cr0xrSWso9cY
 0hffv6XYvnjitYp+Z3H9vGiNb7NHWErXSQgryi4vj1bvPEjxTPaYVzvMLDPXuxpYAAAA=
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3208; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=+yBeGPCgRHTOxvcXV1w59ofL9pfCazzAWDH5U/EyBJg=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk06cUHzDdNpGGesOZmmc+YMSKrtriwuY+iwprN
 JZdPFrQEmmJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNOnFAAKCRBD3pH5JJpx
 RQkoD/kBqOI8k1ubY4MOTHbqFxe6TN5w+6ZDgk7miguWIbem5eDEhxopCMUCX3GxaE1jt1ME5vD
 YWATBdOBc4DVV3zzHmvKolC8U3Nxv9VdltoJ1nX1gs+yBH+3i3WM5zpV9EO2a3pOXoNMLrWbPf0
 olupwzhMTVA/5AgDJ9mnmvnBbNstM00ili3CHdbMlhnL9DyhCjWw+Ksasps+Wf+SvC339Ey5gZb
 oBmy/Z1wgFn84iZW8Giht97slvZ7tpmEw8nNwwsblzEWynD5hD93K8rG5i85w4/PvE3gvzhP3Av
 3r187bD12TqklmumK1M1I34d+2VbgwjspFxW8lUo5/lxOgzpApi9pf8uasGw/TAIkCXhbJmMpb9
 1Yki594hOoHPeM4keCQxQgdIx73nqyw/hfCbNv7Q5apvljENNvtINcXLd8hMU+ksjoreVsbWWmb
 Q2ebVgMCsoP3GOWMzRA/8WqdaRmRX5Bvd00QCBFfgsqed4FDTXNZssQ52DuK2S3l1ssSAVccMIm
 n1s4UWG1Z6GaZABvjpnxEWg3puIHzCiOhMcwA09d2Ls6ecr6Qz/Glhl0dd3G+JgD4B0OF4U6P1p
 D5K7r4R1Kv5QpuiKiMYqGeQJs5/0SBcYNfxVSlVbsYMil2u6MznvdcId3B1p4BYLNTXOSUAizrE
 rygkfOd3rySWbsg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
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
      arm64: dts: ti: k3-j784s4-evm: Fix interrupt ranges for TPS6594 PMIC

Esteban Blanc (2):
      arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
      arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs

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
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi |   2 +-
 6 files changed, 719 insertions(+), 1 deletion(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230809-tps6594-e450b5738e66

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

