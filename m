Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8707FA472
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjK0P2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjK0P2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:28:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A769B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:28:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b0c7987easo3479316a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098933; x=1701703733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDUaT/KJ/VNfco6RB2vLVEnszdzFi1oNwuTEuo9Y8w0=;
        b=CI9dKg0mpX7X9lFR/5F4+G2o3Ebc3EukfnUyFXOeuTJrZ4wc1hlbjJpUog6gih0/pH
         Jmdh4bbvs200fs+yCA39mDv8+p2UW7Jnic4RUfWYjHOdEai/FzhOrBYutyDFWHXNsv8x
         qnedsl5lY46A3XsB2A5yyPb32mL+E9hwlAjrAKaKpM6eLBgRwfZVaPcMObpHbhGfXdpF
         BdM8rMX7sZVEfMp3as0GuljVwBS+FhYBSq/nwCU2It9EZ647opqab7awIky5rUP1VKQJ
         niorDWhVeFwSXYZN17rfq7zi7dB+6us11aLazmyWPE98i+VMStGAmjtDkTiBcogcb3of
         rOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098933; x=1701703733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDUaT/KJ/VNfco6RB2vLVEnszdzFi1oNwuTEuo9Y8w0=;
        b=XWq81J35DPKXGC+SX/pcZ1JBRhiJ9FA3NvIFQ5+18WFTXShJUYLJJY9cLxmHJOpYvi
         VH9uy40ZNXw9/P6/bIhQrzgg88GDA8Jq4wFm/2FmsAbVhn7MWyFHi74X83VnI3ej4Ltj
         7xTnEuLYtG5nb1tzveWxWUW+ajzwXg2OxEJ7HVtkLlNCehEGLaqF/r/ewMlB8xPsfPvn
         TRWsL43l8i7yfzjQxEZAgvtISzwQU07+RGzgN0bJpUAc+J0i6eU5FX5gGdHHicx04WBO
         MD0bKNbXyaWuYppQczYpGOF+NDAlsJ3MOpYa+t0QzY6WqZAxQwroHpPQmsLnA0XfgnJM
         l8yw==
X-Gm-Message-State: AOJu0YxqmYx35uU8QIVXBEcbnjrYDnutGiWTwdHI/cElObjEmeHngznC
        ysu4ecBXxMNgPjUF3PC/gz3qwQ==
X-Google-Smtp-Source: AGHT+IEzmMDYeClli0bsqBMCQzev/3yzgw7HjJl19gGbvndSUAHwGg0er0pMbvZpi1YMHIF7FhqcWA==
X-Received: by 2002:a50:ccc2:0:b0:548:4da2:fecc with SMTP id b2-20020a50ccc2000000b005484da2feccmr8744965edj.3.1701098933173;
        Mon, 27 Nov 2023 07:28:53 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:28:52 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 16:28:41 +0100
Subject: [PATCH v2 01/12] dt-bindings: display: msm: qcm2290-mdss: Use the
 non-deprecated DSI compat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-1-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=1474;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=StOyqUBN12uWXGz5VxyIVjZXe8BbnbVf9Pwbyqv47+8=;
 b=2AvUROB7bo2pn+OEKisCdCRJFBG9VM6cMv+CV/oyTrlgWcVcR2CBpCZ+93Xw3LHZ0rKPc8zwJ
 YESXk2ZQrZpBDMG0mpAz8rh1T4OM3ctfOJ1lfQm20vjIxYEWsctWK1F
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "qcom,dsi-ctrl-6g-qcm2290" has been deprecated in commit 0c0f65c6dd44
("dt-bindings: msm: dsi-controller-main: Add compatible strings for every
current SoC"), but the example hasn't been updated to reflect that.

Fix that.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml         | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 5ad155612b6c..d71a8e09a798 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -56,7 +56,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,dsi-ctrl-6g-qcm2290
+        items:
+          - const: qcom,qcm2290-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object
@@ -136,7 +138,8 @@ examples:
         };
 
         dsi@5e94000 {
-            compatible = "qcom,dsi-ctrl-6g-qcm2290";
+            compatible = "qcom,qcm2290-dsi-ctrl",
+                         "qcom,mdss-dsi-ctrl";
             reg = <0x05e94000 0x400>;
             reg-names = "dsi_ctrl";
 

-- 
2.43.0

