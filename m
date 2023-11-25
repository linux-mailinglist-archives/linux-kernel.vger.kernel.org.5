Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC07F8B76
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjKYOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjKYOR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:17:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C533610E2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00ac0101d9so379732666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921877; x=1701526677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWCPgxbV31hYh8dy6WyfWoyvdSmmu8EadahKhw6DkWw=;
        b=qcLUpqjiwzHK5tC+KD+KtHDgUJB5RTkKQPP4XhaNtPXiIcjb7JzabYxYqicZ5HiNLb
         NhRMp2euNEbewi+QDtjIsNvoAwbAsaJCYLKIAIe39dWa27HDYKMhIDAiYoUoyEudI5Tg
         e5FxcJE3u+s2+RTQW1KIJGUzZVPaajp7X9yczcPrFDZOWHBNeqicLtyD6HgPYNkdjz92
         +P7DBicLgpAfqdADC1m1wMVmCFhKWDfDGs+j1M4FBxMEpnmZ38oyvSmIMmlEGnuaHkW+
         8a2OPzoyAyVLHGDiKeCCFEqt9v94hQnlp3bDZqJgT6Z4f4msJcWA/5KbQFx1SfdvDBJ/
         1k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921877; x=1701526677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWCPgxbV31hYh8dy6WyfWoyvdSmmu8EadahKhw6DkWw=;
        b=mObErsQBZNXOnjoEEOPL/v5CYgCKRN91NKGizo7qnCYV3U7Dnbm+EqznSbqbvrs8nu
         KwVVZp7iRQ3IfC20OfxMRXa306Q13FZND7UOIpnYojnoXzXE5jNhqBnvMZGfKrw5TJhs
         wJPNYk5+kUGncc4eR/+VASF4yau/+GX9AfJPTO6+W1GFJjhS+IC4Kn0bhT/Ijn+LoF3A
         ewdLwUpiJa/eJs0sO2IbHJGv/D6Defkk9uxngqo/Kzy0inHZDEOQAkIIkKHKMZqcGHVM
         EiorwMiBnV13g2Bq/NaKRrPIgdJK0ryKzXfA89S+ic0HZ536vAHjKmiu6T0CswkQIQqU
         5BrQ==
X-Gm-Message-State: AOJu0YyM/muFq1IiZAlRZACiy/ME8hGvidDWYgaAmuIC0jWdYWO5ZVi6
        Vi86NHBh+kmyRD/ZSPMsA9fgTg==
X-Google-Smtp-Source: AGHT+IHvD1QUH58vfrh+JuFXiAspD6f2yTyYe0BNJ9QJi9uFvF8FzZqrsK628r6rcj/cdkeKg5L5Ow==
X-Received: by 2002:a17:906:608d:b0:9d2:20ee:b18b with SMTP id t13-20020a170906608d00b009d220eeb18bmr4065922ejj.42.1700921877219;
        Sat, 25 Nov 2023 06:17:57 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:56 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 15:17:33 +0100
Subject: [PATCH 05/12] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 QCM2290 bwmon instance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-5-11d71b12b058@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=892;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4p1t3ladITCzScGHKWRD4AUO04YXuJiZkuRiWJFiujo=;
 b=HgtcxdLyklPczRRLJMxdrlC1sVeNSeCuWIN6F4Xkr9dxy/a75RHP8Tm9mVxVipeW+jkpJiDqG
 jjrxeMEwW5LBwHqcbF7tqgSlw1eWMPkjI1ABsatTSpX8EHUOrDEKyaC
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

QCM2290 has a single BWMONv4 intance for CPU. Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 7cb8df757477..a88cea732370 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -25,6 +25,7 @@ properties:
       - const: qcom,msm8998-bwmon       # BWMON v4
       - items:
           - enum:
+              - qcom,qcm2290-cpu-bwmon
               - qcom,sc7180-cpu-bwmon
               - qcom,sc7280-cpu-bwmon
               - qcom,sc8280xp-cpu-bwmon

-- 
2.43.0

