Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1679748C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjIGPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245286AbjIGPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77080199;
        Thu,  7 Sep 2023 08:35:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387BqJWF004563;
        Thu, 7 Sep 2023 06:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694087539;
        bh=IO+EiaM/KzCqzBhmkaLxSaswATr0Orw1HE13RRPlyto=;
        h=From:To:CC:Subject:Date;
        b=WLBuwTM6lY87ISzB95yWxppyD99wQl2UmrgzOrVPjssYutcgwTSRNd9J8kZr4EPi9
         2qrqxBZ6JUALzTlh9yQdaLt5bQ3p494rZqkDonNZ9BAfwLep1EPzXoPGerQey4JzPo
         5nJtMpv4XaTMA2Ow8wA9AXOnocrtg3CPb+35Op4E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387BqJDY078457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Sep 2023 06:52:19 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 06:52:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 06:52:19 -0500
Received: from localhost.localdomain (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387BqFVe129423;
        Thu, 7 Sep 2023 06:52:16 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <rzysztof.kozlowski+dt@linaro.org>
CC:     <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7]arm64: ti: k3-j7: Add the ESM & main domain watchdog nodes
Date:   Thu, 7 Sep 2023 17:22:03 +0530
Message-ID: <20230907115210.28082-1-j-keerthy@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 188 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  32 +++
 5 files changed, 352 insertions(+)

-- 
2.17.1

