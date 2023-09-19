Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AEE7A6384
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjISMqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjISMqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:46:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA45F3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:46:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502a4f33440so9174080e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695127568; x=1695732368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fWFiq2Z3kzEyU88O2c9+i0+0nk8+Hu7Vs+xo2WgRZY=;
        b=0qu5Ts8zT7BUKq+V4tf8qNL+Uamsn0u4PCcd/SdXWT66uBOofC56VEyRBtviIASGBt
         Fri7YsQnAta4i68K5lR9fRr86BuIsSfJjVuz2LD5/l0QM8X8ZXzfvEBXMujWlx1la7cW
         qvFI+xYOAX523nh/J32xpYNYTPdY5PnFU7yIQTDhjfHQ/shfG2rJVuWdVMt/fv+aZzen
         dNqp1ckCWBw8IbGaB+GzaXRAUBVt6a2N/2nVSMMLKaIdVSpjd7HlWynoRZ921MSAH/W9
         AyvWhlToFeX598Mks+iZGC9GadgNcHgQ2HtHEflgKgosd2gCtyU1L6euO/c6TTajnQRi
         eWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127568; x=1695732368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fWFiq2Z3kzEyU88O2c9+i0+0nk8+Hu7Vs+xo2WgRZY=;
        b=Q41KG5JWCEI7gGfGi12+T3sujg9K4bDDaYaWo4gnF51ah6slx6L71jXOYwIXs5HKde
         B8XRsx6TINsuSwG+C/1l6uGXfqE8MyFgBC/qiCey3IIVNRfDpY83ZjvrNsvtvQgBjAzb
         rqGkcRCKNE7WNeWjwLcyvo02e2tCv7C2uALVdEw2su7ku/5Kdhc6xgB8yOLWWlbOQbGE
         BbXEmItABupPYL3wWRX1FeZJdxvp48dsVYhtThpeevOtQBEw5HVqlKy8RLuOoHLclI41
         WJljhTj6w4NAWcdxvm8hLOpAtQxdpjqBbKF+sTFMrUcGL51rTg9Met/cgVfuYlk0FTZJ
         DdNg==
X-Gm-Message-State: AOJu0Ywu+7P3RM31RvGNQHuIO2MQDBz1FANPKvPPMdpUTJSMebLiHy58
        7fdJ58fZroi6Oqn+mX8tV8hxSYbOXvAZCPq8ahSt4GLt
X-Google-Smtp-Source: AGHT+IGZklR6vmwx+I1m2TYBs5iOwsPLRBe+Obf/CId5PwS12y8h+KZFNQQ9tDvt0rDzC8/Y2ewakQ==
X-Received: by 2002:a05:6512:31cd:b0:503:1722:bf3a with SMTP id j13-20020a05651231cd00b005031722bf3amr5986480lfe.1.1695127568502;
        Tue, 19 Sep 2023 05:46:08 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00532c1dfe8ecsm635878edb.66.2023.09.19.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:46:08 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 19 Sep 2023 14:46:00 +0200
Subject: [PATCH v2 6/7] dt-bindings: arm: qcom: Add QCM6490 Fairphone 5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-fp5-initial-v2-6-14bb7cedadf5@fairphone.com>
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
In-Reply-To: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fairphone 5 is a smartphone based on the QCM6490 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..76934f4772e9 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -50,6 +50,7 @@ description: |
         msm8998
         qcs404
         qcm2290
+        qcm6490
         qdu1000
         qrb2210
         qrb4210
@@ -391,6 +392,11 @@ properties:
           - const: qcom,qrb2210
           - const: qcom,qcm2290
 
+      - items:
+          - enum:
+              - fairphone,fp5
+          - const: qcom,qcm6490
+
       - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
         items:
           - enum:

-- 
2.42.0

