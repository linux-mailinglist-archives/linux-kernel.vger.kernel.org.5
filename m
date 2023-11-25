Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298707F8B56
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjKYORn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjKYORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:17:39 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516EA12B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:46 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a002562bd8bso537532266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921865; x=1701526665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rQujemNns2ndt1lXcUIici3g0rf7w22fn5B+qvqdAk=;
        b=MR4xcmJIfSALWI32kA72Mv2nx4nqOZrfQAzNPojw5v4eBYFD4xszOu8eInIvuRCNFr
         D9sgsdq0A3aHZbDSzvNdwyCJdwJwIQXBVfabKmGoxy7KIqJ1atKaR5ZJIhpE9kvHz6RO
         ma161huomoE4jZYAwfFQplkzzpsqmDLPILmEt8VMPKQeh8a+TSqc2zmWahH7mx9w3360
         MRKh3vEoloa0N5Dkvua8eOCkuUSBcmaKOBw0A4E0KZCiPBCvsyvmiQl+ftrsJIMEptx5
         mcuBP92QsZnZodX9PAM4/fND5CiJDXP4qf1NAgf5Odx+2p+Gpys+ld2eWn9zbODWnBOr
         svXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921865; x=1701526665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rQujemNns2ndt1lXcUIici3g0rf7w22fn5B+qvqdAk=;
        b=LqElqNzHx7sNf+pB9tq0qO8irCA2OMs8qNX9NhIe8kyOte86IG5UokXjbqboRHqIYH
         qprSLpIdbcxXw3AUxEfo6TPS4u1akz9jxZSl7LqsBFeimu7MG1AGpSmKK3DgDoK6x76f
         kowL61EenMSDIj323P0uTY2ty8l+U6RGqYd4+NknrfTM1N/SHa1TeTlsLp7hLBKrB5oa
         TYn7bae3zeV0XMo/jA4mN6wgH5OlzY7jzGsT4hH/DDn+O7PSd0shgUMDK8jlZIJMSP7T
         Bt4RD/KCZYbPXKOIyHqyBb2aJGNyX5kPGtaUJPAWd2czVOJDUR5IPb4i1OxiO1FhpAT6
         VgLQ==
X-Gm-Message-State: AOJu0YzPwO7JD0wd8pNwuwdrGdv4Lp211rZrS/oHKgamJsZV1SGqG2vi
        cE8ptzI5CGrnBzesq9v91CsGOQ==
X-Google-Smtp-Source: AGHT+IGPxq21Qjgc/GrNJp+OS6vlYQiVZrLBsYgKptJdvk4KWzY/ul6KxNZYKidVLZt5GlelpE1RPg==
X-Received: by 2002:a17:906:1c0b:b0:9a9:f042:deb9 with SMTP id k11-20020a1709061c0b00b009a9f042deb9mr5318580ejg.19.1700921864631;
        Sat, 25 Nov 2023 06:17:44 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 15:17:29 +0100
Subject: [PATCH 01/12] dt-bindings: display: msm: qcm2290-mdss: Use the
 non-deprecated DSI compat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-1-11d71b12b058@linaro.org>
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
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
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=1164;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y1sirvX5YFsJjlPb48bi4MpncyZ0lMCRlJZu7X2yRoM=;
 b=UiGcO+L4/a0dmckDlbkw20ULhUpsIjv/+kQuhdQaBChp5KRuCtnnqN8CqLFyn7qRa5+5NOM2B
 ozznslemdQeAT1tVEV7J9StfijAPcDgoNEvSOjEwpF9tAfdtcIiixbC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 5ad155612b6c..3d82c00a9f85 100644
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

-- 
2.43.0

