Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598E07F8B59
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKYORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjKYORq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:17:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F41518E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54a94e68fb1so5725852a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921870; x=1701526670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqbb19oWFPD8qDhmzNJu7LExFvnUbJSOuyMJKMhlgUE=;
        b=XMUvah7Y5bmCLGppXyFecSHUS4vd5revorZmDf7dzLCYhOMKzetRVzBU2pdUax6K+w
         Q2+YrboknWr/ZpWDGBzwDfZ6C2yQGRadXQXMQHltZjD5YOyvHyrHI3yOsfZ5F/gnkbTX
         36qPdFgNQWQNhWcQOjNLhSfb4XcWhiFcMp58hkHD30Dck4Q0hClvWulmNdoYPytrapkO
         qb8SeLqxguscKJUjjTdszaAX/MXKO+4Po2GjXBAE13lrS8UxHyWStARKF4FXXSXjTXwr
         e47DMbQMD6eWn35YpEfqwxFgqV21RunFmMOvLqsPP/Fqz6/u+DUUZnzafvYO1jyZTPZ5
         XpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921870; x=1701526670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqbb19oWFPD8qDhmzNJu7LExFvnUbJSOuyMJKMhlgUE=;
        b=aWSwT2IHYKYeAxWr65MSXtePOe3PJ5XDF96WMPrERb8l2GlPenMK/SjIO20Sy7nl9H
         ricbmQ4x7k1Ox08FMdnG90hGDNPLB6vRdyHiSymsiWzSYB/7cXV5nrCg/4VkYunT6fES
         kR4voLGHdJbnwNnGJlgoUltB92UgbwAgwY3gQIga6z5c7WCMDJ23bwtRM5rDg16178y+
         lk/r3aftRyZ6Mqj+UrQ53Gg6GzSyMlWklWqI7LJxyDJqKRpsqIfW01GzMKB/PaAEIYM+
         A1+VoOFIGwNzx/DbPOqjs8JfNO5D54GfdvIqFooJ4xn0r7KVKSIM80KkwKh2USWRRuis
         /m3Q==
X-Gm-Message-State: AOJu0YwaGMmAkHLJdajdqzdRDOa7fs+dJZAvk0Btc52cUyefIsR+2C9B
        pWSRmI+N1jIEOfNijj6OxEH1MA==
X-Google-Smtp-Source: AGHT+IGR9tBJZuW4Oo7JUrMEGXAjwVM/uMciWDFiip2iKnRP19yE7RUhPP5bwCFjfp39Yo++2RfLfQ==
X-Received: by 2002:a17:906:b298:b0:a06:dd05:d695 with SMTP id q24-20020a170906b29800b00a06dd05d695mr5854984ejz.12.1700921870758;
        Sat, 25 Nov 2023 06:17:50 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 15:17:31 +0100
Subject: [PATCH 03/12] dt-bindings: display: msm: qcm2290-mdss: Allow 2
 interconnects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-3-11d71b12b058@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=869;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xDff6gIDu+CTWuVjzt1GPZpEINlhu/tSsPBU3gWPnHA=;
 b=YmejfvEjbhNqruT3MXv+XMo97zWiskf4GaKaxji8ggapDZtFzdQgC4kASqndzOWm+67Y8bFa6
 0FF93EB3HtBAgsjYb/KgoXzUsvQdlOPj1tPFtCY7pLo2Hh+D+dYuzrA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to MDP0, the cpu-cfg interconnect is also necessary.
Allow it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 3d82c00a9f85..51f3e9c34dfb 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -36,10 +36,10 @@ properties:
     maxItems: 2
 
   interconnects:
-    maxItems: 1
+    maxItems: 2
 
   interconnect-names:
-    maxItems: 1
+    maxItems: 2
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":

-- 
2.43.0

