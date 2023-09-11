Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E0679A249
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjIKEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjIKEKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:10:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A2FE;
        Sun, 10 Sep 2023 21:10:11 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38B49qko130036;
        Sun, 10 Sep 2023 23:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694405392;
        bh=xYMZqVmXyMNYdMNFe+6ehAb2H/sTtPMLrnITxf0FCvY=;
        h=From:To:CC:Subject:Date;
        b=jGpS0hiro3dT0+MCTxsUhImbolKNGNa6avME66SQO5l/n9pHrxIGlFNOp8MzUVKYV
         AsCaXgihVfJekGVBRhAqITBWNv0J0U6ntNmcvcgRrXuFXAQMZpBrVhVobyHxoTUk3a
         zlwqrYdtBaFWrDm5WHSIRo8S9sfIUz6T5jheNHNk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38B49qTp040480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Sep 2023 23:09:52 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Sep 2023 23:09:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Sep 2023 23:09:51 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38B49mJt094719;
        Sun, 10 Sep 2023 23:09:48 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] arm64: ti: k3-j7: Add the ESM & main domain watchdog nodes
Date:   Mon, 11 Sep 2023 09:39:35 +0530
Message-ID: <20230911040942.31031-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series add the ESM & main domain watchdog nodes for j721s2,
j784s4 SOCs.

Changes in v3:

	* Added all the RTI events for MAIN_ESM for j784s4 as 8 instances
	  are enabled.
	* Rebased on top of 6.6-rc1
	* Tested for the watchdog reset

RESEND series - corrected krzysztof.kozlowski+dt@linaro.org ID

Changes in v2:

        * Added all the instances of watchdog on j784s4/j721s2
        * Fixed all 0x0 in dts to 0x00
        * Fixed couple of ESM event numbers for j721s2
        * Rebased to linux-next branch 

Keerthy (7):
  arm64: dts: ti: k3-j721s2: Add ESM instances
  arm64: dts: ti: k3-j784s4: Add ESM instances
  arm64: dts: ti: k3-j7200: Add MCU domain ESM instance
  arm64: dts: ti: k3-j784s4-main: Add the main domain watchdog instances
  arm64: dts: ti: k3-j784s4-mcu: Add the main domain watchdog instances
  arm64: dts: ti: k3-j721s2-main: Add the main domain watchdog instances
  arm64: dts: ti: k3-j721s2-mcu: Add the main domain watchdog instances

 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   6 +
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  94 +++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  32 +++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 189 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  32 +++
 5 files changed, 353 insertions(+)

-- 
2.17.1

