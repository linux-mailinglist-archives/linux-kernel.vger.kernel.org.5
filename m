Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A180A6DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574381AbjLHPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574205AbjLHPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:08:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67019BA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:09:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso3117403a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1702048139; x=1702652939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+fYAGPB7ccYtzFuGwN8+ETe0Pw0bdf6T8UKSdRouAU=;
        b=lqNu828biHOx3OAsCKtSqWsgvHhMztLC1UeJ3f5rb/ZIzC9l9iqNEcqxjxWXmSFsEU
         mooVDrZjqxYXACE789MnFKPfiO7i2kJIgt5KuL1GFBpMGL59mCNjVNuzhFoGqB8nENIt
         mT5AepXsSJQAahnCogW1lbQLq2OCOyOsbDeKb+xORn7dZPvDwuzALzR+oO+cV9UiSUe1
         mWbtFbJbJ3mYF5qeLVtjpRfA9TIrtdD5LIJhZ+/ej3CGW3M2KFdM40eqmn8kCaBtHXwq
         pLHj9R6ZmSZz5kkJO5FVpcPST7SyF/242Bi5FJWjyXW8KL5lAjx/2mNhxOdfLC+dn43r
         n/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048139; x=1702652939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+fYAGPB7ccYtzFuGwN8+ETe0Pw0bdf6T8UKSdRouAU=;
        b=GsqRtibOGnCx74vgvFOzRVjcGkGt9wR31ldFu6F0aO8Cn/KyfyXiYHD2mPejFU857s
         RT9M8TsIQItIUcWx82VUP53U2liz7SrTIso4kLx2DV+nySh+cNNyZ0egco9bX5HK9QE4
         //jS5//An3yM4KwvXdm/o63Zt5Z0myRgxyr4xnuhH+PePpfMKyjZvva38rUf8354yhPe
         cJJgqMPzUVms1TuXOxE10kdckdpt3dsG5X6kp3Y0WGf/k3qQl1TY0qSPbNY0dUk07evw
         I6MIxgMZl9mS78pvBqlFbvRw9LY0XcREohj4I774T+H1arqwlq4VMzFXq3XeypuMFAKo
         hRAw==
X-Gm-Message-State: AOJu0Yz3qtXZECNOpdtls67S+1ZZB03kZ5OJE4kpEdppoPbyf99eFrwg
        TtVioXFzaf09vR8rfdLmwLGIUg==
X-Google-Smtp-Source: AGHT+IFIqEHizA58jrWc6V4gUXwbZzpPyQqfiite7PHBiqSOy2F6BVUE922YVn9sDh7PogJGX8czHw==
X-Received: by 2002:a17:906:796:b0:a19:a19b:78cd with SMTP id l22-20020a170906079600b00a19a19b78cdmr62252ejc.144.1702048139217;
        Fri, 08 Dec 2023 07:08:59 -0800 (PST)
Received: from [192.168.55.221] (tmo-113-102.customers.d1-online.com. [80.187.113.102])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a1cc1be1146sm1096114eja.217.2023.12.08.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:08:58 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 08 Dec 2023 16:08:01 +0100
Subject: [PATCH v3 05/11] dt-bindings: remoteproc: qcom: sc7180-pas: Add
 SC7280 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-sc7280-remoteprocs-v3-5-6aa394d33edf@fairphone.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles and constraints for the ADSP, CDSP and WPSS found on
the SC7280 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/remoteproc/qcom,sc7180-pas.yaml        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
index 6f0bd6fa5d26..c054b84fdcd5 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -18,7 +18,10 @@ properties:
     enum:
       - qcom,sc7180-adsp-pas
       - qcom,sc7180-mpss-pas
+      - qcom,sc7280-adsp-pas
+      - qcom,sc7280-cdsp-pas
       - qcom,sc7280-mpss-pas
+      - qcom,sc7280-wpss-pas
 
   reg:
     maxItems: 1
@@ -75,6 +78,7 @@ allOf:
         compatible:
           enum:
             - qcom,sc7180-adsp-pas
+            - qcom,sc7280-adsp-pas
     then:
       properties:
         power-domains:
@@ -120,6 +124,23 @@ allOf:
             - const: cx
             - const: mss
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7280-cdsp-pas
+            - qcom,sc7280-wpss-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mx
+
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0

