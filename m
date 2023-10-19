Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20627D04DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346677AbjJSWbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbjJSWbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:31:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6921612A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:31:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39JMUvr8054131;
        Thu, 19 Oct 2023 17:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697754658;
        bh=VdXh0Q3nlaaMFcGOy+kwVap9/zRd+TiG88+nvkzXEKk=;
        h=From:To:CC:Subject:Date;
        b=hucnuRkiKrFJR6H5Dpp2nl3XTjK4S9PGCBX9+ERg4/nnEl0fzYBHFA64/u+ub3bFo
         0nfwjRf65bp9fPJfMYmQrxTBlW6NNBB7tr7Ze4NhmsTN4fusimO3d6ngRlSFH6wqA0
         k8tlGsaj5RGasMsNIfMgs0ZCM3SOUgDy2XtfoGG0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39JMUvqn037506
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 17:30:57 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 17:30:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 17:30:56 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39JMUuN5031372;
        Thu, 19 Oct 2023 17:30:56 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 0/2] arm64: dts: ti: enable more peripherals
Date:   Thu, 19 Oct 2023 17:30:56 -0500
Message-ID: <20231019223055.1574125-4-bb@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=bb@ti.com; h=from:subject; bh=CbG6Wyp5u+7iDIEJYxefM6oHrbr5pJFrC5Yal4fnqow=; b=owNCWmg5MUFZJlNZZHoW3wAAaH///vbvf+cvf2+O+uj+Xl9v+fW3738pG2v7X+tv7Ff/m2+wA RmyiHpAADTQNDQ0AAZAaGgAADQGgAyBkA0AaD1ANAyPUD1PUekAybUxPKM0yiANA9IAGmh6gNAD 1GIBk0ZDT1GgaAAAwgwjTJgmRoDRpoaAPSeppoNAaDRhBlPUZNNqaepkaGgBphMgZAAAAxGQaaA DRoyZNDMiZMgAANGRo00DQaAANADBg+vBPYb6Uwhrwi8Dc5pM4XHGKFI7H8QdLoQ5MA++c4G+CK JWCliyjUn07t6/COPOVMzaiDnFV9XLhOCJnnfskoFytoufrYQp5hw3MEFuhcu89/LDAlBAGg0tG JTdfLl88Zd9vGGhlXgNSTI4QBNfFr+kJuK5hvtqqyMcUGqSuIUTyPm7+0ATHi0tKKF2qR3ZqGzS A5qOqDZEYJrjKtWaDVcwukEkyqwNlYuTrlY6gS7CIdF6ND9ojn5eq1u5y0xpDV1rlDKB9Q33v+v aGeg7KHRhVQB8WVbgw/QlaIIbSS35QlinUuOKQ36aFVZcEmmBPSZf0ZRMX0NJ476AoS5D7vowBA AAknvz+XGZtNkyEDPyWKdgYh14woB9gTSMSJkEtkRumHf9Kb6xo8JTjWC2GhMsS2ARLGoyBsO6x RRR4Iv/F3JFOFCQZHoW3w==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes from v2: [1]
- removed USB entirely
- removed efuse MAC address region from CPSW
- renamed main_conf from syscon@ to bus@

Changes from v1: [0]
- changed main_conf compatible to simple-bus
- moved all bootph-* properties to bottom of list
- used 0x00 in all reg properties
- changed wkup_conf compatible to simple-mfd
- reserved mcu_esm for MCU firmware use

[0] https://lore.kernel.org/lkml/20231010035903.520635-4-bb@ti.com/
[1] https://lore.kernel.org/lkml/20231018194839.2689377-1-bb@ti.com/

Vignesh Raghavendra (2):
  arm64: dts: ti: k3-am62p: Add nodes for more IPs
  arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi    | 764 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi     | 190 +++++
 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi |  47 ++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi  |  69 +-
 arch/arm64/boot/dts/ti/k3-am62p.dtsi         |   7 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts      | 520 ++++++++++++-
 6 files changed, 1567 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi


base-commit: 56bc311585206a8955de793301d4f84fb4ad2ee6
-- 
2.42.0

