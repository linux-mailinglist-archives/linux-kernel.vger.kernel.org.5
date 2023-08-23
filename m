Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8732785952
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjHWN3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjHWN3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0FFE6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c136ee106so739296666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797292; x=1693402092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbrWg1Qz0KH3Qccenl+/SPqOk9dbSBcuvMF62khAq+E=;
        b=gmQdLuXhIadC+3YGGc40tOGalbCnN/X9d/PD1wRScndiRZJOfVa8v5NZc+Ntkkcevm
         sbQMZNJVZxTktjJh/aABaAQiAPFzNx5G/aQmlIa9ELgL9X9rFE4sfmbXFmUlbhbXjtk6
         vGp2GExSk+PCFNMon6JLMETrU49dtCfBpTVPdN0eEpapyk7flG2cdGEMNrDGBvUY6isN
         aWNy43o27NYCx2+Vo3AUmRmIu6JUuB8Ac3BVmFLFt6DDDY9MBnJE/06w1gBzT6uE4NAH
         zk/+Q2Rhm8exA+lLsleYxbskTAfmIwHny+Ff3DBlggS0jYfdafH8unSMkAxbD8rdnZyW
         3kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797292; x=1693402092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbrWg1Qz0KH3Qccenl+/SPqOk9dbSBcuvMF62khAq+E=;
        b=Xmqr8o9LdlKeny//o1dnke1qJdfPugokngNJVoeNJDyouPUnDCPvBTUs/VB9pqVSMW
         37x2Kg3Ei/+/+XFnL/pNF2t5sOdpHdNdtguSOPsy1d/y0ulweUgdxIx+X4nQrs1kvF12
         RWYDhoPfy0avSoV2YBnKi8wWHh/0FzZ8ri4hNe0gEZEInQ39vHOEbidQlE38mkPk4xCW
         ymFIqRtYqnc8mjye+u9IWJJKVbibc63uibzXm3Z8gPtbU6Kzaeh7M09PwpgDBXQ1lyj/
         wLGdsh+DMgqy7tr0m4aJx3iQcGPsw4kz53pajwPQO5PLtevjtjjPzkGppzcNaQ3+jgTM
         16Kg==
X-Gm-Message-State: AOJu0Yxe4Kq4czVpf8/OC1u/FeYUp21y7kDYHg6S1vE+eJLOuBT8lhvP
        gWdl4e0wejn5XCt4g5hTueyYhw==
X-Google-Smtp-Source: AGHT+IHVkYmn7tTPnfaTsMvSddCUbbqOb+YnMjZT5k3Y2Mpxq82uOWIVKznNyRfdf3787Yj0Lm2gYw==
X-Received: by 2002:a17:907:2709:b0:9a1:eb67:c0ce with SMTP id w9-20020a170907270900b009a1eb67c0cemr949861ejk.50.1692797292309;
        Wed, 23 Aug 2023 06:28:12 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:11 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 15/22] dt-bindings: nvmem: Add compatible for QCM2290
Date:   Wed, 23 Aug 2023 14:27:37 +0100
Message-Id: <20230823132744.350618-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=h03cSLldpMrJptCunUVQKURiMe7oNZI7A+mXhMwapFo=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glJNmWQm7r3iQ+mopTVWkCaO+AFjfvswmL43 2KyCMIJj2SJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSQAKCRB6of1ZxzRV NxBOB/9iXm3+bIQR9s5JQ+apmAJqUpfR1I2GoSEgq8dTtH3Y3BsgmD8x5kgsLBSkpx/IbQiRfQs c8DDvamF8KLN15emNb4RQsnx1KsgBY8J39zlSfU+hEaQE6I24NvsWTh20LWcxeTVYYd/TV2acKp dgOO/b14JG76qIdimlwul+eXSC8HeCN5RiV8Q1YSiqWPZaw+yYsZ3n/FVs2qPX9bp7OMEsGw73S YDSnWDxYMKscRXxfGZBEpn9Y0oZ7H0EH+4yEXvXO1V3nSl2huIC0CaqL41nJ+IvIioxVz0QOlUy Sw9/zd4uI5XTv3lb1xKgyzyGDppDEzTTt3WIC/tNVsDMRmbu
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index bdfc6d36a400..8740938c32eb 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom
           - qcom,msm8998-qfprom
+          - qcom,qcm2290-qfprom
           - qcom,qcs404-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
-- 
2.25.1

