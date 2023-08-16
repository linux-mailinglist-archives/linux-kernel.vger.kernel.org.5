Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807E677DB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbjHPIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242634AbjHPIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:04:33 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F2D1A8;
        Wed, 16 Aug 2023 01:04:30 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37G83Hw9045140;
        Wed, 16 Aug 2023 16:03:17 +0800 (+08)
        (envelope-from Mingjin.Yang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RQgYv4K8Rz2PrmZp;
        Wed, 16 Aug 2023 16:01:07 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 16 Aug
 2023 16:03:14 +0800
From:   Mingjin Yang <mingjin.yang@unisoc.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <mingjin.yang@unisoc.com>, <magicyangmingjin@gmail.com>,
        <Ling_Ling.Xu@unisoc.com>, <Jinfeng.Lin1@unisoc.com>,
        <Yangbin.Li@unisoc.com>, <Jiansheng.Wu@unisoc.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V0 1/2] dt-bindings: iio: adc: Add support for ump518 pmic adc
Date:   Wed, 16 Aug 2023 16:02:24 +0800
Message-ID: <20230816080225.21482-2-mingjin.yang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230816080225.21482-1-mingjin.yang@unisoc.com>
References: <20230816080225.21482-1-mingjin.yang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 37G83Hw9045140
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ump518 pmic adc description and sample in dt-bindings.

Signed-off-by: Mingjin Yang <mingjin.yang@unisoc.com>
---
 Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
index 8181cf9a8e07..f28d188d83da 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
@@ -21,6 +21,7 @@ properties:
       - sprd,sc2730-adc
       - sprd,sc2731-adc
       - sprd,ump9620-adc
+      - sprd,ump518-adc
 
   reg:
     maxItems: 1
@@ -46,6 +47,7 @@ allOf:
             contains:
               enum:
                 - sprd,ump9620-adc
+                - sprd,ump518-adc
     then:
       properties:
         nvmem-cells:
-- 
2.17.1

