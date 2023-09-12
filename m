Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C8D79D3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjILObF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbjILOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:30:58 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F77115;
        Tue, 12 Sep 2023 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=rqAqXU+BauAuZhoJ6lkP5DQOkX1bFvCYekVfXB5a7v4=; b=GgHrrHIgtFRan0MheQxCydItfh
        ekI6z8r3PAlYr1ztBSOqu+VTwuTgU30ollUcc+9On7jCN6lrdTW5t+ufWif2ZMJ8cP6YSTcVoHIsy
        /KiNRrW5tQm2JWo029WCYDLPBpSXo+Ag3wS+ouooevmNh/CQ47Kdp1YxIaQKjDv9lodJlnrZJOszc
        K1O9n9nQ38uQTsgi8NcaVIhfE0ow29Yy2nwVqZehpT6rZY3KythGZcAqjjkvtNXnXJD+wWuT9U2Oc
        VcCmXOgOei5oKnn0NGptbKFMRzjiPeq4+Jxu8rt6v20gYhkcref5r4ORCbXiN0HeeqiRzHMed/dfq
        62nNSxxw==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qg4Pj-0034i9-02;
        Tue, 12 Sep 2023 16:30:51 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 12 Sep 2023 16:30:38 +0200
Subject: [PATCH 3/4] spi: dt-bindings: qup: Document interconnects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spi-qup-dvfs-v1-3-3e38aa09c2bd@kernkonzept.com>
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

When the SPI QUP controller is used together with a DMA engine it needs
to vote for the interconnect path to the DRAM. Otherwise it may be
unable to access the memory quickly enough.

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

