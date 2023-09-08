Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDE798B00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbjIHQxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245243AbjIHQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:53:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6321FE3;
        Fri,  8 Sep 2023 09:53:10 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 388ABbpt031291;
        Fri, 8 Sep 2023 18:52:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=fUR1GBMB4mpwmi+3FRdeGu6mwVffrm2wfQk8yZwS44c=; b=zH
        SuTrVjupfSPR1rrTeeexVV4I1xpVvSFwf5mrd7LZz5aDXdcZuB6+PdWKQpahCxp4
        DEIzwVNaF1BU8wawwhIUX1X198ZPK11XMc91V7plSMZF6vfCKVWfWuwKaNqjFxuD
        J/lVgrcU+/ky5eihXJUaOqvXlL1e/x+TAAfyMf5OIhcAyFIoduexKub04EoOaAP6
        vUjUbSHIMijRNlKlKphI7x+b/k7i2CVqmj8Nj4CzABk0ywvMXrKflYNGdO9kmT9q
        mZAa9e8gXkpQgasWqfsPvpTe4vokj2yz5z/CoBXtNXzG4pbwiWyXrtBgT4Nqq1gv
        JVHgUbz2EmxQJp1ioHnw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3suvd13wmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 18:52:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2EDE9100056;
        Fri,  8 Sep 2023 18:52:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D94D209EF5;
        Fri,  8 Sep 2023 18:52:44 +0200 (CEST)
Received: from localhost (10.201.20.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 8 Sep
 2023 18:52:43 +0200
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
Subject: [PATCH 07/10] dt-bindings: rng: add st,rng-lock-conf
Date:   Fri, 8 Sep 2023 18:51:17 +0200
Message-ID: <20230908165120.730867-8-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908165120.730867-1-gatien.chevallier@foss.st.com>
References: <20230908165120.730867-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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

