Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69075634A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjGQMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:53:03 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F70E4C;
        Mon, 17 Jul 2023 05:53:00 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5TpJh020422;
        Mon, 17 Jul 2023 05:52:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=OoOXrpIZdvfkubmPKjeC5jzckUP2dLYGo/Bx/R0iEnw=;
 b=Dpc4oBrlQi8yhw4miIUR8hehxxsy5ZE9L4sFe0zohJk1T1Eitp0KVcl+FG/EcTQ03BL2
 frkKjFcJrSQXHvy9m+3S9vDEzaqHujztQfoGX3YeA9ms3Z7L7uYLES8hKSmdh04ObvJP
 0oC55JBA60xFoy6sbPiFlSqASlmh5MzMayWAZ3FCldd9fO3lwJLjauotvpIk/n7tMKSE
 7FWrip56VwdnW3rxwtXJj5TNdgX7Mt2Tvbc7yvWJPoSXVT0lin72kbHXz0kNIyY4dw6e
 pquB6WR22jLOtsuaeOCEVJbYjRCnvulwAfpG0p2OTBJTZeX4Gu2yDqa67jZ9UEKR9Jdt ow== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx18n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 05:52:52 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 05:52:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 05:52:51 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 21BE53F70A4;
        Mon, 17 Jul 2023 05:52:51 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v4 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Date:   Mon, 17 Jul 2023 05:51:45 -0700
Message-ID: <20230717125146.16791-6-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717125146.16791-1-pmalgujar@marvell.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 55VCfbYEILUdl4A4bFkbZf4rWZbVjvbv
X-Proofpoint-ORIG-GUID: 55VCfbYEILUdl4A4bFkbZf4rWZbVjvbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_10,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayanthi Annadurai <jannadurai@marvell.com>

Add support for SD6 controller on Marvell CN10K series SOCs. The
existing sd4hc is not compatible with the SD6 changes.

Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 52 ++++++++++++++++---
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 6c40611405a08717520f4ce3a78a9cb8dd9aac69..51f44c00a50505684c7c7c49c59c1ebd8d85d5d0 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
+title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
 
 maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
 
 properties:
   compatible:
-    items:
-      - enum:
-          - amd,pensando-elba-sd4hc
-          - microchip,mpfs-sd4hc
-          - socionext,uniphier-sd4hc
-      - const: cdns,sd4hc
+    oneOf:
+      - items:
+          - enum:
+              - amd,pensando-elba-sd4hc
+              - microchip,mpfs-sd4hc
+              - socionext,uniphier-sd4hc
+          - const: cdns,sd4hc
+
+      - items:
+          - const: marvell,cdns-sd6hc
 
   reg:
     minItems: 1
@@ -139,6 +143,40 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,cdns-sd6hc
+
+    then:
+      properties:
+        marvell,iocell-input-delay-ps:
+          description: Delay in ps across the input IO cells
+
+        marvell,iocell-output-delay-ps:
+          description: Delay in ps across the output IO cells
+
+        marvell,delay-element-ps:
+          description: Delay element in ps used for calculating phy timings
+
+        marvell,read-dqs-cmd-delay-ps:
+          description: Command delay used in HS200 tuning
+
+        marvell,tune-val-start-ps:
+          description: Staring value of data delay used in HS200 tuning
+
+        marvell,tune-val-step-ps:
+          description: Incremental value of data delay used in HS200 tuning
+
+      required:
+        - marvell,iocell-input-delay-ps
+        - marvell,iocell-output-delay-ps
+        - marvell,delay-element-ps
+        - marvell,read-dqs-cmd-delay-ps
+        - marvell,tune-val-start-ps
+        - marvell,tune-val-step-ps
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

