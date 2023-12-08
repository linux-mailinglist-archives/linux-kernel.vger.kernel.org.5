Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29480A6C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574263AbjLHPI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574265AbjLHPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:08:43 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571051BD5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:08:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1caddd6d28so288615666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1702048128; x=1702652928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADyyGGnuyYVsE20DUsH/ImAyYyUEsvd/x7yinUyvXfA=;
        b=tA1xbQo6EvGz+aode6ogAKiBk5vrS005u47YwLVcXhOxRTvx5NsrZ4wgXy7kTlaWvk
         4n/eYRnuqNAUdc8dBwZsHtITWPkNxJNZcM/hYErNZ7Mrk+b+GvGH8l/dt3DxP4Z+AQno
         MFSWlPeEMN7vVMQasS/xsGs4I4GP3ADRAqIMCPzgQdv0hBiFvtPeuXtUMasbXTQXviMh
         o3PPjBpNp9s3icfnDCRqiTQcgcCegoqzh+wE4G8dkuR9UBaREoXrUhNyret8i8uYIU7g
         o2PxAjwoggGszUySz+d9hacmcdxxoOzpMiCNVGV+XfzUxWw1nYuIkMMXXvR8pdarVcrf
         TYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048128; x=1702652928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADyyGGnuyYVsE20DUsH/ImAyYyUEsvd/x7yinUyvXfA=;
        b=csjJLom6Kku9i3I0frzDVRNtAWpq8fyHCsc29R2hRtVxcEeACt+nyB9BX10ioQ+oZG
         k9bl87uPjTiUbxXXZurWgm6fglCzKf0u8wceFg6q2+5Tbw/yiZ5yMFjc7IRqJU084wUr
         fq+owkNzMfl55MCMDJwlpS8krcJAJzq2+96Iw/By/gvtosM9k2MeRroB+QN+NNbkbJfS
         AINEYpQp/KgGtAR42XudJalB1YXxLxi8nVFKAnHRt32bDmBVm9upPJa7DhKBsYj0Fwyc
         02E4shgc+aWZrV5/l1y+d8Y51sljF5pITZifr+kN03yyX8IK5S9TpZ//j0VaqK+TvA54
         53nQ==
X-Gm-Message-State: AOJu0Yw0PbYabaCzZ6YjOUcWmkokb8+UWpba2YPk2XCjrswIn//TfdMb
        uRy02rptpjvFfmVf1kemSxFPSg==
X-Google-Smtp-Source: AGHT+IGsSCIr4ijXHWnZzYoOk2/a9DsQsa5DZSvHFnPOefRXTzuE3I7g/8SvqT/wIlriLsyjx/sEeg==
X-Received: by 2002:a17:906:371b:b0:a1d:767:f068 with SMTP id d27-20020a170906371b00b00a1d0767f068mr48853ejc.31.1702048127721;
        Fri, 08 Dec 2023 07:08:47 -0800 (PST)
Received: from [192.168.55.221] (tmo-113-102.customers.d1-online.com. [80.187.113.102])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a1cc1be1146sm1096114eja.217.2023.12.08.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:08:47 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 08 Dec 2023 16:07:57 +0100
Subject: [PATCH v3 01/11] dt-bindings: remoteproc: qcom: sc7180-pas: Fix
 SC7280 MPSS PD-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-sc7280-remoteprocs-v3-1-6aa394d33edf@fairphone.com>
References: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
In-Reply-To: <20231208-sc7280-remoteprocs-v3-0-6aa394d33edf@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domains for MPSS on SC7280 are actually named CX and MSS, and
not CX and MX. Adjust the name which also aligns the bindings with the
dts and fixes validation.

Fixes: 8bb92d6fd0b3 ("dt-bindings: remoteproc: qcom,sc7180-pas: split into separate file")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
index f10f329677d8..6f0bd6fa5d26 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -114,11 +114,11 @@ allOf:
         power-domains:
           items:
             - description: CX power domain
-            - description: MX power domain
+            - description: MSS power domain
         power-domain-names:
           items:
             - const: cx
-            - const: mx
+            - const: mss
 
 unevaluatedProperties: false
 

-- 
2.43.0

