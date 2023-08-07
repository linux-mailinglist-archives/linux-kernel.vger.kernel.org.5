Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702C9772E4D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjHGS5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjHGS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:57:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE0010F6;
        Mon,  7 Aug 2023 11:56:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377IuooQ030792;
        Mon, 7 Aug 2023 13:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691434610;
        bh=SvAcfAcU5HvbGLrDuMxEWi68zb9byF424ZQoyjVoNmw=;
        h=From:To:Subject:Date;
        b=bXP+NvxWyxkTDWT/YIPZfvRT4Yy3laCmgc0HCBVfkbFf7y+ji9+Nqe2FK+5VCmWY2
         BcRYRUibdKYJ/lgJF6sjNTwgjbGbB7EO/iTSC7Izm7bJ72yTxSXLXPY8ySC7WiqL6I
         crgRhjzHAx2x5C4Yv3HepiFJQlQN9oUIak4C/iHk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377IuoIl027171
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 13:56:50 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 13:56:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 13:56:49 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377Iuj1q013364;
        Mon, 7 Aug 2023 13:56:46 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
Subject: [PATCH v2 0/4] arm64: dts: ti: k3-j784s4: Add bootph-pre-ram property for SPL nodes
Date:   Tue, 8 Aug 2023 00:26:41 +0530
Message-ID: <20230807185645.128751-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bootph-pre-ram property for all the nodes used in SPL stage,
for syncing it later to u-boot j784s4 dts.

This series will be ported to the u-boot k3-j784s4 support patch series,
and was requested in its review process:
https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/

Changelog:
1) Added k3-am69-sk.dts bootph-pre-ram patch
2) Added bootph-pre-ram for wkup_pmx0 and ospi0
3) Added bootph-pre-ram for mcu_timer1

Link to v1: https://lore.kernel.org/linux-arm-kernel/20230806164838.18088-1-a-nandan@ti.com/

Apurva Nandan (4):
  arm64: dts: ti: k3-j784s4-main: Add bootph-pre-ram property for SPL
    nodes
  arm64: dts: ti: k3-j784s4-mcu-wakeup: Add bootph-pre-ram property for
    SPL nodes
  arm64: dts: ti: k3-j784s4-evm: Add bootph-pre-ram property for SPL
    nodes
  arm64: dts: ti: k3-am69-sk: Add bootph-pre-ram property for SPL nodes

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 13 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 25 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    |  3 +++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 10 ++++++++
 4 files changed, 51 insertions(+)

-- 
2.34.1

