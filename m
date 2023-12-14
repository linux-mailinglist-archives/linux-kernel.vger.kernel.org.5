Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65AA8133E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573637AbjLNPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573619AbjLNPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:05:18 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B4A124;
        Thu, 14 Dec 2023 07:05:24 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9LVwZ002218;
        Thu, 14 Dec 2023 07:04:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=4Vrpl3GKq0ZVGwiSMqAGII/gJtRkuWeqYblf7IvmvjA=; b=RjO
        wJMpSS2S3x9syhPon6RWbnCbMFltFFsQXNj+yVIXlbEVQOfMO7HBfDHjtqXvEYKb
        PRB+d6OpWZy2PM4nTd/SVceKsQhZwv5ez32SgDEk5+cWuK5rMvzD5lSeKqW0Yy2o
        GzqFCP2t/yDv1tK1EapaBrrBg/Cl90KqLKH+86OgsJS1MQuyUAOYZ18vCpt4QixG
        V5AoN+tWnYVXChUprGcymqwavK5msLAG5jTuxYqAFmuL/V1fDCSM8hpN3o3YINPd
        sJ0so/CVjlQznki/uWW3A/KqfaRkoCgadsgyKR80cnJGa1TLIkcIiOhrQJBE3SKH
        4l0gI5O8OZRRYInh8Pg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uyy0m93tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 07:04:27 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Dec
 2023 07:04:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 14 Dec 2023 07:04:25 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 88A283F7074;
        Thu, 14 Dec 2023 07:04:21 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregory.clement@bootlin.com>,
        <chris.packham@alliedtelesis.co.nz>, <andrew@lunn.ch>,
        <fu.wei@linaro.org>, <Suravee.Suthikulpanit@amd.com>,
        <al.stone@linaro.org>, <timur@codeaurora.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 1/3] dt-bindings: watchdog: add Marvell AC5 watchdog
Date:   Thu, 14 Dec 2023 17:04:12 +0200
Message-ID: <20231214150414.1849058-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214150414.1849058-1-enachman@marvell.com>
References: <20231214150414.1849058-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9rMqeby1yL3v-5cQjbDFjlyjx1Mq44Mf
X-Proofpoint-ORIG-GUID: 9rMqeby1yL3v-5cQjbDFjlyjx1Mq44Mf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add definitions and examples for Marvell AC5 variant
of the sbsa watchdog.
Marvell variant requires more memory definitions,
since the initialization is more complex, and involves
several register sets.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 .../bindings/watchdog/arm,sbsa-gwdt.yaml      | 52 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml b/Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml
index aa804f96acba..331e9aa7c2f7 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml
@@ -20,12 +20,17 @@ allOf:
 
 properties:
   compatible:
-    const: arm,sbsa-gwdt
+    enum:
+      - arm,sbsa-gwdt
+      - marvell,ac5-wd
 
   reg:
     items:
       - description: Watchdog control frame
       - description: Refresh frame
+      - description: Marvell CPU control frame
+      - description: Marvell Management frame
+      - description: Marvell reset control unit frame
 
   interrupts:
     description: The Watchdog Signal 0 (WS0) SPI (Shared Peripheral Interrupt)
@@ -39,12 +44,55 @@ required:
 unevaluatedProperties: false
 
 examples:
+  # First example is for generic ARM one
+  # Next examples are for Marvell.
+  # They are organized as three sets:
+  # first set is for global watchdog, then CPU core #0 private watchdog,
+  # and finally CPU core #1 private watchdog
+  # Examples are given for AC5 or Ironman. For AC5X SOC, the last
+  # reg item's low address (0x840F8000) should be replaced with 0x944F8000
   - |
     watchdog@2a440000 {
         compatible = "arm,sbsa-gwdt";
         reg = <0x2a440000 0x1000>,
-              <0x2a450000 0x1000>;
+              <0x2a450000 0x1000>,
+              <0x0 0x0>,
+              <0x0 0x0>,
+              <0x0 0x0>;
         interrupts = <0 27 4>;
         timeout-sec = <30>;
     };
+  - |
+    watchdog@80216000 {
+        compatible = "marvell,ac5-wd";
+        reg = <0x80216000 0x1000>,
+              <0x80215000 0x1000>,
+              <0x80210000 0x1000>,
+              <0x7f900000 0x1000>,
+              <0x840F8000 0x1000>;
+        interrupts = <0 124 4>;
+        timeout-sec = <30>;
+    };
+  - |
+    watchdog@80212000 {
+        compatible = "marvell,ac5-wd";
+        reg = <0x80212000 0x1000>,
+              <0x80211000 0x1000>,
+              <0x80210000 0x1000>,
+              <0x7f900000 0x1000>,
+              <0x840F8000 0x1000>;
+        interrupts = <0 122 4>;
+        timeout-sec = <30>;
+    };
+  - |
+    watchdog@80214000 {
+        compatible = "marvell,ac5-wd";
+        reg = <0x80214000 0x1000>,
+              <0x80213000 0x1000>,
+              <0x80210000 0x1000>,
+              <0x7f900000 0x1000>,
+              <0x840F8000 0x1000>;
+        interrupts = <0 122 4>;
+        timeout-sec = <30>;
+    };
 ...
-- 
2.25.1

