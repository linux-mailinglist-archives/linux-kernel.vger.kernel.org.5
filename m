Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57AA7DB6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjJ3J6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjJ3J6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:58:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1553711C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:58:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4084de32db5so35527875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659882; x=1699264682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUKa+dq+yboEToV9c6wS680Ux5CIHHimAdjadaUPKj4=;
        b=is6GpgZVk0nr97OimA+v0V599OyY76WPzXHImVeVgV8mTvbtY+VVY5bYdyp8pt0VpO
         4sG0yy3UcYllNleiX/+tco3q4rzIToUXxJJfmDpNVeqIn6sqRxUmoqNEFw8CKthl9coM
         4JjjYDTTiKNQlToumULjY4+V2JgpvN2v8PaowUAK5blhQT4lIo8Z8BFLy3Gb0Qdo7ODx
         ypvFVp71oCQ+xcF+C3GPibQGRhc4PPnmjy2a+UY5yJc2XDT/UEObeBBlNxvyZCB6FjOk
         SpY6dZcy/gEDztQcw0IFr9cjmA6rDJt3pszkijqHdBTJaED3wkrZrr4T61flSkY3V7j4
         +j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659882; x=1699264682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUKa+dq+yboEToV9c6wS680Ux5CIHHimAdjadaUPKj4=;
        b=EwJeoTiMakMzBBM+qw9CWXM6qJpEuN3+hapdn9a96A8opDNVHSbv1cUExZXPMHDfOj
         WtjXSvWB48zxbZ8fh3m+SJnwKrtXiwANxkSouKE8BRdOaL3m31C32rA9rnhMhKh/doTA
         YR/aJmQ3Y6u9NphPVSke17Q3oQeAus6MYVYdGmLxR1zdJeggZ02Jf25rj6f11UAIo53j
         ESeSeJ7H+fipCLi/V6uf2ZWS5bTzQd8N5qKpDPZLHKvGXbgVgrHIlk4yrFDkETwgGXF9
         ZULbf/V9pAHPHCyrzb+dgdeajsS+PaObD7HrJvUxMhaCR///uHUsdgtQWoKE4uFO7sFm
         JEEg==
X-Gm-Message-State: AOJu0Yw77Yb6YQ3kEz7kkuf8Rn6f3md4/+dyjbRNTW5Wemmm0RDrkdd7
        oMKky8cLTqyZvIASLlZ6/sdfpw==
X-Google-Smtp-Source: AGHT+IHVsrvswZ/Wng76D9Yw4X9SzjZslqNvbPOy7uP7Nu6iedTaWK7qWiumdE7z1Gpv/xUm8/LgSg==
X-Received: by 2002:a05:600c:c0f:b0:405:458d:d54 with SMTP id fm15-20020a05600c0c0f00b00405458d0d54mr7694233wmb.33.1698659882514;
        Mon, 30 Oct 2023 02:58:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b00402ff8d6086sm8703714wmq.18.2023.10.30.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:58:02 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 10:57:52 +0100
Subject: [PATCH v2 05/10] dt-bindings: clock: qcom-rpmhcc: document the
 SM8650 RPMH Clock Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-clocks-v2-5-144333e086a2@linaro.org>
References: <20231030-topic-sm8650-upstream-clocks-v2-0-144333e086a2@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-clocks-v2-0-144333e086a2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=775;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3OGk8WniY/E80D7AnGFZsLrGftq5gP+nMB6OXCYdMrI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP34hShmOzsR2b9L0oaoVascRLZOcZVGH5x6fX34J
 NeDb5vaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT9+IQAKCRB33NvayMhJ0V6xD/
 9TSYUCbv3OQqv0rEZCHu1/ATFtcfvBA/2NBnH2oXasiW1mvBBnnqMSTzI9BgptQ9YyCGWIe62A/3Ak
 iVcgLg7d/XRe+/JFEYkHmgpTKDdxqfvVhLBLpDBeR517i8rn6xwZ2vtTmBFNcDNz8Np+oUijDGuhR/
 ENewGOSzQxRKw9Wxb/8yI7FM4lAqIfcvsrvvHS+T7MLDaM/zFdyLroMQThTyqFhlwP6bnsrybWYGX1
 Qc8wtU9dNGcbUNTO1C7cy8kwgygdOLNx6BOPlHZms4Dacd9sbicggqZhNLs/cO3ArcOgCRvxEYZ2Bm
 2z7qlVP8odT7howPIlOJksU3wZgPfK/OLq88hJUfceVpPNjg/5uXi4uRgZSfY4R+RnvhohYtokfyru
 b6tdtoqegu6uAEpQACMQulVAewQjvuw4fKlADLi7Iy1h6oWeMiuXgYz3IEGzgSowPuibJfXL+zWhCx
 U4+ivQkdpTTy4ifFQUO2W8AlomtreHhLvlS04Vu2DlIV8VOmyBSUoto5y6qtuaHubaJnfG1jYl4Srs
 Qqb26tBRS/hDzFP+NaKS5f2K8F5nC0F0GT6K9HYVT+WBmo3RdsCvyBu45njWULW6M9Ybyj00p7Ts97
 BVL3i6Vo4RDl5Jy5LkPJQ/qA80dyOBYzZMo7JnzL6GLw5qQ7tWAZoxg1yB+g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the SM8650 RPMH Clock Controller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 4eb5e59f6772..9be952a5a227 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -35,6 +35,7 @@ properties:
       - qcom,sm8350-rpmh-clk
       - qcom,sm8450-rpmh-clk
       - qcom,sm8550-rpmh-clk
+      - qcom,sm8650-rpmh-clk
 
   clocks:
     maxItems: 1

-- 
2.34.1

