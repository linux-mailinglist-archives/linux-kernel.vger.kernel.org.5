Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492497AF88B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjI0DSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjI0DQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:16:10 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C37AB5;
        Tue, 26 Sep 2023 19:37:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R2bPGv077217;
        Tue, 26 Sep 2023 21:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695782245;
        bh=sPJt3MUTlgOOgPHKnn2aRSLK4Mi2e6bKlpQe+aRuLho=;
        h=From:To:CC:Subject:Date;
        b=G2ZWmFioECIUZxVtF+bgObF0UZa0sNDb0PuqzNpWFs+/nIEHbh9OwJrbGIxtmOAaD
         RRWJ7ofL/+zIRkn4tyrrtneNhinPvjDE45M3XIa4MINeIjsMe609UXGwhXRfnD+DDL
         BGsp7IZK7v1KCX3ntjR0hem9dL6KQscmflpCawXo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R2bPRe026159
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 21:37:25 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 21:37:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 21:37:25 -0500
Received: from localhost.localdomain (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R2bL7S013228;
        Tue, 26 Sep 2023 21:37:22 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/7] arm64: ti: k3-j7: Add the ESM & main domain watchdog nodes
Date:   Wed, 27 Sep 2023 08:03:50 +0530
Message-ID: <20230927023357.9883-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

The series add the ESM & main domain watchdog nodes for j721s2,
j784s4 SOCs.

Changes in v5/v6:

        * Updated commit log and added comments for MCU & non-A72 watchdog
          instances disabling.

Changes in v4:

        * Added bootph-pre-ram for all the ESM instances needed for SPL.

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
  arm64: dts: ti: k3-j784s4-mcu: Add the mcu domain watchdog instances
  arm64: dts: ti: k3-j721s2-main: Add the main domain watchdog instances
  dts: ti: k3-j712s2-mcu: Add the mcu domain watchdog instances

 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   7 +
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 100 +++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  38 ++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 195 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  38 ++++
 5 files changed, 378 insertions(+)

-- 
2.17.1

