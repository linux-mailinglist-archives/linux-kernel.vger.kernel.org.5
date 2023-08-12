Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E67377A078
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjHLO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbjHLO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:26:47 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30030E6;
        Sat, 12 Aug 2023 07:26:22 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37CCqdNM031533;
        Sat, 12 Aug 2023 07:26:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=QogFfVZHAQnuxdR+2F4BFYMASlnBVZu94YdsQiZp6UA=;
 b=CS5+CwKz2aftnTnRqWLPzcsWevE3C0M8p+gRnkWDJ09UHM0efwL10fXHVh4XsiVzV0GO
 wO6Or8JXbXJXYNXRSrMfrOLlibIXoWdxZaS7KzmMkHEpCHNebfXaekRSOKoFKnx9AxmU
 gRg+KDLkCchRtPNPhvGeysr+v+KOeKCmjSMKHDkIrq5O85oqTnJeHuLqEeBZ2NN1okFn
 WZpOQ4O7deYb1JUjgxtjB+vQkK8jGpQcRAeHjzucqkeqPuk95CC5HuHS9yUjxrYMLD9E
 0h8Ov8U/AklDFLgp0lxmdpBjBHooZ5NXLuBc69fUO8WRpNlL5dH9Wu0CoSfWJT/KqPR3 YA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3se7en0k44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 07:26:13 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 12 Aug
 2023 07:26:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 12 Aug 2023 07:26:12 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 4E11E3F7044;
        Sat, 12 Aug 2023 07:26:08 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v2 6/6] dt-bindings: perf: Add Marvell Odyssey DDR PMU
Date:   Sat, 12 Aug 2023 19:55:18 +0530
Message-ID: <20230812142518.778259-7-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812142518.778259-1-gthiagarajan@marvell.com>
References: <20230812142518.778259-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2Ubumwce-U62qob2Ec_I1EzDdUdQymK3
X-Proofpoint-ORIG-GUID: 2Ubumwce-U62qob2Ec_I1EzDdUdQymK3
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

Add binding documentation for Marvell Odyssey DDR PMU.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---

v1->v2
- No change

 .../devicetree/bindings/perf/marvell-cn10k-ddr.yaml      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
index a18dd0a8c43a..a435cbf4aea0 100644
--- a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
@@ -11,10 +11,15 @@ maintainers:
 
 properties:
   compatible:
-    items:
+    oneOf:
       - enum:
           - marvell,cn10k-ddr-pmu
-
+          - marvell,odyssey-ddr-pmu
+      - items:
+          - enum:
+              - marvell,cn10k-ddr-pmu
+              - marvell,odyssey-ddr-pmu
+          - const: marvell,cn10k-ddr-pmu
   reg:
     maxItems: 1
 
-- 
2.25.1

