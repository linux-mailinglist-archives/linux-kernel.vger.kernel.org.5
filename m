Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402A67EBEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbjKOIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:52:24 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFB2CF;
        Wed, 15 Nov 2023 00:52:20 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF8q8Uv087284;
        Wed, 15 Nov 2023 02:52:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700038328;
        bh=/T2qgOykdX69s4aGpFDNh54kQideN4c9OJMXqKyBHco=;
        h=From:To:CC:Subject:Date;
        b=Ekqb9nMD/pD/ebBIi/cT0IIEEXACf9ycwUStJE63V12aJOWuuJ90ExEz7fr2yxZHq
         HyBtZ6hnT4kElBnZ1D8xnvcSqhXKJ3YQyA0g/o4C9PNnWw69/ZpB/KsQuErMiDbTkO
         TuKGydltJ+TU3XmIZ0LRrbwhvfkfiSmUr7iDPH+I=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF8q8Sd068908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Nov 2023 02:52:08 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 02:52:07 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 02:52:08 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF8q4lu005114;
        Wed, 15 Nov 2023 02:52:05 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add PCIe Endpoint overlays for J721E and J721S2
Date:   Wed, 15 Nov 2023 14:22:02 +0530
Message-ID: <20231115085204.3578616-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
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

Hello,

This series adds device-tree overlays for enabling PCIe in Endpoint mode
of operation on J721E-EVM and J721S2-EVM.

NOTE: This series is based on linux-next tagged next-20231114.

v1:
https://lore.kernel.org/r/20231020113222.3161829-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased series on linux-next tagged next-20231114.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-j721e-evm: Add overlay for PCIE0 Endpoint Mode
  arm64: dts: ti: k3-j721s2-evm: Add overlay for PCIE1 Endpoint Mode

 arch/arm64/boot/dts/ti/Makefile               |  6 +++
 .../boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso    | 53 +++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso   | 53 +++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso

-- 
2.34.1

