Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA8E7F63C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjKWQRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKWQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:17:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D030510D0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:17:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b36339549so5629745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700756265; x=1701361065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1QWKo5v1x3RldbHoETv2ObEXLCGaOLMr/Qq6NkPTAw=;
        b=PuKHJoKZOgm6NKkcURNE+DT/ehuqGdHHOs25dDJque7EDpPzXvkgfe0G57xSgAXzl8
         EasBU8v8YqqL3yGe1/98uicjkxfFpIRBoJDtNBUaLnh/MIkAmMHH5DjP/SSVD2H3zG7L
         mQZiwekWNEP0XgfweP2TBNA/NUNnrx5Fd04YksUa2tqJMGyIl258Oyx3ia8oaHfNd0X0
         RtDTQcNXScxMeMMoJ3Fn3R9qf9fS8csd9OBK5Uk9z78ckE+oRDb4yvBcjJ/e6aoK3Ot+
         IcqTQdLnDw8ZK1JfakwjTEvOu9Os5jWwxpSYTW2OsnhMt4YwC7NAXfIz8hGnPp2oUUob
         OrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756265; x=1701361065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1QWKo5v1x3RldbHoETv2ObEXLCGaOLMr/Qq6NkPTAw=;
        b=pKQNs+/zybkETKK6qvgdZ/XQ5tAaXgCrTQ7Lape0dNjBhASn0F/lferoTJF0SOZycC
         NIDlr372Ar4gpfcsEPuLO9s92nnctZtvKdrdEvNdt6LlGpdohhsYI+laZ3KCNbkECRgy
         ZWMpGIaMYUPaEVUHK533u9nTfjVD19fUjR4NN7DfKgnzIbaLtbFUJB9TWBjus8zrO2vy
         oQRv5vy+tE3UmqV0XyTea1vqanHPPPzRSN4kLKmOifGHcWVdBjtR5Y8YWEy9NnPw84ql
         8yEB192PtJosVV3ZOtqDwRDmAfkvcpFEV5zUslD1IO8XeRLLd+3UiVYRYXtMPwUglRGP
         /tGA==
X-Gm-Message-State: AOJu0YxlTOGHnLdrtHOWuepW4leT6T6onQQX9S+qOjpGj4+dymuaol/X
        8QWvJBP98MHqdF5Ywfc83IwaMg==
X-Google-Smtp-Source: AGHT+IHG1IHPzr5+pbBp8rozL88cTH/APU9g55yvH+q/8GEbtJ5D528qSdJUOc4Q7WvVqxqFHAVyUg==
X-Received: by 2002:a05:600c:354c:b0:405:39b4:3145 with SMTP id i12-20020a05600c354c00b0040539b43145mr75899wmq.2.1700756265210;
        Thu, 23 Nov 2023 08:17:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y3-20020adfee03000000b0032f7e832cabsm2052748wrn.90.2023.11.23.08.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:17:44 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 23 Nov 2023 17:17:41 +0100
Subject: [PATCH v2 1/2] dt-bindings: power: meson-g12a-power: document ISP
 power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-1-61f2fcf709e5@linaro.org>
References: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
In-Reply-To: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=643;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=TxQCQp8KexETWz0DJ5Ct9muX5KYY3F1pMZr7p8jc1eY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlX3smKF0j7nA9VBHAoArGETDgFABLBq+akOAUMfBw
 jks/YGWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZV97JgAKCRB33NvayMhJ0c8+D/
 95IVvCDmoe/Lg2/8P5KkyobwLXAIcequgCcdntyasiSIm4J1E1f86uko4BSsU5yVlpIaaTRrQ0N/3R
 y5hkNE24ppDxdjraw/K5W7Lu3ooELU0qiCiLJS46My/En8UXBv52LSI2RjzUA+IH/xXswYlvt8/RZj
 Cj1BmDSFmVewFPyctRF5r8YtaEsUQMhUd6lOxIP1OFE02wlQdklaRnjGH2DY6D4iFXg+NMwGUJ1Kt2
 eygrQ7B8TuV5alfnzgQvPvwBCws6dXOzVnufEGz6NcoZJoxCjcy+nLJhWa72KyVMFeiE0XT3x0mtC6
 Ru+l9E48F29MPVit+ijBGu1SkEfaL17/yqs5vJ6S40N+MfQ1Ta7A2pOQr855AsXn3ZTHPX1Vwp/FaK
 5rspfLzkyL7WvQXVCGbK5C4/+i5ltdiJgq7UDpXcU5zfJNF3YnKDTnd7yaOuWdp9ihmGBi4kmbSjG4
 cvq2oPuLGlmsmVNw4gUoYj3kJIGwnIYtFzWGDNWgC3YJBktymd+L39jSAhdt+B4lxU2UaGk8OUTJDz
 fTm9YxSUls8SXyiRfkzZ9f/X0w0WDzqYXT166ul81xaq4aaAan4BQLwcPxoTgewYTPbMo/4jIcjKcv
 yDMMFdXEKi5qq6578gj4ZwfuR1+G27bQcwYruddf39cSSN9vfdIOFt6pTVYg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI ISP power domain ID to the G12A Power domains bindings header

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/power/meson-g12a-power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
index 44ec0c50e340..01fd0ac4dd08 100644
--- a/include/dt-bindings/power/meson-g12a-power.h
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -10,5 +10,6 @@
 #define PWRC_G12A_VPU_ID		0
 #define PWRC_G12A_ETH_ID		1
 #define PWRC_G12A_NNA_ID		2
+#define PWRC_G12A_ISP_ID		3
 
 #endif

-- 
2.34.1

