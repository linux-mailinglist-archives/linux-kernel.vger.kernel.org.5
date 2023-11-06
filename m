Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9294A7E1C6D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjKFIj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjKFIjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:39:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED410B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:39:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32f7bd27c2aso2958765f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259959; x=1699864759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxpSuXDoom2RWs6bn/SJPon0BVz9GrlE7SEKe7RDhZw=;
        b=u7w2sVRlHwI+2GsGj4vUq1P0BAsc0fnW464hE2I6fj8KjeWEi0nEsRwYeTS403Mqcm
         Do2KBGjItaAbw0PymJpa+UxIY7LmowAEofe2wlxAS1BkBEKPQgJC5FtVOzttYsKsIUHO
         RY+cH+We85RqdZe4bvzbosz1i/+QJqOalpL3pA9Fs0lNHKVitF+wVkd31uuP3rdkMco0
         Km07s7lOwANiPvzTNc2zW8LOAOrrwfJHRkZt65cEo2wqyPZsZX9pvnCKsFMQOsEJiDTt
         GupD4JXpBKjrxdqZ1VQWm3odvfOEFjowJpptAAbQdD5YnCcwpKev9RQV4WTb9OCkwL56
         26Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259959; x=1699864759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxpSuXDoom2RWs6bn/SJPon0BVz9GrlE7SEKe7RDhZw=;
        b=lcMOFJ94u/eQHIQ3YCHxTTldsj2ejynEB4bsHTDhSmjLBXH1qUEAhPtpniQMZuw3ku
         WMu+5RL/jc1OgKugql5NMQfMTjYhgrX+C3uGAIvvFBNUtBhjOEvIq2mcdJvKV2hBWC2z
         p9nwWjgeOiFH4Z6hQ42UFdNd+R0FnbnLH8lcUS8OsfpnCTbtYCxPM/NR6iNG4+jTWNqt
         SrC8iEEJIwBGcYR/WhP+t9WhIgm1n7gwA8Q1KljIK0kz670IuJFqlJRG2d2OeKIJ/hAD
         I9JYR/TwwVw32UB5oNpihN0BjhVeKbRal4sYlIoH/UVT9aspe/Bz7cVNJ1CvT+YDvoxI
         ftgQ==
X-Gm-Message-State: AOJu0YyLaO/BmG+u4IwbyG7zA8HNU7MrCmd4afKkqDnc2Qhj//t+m7r+
        K81hO1DEblakeucNYW9A+fDs6g==
X-Google-Smtp-Source: AGHT+IEhYrXI9itv6YupEtvTaN6G/zOpcHBoWVN/YscOkhOcyrbglwr583huBxTB8M7MU/bgvo5W8A==
X-Received: by 2002:a5d:508b:0:b0:32d:5cc0:2f0c with SMTP id a11-20020a5d508b000000b0032d5cc02f0cmr22081873wrt.40.1699259959099;
        Mon, 06 Nov 2023 00:39:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t5-20020adfe445000000b00323293bd023sm8829830wrm.6.2023.11.06.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:39:18 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:39:09 +0100
Subject: [PATCH v2 1/8] dt-bindings: arm: qcom: document SM8650 and the
 reference boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-dt-v2-1-44d6f9710fa7@linaro.org>
References: <20231106-topic-sm8650-upstream-dt-v2-0-44d6f9710fa7@linaro.org>
In-Reply-To: <20231106-topic-sm8650-upstream-dt-v2-0-44d6f9710fa7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UZ2eQGqqiWNvOpQYnbzT/mou5C8lbL9c01Zc1IvQLo0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKYxtLSXOrk6lCKW4cwXYxjE5T5XelBSBYoizKv4
 iuGJKH+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUimMQAKCRB33NvayMhJ0R3YEA
 CmqzdW15GvV0UP3/bQQd3cMwJrlhz5hlGK1M/lQV6JbRrpZri1kjygcwNchWj6Nl3Xvav40q3KsBm9
 Lff9ocq1tiulH1Plpuq0z7eoVoBnt9arKYxQumEqGt1pJeYfysB+RxffDDahgNaXD1L2VPU49O3EtJ
 yExz39+N6RgEAGijAnltzT5JEyETs6jObLVM8/8Od0XRojxq3h45c+2L4HxTxE9MvEIcbGAh0WaN2u
 Yn7EpPsNpSFESjup49Mc/vqdu8szJ5gx/57fz+H+gOCWjgtKIWWg4tJRLH2ghEvLjidfg0xUQnhOuS
 3zr5x1TueXEDar4l0WdAI7FTuZU2uMwmF1mmGXIEIE+MNJ+ZB0GTDUmj97/Fp/VkzkxfEZ07PUjDml
 MZOzmUppL1mnVLdEejX8X6dLISv2cbJSxMFpOKQQyDTeQ5bE6o9gu6hLd/eVt44bTly7pyCBtx9pXG
 lC/KI72qf158Q2kZAJtcazvD73TTEUJGr5NxcL12PPGNr5vbgjTZXcy0nK8G8+PgNBMGQ4tYmmnHs9
 T1SvVJat5ruui3GcS2BkssweBHviL4L5ykyXTv9hzHzg3oxOGC6vQ4WVV8m/xdvCMbHh/iFBdpN+eR
 Pp5E9ivz1A0LZbdFqFUwoddwx64Hq+t/+Nv5coaQ/2ngqo4tb2k9GjgUsRyw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8650 SoC and based MTP (Mobile Test Platforms) and QRD
(Qualcomm Reference Device) boards.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88b84035e7b1..c5b6518973d8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -87,6 +87,7 @@ description: |
         sm8350
         sm8450
         sm8550
+        sm8650
 
   The 'board' element must be one of the following strings:
 
@@ -1044,6 +1045,12 @@ properties:
               - qcom,sm8550-qrd
           - const: qcom,sm8550
 
+      - items:
+          - enum:
+              - qcom,sm8650-mtp
+              - qcom,sm8650-qrd
+          - const: qcom,sm8650
+
   # Board compatibles go above
 
   qcom,msm-id:

-- 
2.34.1

