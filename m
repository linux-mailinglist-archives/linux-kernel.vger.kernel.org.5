Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3F79CCF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjILKFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjILKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:04:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0806E64
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:04:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ad8d0be93aso66950066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694513091; x=1695117891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76F0+BldbGsR8SBANuEdRlfBFJURUSsOZA3YGl1lILM=;
        b=kzbwkr3Z4Cecmq3sCp5OTxC/OuWF89fG/jgPYZatb8oFqiRmxMtX8muRme8DRFlAE3
         2KpvAxu58uBhaviD0aGzCw+m0KbN+DYLHHbK4ygrhfyuFUe3ilBIW61mDOJqs+ouQPBa
         Rh9loEgrWS2KWNVFWFUtDn8sZXFs/MmMJTz1PB1p7n1m5Nqb1HNbSp1DLbjX46YAKEKK
         XMSAOeUBi+8AguPz/Q0fTPbC/8/3evtIyWad8rRm0WjwiW34odJJA7E5vr7s8MUdc+pn
         XIBM1wSJLKY2ap6coD/ZxrhvAQIf+HBP4Hp9x2G3IpF7bKzvZrplhKacIpcVh0F5wjOC
         UsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513091; x=1695117891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76F0+BldbGsR8SBANuEdRlfBFJURUSsOZA3YGl1lILM=;
        b=H4Gu3Bn8MbTkvE5mvM6YOU3DK9IG8TTRgtBlcfzg+nAahbQTNkTAby/+yF2hvk7epW
         vgIcvF+DwwmDx7+65/nhoIsBkTOIifnm/dgh0//0qTDX3lWpGA87RPJYIOYd9JAHPxbr
         4d0GcWo3uaQzN5W66OVB4lmf59R6bL7tmrMtgV1HHYzlWLm7v19jh3s+lw8VMnWK9GSA
         3RhPGu2vB8+BQnXeNEbuSnUav9hZEK0pGbPcji5hh83IOOjoveg5PAKIehUD1uwm+JSM
         V/ga0zrhA0F2K858agk9haXO4910O4XqUbFkyFY4NFlgQqeN9MNLMuOGGAf8+x+sgosm
         jqyA==
X-Gm-Message-State: AOJu0Yxb78X5iu6URCdGd9GVpzv69jXCRvAremtepkbjBQKskd6lKMKZ
        Viok2kufH6JOrw0bqNqu38v/Pw==
X-Google-Smtp-Source: AGHT+IFFTR7Me9GkF8TwPhcPBB1Y5s/bvb5Njy18q0t6j3M2sBcRZTcWLShIUmaBK5Yj95BzYsqQxA==
X-Received: by 2002:a17:906:5a54:b0:9a2:26e4:a5e2 with SMTP id my20-20020a1709065a5400b009a226e4a5e2mr2847448ejc.25.1694513091507;
        Tue, 12 Sep 2023 03:04:51 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906060300b0099ce188be7fsm6592053ejb.3.2023.09.12.03.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:04:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 12 Sep 2023 12:04:44 +0200
Subject: [PATCH v4 02/10] dt-bindings: display/msm/gmu: Allow passing QMP
 handle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v4-2-8b3e402795c1@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v4-0-8b3e402795c1@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v4-0-8b3e402795c1@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694513085; l=1312;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=f8Ks5qBU/xHwVpGLbBaIcN6/JSh0hSEZ3lbJ3m6GXGI=;
 b=9i+f9omsQyT4L6anbqN+1N8xukVQtyzR1G/5cFpfCRAcXhunuhaQaBlVP9C3SF6hKNycjZwNi
 tSIY9XL7KOcASIQvJHIYdBcJDX5frjvV03WkZdMxQnt8Xz6ujKo2wvN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting the GMU, the QMP mailbox should be pinged about some tunables
(e.g. adaptive clock distribution state). To achieve that, a reference to
it is necessary. Allow it and require it with A730.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 20ddb89a4500..e132dbff3c4a 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -64,6 +64,10 @@ properties:
   iommus:
     maxItems: 1
 
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM
+
   operating-points-v2: true
 
   opp-table:
@@ -251,6 +255,9 @@ allOf:
             - const: hub
             - const: demet
 
+      required:
+        - qcom,qmp
+
   - if:
       properties:
         compatible:

-- 
2.42.0

