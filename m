Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC078D27A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbjH3DTg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 23:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbjH3DS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:18:57 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C31113;
        Tue, 29 Aug 2023 20:18:54 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8C09824E276;
        Wed, 30 Aug 2023 11:18:48 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Aug
 2023 11:18:48 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 30 Aug 2023 11:18:47 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mmc@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
Date:   Wed, 30 Aug 2023 11:18:44 +0800
Message-ID: <20230830031846.127957-2-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830031846.127957-1-william.qiu@starfivetech.com>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the change of tuning implementation, it's no longer necessary to
use the "starfive,sysreg" property in dts, so drop the relevant
description in dt-bindings here.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../bindings/mmc/starfive,jh7110-mmc.yaml         | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
index 51e1b04e799f..10df41941331 100644
--- a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
@@ -36,26 +36,12 @@ properties:
   interrupts:
     maxItems: 1
 
-  starfive,sysreg:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      - items:
-          - description: phandle to System Register Controller syscon node
-          - description: offset of SYS_SYSCONSAIF__SYSCFG register for MMC controller
-          - description: shift of SYS_SYSCONSAIF__SYSCFG register for MMC controller
-          - description: mask of SYS_SYSCONSAIF__SYSCFG register for MMC controller
-    description:
-      Should be four parameters, the phandle to System Register Controller
-      syscon node and the offset/shift/mask of SYS_SYSCONSAIF__SYSCFG register
-      for MMC controller.
-
 required:
   - compatible
   - reg
   - clocks
   - clock-names
   - interrupts
-  - starfive,sysreg
 
 unevaluatedProperties: false
 
@@ -73,5 +59,4 @@ examples:
         fifo-depth = <32>;
         fifo-watermark-aligned;
         data-addr = <0>;
-        starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
     };
-- 
2.34.1

