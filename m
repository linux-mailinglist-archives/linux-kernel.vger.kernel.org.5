Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBD78AF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjH1LnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjH1Lmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:42:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44E0C7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5008d16cc36so4722121e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693222954; x=1693827754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc92mAtkRQx6lROJXZsbE1Z78tE/c7LVAty0SEnStAI=;
        b=TY2nT2jlSIm3rdBz17IZhftwVvx9Roq33fGw36bP/M1ROGzvuz86gG84InX/9n1pOv
         NPK0AAV/8wnzQGzKAUgdFTJ3VkqIPWsaNm9lQqSTMGu29xgLT+gN7F5lrwLdnaups/N9
         nXCuZ5y+P1XZnGXXIrgXvNJEft9MLjo/6cZGLI4d4iHfKnuRHfFUgGS+P+m8t+zqcU5m
         PPZ1Poi001L5R4wF2LtUMceahIGLp+M4TM5yXE19DpRqD4NPNbMbn3BnML2mZsXKXW9W
         TiUfzLT3g0nLOFSlVOxHs4D6xNRIXIrma569Ynf/BEyv5FNN0SjI8S5IdG0sxDNqYXrf
         M8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693222954; x=1693827754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc92mAtkRQx6lROJXZsbE1Z78tE/c7LVAty0SEnStAI=;
        b=OC1qgZ9FrGuDp3W1wz4zUAla4vF5Tf7llA/lyRQA/d0Q2nREFTlmUXduOodG85+2Xr
         xaVF1q9Uh92SINI3+ABbRZHWY0kz2BVylZiGWPBfCvUqGRk8zzulRKUMskrddvzHYLpO
         b3KhAnyOJcy6uvaWnQLo4x4h2bbrmwf3nG+WgD+EwBQ2EXeftwBPTMIAFNaJwLiNc0wd
         vjwjbAEM54z7X+Xx6c2m+qKBuJXF5tNpbzwoYq3fks8Z0XABrJhFkfTgoi0XwsCLji6v
         N1Zc6yRbYscozUu+donu8klAoziNk9jV6g8pWKgHcSfrM6B6k0nt+q5x2yd4jWtYf+RJ
         efOw==
X-Gm-Message-State: AOJu0Yy2K9SDtiYLhd9w/dDe0ZZlLA6JQN4TC6qrgHblYBVUlK/QZ1CS
        svqaS9vdYGwOMDPWJcpx1CrZWQ==
X-Google-Smtp-Source: AGHT+IHs4krfqPk/ngVZJEiMOsX7zZoTdP2HqmNXWgvrBkB6uBxKns82d+V9qH9ZTaLAl59j1/U0vg==
X-Received: by 2002:a05:6512:3d29:b0:500:9796:fb6 with SMTP id d41-20020a0565123d2900b0050097960fb6mr11768125lfv.40.1693222954173;
        Mon, 28 Aug 2023 04:42:34 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id b2-20020ac247e2000000b005009920b6afsm1547799lfp.9.2023.08.28.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 04:42:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 28 Aug 2023 13:42:14 +0200
Subject: [PATCH v14 2/9] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v14-2-9fd23241493d@linaro.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693222948; l=1623;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9e02GqF0W2bdk8xEgHkhPQoT5fTXD4a1qiHIfQOhR7M=;
 b=TX5ZrVYwwZ1ynV3DxOKAucd65FQiu2jr6VgZBujEKWHmOBGDcPpey9RZ2N0C/6mDdx5n1wpa0
 W22D6tBhHRvBijjk6E2lZMAt9ly9SfEd9xPA7DO2t9AzsbdmJG5FP1f
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPR3 and newer can be fed per-OPP voltage adjustment values for both
open- and closed-loop paths to make better decisions about settling
on the final voltage offset target. Document these properties.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index a30ef93213c0..b203ea01b17a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -34,6 +34,20 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      qcom,opp-cloop-vadj:
+        description: |
+          An array of per-thread values representing the closed-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
+      qcom,opp-oloop-vadj:
+        description: |
+          An array of per-thread values representing the open-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
     required:
       - opp-level
       - qcom,opp-fuse-level

-- 
2.42.0

