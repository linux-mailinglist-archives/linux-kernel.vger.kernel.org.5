Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A857E816C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346047AbjKJS1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbjKJSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:51 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994C2F374;
        Fri, 10 Nov 2023 03:26:16 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAB9rNx015441;
        Fri, 10 Nov 2023 03:26:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=r+UUxKqX+aAcUH0rXOAqYTo4Y49jLfTNWeVCkEMdpjU=;
 b=ANJuNB7ljOk3OmiKk3+FB4059kC6xmakiHCS/BZ6/PupVKuWwgK9rgkZA94Fv7w3u7aO
 T8nxA4BcckwwncTnUuaSDPGswbIjQFZmFTmOCYAUa9y+eDBweQzxBi8qln1IwT75eskV
 Sqq16KmDgCvKfUIYgwP8DKGF4zeyLQoVnwr8LM3xFu4arXPREMKQdqrc8pueupaqvqWG
 nG4WBb6ZRai73pobvcFR7VWzUUgy+vNKrr2+VZLDTYaAoITLxPAH4FZfPEo7KSwlzp6q
 7E2aTOYkA/44pyPECLQ2kZLjJ/xsIkg5y9h89vvBHj1c0aZh3nJSJHv8gMppRLxYJ39v 9A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3u95qatpff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 03:25:59 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 10 Nov
 2023 03:25:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 10 Nov 2023 03:25:57 -0800
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 91C995B6933;
        Fri, 10 Nov 2023 03:25:53 -0800 (PST)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v5 1/7] dt-bindings: arm: coresight-tmc: Add "memory-region" property
Date:   Fri, 10 Nov 2023 16:55:27 +0530
Message-ID: <20231110112533.2499437-2-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110112533.2499437-1-lcherian@marvell.com>
References: <20231110112533.2499437-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k6ujKPaIPoDxZgvJYwSo3dAGPgOIZeY0
X-Proofpoint-GUID: k6ujKPaIPoDxZgvJYwSo3dAGPgOIZeY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Changelog from v4:
* Description is more explicit on the usage of reserved trace buffer
  regions
* Removed "mem" suffix from the memory region names

 .../bindings/arm/arm,coresight-tmc.yaml       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
index cb8dceaca70e..6d266ac0016b 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -101,6 +101,28 @@ properties:
           and ETF configurations.
         $ref: /schemas/graph.yaml#/properties/port
 
+  memory-region:
+    items:
+      - description: Reserved trace buffer memory for ETR and ETF sinks.
+          For ETR, this reserved memory region is used for trace data capture.
+          Same region is used for trace data retention as well after a panic
+          or watchdog reset.
+          This reserved memory region is used as trace buffer or used for trace
+          data retention only if specifically selected by the user in sysfs
+          interface.
+          The default memory usage models for ETR in sysfs/perf modes are
+          otherwise unaltered.
+
+          For ETF, this reserved memory region is used by default for
+          retention of trace data synced from internal SRAM after a panic
+          or watchdog reset.
+      - description: Reserved meta data memory. Used for ETR and ETF sinks
+          for storing metadata.
+  memory-region-names:
+    items:
+      - const: tracedata
+      - const: metadata
+
 required:
   - compatible
   - reg
@@ -115,6 +137,9 @@ examples:
     etr@20070000 {
         compatible = "arm,coresight-tmc", "arm,primecell";
         reg = <0x20070000 0x1000>;
+        memory-region = <&etr_trace_mem_reserved>,
+                       <&etr_mdata_mem_reserved>;
+        memory-region-names = "tracedata", "metadata";
 
         clocks = <&oscclk6a>;
         clock-names = "apb_pclk";
-- 
2.34.1

