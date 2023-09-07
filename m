Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477F797F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbjIHALz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjIHALx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:11:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088B1BD3;
        Thu,  7 Sep 2023 17:11:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387BuxjO077127;
        Thu, 7 Sep 2023 06:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694087819;
        bh=ITPajO3rF6JwLUFXYTCRYg+VJ3oXJUj2nhPzmdvLurs=;
        h=From:To:CC:Subject:Date;
        b=Hc6stSkrhOeQ8OzrjdtOuaWqadZtLOla9esUSc2oGbKnoTGkAkmYM27OhfioqNFMQ
         CZW014L8pVoY472nfBzgp0LXqeoWWFAgoB5x0eDzKWRaiSwvEYAmft5FXoGNeoQpwC
         5WU6G8sOAqnaeAPKMCFqnxtHtxiOIuawLNhe6C5U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387Bux4a006622
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Sep 2023 06:56:59 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 06:56:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 06:56:58 -0500
Received: from localhost.localdomain (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387BusmQ005696;
        Thu, 7 Sep 2023 06:56:55 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2 0/7]arm64: ti: k3-j7: Add the ESM & main domain watchdog nodes
Date:   Thu, 7 Sep 2023 17:26:42 +0530
Message-ID: <20230907115649.28289-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

The series add the ESM & main domain watchdog nodes for j721s2,
j784s4 SOCs.
 
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
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 188 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  32 +++
 5 files changed, 352 insertions(+)

-- 
2.17.1

