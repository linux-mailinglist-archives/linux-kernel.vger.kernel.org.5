Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74A7FA489
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjK0P3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjK0P3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:29:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F8B131
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:29:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54af1daf6a9so5861125a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098944; x=1701703744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsjff4lo1TEsrq1gFW/fhWlByzdhetZPF5yWDTWUZEA=;
        b=MjKz4i9JEnsvpFh9NJbh6ao518pGLidS+riiMljmapXlIwc7jS7grGtgYOHWQJkfSw
         guCJlFjnd70xio2crIB3s+a536rpt6HzisaAIX3BSzROg93WhSULXqnx9aPxwVfcVdIH
         wMGSKhpTVST14FPmE33QU0mCM/J1+4ELP3PXgyVCBPeLI5yXOo8S1JnQz7Q2m22yXSVE
         dn0236y/E5S/OQJ9gLc/d0OW40q4G20w0qtyY+kNyVwEWZR+/Ll49eApOBfN44kf7Z0y
         ElP/3ZG6Ih5e/+b5DI1sXGTJOI8z7fvPDfX7v/W16VkeWzbY1Pcc2jt3X11Kxl+T01mt
         /gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098944; x=1701703744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsjff4lo1TEsrq1gFW/fhWlByzdhetZPF5yWDTWUZEA=;
        b=Ly7Vaun6g4i4uhXde+H/oq2n3N02W7Vha2D+nW11ZfjH4RWH7ByW9I1oDTQ3iXPNR5
         TA0rmkz/GC7vNCmpu8IoC44+ge7m6t1moec5IQJQVQfZV/2hDT0elzmnjUCmuvNrgXJm
         4m/g6wEsJVTvZrP+/ScgChR9u/WkyfFHlpLotVotmuZMqEhA3UhpbV9LZHUodzWC2neb
         oyRrffr4fjnQMi7cUVtBctpDVT1d7Dxmx69uaj9nNVbE7OnNQS6ew95ktDYkzpq44jHg
         1+z2G8fbMh3MW3sOTffj9SzruG2vOIWlI7aows2FS76qSIReTcqp4SxotFHPpFvR2LwY
         cg6g==
X-Gm-Message-State: AOJu0Yw+vWGgtmeKNgylVusqUDpIoL6QJO8Id8FIQspN2X1717Kx5hXW
        nvzKyhSl7lcxuYJNX4z37AfUnw==
X-Google-Smtp-Source: AGHT+IFOyIrlG3K4TKUYS2ME/41gHY9uKSnDmZkZO/xmnu/DRtbRQqQLfmFgD0DWgrRTWqt07Bphiw==
X-Received: by 2002:a05:6402:b08:b0:54b:35f1:905 with SMTP id bm8-20020a0564020b0800b0054b35f10905mr5607319edb.3.1701098944044;
        Mon, 27 Nov 2023 07:29:04 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 16:28:44 +0100
Subject: [PATCH v2 04/12] dt-bindings: firmware: qcom,scm: Allow
 interconnect for everyone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-4-979b28f35e4a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=1156;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ATWzTDawV1rfiW1Rmh2AEVyFtBtlEoO5VeMvQ1CdaLU=;
 b=d2uxm8koLiSmmdjKdjpShjLXryrZ+gjNkqEkIxKGxUdhaPhhQ69YN5mCvINv/crH2NFSPaxwY
 vbIbYzQoWl8CAPM339TI9Ayh67M741P51t4zrDzpIG103JKmvS20sDA
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

Every Qualcomm SoC physically has a "CRYPTO0<->DDR" interconnect lane.
Allow this property to be present, no matter the SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 0613a37a851a..f3a87a8426d0 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -178,21 +178,6 @@ allOf:
           minItems: 3
           maxItems: 3
 
-  # Interconnects
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,scm-qdu1000
-                - qcom,scm-sc8280xp
-                - qcom,scm-sm8450
-                - qcom,scm-sm8550
-    then:
-      properties:
-        interconnects: false
-
   # Interrupts
   - if:
       not:

-- 
2.43.0

