Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40C775EE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjGXJBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjGXJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:01:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38FB10E2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:01:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so6332450a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690189274; x=1690794074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Si2yoaGJd8rFYolBA9VeX61ymzauJu7lrmelvkXzN9A=;
        b=RX9jxoVJ7L4k+NwTCgax385PfImAKzUQupdsP4A854pBV0os8TEYukw6ZnsgO7kPDx
         L8GBuF7WgqwChMoG9WizE0J+l83e1F5QRAvGc7K6zFBPaDsFZePvF1QkNYlZFT+Iw3lC
         ODs9sJxQJv5ocSIK8FqhlljRCe5AdnCs39TkX+R2JpRL8bwogljZJKktwuvkpGqHp4ni
         VmUSq5VRtzazEmhW/KQyKDLifXvBfLK5bPqjz2t7aepOzUqZ6M7BvxMCRuOGYNKfzzJR
         KNru7mu2XVx1i2LBn7pMVmsKrB+IpaqBDBfaM9W4/VUwppcatEIZ4E+kdMqHpOra/+2M
         RCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189274; x=1690794074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Si2yoaGJd8rFYolBA9VeX61ymzauJu7lrmelvkXzN9A=;
        b=BhZFx8FZKCPXGXrOoGC7QiOHM9Qco/jDX1zSyXvofzC1qB1tK1xk8DVSNKXCtbYnlt
         LgGFMNCQsShWhUuZOse2f5zmiZH7kOtR1kOMhClEGZgfbzYunkw6FzcgFRh0y3SByRNu
         uL1xQYls6XBza8l/1COotpGRVK5SS9kZoveQiL6SgDl4w0nYvzgpcn168lA3ey4dFImo
         tJCulblEpSse8oIsEh3JmipFTOnl43zNOrbdbTEaOhh/w7XjWvCtrpN/DO2nImVFQUFc
         vsV9lnU22KOt0LG4j/tKyMaJZZgV6mnAqHf2VKTAUMhjYidoa4OOxiJnit2wNaMOQQvK
         W22A==
X-Gm-Message-State: ABy/qLYj1kd1pun5lD5QPZRaEIGFOA7xafHAB+lVwBPQC7/4s/3idMj2
        p3o3KVbmCymHHZaooI0ugCqjSQ==
X-Google-Smtp-Source: APBJJlHGICB2pi+S33pYSU0fHTt8wueRV8hkNceUL4zuQg15oE+05BXfChWepK5U19fmg6KcoxrRvQ==
X-Received: by 2002:a17:906:9b:b0:98d:fc51:b3dd with SMTP id 27-20020a170906009b00b0098dfc51b3ddmr9742418ejc.41.1690189274233;
        Mon, 24 Jul 2023 02:01:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709063fd000b009894b476310sm6384819ejj.163.2023.07.24.02.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:01:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: arm: msm: kpss-acc: Revert "dt-bindings: arm: msm: kpss-acc: Make the optional reg truly optional"
Date:   Mon, 24 Jul 2023 11:01:09 +0200
Message-Id: <20230724090109.19489-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 981be238e1d28e156aa9da2a8722f86f02fd0453 because it
was totally bogus and duplicated existing minItems:

  ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml: ignoring, error parsing file

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
index facaafefb441..202a5d51ee88 100644
--- a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
@@ -21,7 +21,6 @@ properties:
     const: qcom,kpss-acc-v2
 
   reg:
-    minItems: 1
     items:
       - description: Base address and size of the register region
       - description: Optional base address and size of the alias register region
-- 
2.34.1

