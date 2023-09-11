Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BEC79B208
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbjIKWVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbjIKMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:03:41 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15679E40;
        Mon, 11 Sep 2023 05:03:36 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38B9SwjJ023349;
        Mon, 11 Sep 2023 14:03:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=fUR1GBMB4mpwmi+3FRdeGu6mwVffrm2wfQk8yZwS44c=; b=GD
        NUBK9e8DxH1QJBCE42dKysP4s+jY4cahrDdKzcvoGgCZfywMgLvgnmmehKUztWrP
        vFo4ICmzAErunN7ZFK2IY1OEsEmUTLGjX9J3ff3hLqsOR4206efsGAq7984wctxD
        HzaZsWRuFQ13oXZ40kj7An0sFbIttGYZscA9U9UKAWN8SJYMD2jkXKNJw92rW5jq
        6QhPaClojT+kgcFcHDknccD51+HKfH2VX/hOayotDYrs8/2iIQ3eRLBV7XEVX4K9
        H+0u7DY9qUfyMHUwENJ9Ur/yiec0Ez2mRZn9hutTNXGk3fiNucWIP2XbirO5V9A6
        x4cRqHLWHNoMfmmADxkg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t0g21yw4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 14:03:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8179100061;
        Mon, 11 Sep 2023 14:03:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9F1D7237D89;
        Mon, 11 Sep 2023 14:03:23 +0200 (CEST)
Received: from localhost (10.201.20.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 14:03:23 +0200
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH v2 07/10] dt-bindings: rng: add st,rng-lock-conf
Date:   Mon, 11 Sep 2023 14:02:00 +0200
Message-ID: <20230911120203.774632-8-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911120203.774632-1-gatien.chevallier@foss.st.com>
References: <20230911120203.774632-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If st,rng-lock-conf is set, the RNG configuration in RNG_CR, RNG_HTCR
and RNG_NSCR will be locked. It is supported starting from the RNG
version present in the STM32MP13

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 .../devicetree/bindings/rng/st,stm32-rng.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml b/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
index 59abdc85a9fb..0055f14a8e3f 100644
--- a/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
@@ -37,6 +37,20 @@ required:
   - reg
   - clocks
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp13-rng
+    then:
+      properties:
+        st,rng-lock-conf:
+          type: boolean
+          description: If set, the RNG configuration in RNG_CR, RNG_HTCR and
+                       RNG_NSCR will be locked.
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

