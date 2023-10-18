Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FCD7CE81D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjJRTtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjJRTs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:48:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A280137
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:48:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IJmfjF027677;
        Wed, 18 Oct 2023 14:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697658521;
        bh=9SzxN7z0AOMmNH0NcVN1MDiPlUK8hsEDDqyajJ33Ts4=;
        h=From:To:CC:Subject:Date;
        b=Ik7puBL+BHp7w//dC1v4AW8GsVABVF4VVAXswna06nDmWzMak3E+U+MHfl4tJAzW+
         EnOqW8Bn+Q/qbSqxQkzh2TTeIvcNobXFMOGuu21nrDBiWMoivvDVSAyZNKzteZv1QN
         NZ6gQ02tKUQz4XKvcP9/E/Frwhkqv3rVCV60QiqA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IJmfvU121447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 14:48:41 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 14:48:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 14:48:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IJmfZT034711;
        Wed, 18 Oct 2023 14:48:41 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: enable more peripherals
Date:   Wed, 18 Oct 2023 14:48:37 -0500
Message-ID: <20231018194839.2689377-1-bb@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=bb@ti.com; h=from:subject; bh=xzW0FbaVEenr18ZR6mQVsDnMzOnUH53VOElrveeo2Cw=; b=owNCWmg5MUFZJlNZeOS01AAAZ3///v77n2v//XXNJ40r97d3cxb2/2dt+d97b9+r37r/pe6wA RsrCHqBo0GgPUZDT1AGgNGQANA0AANADE0wjQ0NBkGQAYQAZHqGnqBgNR6gNqHQAaNGgyAD1AAB o0xGTQ0xPTUAaDQND1NA0bSaMjQNAeoNA0B5Q9QA0G1ANBohiYhp6E9TQaNDJoyA0GIyaAyGgaB oAZAMIGTRiMjQGmgNA0ANNAyPUBk0yAJwxVvC1heCwX4oFqOIQ+8Z2S0HZnx26N9osTAWNoH8HA a9VMiz0D9iuluEGvzag48dQO0ZtJmgCDYaFNTkUUZUL5JI+tEqULNm1+OJQ9tGnNFC9a8lWxscN USXNKCg6ZgYZJMh3sxlnHIcoMiRrSqwAXC6UTHAFVuPPYyR55k3BaCBAM0XZak7CKw1p5esBWEW xxw7JsaR2iviedOpg4gRQF5wYotiG0DMcPp5PNdmEFqgGwntfHFleC3IrPhri6nANYxe2KmamwM 9PvKVT5cEkiUt19frlZBzvMpv6kwMMzYulNyieQfmI1rQeoSODZUkEWKssL2csUD93eCZONQNgo Um3aIUEI2Dg+n1cgMxN4VoA13Ste4uwQo26CFFNDACsNoYc1clvw3wO5D5+pVO6gbL+/R8ECePA j07q18UiFNHj/4u5IpwoSDxyWmo
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again everyone!

This series enables most of the similar peripherals already enabled for
the am62xxx extended family of TI's K3 devices for the am62p SoC and the
am62p5 start kit board

Thanks for reviewing
~Bryan

Changes from v1: [0]
- changed main_conf compatible to simple-bus
- moved all bootph-* properties to bottom of list
- used 0x00 in all reg properties
- reserved mcu_esm for MCU firmware use
- added syscon nodes inside wkup_conf

[0] https://lore.kernel.org/all/20231010035903.520635-4-bb@ti.com/

Vignesh Raghavendra (2):
  arm64: dts: ti: k3-am62p: Add nodes for more IPs
  arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi    | 811 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi     | 190 +++++
 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi |  47 ++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi  |  87 +-
 arch/arm64/boot/dts/ti/k3-am62p.dtsi         |   7 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts      | 589 +++++++++++++-
 6 files changed, 1701 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi


base-commit: 56bc311585206a8955de793301d4f84fb4ad2ee6
-- 
2.42.0

