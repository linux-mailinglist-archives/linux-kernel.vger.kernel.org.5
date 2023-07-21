Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D835575CC02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjGUPgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjGUPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:36:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2F3AA3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so30871181fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689953780; x=1690558580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2sN1njN3aeHCAhuuWcfUvrdjTvaL2oixQsZ2bpyQ1g=;
        b=nwWa2FU+6xGFTb3c0+5Rw12YB2Orvv6qTfFZI+1rqyCYs0UHMtNYhrd1kVNvf20sQL
         +aTOI9oVRWdgnLBM+PgX31KzW8GwdzgcEgdINEvgc7zVjLfck8nQlnmbHSROPhTXz96S
         BcMgpaPvOuyBeTdfmRtPvsDARzSPNSeTnQ0PSQS64nB9fJGyrFdX5OVM5/53n/ylX7fO
         hwKnFylzoklJu5Ge0CTpmbSmsVqRotjye4r5mXDdq4CJWwGuntiZouKbzFrqclu3mh+d
         G8yPSxe/FPLyfGRkWgRDdRGlSBLBu6A8KuOlCHHWKDFbkiv1P6yVvDmVOCdbufE3CXzx
         e/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953780; x=1690558580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2sN1njN3aeHCAhuuWcfUvrdjTvaL2oixQsZ2bpyQ1g=;
        b=kJZnSlfRaQN/4kIFWTf389s/RX6sjMNWf3nEX8qzR6zTMRJDAve65tUyTdglHqn74G
         H/xACeUcSJ6EQWhiRIh6/pqs9qH7LcC6jjGdBfFR8/G7bvOtz7Q3KhvpiaxNQkLuB4Xq
         09ahqGoXw2+lHrBeduxo8PsDp/I7Aysvrz2L67M3xDmTGHQTrxq75pXb3SB3Fitx2mjN
         7l43CMq7Apg9rvKnOAV7VWvboR/Gbdnx6992qF+v5MBBEXk17UfWm2pCZJf6x7JnXvzq
         us+MSEAEcm0v4CFXPiVaI7fa1rJAUgbm8TTtLpIkTGaI4BHLZBIYm2veekNUOAgPPm4T
         IYmA==
X-Gm-Message-State: ABy/qLZSR2pkEeh+d5nYsEqzalLFbHixlHcdVI1JSOOIFU8FWohUmBiG
        MOZsbndfaS4/jGETPtHkcd79pw==
X-Google-Smtp-Source: APBJJlG3j+ZtgxMplO7elJH3Ooo3khnM26eg1JS5adtIIzCxNqnkQ8D3XCNduTmHk6RRLjoJta5Oow==
X-Received: by 2002:a05:6512:542:b0:4fb:a0f5:d88d with SMTP id h2-20020a056512054200b004fba0f5d88dmr1448884lfl.42.1689953779916;
        Fri, 21 Jul 2023 08:36:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fba1278e6dsm782535lfc.107.2023.07.21.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:36:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 17:36:09 +0200
Subject: [PATCH 06/11] dt-bindings: remoteproc: qcom,adsp: Remove AGGRE2
 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v1-6-cf6cd5c621d5@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689953767; l=926;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=L25Raewd+bgyg8nTW2NMSC0ps463tC/549ws6HCFPTc=;
 b=0HK9G06u6teuw92h8C3XGl3h5n6kyB7MQf/OmcF0h/Z/U9wvqekT9QS+HVI6yorSL5dKuRvsO
 trc0ucmNv7gCj4PY4L+1ekZFitQD63iNCSEqxRxirHFJ7y3NONVTzor
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
within the interconnect driver. Attaching it to SLPI was a total hack.
Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index a2b0079de039..af78f76734db 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -91,11 +91,9 @@ allOf:
         clocks:
           items:
             - description: XO clock
-            - description: AGGRE2 clock
         clock-names:
           items:
             - const: xo
-            - const: aggre2
 
   - if:
       properties:

-- 
2.41.0

