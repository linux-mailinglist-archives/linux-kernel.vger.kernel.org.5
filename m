Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903D37DB652
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjJ3Jp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjJ3JpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:45:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0A3B3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:45:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso58448421fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659119; x=1699263919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNThzkno/tA8gx4YDIL0XR1cAqXysXZOv8m+VhoO3R4=;
        b=X/8eF8Re7RWynGrRJwEQPRM6aXycq9dYnOWd4of+wjPfks8och01IwIpvo2wpsEws0
         TWUPgpjccipo4LjIgTKoAK4lfKqiZv2afR7ZO6QTrRi6k8LYQ7nxfAZecOol+KVXg9xh
         EvL2++0gm6ziKN3LmbpRheLgPfsWfMlguOmw4hANB1maLhrWeI3AVLq5tywWTC6RT+mD
         KCjA+V2xivHqnuF6eLg8kLgWgVhXe2xUZCj655yytN6TdZAyfII7/Y8sfMN7U2OQOCCT
         rChaHkd9b9iWOsFj9EBZorOEyhW4Dki0OzRQv2jJX3bgnpnsWcANWbWVCg/ybOuv7DIQ
         BtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659119; x=1699263919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNThzkno/tA8gx4YDIL0XR1cAqXysXZOv8m+VhoO3R4=;
        b=Ya19V/cPVqoGkfZRyshUEvEyNkBDidyfz1QoAPyPT4SpkVjoiza9h2m6SCJsORK6vz
         u+TAyvxN8W6sme4idgl9Y0C9hy/GjzsPSJOsLVQlImbt74vGoTAahKX/+V4goZ5aoDX4
         LcAJL1cDMbuLeeaM0MEviBaltHcpISE7sD+1dstc4edMWa7zYzS7WJrVHXiIlaksy1Mg
         nQ3fdGkz9Ui+cxwV0T/E2SBncy273iENdUY+uRabX4KrljceLMj8rdcbTD56N7Q46+He
         nre7DUhqN1+7Gh/WoFDxnoirjyYV/HYz5M/FtnHbc9Vs0SOg686651VQSDzpvVp/XQfC
         eQWQ==
X-Gm-Message-State: AOJu0YwrzQe788SYfrnUN3/3WIH4qLJ8Fp9Y2CnrYZPtRqGI/QbJGrVY
        xAcp/OrXe36ZnJswnsi9ufTiCg==
X-Google-Smtp-Source: AGHT+IGVqoYBYMy56KrphfcbYH/RLyiBlAjz+81fsWZI8SZ8xt+RgVK1ENtkGf3wvx4LVFm8wdpTxQ==
X-Received: by 2002:ac2:55b7:0:b0:4ff:ae42:19e2 with SMTP id y23-20020ac255b7000000b004ffae4219e2mr6654721lfg.58.1698659118805;
        Mon, 30 Oct 2023 02:45:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a10-20020adfe5ca000000b0032f7cfac0fesm5069446wrn.51.2023.10.30.02.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:45:18 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 10:45:14 +0100
Subject: [PATCH v2 1/2] dt-bindings: cache: qcom,llcc: Document the SM8650
 Last Level Cache Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-llcc-v2-1-f281cec608e2@linaro.org>
References: <20231030-topic-sm8650-upstream-llcc-v2-0-f281cec608e2@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-llcc-v2-0-f281cec608e2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=746;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9t+7uRPAjXQpmVyEoYE97yTfubZ8aUYnCpovDrgVtVg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP3ss8VCmKwb+4Y3OIqEt4sK8kykpedFWcHZIFs0W
 GY9PKoqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT97LAAKCRB33NvayMhJ0ebVD/
 wKCmio+QYC0rHtr+a7+B4sfcoxAC0KtaNkUc3e+R8ZcUCBcLQkKgMzAmlM9C4xQYvrRbVCSs8uDPAD
 WOtDQ6WHWQpjdV4VIhwDh5sjIaUqMhODlRVcqPkYhvXgSxuh9SJtzqzRrgv8waJPmIJAgMVOpWvwbc
 yjq1XrjEHGo/UZUzhl7+ZJ21xtaiYXO3+63aS7AEVI8jcDtk1+3kxNUD2EZ+HfXjAs+WQxoVOAawL/
 oyfOs5C4Flk6+il5go2+ajalW+8mO9cYGGGGx4iLqqBCmKtUGrKlJOB5WOUwg2HiMPEJOizDlK2Wnb
 G1VP+nYRQxlbSdJ6fHqAq8EAbCd0yJYpsjwbQlKovLc6V1mgF99ftCO5a0SnllOnAl0vKmxI5ruBQr
 37w1n6u5/JyzKWCQ+txtNlnbWvgOicj/SGoREm5DV2rIY4EqR2rYVI3Dpj3u6ozSnq8df/qZDBlMoz
 b+fYGiE4KKTw7I7/3iwwmVDfSwf/3yMoQgziVtjS85mLLe6wJ0Ad1qUBAgr0CM0J/b9NQZNwEzMXkN
 70rmfIyWGRYag4VY3YP1Xk+el6pLcXJgiV9XbUcKq0W6asps3PI8g01CrTIgNSStcP10AA7rEjacqU
 KKx5XDT0IMqoHyyBedxr4cYxO/yL3z+U5EiU/VmMOVeLYYD9WVDxShXeXX+w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Last Level Cache Controller on the SM8650 platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 580f9a97ddf7..7a211e35e166 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -33,6 +33,7 @@ properties:
       - qcom,sm8350-llcc
       - qcom,sm8450-llcc
       - qcom,sm8550-llcc
+      - qcom,sm8650-llcc
 
   reg:
     minItems: 2

-- 
2.34.1

