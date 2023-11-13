Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52D7E9863
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjKMI5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjKMI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DFA10D4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso6376358a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865787; x=1700470587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRhWkDdnGigvskQkUKrgh/oalrp9HqrPtGT3d3EYkwo=;
        b=G8P8w7FsfgnzZdy+JLVvAkYibjIwpbs9vfkmyoMM1UGh0RS8nfoZoYzA+Sarevjfpj
         Yl1EQq87fNbhdcg34gJU7t4LR6Zln5Kvtdc2S3GQFhmfpwYpZdlJHHRtHnxUOE0T3MnP
         RtIOqpTugnWk+IBJO5wyjDYARiGHgvUHBwBZ6sw4Gx3oc9iFOOsfPYSZLlPUS+lISpIm
         7DoqxK7yoeT8OHHgCIAhWByB6LwYSQEDaHB7Pa22o5ufvbfVKOnjVl44Q3mL/Qjhdbg7
         q1vYuyOh0qQG8b2Pifw94ndGaKIm0YIOLCTcw+00tSyG08eBuP46qMQzXOyXlnHpYtpi
         /hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865787; x=1700470587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRhWkDdnGigvskQkUKrgh/oalrp9HqrPtGT3d3EYkwo=;
        b=hh1evZVQTHUVzkZlyHWpAGWQCMz5SCMyu0q++DPvA9lkxMbIvh9lBeYbMpAwixn8lK
         O1smCi0buTUJSvPDkcTdKEBr3Xq940a+zulk8RgItwa/bEw22Xo/TTKSqBJ58GieNwBE
         vUjk53eIlEMJR78KcB6Yra3XdC8VufRj9XSiq6k4XmYIRFrp3I+pw7iTrEKW++Wl5tya
         sca6tceanozLJaR3Mp8HjfDz7JKcRRRYWpHjntImQLwbbuxHW1O5/dL7Q00Zpz8Wq9O3
         an2KUwE8tDQt/6r8WHZ1FdJWDK9NKqERpDnz4R1Hf2Upl1mDFA9yA3hs1KvD+b39NgaE
         CcOg==
X-Gm-Message-State: AOJu0YzyuI2/8CbIHeG7L29dr0MlXi8WRSqpx9Vr3GYGQmciiQsKaKoU
        DLwDLEZBRy+SyzqfY2K60r2Hag==
X-Google-Smtp-Source: AGHT+IHIe8ed1PabKkxpijJl0eidO370nOLmjNTFG26Ovn6nKLHeEhDCEYK933B4GOH5lsn2/BoBGg==
X-Received: by 2002:a17:906:249b:b0:9dd:dd4a:d799 with SMTP id e27-20020a170906249b00b009dddd4ad799mr4322856ejb.22.1699865787503;
        Mon, 13 Nov 2023 00:56:27 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:26 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Nov 2023 09:56:16 +0100
Subject: [PATCH v2 05/11] dt-bindings: remoteproc: qcom: sc7180-pas: Add
 SC7280 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-sc7280-remoteprocs-v2-5-e5c5fd5268a7@fairphone.com>
References: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
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
2.42.1

