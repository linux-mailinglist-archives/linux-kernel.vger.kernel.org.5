Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F87B78A717
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjH1IGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjH1IF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:05:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A1123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:05:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so24981715e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693209919; x=1693814719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H6vpb7vz8I4elOBNs6E9tcR89qbBd43TTRc4haGCdE=;
        b=eXAQx5mIYJLteB1/kjkx1jM0vJP9s55L21WgpWJLcFABdk28qow057Qi5hIZMF8GsJ
         3O/zxYyuz4IYKBeepD227Cdqw8DA+bQSD2KAygDBG9wqn5nWjNgRHIFErNVKq1c5iwKJ
         IyEuMyUZKJisgblRVifxkla42J921suJf7gNf9FbhLUnSAEa2rIB0nhVZ3hM9RF1EZkv
         IXlFzUcfU28pvL7ZMwWKWVEdf2dwmcnlyTLcgMcn4TTKMB3qZrX6UJP++Z7QgQ5cUEgc
         0N1kOZ7j/6jEklmujR4gpoE+8xpRONWJYEXYbR9o0uJdVxe6M33ZV94cOrJPAR/d8eAX
         +n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693209919; x=1693814719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H6vpb7vz8I4elOBNs6E9tcR89qbBd43TTRc4haGCdE=;
        b=k+pEuwOoEllGFwZQH17bhZdTcld+AR/5hm0NuHeZHJpITMAis+fDqGverv0KTLp1N3
         4JcB5JYzILxNuiwTqOMrsURvVTp9/mfi8oiBf7CGOsxB1c9+rcOyVryezGR4fkyKBvQs
         guhxhyqNPJ5agjSBTdZ2KZP2AdDnT6bEhq9+xPHz7ll/p/MWdeKPftPV6IxDROqSblOg
         LazWN9fqSQarhdsfRzJeZ8vo5HKfq8B0gw2nxNy7EiJCV2NAsWQCg5HV5tIYROgGW4nq
         9kMuxlLMDAIiV5dIfvbeZUfgAeZpLSYAmVnlASEBa7RhXM8WItUMabwXq0OdibsvgL85
         pILw==
X-Gm-Message-State: AOJu0YzX21OeiCizfiLQnyWbhTt/GSYMLSoNwUKh28kwQjtJjWkhb8Ci
        4EUs0t+KSBnqwZ59lAflh6se1w==
X-Google-Smtp-Source: AGHT+IHdO24JFhU9CHCfYSOpLnq0vwHNEayFbkbQPzMH31amPzA7JkJI1G0Q1gsAG67S47gsU2PT9g==
X-Received: by 2002:a05:600c:446:b0:401:519:bd with SMTP id s6-20020a05600c044600b00401051900bdmr9007695wmb.37.1693209919695;
        Mon, 28 Aug 2023 01:05:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id z16-20020a1c4c10000000b003fa96fe2bd9sm13067035wmf.22.2023.08.28.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:05:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 28 Aug 2023 10:04:40 +0200
Subject: [PATCH v3 5/6] arm64: dts: qcom: sm8550: add TRNG node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-topic-sm8550-rng-v3-5-7a0678ca7988@linaro.org>
References: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
In-Reply-To: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pEfVqD3bo2rwpc4UXYzUwHbnl5WWQlZjBsz2SVzEcNk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk7FU42CR3DBT8IftFWJDKHNPN2HqvE3iv6iB1jeTs
 8RiwfaKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOxVOAAKCRB33NvayMhJ0dr3D/
 wMd9jubMSwmfygqPzjlzwcke1LHpDbsjLes9oCKTRnDnAHzYgOauRpYaS21c87JUmF7E3WmWrhyEhr
 2jXEsoVjae2VbbP5+SQ3mWZHI60uzIC3Hl2dnd2365wGJ6ZYzMfI+c/y+bziZMPRPzw6mEJ9gbiteb
 /2lwKKw2aeERcOOFXweKibcCJRyqKCt6xy2+HxKen3HQM7iZwIrouRM2l2sguYZLHHteJ7WPfbjAce
 I8gdhEhbrP58J9HVBuz5lb4yQGo9dhsmdNAGJ5VM1vUBzw6MLZJnzxCEaE7r8IyROILloATW9tJcDo
 ZqdJT+ZK2CJJgts+X5OLHt//kYENqAYcJHw0CtLw8FAlXPwSpfQDicxnoXc8xb3kevEE2UGEAs29TK
 qk/goMw9FtR8l3s+kbbyWb0mtQNzmwwANd0dBhSRJT08OklKQURerv1zGL2A9GqT2qaAqexts/7I2z
 rntGPPq3IkjXnIZSZSGuFM5Uxrh3iyGDDyqdNumlPhaHHTt42oImKyTl+WJpx8Nd4H6xWJsQpX/el1
 0SFf3SwZ9XPfpPBeeJHA5Y/xIoiWds/bKDWJzjDiUVRyGWzpIhlW7EK0p2GtGGu7bYqvF/2oH7T7gD
 ynGjpfQDBGn81KziJsSpSc1+vYQJ8H5uUX6nFLq3TB6Se+rs9MyqRtBKSk5Q==
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

Add the Qualcomm True Random Number Generator node.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d115960bdeec..c42c5bd03a37 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1661,6 +1661,11 @@ mmss_noc: interconnect@1780000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		rng: rng@10c3000 {
+			compatible = "qcom,sm8550-trng", "qcom,trng";
+			reg = <0 0x010c3000 0 0x1000>;
+		};
+
 		pcie0: pci@1c00000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sm8550";

-- 
2.34.1

