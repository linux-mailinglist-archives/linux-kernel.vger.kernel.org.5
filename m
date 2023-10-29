Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C408C7DAD90
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjJ2Rs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjJ2Rsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:48:52 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A87D6;
        Sun, 29 Oct 2023 10:48:46 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39T7D340026062;
        Sun, 29 Oct 2023 10:48:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=sbvx86w1d/4xh8rVtCB6CJhT45LBCFOcIMwsxmOtjaw=;
 b=h4SFwCYFsOyxOhPj4NcIutJsEr5Sk4S6FtWiHgWIl/cAIS0vSjnh7yOMeDahS2EWw/XB
 oY40yT8HCY4fNtzFgJdFYxOgLmQnm//pbJB62fDfvixmBra+pP+BkxJp7r0pQAMxxYZF
 ty4+7blItgPan82YfDEnmYAGzJTChPCp1eqCG4tyORFXs7yX90FqcqEwZsf+5utLliWo
 RHxSRh+74YjWZPp++XzoQMlHu6ZYsXsw41BHH8KzufaFiaFkZ45G1HL00Og+v8+hvnEo
 2vah2ZQa3pv5uGeCyJVxnP8shEf2LsfzVw+vczZD74w8yZJEQEWu09mSpohRx6CmfKG5 jg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3u0ynqbqm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 29 Oct 2023 10:48:31 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 29 Oct
 2023 10:48:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 29 Oct 2023 10:48:29 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 4DA0C3F70A0;
        Sun, 29 Oct 2023 10:48:26 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v4 2/3] dt-bindings: arm64: dts: add dt-bindings for Marvell COM Express boards
Date:   Sun, 29 Oct 2023 19:48:13 +0200
Message-ID: <20231029174814.559583-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231029174814.559583-1-enachman@marvell.com>
References: <20231029174814.559583-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R5h-RK8kAZFutVQB-Qu0HCsCwG0c6VI3
X-Proofpoint-GUID: R5h-RK8kAZFutVQB-Qu0HCsCwG0c6VI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-29_06,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add dt bindings for:
CN9130 COM Express CPU module
CN9131 COM Express CPU module
AC5X RD COM Express Type 7 carrier board.
AC5X RD COM Express board with a CN9131 COM Express Type 7 CPU module.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 .../bindings/arm/marvell/armada-7k-8k.yaml        | 15 +++++++++++++++
 .../bindings/arm/marvell/marvell,ac5.yaml         | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 52d78521e412..7e0ac5110eef 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -60,4 +60,19 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description: Armada CN9130 SoC without external CP as COM Express CPU module
+        items:
+          - const: marvell,cn9130-cpu-module
+          - const: marvell,cn9130
+          - const: marvell,armada-ap807-quad
+          - const: marvell,armada-ap807
+
+      - description: Armada CN9131 SoC with one external CP as COM Express CPU module
+        items:
+          - const: marvell,cn9131-cpu-module
+          - const: marvell,cn9131
+          - const: marvell,cn9130
+          - const: marvell,armada-ap807-quad
+          - const: marvell,armada-ap807
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
index 8960fb8b2b2f..734e1716a3e9 100644
--- a/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
@@ -27,6 +27,20 @@ properties:
           - const: marvell,ac5x
           - const: marvell,ac5
 
+      - description: Alleycat5X (98DX35xx) Reference Design as COM Express Carrier
+        items:
+          - enum:
+              - marvell,rd-ac5x-carrier
+          - const: marvell,ac5x
+
+      - description:
+           Alleycat5X (98DX35xx) Reference Design as COM Express Carrier plus
+           Armada CN9131 COM Express CPU module
+        items:
+          - enum:
+              - marvell,rd-ac5x-carrier-with-cn9131
+          - const: marvell,ac5x
+
 additionalProperties: true
 
 ...
-- 
2.25.1

