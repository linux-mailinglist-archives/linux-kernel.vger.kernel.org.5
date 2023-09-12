Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9D79D3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjILOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjILOaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:30:55 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B952118;
        Tue, 12 Sep 2023 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=e0RspZwtHY4b6xeF+Vsx+c1salPGf7KUDftS+3xrVTM=; b=D8tMDnO24+Gcj2XS/qcJZVEek4
        1iIPIOQy+bYEclNUMc81yKtm0lqpToj0AD/LQp37m33Mk2CtW29mvHO2dd8qrc7/t7qxosfnRZ8R5
        GVmBwHjPVyH4xicTvOmSPU2uO2ZEBjOUmAQvrPpds4HP5LJNPpIOdGUS8NsFKGF/T4CW490t2yrVM
        MLaF2vMCJ9+ZG8V0aaYh4KNLPk8FqKoU2O+H2KbdFse9fpVrb2DBqVjF/lTyQV1PNYFC0gjiOjg9A
        Ge3ArM4LitLiFZzS8o9V5NY80vIodpUW51EW6QlasO0gcjbK4wjMqE/JkqO9yT/mxuNzF44v9rpQA
        e/JUTaJg==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qg4Pf-0034i9-2Z;
        Tue, 12 Sep 2023 16:30:47 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 12 Sep 2023 16:30:36 +0200
Subject: [PATCH 1/4] spi: dt-bindings: qup: Document power-domains and OPP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spi-qup-dvfs-v1-1-3e38aa09c2bd@kernkonzept.com>
References: <20230912-spi-qup-dvfs-v1-0-3e38aa09c2bd@kernkonzept.com>
In-Reply-To: <20230912-spi-qup-dvfs-v1-0-3e38aa09c2bd@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document power-domains and operating-points-v2 to allow making
performance state votes for certain clock frequencies of the SPI QUP
controller.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
index 93f14dd01afc..1e498a791406 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
@@ -47,6 +47,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  operating-points-v2: true
+
+  power-domains:
+    maxItems: 1
+
   reg:
     maxItems: 1
 
@@ -63,6 +68,7 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-msm8996.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
 
     spi@7575000 {
         compatible = "qcom,spi-qup-v2.2.1";
@@ -76,6 +82,8 @@ examples:
         pinctrl-1 = <&blsp1_spi1_sleep>;
         dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
         dma-names = "tx", "rx";
+        power-domains = <&rpmpd MSM8996_VDDCX>;
+        operating-points-v2 = <&spi_opp_table>;
         #address-cells = <1>;
         #size-cells = <0>;
     };

-- 
2.39.2

