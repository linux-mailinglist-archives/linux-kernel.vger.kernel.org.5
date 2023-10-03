Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3040C7B6239
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbjJCHKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjJCHKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:10:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87CC6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:10:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406609df1a6so5748485e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317029; x=1696921829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JssHYOFSSsJtW/9ko+cRQNdDDnX/e2dMOwlr6O98kGw=;
        b=Bw3BUh16HcG7MpTKAbNKrFk90VMe/WAHpAHIOieEahF7gaSwcKWhYUC77JCfgJA01N
         9IEzqd9GFf8nUVNy0iGCOtgsbUoHgAdeIPbvpB7qc7Mf9dJHCNY9QAbIF3SuLDEnaO1G
         K6RqxOQ2uSwsjabILVDfgEaux3xaUR1Zd3HIlcqN4s+e9gmay1Z3BFUP/38U1KwaZdtn
         Q/ocoOccy0aSeqJZbuIER673TLvHNG8XYXw0bXgm3mUgytAXvUo2qfxPoJ89d928iEqj
         Ko0av2QRb6ETeUzybvAVGzglrtjdi1NRnYNata69a0ZJxD3pXGBJmx/DweezGCzi2O4t
         nOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696317029; x=1696921829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JssHYOFSSsJtW/9ko+cRQNdDDnX/e2dMOwlr6O98kGw=;
        b=Dz90PGUaH2oXWNoza0a6DCuz+Yb+Mxd6XVd6Y7ylg1L+0XXLp2IJMVpX9QVX8q9Pc3
         OlsOX4rIIGWJ1Ot+CMm8eLDqcuKYtifq16klm3hOrpMNKDDOfh9v5H1aZPH6ozkfqZy/
         fuio+2KNv/imQEuKTpUUYy9RUypcYdomy3oVr3peOsA7ken5/4e+1/cPR6K3NPGF6ABK
         TrmaAqll5MCSSM508ETfAttJXc7n3yPfZfy4fXBNrcvWEH6MvNmGH/NZCbMbcpM5dB04
         3QHvGPXJ3Esd9B1DBheAJR4ziesnZBl8Tr8NLdeiWRd3Oewkq+d2NURvUYKrYXJfsUII
         5cYA==
X-Gm-Message-State: AOJu0YyilJyBenzmOnlwwxLrl1Hw+HLyKdqVIuF0LoHWiKi15Ym+4Y4o
        Gwoh/pdkxU54fhkYmfaNPoJsOQ==
X-Google-Smtp-Source: AGHT+IF7aHvQpC0Bf6IGTXkdlSkgULFkZEZzy1fGTLIUj9kIes1KcqPlMS1t1CQ10jvTzHteINF86Q==
X-Received: by 2002:a7b:c3c1:0:b0:404:7670:90b8 with SMTP id t1-20020a7bc3c1000000b00404767090b8mr11953540wmj.27.1696317028852;
        Tue, 03 Oct 2023 00:10:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k2-20020a05600c1c8200b004065d72ab19sm8746652wms.0.2023.10.03.00.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:10:28 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 03 Oct 2023 09:10:20 +0200
Subject: [PATCH v4 2/5] dt-bindings: crypto: qcom,prng: document SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-topic-sm8550-rng-v4-2-255e4d0ba08e@linaro.org>
References: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
In-Reply-To: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=577swv6REyO06YPayl/NJ2+pSbFK1mIeUk3V8xet8Ks=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlG75f6qguhMqLrMtJ9Gn1S2J0RQ/8QXI4aa9yW9/g
 BsLkUE2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRu+XwAKCRB33NvayMhJ0Yn2D/
 9+KxFN4Iwpoe8z/Oytxz5DNjMENQctIVVYj3gvweaZjB2TuB6i0oWN3WMeyV7rTly6mvOmsF5OgI2C
 KLBzmmODHtH89TowGcW0md1zjBtKbt7Ena4hw437RyQW4ROGuYPZMIqvtWs/zCsfV3WSkjGSdOPTq9
 oVLVELSr02/q1majkUjPCM4hquMjQPcZqGa8jH3Vlrj7iYALebBzUvQNwPjYjWhVZEBnbQGMqd4xTp
 KRlyyii8ZrR3lUiFHsdhWMsjPa3ztV9H0wH7w+hU/uiOwY1OasCwZ846nonvd4TBRicUujqnmhv5fV
 1yIBI17Ym5UZ+1VCw5Ko651OZatT0BaUyqnRmI4V7MBuFxSIfMErG6UBEr61WzPNtEmu5jwhmPpeDi
 aGYI/w4FQu2zZdv9fGSWXRcfJXjU0wBOjLyJVHIHHSjfcBKUGCHIPSkKPm7zs+TFGf2++ny5sUJBOy
 ctoKv6aY6WDfGFuyUsbc/a+IEJw4glLxT8E9KKsFR0rJGkQq755kpys4OZ4q+XIUGgFuEUYQ5IiTa2
 YASVc2b8t2la7gu8e0mT8guju5tfQcLtxivv0rv9rr8TdZCtS5uKrbXrfAe/oHoygJETZIyvw630Zq
 xa6yGqDLSA2A7kxbejBdq65I0XZbmW3eqgXjuczYD6jbTl9oZdaHgRBmgFKw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document SM8550 compatible for the True Random Number Generator.

Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index 04ddcc0f7165..633993f801c6 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - qcom,sm8450-trng
+              - qcom,sm8550-trng
           - const: qcom,trng
 
   reg:

-- 
2.34.1

