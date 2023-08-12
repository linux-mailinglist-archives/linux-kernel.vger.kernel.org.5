Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B377A076
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbjHLO0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjHLO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:26:09 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455ED1FE5;
        Sat, 12 Aug 2023 07:26:08 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37CDuZiN015003;
        Sat, 12 Aug 2023 07:26:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Cp4w+jIBE4OGfvuXjDQNp9YPcLqLe9JIVtLeGphlHAY=;
 b=SwVFWg2ZxfdZnVBDsVKmvgxikC36bddO0/U/TQ2J+rwGYUIIiZtrf+MXXZnfsXRazzks
 DtbMaKQozMMAwQ2dnS60OBSwPagHAUPUbbjRSPPraezdK1hZ0DZOj654NUVNaetf5C7g
 iubrELJxXFoZjMW2qhO0enpRoTpG7gdS2BJoLgKBF5SZWSvfFmMZCBLQyPlzhW/vtqH5
 d7XTCXWu6zWm5rK6Wcl6g/nv5sFVcW3ELytrP3oT95vep7zVaH7alZqvAzFgYFr6Lth0
 Pi+nWutlVoBtWnaDI3EuEHca42RqoZhX3/prfNbj+EbbRN40zicbMythgi8vZO3B4JpA fQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kj09d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 07:26:00 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 12 Aug
 2023 07:25:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 12 Aug 2023 07:25:57 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 074A43F7041;
        Sat, 12 Aug 2023 07:25:53 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v2 4/6] dt-bindings: perf: Add Marvell Odyssey LLC-TAD pmu
Date:   Sat, 12 Aug 2023 19:55:16 +0530
Message-ID: <20230812142518.778259-5-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812142518.778259-1-gthiagarajan@marvell.com>
References: <20230812142518.778259-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xlue4Tfpag-saTc5X1piSGALROoaBXFw
X-Proofpoint-ORIG-GUID: xlue4Tfpag-saTc5X1piSGALROoaBXFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_14,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Marvell Odyssey LLC-TAD performance
monitor unit

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---

v1->v2
- Changed DT binding file name to match with compatible
- Added respective document in MAINTAINERS

 .../perf/marvell,odyssey-tad-pmu.yaml         | 63 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml b/Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml
new file mode 100644
index 000000000000..a1b9ee71e5f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/marvell,odyssey-tad-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Odyssey LLC-TAD performance monitor
+
+maintainers:
+  - Gowthami Thiagarajan <gthiagarajan@marvell.com>
+
+description: |
+  The Tag-and-Data units (TADs) maintain coherence and contain CN10K
+  shared on-chip last level cache (LLC). The tad pmu measures the
+  performance of last-level cache. Each tad pmu supports up to eight
+  counters.
+
+  The DT setup comprises of number of tad blocks, the sizes of pmu
+  regions, tad blocks and overall base address of the HW.
+
+properties:
+  compatible:
+    const: marvell,odyssey-tad-pmu
+
+  reg:
+    maxItems: 1
+
+  marvell,tad-cnt:
+    description: specifies the number of tads on the soc
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  marvell,tad-page-size:
+    description: specifies the size of each tad page
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  marvell,tad-pmu-page-size:
+    description: specifies the size of page that the pmu uses
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - marvell,tad-cnt
+  - marvell,tad-page-size
+  - marvell,tad-pmu-page-size
+
+additionalProperties: false
+
+examples:
+  - |
+
+    tad {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@87e22b030000 {
+            compatible = "marvell,odyssey-tad-pmu";
+            reg = <0x87e2 0x2b030000 0x0 0x1000>;
+            marvell,tad-cnt = <1>;
+            marvell,tad-page-size = <0x1000>;
+            marvell,tad-pmu-page-size = <0x1000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 70d2971b93d4..b9da1affe8b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12591,6 +12591,7 @@ M:	Bharat Bhushan <bbhushan2@marvell.com>
 M:	Linu Cherian <lcherian@marvell.com>
 M:	George Cherian <gcherian@marvell.com>
 S:	Supported
+F:	Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml
 F:	drivers/perf/marvell_odyssey_tad_pmu.c
 
 MARVELL PRESTERA ETHERNET SWITCH DRIVER
-- 
2.25.1

