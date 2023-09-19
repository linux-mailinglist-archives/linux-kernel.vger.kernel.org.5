Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3691A7A61E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjISMAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjISMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:00:07 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A23F4;
        Tue, 19 Sep 2023 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=UFT/kNZvjITibF9Ff1wzT/ZwHXknsQ9chPcc6jD+0QE=; b=G+bxTuqmExwrQpdM49OLK/Ndyz
        TuRMp1GDp4s7+GmK/4tta+YNWsJn/ttbIoouCGf5KPpNeZxAYBzzebBAhIvPe1wTtZHiVOC9Z0CnT
        NByoiuEpEOG388I1ZUW/QINNh6No9njhSH9uHtYRORenz7fmKoIR9qNHGSEJ0nP/0SEejSpi5dfUZ
        ztbCGiWrN5KMyL3/3SGMGrBd3jfpESCkRhH1AaG3PJw9QLuSfG+mB4Y54LqdDnSoki/KDn0iAzke+
        pFGHQw1fl/jBef+cNbMg0YSV9jxeR6Yk0XvbqujvNqdCzEEclKLen3IEbwqqUTmA5txG/jqGKPQqs
        r1LaEQrA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qiZOY-004b4T-11;
        Tue, 19 Sep 2023 13:59:58 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 19 Sep 2023 13:59:50 +0200
Subject: [PATCH v2 3/4] spi: dt-bindings: qup: Document interconnects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-spi-qup-dvfs-v2-3-1bac2e9ab8db@kernkonzept.com>
References: <20230919-spi-qup-dvfs-v2-0-1bac2e9ab8db@kernkonzept.com>
In-Reply-To: <20230919-spi-qup-dvfs-v2-0-1bac2e9ab8db@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the SPI QUP controller is used together with a DMA engine it needs
to vote for the interconnect path to the DRAM. Otherwise it may be
unable to access the memory quickly enough.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
index 1e498a791406..88be13268962 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
@@ -44,6 +44,9 @@ properties:
       - const: tx
       - const: rx
 
+  interconnects:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
@@ -67,6 +70,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-msm8996.h>
+    #include <dt-bindings/interconnect/qcom,msm8996.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/qcom-rpmpd.h>
 
@@ -84,6 +88,7 @@ examples:
         dma-names = "tx", "rx";
         power-domains = <&rpmpd MSM8996_VDDCX>;
         operating-points-v2 = <&spi_opp_table>;
+        interconnects = <&pnoc MASTER_BLSP_1 &bimc SLAVE_EBI_CH0>;
         #address-cells = <1>;
         #size-cells = <0>;
     };

-- 
2.39.2

