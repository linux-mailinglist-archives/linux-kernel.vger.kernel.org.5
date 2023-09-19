Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8A7A61E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjISMAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:00:05 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC6F3;
        Tue, 19 Sep 2023 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=ffq0+SGQ8MUyYv3w6IpPZxS0q3DMyt6jN+7SxiKE6GE=; b=h4XzlwIRhiYBdzseaguyIujdfD
        W0inlorb+nsWhFe+7Cg7EYSihkirHCVsbkhk9/uVrYbABXUupX2AensJOgWtSTHSdLu0etROnDxwv
        QeVnIrdamJNS1SlXLtdZ5ALZAviHRCN9S045FUopzdbQeH3e/6zAfneYMVvWoNu5SrOI8XQD7SS4l
        MzOZXjjv3Xqod5dA7iDD9sTPvpWn3Qwk4GI7NLHtCQaXXUevsMEgN8C3Ki4CT8R5LardtukmKaHOj
        Apyc+zh3St92vYI1AIomGYUDFk596doTu0GeE9iK3ZVXXTwArwLdvLuZSJokMTwGmGSefG5fp9BF9
        V6VMLpcg==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qiZOV-004b4T-1G;
        Tue, 19 Sep 2023 13:59:55 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 19 Sep 2023 13:59:48 +0200
Subject: [PATCH v2 1/4] spi: dt-bindings: qup: Document power-domains and
 OPP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-spi-qup-dvfs-v2-1-1bac2e9ab8db@kernkonzept.com>
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

Document power-domains and operating-points-v2 to allow making
performance state votes for certain clock frequencies of the SPI QUP
controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

