Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AD7B2AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjI2DoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjI2DoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:44:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC4A19C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:44:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32336a30d18so5648891f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695959048; x=1696563848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0simBD6rQLXMPt0Y2N8ykn3CDbCGOnXOOhhxwHhlQgQ=;
        b=vlmuy9OfsPkqRf0juU4qYOjCb503nz/vO0igEUQ6SL+oPoWXvOpJmZ7Ee2wJLCnPP4
         dyfSgNSG/01Jlu+px0P0xHFepjgPOws0RFfDgLlzPtA0iXHmogTnkW4QisGzqUsQ1jG7
         pIfCedgZ23tvLsDwsGGj/47uaVV5tjayj6UqRXSYOwFIn2hwdvORoU/k7vOrnf+zTwfJ
         aG3NtLd/VwsX9Nm76CRi87qgz5g398J5UBv/zFHYVkU0FCv9BojXf4GaMhyBvITFz4SB
         77mYQfxuFjJftB7IOW6yGeCzc1o+AEIrM3IS//il5t2tQScKgVBwrQVKYdCsPfS721ko
         9/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695959048; x=1696563848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0simBD6rQLXMPt0Y2N8ykn3CDbCGOnXOOhhxwHhlQgQ=;
        b=Sn8J2fGq+3ycMPsDFT9XGh0O3y0tiKIoW5bkyoOX66iAI9CvqxFBm8nxJCS28esFu2
         AzcIJwO0O8A38rcmiNn32t9pbpVgs5s7vA7BJuOxwl87A2cencaGJxz4l003l3QOe+zr
         QJ/5VsVcpTF7W4SjxToZjtg1xve1jr8SfrLi7zZgJvh/3MYfceNFHTwD9hfQOr6e8I4U
         hO2POzFJQdSkakH2OQ8uY884PiXP5Zvi/R5UekyGji4ZTmzrm6pDR2T8d7nfl9ulYMB2
         ufoeiDt9D9SFer9hB19tpB5pl1h4YwAZW/pE4ipTYYkQ4HvgtmVNPslzARxKLtFn8q7L
         L5sA==
X-Gm-Message-State: AOJu0Yzv3TSQLUmQi1gDqYtnZqMTMaNPIluvl7AtWMT2/LOPX7p68u/U
        1CwVOCdWfyKGcqnbJqxV9dnVaw==
X-Google-Smtp-Source: AGHT+IG6g7pShCf6eVY0sCYibCGHTk9kPatZkhxOjKErJy9l86I0M+oerh+DrvDu3P9n+z31G/+QEQ==
X-Received: by 2002:a5d:4682:0:b0:31f:e80a:33aa with SMTP id u2-20020a5d4682000000b0031fe80a33aamr2597930wrq.27.1695959048003;
        Thu, 28 Sep 2023 20:44:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm20645177wru.52.2023.09.28.20.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:44:07 -0700 (PDT)
From:   neil.armstrong@linaro.org
Date:   Fri, 29 Sep 2023 05:44:01 +0200
Subject: [PATCH v5 2/2] arm64: dts: qcom: sm8150: extend the size of the
 PDC resource
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-topic-sm8x50-upstream-pdc-ver-v5-2-800111572104@linaro.org>
References: <20230929-topic-sm8x50-upstream-pdc-ver-v5-0-800111572104@linaro.org>
In-Reply-To: <20230929-topic-sm8x50-upstream-pdc-ver-v5-0-800111572104@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sP+r4e04X8jecgSE+GdyYs6YDv2q2USTYBLqb/XeWBc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlFkgE6Hat4o6gljT/wwjabnHx41yjh0M4fp+eFEZV
 R9Llmj+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRZIBAAKCRB33NvayMhJ0QirEA
 Cd7dhmXO7B5MbxvUn1DThRdtFTqIQfglZ/bsMPwx0O2uHdI35FikKiKDwtVLUavDjNi1uyflj/2IOX
 hXhJyUK8LV73Ar8G+bS4706y/f1l1LRKgIlJwlNkjsP6/tEBF4/MCXA6C4DeZva3JRuI7Ei5T4YwaA
 IMNOXL924ahXGMxPSNEy/Juok/EIwo6StODJV62Or9CGxNe563AtBV3fTPGwwWGqdQvmCO2DtSgtl6
 qmJWIPmbjy3ZP202NJfndcgFG4NeMlYwNd9lNqQQIumbjWo7dOChFQCnVEqNIpmCrUhx1OdPvrljtG
 4LjywL2ZjXgsU+HQDKzjpUflWMn0ks3xtUqrBeUSjJT/EHc2OvjlZlSL8pcAmsHVXcjUsY0Atbaw/d
 8l4qgo8RtVXXjp3ZSu9wqZOTYDukT5sFq38EA1Vy5hKuGWhAWSsu+mnMwnoWCpgwAKKUqfqBJVJhoj
 QFo0kUCXw6ry1MEoWO/khc+CWBCHRFga3cwXoN9fAD1MBDzuNKDRGpDxqvckcw1j1su7+dOyms++VE
 3VMCbWqyPaJ+ZNc2slQrU3YhooRpXvfo/ZuICwyAnxv0JC4n5dXU6pOixqGBwSJm3digwGT7ViRThu
 qbOK1/ZWpMUIP/eU23Ps7TgsPrrMopMIZkv1BU/Maasrz1OrYuIkn0dgnR5A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Follow the example of other platforms and extend the PDC resource region
to 0x30000, so that the PDC driver can read the PDC_VERSION register.

Fixes: 397ad94668c1 ("arm64: dts: qcom: sm8150: Add pdc interrupt controller node")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a7c3020a5de4..06c53000bb74 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3958,7 +3958,7 @@ dispcc: clock-controller@af00000 {
 
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8150-pdc", "qcom,pdc";
-			reg = <0 0x0b220000 0 0x400>;
+			reg = <0 0x0b220000 0 0x30000>;
 			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
 					  <125 63 1>;
 			#interrupt-cells = <2>;

-- 
2.34.1

