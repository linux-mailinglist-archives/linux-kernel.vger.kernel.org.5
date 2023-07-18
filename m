Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5F7573B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGRGLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGRGLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:11:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5DCB5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-668730696a4so3515530b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660671; x=1692252671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbm/PmLqZ2+dwjBfZP2gF/+K4CifkL2BaQdnSKOCCK0=;
        b=BSeGvXzyvC6Njh/qw9ahZNPuM34cQGvUmin8yKRTbj91I7yh3LlIMI6go5S5ZIpnnc
         Ja3acDk5cseN80eW/5ZNMC3mV/cbxkAg2Zhs5GLLYOXCgHluijWVyWQVr80uvMKkVY62
         jm+Sf8ew899PkVv3ChO7gTVCDdEP/y/PMpB9BDMEjtd1VSsyZs4ih8eJRDuiPN7uS/do
         QS1B75/7w5NVkQmEK+erx0Q86bNAK15ud4BeZanqN77vK01ktmAtgtmwQHdbUweAKNXn
         /RrxHKev7Ggxdbt5GfCvQHAq2510HlGVAfFwEqhKY96JXHSC1BUzRmqN17srj0vBmzYn
         p+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660671; x=1692252671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbm/PmLqZ2+dwjBfZP2gF/+K4CifkL2BaQdnSKOCCK0=;
        b=FJPW8mPe+h0KJPIW+6WmxjR5bFeD5Dd5MBqMbXImMhVMqHIWnahrJ8T2OiGEg3ZQxx
         tpNgDFvIZkUJDorlefJnpVIcOS5/5WfLmACzCQi4NccmfJBHGAHEg7vzVOgV4Lu62hTY
         wkhhzlg5HS14NPT3OBxtrMAKKOwYbLfQNcNjF/UEUSIU8ktsUANHUZheGBOAyH5fBsFa
         M7QA0FAEZ6U2+pw4PG6OUuLUkjeuL6ON0OyruIN7Y2nJtAKtB73SgC4T2Ivzig8oFXlt
         nS+I2L4MDprd70kuNlhLiotbkmZuKJMjvtRuVl4qNOvxHL0rLiFKzUWXM9tloYlPPCV4
         AXhg==
X-Gm-Message-State: ABy/qLbnuIebA7gBFbqgun0Yqr5H6+osDS4CQwZzTx5xb5BxBaVxXyIO
        bYJMMV8FHZjoVPyh21IL53TaFw==
X-Google-Smtp-Source: APBJJlEbQa4WJAeV/iDFQ1B93yQ8Ht2+89O3qS43qIRPmQ5VCEHOyV5NYgUMGjTquA9f+29WMDn//Q==
X-Received: by 2002:a05:6a00:22c6:b0:668:69fa:f78f with SMTP id f6-20020a056a0022c600b0066869faf78fmr16312666pfj.1.1689660670763;
        Mon, 17 Jul 2023 23:11:10 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0067db7c32419sm778106pfn.15.2023.07.17.23.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:11:10 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org,
        stephan@gerhold.net
Subject: [PATCH v9 1/7] dt-bindings: mfd: qcom,tcsr: Add the compatible for SM6115
Date:   Tue, 18 Jul 2023 11:40:46 +0530
Message-Id: <20230718061052.1332993-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
References: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the qcom,sm6115-tcsr compatible.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 5ad9d5deaaf8a..b580398041d87 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,sdm845-tcsr
           - qcom,sdx55-tcsr
           - qcom,sdx65-tcsr
+          - qcom,sm6115-tcsr
           - qcom,sm8150-tcsr
           - qcom,sm8450-tcsr
           - qcom,tcsr-apq8064
-- 
2.38.1

