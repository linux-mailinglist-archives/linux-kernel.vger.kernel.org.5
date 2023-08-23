Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B029785AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjHWOgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbjHWOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:36:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7AF10CF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:36:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so88384871fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692801394; x=1693406194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivqS0xEwrVFeeN64R1VkPAP36lNsGjNwDFiLimBnEdE=;
        b=Z1RhUzuucUJ1YKoDqZ6FVaSWpTeX8kStbYl5jjawAr7DUILhVN3elfbANhvCZd3UBK
         sw/8zyeaqjRjyzkWL1T0AGRcR5SES/xHgboV4yU/d6q2e5AMtYoqnM0dhhBM/vnihQly
         Q6shkoUnL74aWeYfQf0G4sEaA1wnJe/0Z5W3vfk0DpAHzYzkaa63uprxVi5Z6fl6n05q
         cERPMcAbacYl4RQFwGuwzs72nyVDowjVy+nRd0CvcjVeXXNCMReu3dUG+dp6Ag5xodbK
         Z0EharSQv4D6KWPHhAv9sSNUM/OPVnKP9BWOFGlOucWtaRB5RF8O0hKm0t4+Ec1NbE8T
         cQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801394; x=1693406194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivqS0xEwrVFeeN64R1VkPAP36lNsGjNwDFiLimBnEdE=;
        b=cI0TksxMLhXKBuaAUSPrJoqU6phdG2LoHFptewuh+9dOVer9laUYB+oCN0JnQFVbtI
         2B3e9chUnWNSi8qhx0q034xSF9bmBe+JtzIWQULbvTswx+6SErpzv08U025TWg5EyIWB
         feGAjbNn/HvjwWqT3sNsmuQ9062qNGaZUeHGWv3M6yhFKLJbkgog1UczH0xRYOX0CIie
         UChU1lbOi8Om67yZ7AZqv4Q248KhuQBpYuqEGnmon7iSOEzgjuPgQIgsOqS7kKPtad+K
         TJ3MQIdJY1I6Xj2CfIaCpsAY8aJ2jUo4eo/iGOJhoVhXpxZ4Nxn8VnzA3hs5KWjdOdK+
         SDww==
X-Gm-Message-State: AOJu0YxenZLbmcg5k4nuMvmrktVOBKI4eApGWD6wBZCQF3hb5b5CUJAB
        yNa+hZH/95CoPHi/OP15PaSxAw==
X-Google-Smtp-Source: AGHT+IGhYtqDsu1Foae0Bp0hasc1syDFC0sos1npv/eWwKQThsKzgMlJJrspRuNJftUmAvGqbRJejw==
X-Received: by 2002:a05:6512:a92:b0:4fe:c55:4861 with SMTP id m18-20020a0565120a9200b004fe0c554861mr11048535lfu.53.1692801394003;
        Wed, 23 Aug 2023 07:36:34 -0700 (PDT)
Received: from [192.168.1.101] (abyj76.neoplus.adsl.tpnet.pl. [83.9.29.76])
        by smtp.gmail.com with ESMTPSA id z6-20020ac24186000000b004fe36bae2d6sm2668882lfh.81.2023.08.23.07.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:36:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 23 Aug 2023 16:36:13 +0200
Subject: [PATCH RESEND v2 1/3] dt-bindings: vendor-prefixes: Add Mitsumi
 Electric Co., Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v2-1-9f1b41f4bc06@linaro.org>
References: <20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692801391; l=1125;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cMf7ni6nLZNuOnZX2l2Ut6wq6sxntra5jVOeRd5nM1U=;
 b=cgPIWTlzumQQfj+VC3sFuor7PGW/b2+umgB6fw59qDGWXx8IgkpokMDQNSex7Fp0hIvIsIlc0
 t+IQvDhKCvDB1WxqKmqEKMv1nUrZu2msGH3paMBLslvPOfoUjDhj9Ke
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mitsumi was [1] a Japanese company making various electronics devices
and components. They've merged into a new entity, MinebeaMitsumi in 2017.

Their current main page is available at [2]

[1] https://en.wikipedia.org/wiki/Mitsumi_Electric
[2] https://product.minebeamitsumi.com/en/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..6142c40cf06e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -865,6 +865,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mitsumi,.*":
+    description: Mitsumi Electric Co., Ltd.
   "^mixel,.*":
     description: Mixel, Inc.
   "^miyoo,.*":

-- 
2.42.0

