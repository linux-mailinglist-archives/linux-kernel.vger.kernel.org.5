Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A648877808F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjHJSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjHJSnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:43:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95FD2D48;
        Thu, 10 Aug 2023 11:43:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AIh7Lh121384;
        Thu, 10 Aug 2023 13:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691692987;
        bh=G0sQwM6dKURV5ElKmMGxV8H+lrT0FqqM/cglZetJgX8=;
        h=From:To:Subject:Date;
        b=n5HNcHX58eaUp6AC4wfaFSYofwMXQ7Pn8WTFHUto8zgB3Jk4xcJ0lelY+255uLHSG
         YgcWXXViQW9wghkH9jv+F3ZuS8utylUufMmnRU9wXxwaAKTL7oIzNamPYUHHgAt2Si
         tfKVd/dVV/hxfcmC+SIyPajwseDMHueLwrrdMmNc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AIh7f0031698
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 13:43:07 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 13:43:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 13:43:06 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AIh2Ox025724;
        Thu, 10 Aug 2023 13:43:03 -0500
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
Subject: [PATCH v3 0/3] arm64: dts: ti: k3-j784s4: Add bootph-all property
Date:   Fri, 11 Aug 2023 00:12:59 +0530
Message-ID: <20230810184302.3097829-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all phase tag was added to dt-schema (dtschema/schemas/bootph.yaml)
to overcome u-boot dts challenges.

Add bootph-all property for all the nodes that are used in the SPL stage
along with later boot stages.

This series will be ported to the u-boot k3-j784s4 support patch series
for syncing, and was requested in its review process:
https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/

v3: Changelog:
1) Changed all the bootph-pre-ram to bootph-all, as only
   secure_proxy_mcu and secure_proxy_sa3 are exclusively used by R5 SPL.
   Rest of the nodes are also used by later boot stages.
2) Merged SoC dtsi changes in single patch.
3) Moved cbass_main and cbass_mcu_wkup bootph-all to k3-j784s4.dtsi

Link to v2: 
https://lore.kernel.org/lkml/20230807185645.128751-1-a-nandan@ti.com/#t

v2 Changelog :
1) Added k3-am69-sk.dts bootph-pre-ram patch
2) Added bootph-pre-ram for wkup_pmx0 and ospi0
3) Added bootph-pre-ram for mcu_timer1

Link to v1:
https://lore.kernel.org/linux-arm-kernel/20230806164838.18088-1-a-nandan@ti.com/

Apurva Nandan (3):
  arm64: dts: ti: k3-j784s4: Add bootph-all property
  arm64: dts: ti: k3-j784s4-evm: Add bootph-all property
  arm64: dts: ti: k3-am69-sk: Add bootph-all property

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 13 ++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 25 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    |  2 ++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  9 +++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |  2 ++
 5 files changed, 51 insertions(+)

-- 
2.34.1

