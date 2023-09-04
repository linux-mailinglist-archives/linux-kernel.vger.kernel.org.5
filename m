Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9AD7910AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351923AbjIDFGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbjIDFGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:06:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB26B109;
        Sun,  3 Sep 2023 22:06:35 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383KqLeD003842;
        Sun, 3 Sep 2023 22:06:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Elk1dRG/E2B2F9ZUpa+arA9I4Rkj60fotSKdV2l7deM=;
 b=dimGgfpAN+elWEJtk/kzlTXXeFijMukOx7YsmsZX6hsCdi2wG+O+16Fg93blVne3pN/c
 4EvPY6l81GxNbfG3GPkorL/B3UW2MYcwmLmbifHBXpAunJ5yFC9p+Zr2LfpXr686jovv
 haEpd3AVrjwGYPw1QxyDHPlMpsW+ZS3UrvYeiZN1y4ZBJ852jM4i8mNHFhs4dD0hAPo+
 Ew1X4Aywb1f9t0nmcqFtXjnzi8xczTyEtMnhkLOw8sYisJ7eWTzXVBNxfJlsR7GOHvx1
 wW5WD7UVn2oDhmehC6/PndU2XUy2VsuSd15F1dMPLxlxsNCd+PgulKG7985i2Ncr/aq9 yQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sv2dp4hqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 22:06:16 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Sep
 2023 22:06:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 3 Sep 2023 22:06:14 -0700
Received: from localhost.localdomain (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id B96013F706B;
        Sun,  3 Sep 2023 22:06:10 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [RFC PATCH v3 1/7] dt-bindings: arm: coresight-tmc: Add "memory-region" property
Date:   Mon, 4 Sep 2023 10:35:41 +0530
Message-ID: <20230904050548.28047-2-lcherian@marvell.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904050548.28047-1-lcherian@marvell.com>
References: <20230904050548.28047-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _EXjN5OSKf4NQKZ-Fz8loGHdgUkmDWMA
X-Proofpoint-GUID: _EXjN5OSKf4NQKZ-Fz8loGHdgUkmDWMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_02,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory-region 0: Reserved trace buffer memory

  TMC ETR: When available, use this reserved memory region for
  trace data capture. Same region is used for trace data
  retention after a panic or watchdog reset.

  TMC ETF: When available, use this reserved memory region for
  trace data retention synced from internal SRAM after a panic or
  watchdog reset.

memory-region 1: Reserved meta data memory

  TMC ETR, ETF: When available, use this memory for register
  snapshot retention synced from hardware registers after a panic
  or watchdog reset.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
index cb8dceaca70e..dce54978554a 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -101,6 +101,17 @@ properties:
           and ETF configurations.
         $ref: /schemas/graph.yaml#/properties/port
 
+   memory-region:
+    items:
+      - description: Reserved trace buffer memory for ETR and ETF sinks.
+        For ETR, this reserved memory region is used for trace data capture.
+        Same region is used for trace data retention as well after a panic
+        or watchdog reset.
+        For ETF, this reserved memory region is used for retention of trace
+        data synced from internal SRAM after a panic or watchdog reset.
+
+      - description: Reserved meta data memory. Used for ETR and ETF sinks.
+
 required:
   - compatible
   - reg
@@ -115,6 +126,8 @@ examples:
     etr@20070000 {
         compatible = "arm,coresight-tmc", "arm,primecell";
         reg = <0x20070000 0x1000>;
+        memory-region = <&etr_trace_mem_reserved>,
+                       <&etr_mdata_mem_reserved>;
 
         clocks = <&oscclk6a>;
         clock-names = "apb_pclk";
-- 
2.41.0

