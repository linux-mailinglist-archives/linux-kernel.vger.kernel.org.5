Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58C37E984D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjKMI4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjKMI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E631F10DA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso632728666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865782; x=1700470582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Yy2i2F+9pJywYxY6AKw4sbn/DiDdL44GgjGmpRdRoA=;
        b=3asjtuz7sgt8quCwhI1cdHSBLmVtwRjEFYRU9UTkuX8DFtQYc5UuI85sxenC1MLo+S
         LI/bwueDq3LNbZD7UNwel4436vXjg/oDoiIy/fClR3dU34uY1NAZ+ad+/TY8AfKaQokm
         b11EN04wMukjV8kBpF6U77vmAG9jcMef8eBrgcVAOh13xtS405t3a1AZSbzny8YyiRKq
         gQSdWmxyE9QsSHummEALpZcQWon7pQKPHhH/IlGYKSreghHBjekbsMoyGDu3f7rA+yNS
         dpOcIwsp0ROzqnfqu1ye6gvG5UTUkPRoiF5JMQ8Qt+hDnlE+YQZ2enVFh+IcpKQCsUnT
         +Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865782; x=1700470582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Yy2i2F+9pJywYxY6AKw4sbn/DiDdL44GgjGmpRdRoA=;
        b=etKfpWTuDB7PBuB/lCaCF05BaCeKTCWP9q9Ojtz5nOaaFnjL1whNxzV0yMt5cJ2ZIl
         ycFAKDpsP2Ayo3lx/kiSkK8JbSb+CT5joIgeoFCA8bIYX8jIW6ygrjRZtI7RlkuHFvwB
         JzOrVEShr+4UfK6mUG1rT4F7wKA1AbF4SRncLzcshRR8RlqWWzoUjRgQ21/blIQNqfxs
         pUVLKYpfJDqnMNucp61YxXzWadAzUV1oUxy/WJP+noHLx2yemh0rJTa0g22fSGnzOrs/
         fuW3MHjkJ/gRTIt7+eXVYg/rJmyKh/y0JbkQ2PIMiQK1W+dFgfFDV8Rez2dnb3J1Kpa4
         hXNA==
X-Gm-Message-State: AOJu0YyH3966LrAVBfCkrEZ1oSCUjMciLl3aJkkY0tZP1ikW5tS8lBJZ
        zIlZdBS2/nHfyrIqlwZQViLQ6g==
X-Google-Smtp-Source: AGHT+IFM/lpqUyVAhbMPMKL5aNIUU8Y2d2td7/wT/Q4RZpTSCZABxHEPsS/89HX+GaB730z6a+XDOg==
X-Received: by 2002:a17:906:4708:b0:9e5:2e15:35c6 with SMTP id y8-20020a170906470800b009e52e1535c6mr4195362ejq.44.1699865782434;
        Mon, 13 Nov 2023 00:56:22 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:21 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Nov 2023 09:56:12 +0100
Subject: [PATCH v2 01/11] dt-bindings: remoteproc: qcom: sc7180-pas: Fix
 SC7280 MPSS PD-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-sc7280-remoteprocs-v2-1-e5c5fd5268a7@fairphone.com>
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
2.42.1

