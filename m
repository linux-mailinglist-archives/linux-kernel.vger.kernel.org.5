Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878A677688C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjHITVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjHITVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:21:30 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04463C2F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:21:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so2395151fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691608849; x=1692213649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKzXZ2xoOmtz+1E6ZSxEFtLtyfPfJbw38y+S2GZug7o=;
        b=ktOkxMQcgVGObAcCt3Knbm410wsa9H2uDdEZ/bh/kb/PTY1yoBH/UsES4eG/yOaN+q
         3gzHgW9KgTARcZ05z2S8O6wE54tVnWFb2jvcTNOfCtBvkYbtIoOj1QkrguFI107bp+do
         XIxkH/f0RznHU8aaw59Qe4YS9C//aPlDruZn9wdBFkfbCjC09zY1y/vJyzxXw81sb67K
         AUd/rg7n58SkzCAUGrTNF8UDDGDtpx+DBjknpO/qGPt0fnfXauXI3wEATyfgOpbhPNNV
         Q9ZEZZdWFxXtIQCpYlCm57pEKF6boSnrhk0jAZQkOJXZ93ssJ/vJ8MX3oTGbPoWHECHb
         agsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608849; x=1692213649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKzXZ2xoOmtz+1E6ZSxEFtLtyfPfJbw38y+S2GZug7o=;
        b=bAcc8FqyZEITzJJitSjKHircR/K2hugVAY82jRZf6FJUqdW6LJ4KONcwxIgtQYvDB/
         pjbqtxiVjPoaJcWB7RkoHX3m6nHvU3c2Iwo+XNyxQ1i7qPXtSx4cahYwR3O3rZ8mqwqx
         hjJnwbc2gnKFlhBMlCYJ9zTgBdf5Y21WjwqrawBo4ky3scIWaYPYhXXK+Dn+SgZR2DKp
         vhIK6Gzu+fi6wKFHZuJXnOWHfg/fvoOU4UD/cEAkRl+NZQIJaAfS2UOFHXb20R3PRAAX
         tT+PGxcDQ6OWYk91AulSX7hfcDbd5mcrYEEfq7ma9oZsMFpdmWvngtNprovQzAAqVaYx
         1kWw==
X-Gm-Message-State: AOJu0YxsArdQHPj1ZjIp8EqEfQi3gRaco1RvOIikkXEqpj13x6q0v7Ag
        qVv+V4RDydMpy8DPY/fzad0R1iYRXzT+vEUPfVE=
X-Google-Smtp-Source: AGHT+IHJ/2+1dRVWftsf3hRe4FCuXfAc11npk5nml584uXlQss/bX0OqSrzGd6MTg33LTDRNR3WAfw==
X-Received: by 2002:a2e:9a8c:0:b0:2b6:9da9:2884 with SMTP id p12-20020a2e9a8c000000b002b69da92884mr82130lji.40.1691608849543;
        Wed, 09 Aug 2023 12:20:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b002b9ed203af1sm2863218ljj.132.2023.08.09.12.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:20:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 09 Aug 2023 21:20:29 +0200
Subject: [PATCH v3 6/6] dt-bindings: arm-smmu: Fix MSM8998 clocks
 description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v3-6-ba1b1fd9ee75@linaro.org>
References: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691608824; l=2584;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AwK2agC2XLAE1uApMOG3gNnll+6I3sbngtzNXhteFLY=;
 b=9iedVVmx0RYZnXA8MtHQb4WwXu0MUQvJzEqf1sqEeHux/YcxVW+ah4TFsuR9KgpG7fZyLt/gQ
 3Eq/kgMEGY1ATnANKZsWUEs/orzBde4cvjS2RzEFnclWUMH/ZMEAhj7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8998 was abusingly referencing one of the internal bus clocks, that
were recently dropped from Linux (because the original implementation
did not make much sense), circumventing the interconnect framework.

Fix it by dropping the bus-mm clock (which requires separating 8998 from
similar entries) and keeping the rest as-is.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3a31a979709b..cf29ab10501c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -270,6 +270,47 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-smmu-v2
+    then:
+      anyOf:
+        - properties:
+            clock-names:
+              items:
+                - const: bus
+            clocks:
+              items:
+                - description: bus clock required for downstream bus access and for
+                    the smmu ptw
+        - properties:
+            clock-names:
+              items:
+                - const: iface
+                - const: mem
+                - const: mem_iface
+            clocks:
+              items:
+                - description: interface clock required to access smmu's registers
+                    through the TCU's programming interface.
+                - description: bus clock required for memory access
+                - description: bus clock required for GPU memory access
+        - properties:
+            clock-names:
+              items:
+                - const: iface-mm
+                - const: iface-smmu
+                - const: bus-smmu
+            clocks:
+              items:
+                - description: interface clock required to access mnoc's registers
+                    through the TCU's programming interface.
+                - description: interface clock required to access smmu's registers
+                    through the TCU's programming interface.
+                - description: bus clock required for the smmu ptw
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,sdm630-smmu-v2
               - qcom,sm6375-smmu-v2
     then:

-- 
2.41.0

