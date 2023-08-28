Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A178A728
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjH1IGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjH1IF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:05:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A311AA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:05:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401187f8071so17998945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693209920; x=1693814720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ5Oj6dPwAeurm4890sw86MQpHuIzNsi2cFp4x5AjEw=;
        b=Or+X4HqXgab7p8Bc6QU0kgEnAZkyk8YD5tkpmqMVP2bvEoJNWb5li3w/ua17Wa1jd/
         outK8KUi4/EWIH7InY3sIrvRoi2vQUMgwwEjHIbZsjEKHqVMAioGAXIVVXNoBp11B0dp
         iXxRVbAXtdYnPNZFlu9Oe6tuBBZKW0F82AX2W9I2OUoOt2384aTCEAmkxSXVAK1Yqy6A
         4saV/a47fveFBAlMNANN4Xwi93Wli3r1T3QhL6gwkTC8I1QakAb2giP9T3b1Y9omdQBP
         my4CBxpH6LSJp3rYHVtUntPFs9TAExVdAx3pmh94j91d9VDVqaj77usIy1yvs+X439e8
         glrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693209920; x=1693814720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ5Oj6dPwAeurm4890sw86MQpHuIzNsi2cFp4x5AjEw=;
        b=WxU6Erc7In2c9cphDwAA9ry5iqvGJiIjfyOd53HqC13WcFNuVIA3PK3i1OibxQR+bO
         +UJ6tQUPWwscwb2+YpFL4fhIl8f8O3dT6rro9qN+RVZWEggLbNpYyua65FsN+wddAoVa
         LN7XlxqieDMEmmzakv/122agH6lQYY7M7PqHaPDa+kQyEceLErGYOMvf6JXDhuoozWxS
         Kc5FVuiIEsTT9OnpGE4/VS0+WZ7VuBEo4rMxhee8AbpXY7EJrNmu9BCJpkr+ogZKXBb6
         WTOx8FMtbTJIFYH05TENLm88Q0FNB9cyGsYWRHUafxqUOEFxghpyd2S7yfl6GXocuSir
         vytQ==
X-Gm-Message-State: AOJu0YzVpTEpcbHOyTdjSjGvb9Z0r7fvv1+3+ESu6RPClioJgnWnotcf
        Y85KWxFkX6yqNuMaosIXs5HRlc7Jb7V1IrdqJeMs2bLD
X-Google-Smtp-Source: AGHT+IF22r5FjSBxYy8sW/y39UnlaDyM/PsQz1C7ObZ/6JiOQheJ1wW/uoh/KdxajGS0R5jzMnWIYA==
X-Received: by 2002:a7b:c8d0:0:b0:3f6:d90:3db with SMTP id f16-20020a7bc8d0000000b003f60d9003dbmr20239679wml.3.1693209920712;
        Mon, 28 Aug 2023 01:05:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id z16-20020a1c4c10000000b003fa96fe2bd9sm13067035wmf.22.2023.08.28.01.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:05:20 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 28 Aug 2023 10:04:41 +0200
Subject: [PATCH v3 6/6] arm64: dts: qcom: sm8450: add TRNG node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-topic-sm8550-rng-v3-6-7a0678ca7988@linaro.org>
References: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
In-Reply-To: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=826;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dDA/t5wxOksk/sHtfojL7tFaSJFH5RjxPNNhxCh91eY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk7FU5W5EUQDZTjl8yU1azqFvazPRpMFkFH9e8IRbS
 HclK4HWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOxVOQAKCRB33NvayMhJ0RkgEA
 CaTwxgg+dHEFnY+HuVmYb7WoBT39wsJ5v3o0AXAAxGVRImWgWbdsX4dLiBQCXJejUtKQjiT3IQAPag
 mSoDOIXsQLhS/huzsgkNI8IIGKzP/W2iLqdcS/IAnpaURWWlOzYTnHYAkMZasvxXXX6now3DjEZpA7
 izTFclq4PAjDclQmzt+2O3s3Z+Xp5OWMk5zhStDfN67z3woCOg6nXMBM5pvhzAwOHAJdPXONRZ3yJC
 kOtKUHnIC2xiQNxWErPpKKQNYXsY5Jy/2YrgdE3UsdaMwz51nzUgUiZL/MWYx2Fj/CCylL2KxYztyI
 INA21YyjzDmO/QYunse2P+CN3DGqr8UJEEQJEn19FMuzg5oLJxW6J+Jk+UCkjCpv8HvzWi/X7XQjYX
 4p1kG5mtmeQPZnqwPdDt0RZsprTEl7GmscLXNHtRmW4jmZyuBmHwoxRdg4oeJsX8aO5yu9YZkTs6JH
 L0K0Ib1f/m5SFcqWdq4S+EZXDWLrMDBKCWs4Da0EUs7zRHcBVVXSEEh2IHs25vRXBVmJTnLKYvWPmw
 sgcjjQOI1hozD8iwdJCpya2daexh/caJtYiuRimg8+qBAUFuWeac4uCAH34y/wwY2aoPt46aLueGVe
 QQbYd3sJPXLo7nZVwAy15mY2IIet3Vy0h0bS7bJCrrU6/37REr9/IutKXxPA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8450 SoC has a True Random Number Generator, add the node with
the correct compatible set.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 6ae64059cea5..e267c6286b1a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1738,6 +1738,11 @@ spi14: spi@a98000 {
 			};
 		};
 
+		rng: rng@10c3000 {
+			compatible = "qcom,sm8450-trng", "qcom,trng";
+			reg = <0 0x010c3000 0 0x1000>;
+		};
+
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sm8450-pcie0";
 			reg = <0 0x01c00000 0 0x3000>,

-- 
2.34.1

