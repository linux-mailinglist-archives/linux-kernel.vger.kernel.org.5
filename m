Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B877DA14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbjHPGBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbjHPGAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:00:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15EC1984
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:00:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so827020366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692165646; x=1692770446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zt17Yup/WwnoxQl5WE6O4OHqB2elPd3OhHcTS9NLBY=;
        b=e/CjjO+S1IEF0k4oc+Khg/7xOTgNlgMSEyIIljAgBEYyzLgMwfR71GmFXBKraVIq6O
         fBipu1EogU9NaTpDLPGhZhrKWwZhCDUFykOIPVMUKwXr401h5cRKf3sc140nwMwOqSY8
         zlR1L1JfJGzM7sI/zCQZR/BrrstfYf5hnNg6A3XWJBoqqDbLNwR1N+ybHHbPxX8JXY06
         xX4Uishf6RDdxeZx8szQ2OSLukh6NONOjXVT3UPDA6Ku8uRB8YPJGgTF1u/0FUxfxV7j
         cnzByF65KXUGpjC8XoJvy4RkxD+9fU6igvvthaUDrt1wqV7EWrp9LRk2Pkvwny/ZMpcV
         BZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692165646; x=1692770446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zt17Yup/WwnoxQl5WE6O4OHqB2elPd3OhHcTS9NLBY=;
        b=NWsDy5ywYzrD6Yg+LbvU3m7nBdVUhWpp/Vf4An+dcC79f84mXtj6yVps9br1+sl5lU
         2w2fAaA5lAvy1amM212NYCQQavcVIK9fRszHpQ+b6xRO6F1mRV7v7+p4wLG6HLeCNV4b
         BRGcdKXh2/HiiNIn2mRowa2y4+jWZVoy5h/DNRNp5pTO60MJB51TuhyeHjy9JDJDQgah
         0Z4UhC3yakLixmYO93Z2Or/GFCR7iX7d43g50uT6pDzIRvDAtVY5M4ffbDYI14KIWASs
         w6VmPAy3wUziPlGR5E+45pF06U7OzLcvijEv1uLTVhV2/w4VckyTzZxG6h/cVjpSIPP6
         2GcQ==
X-Gm-Message-State: AOJu0YwpMxuMU392GDqct5ABRro/vDysGR1vpJRZP1egMh617NgPcNPl
        E2uIt3Jf1uL0mlx+0PNhsVzxcA==
X-Google-Smtp-Source: AGHT+IFnZMRmU3l5bDL4krmMYV9i/GGQ2cFPcEpPog29Rq4WEsSorbWfJcRt4CAlmefd7grij1wz/g==
X-Received: by 2002:a17:906:5354:b0:993:ec0b:1a24 with SMTP id j20-20020a170906535400b00993ec0b1a24mr649778ejo.7.1692165646414;
        Tue, 15 Aug 2023 23:00:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709061cd200b0098e422d6758sm7961455ejh.219.2023.08.15.23.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:00:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: drop unsupported qcom,adsp-bypass-mode
Date:   Wed, 16 Aug 2023 08:00:42 +0200
Message-Id: <20230816060042.13110-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPASS LPI pin controller node binding does not allow
qcom,adsp-bypass-mode property:

  sc7280-herobrine-crd.dtb: pinctrl@33c0000: 'qcom,adsp-bypass-mode' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Fixes: 32d4541abe0f ("arm64: dts: qcom: sc7280: add lpass lpi pin controller node")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index dbcd139f60f1..d8b12666e592 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2498,7 +2498,6 @@ lpass_tlmm: pinctrl@33c0000 {
 			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
 			reg = <0 0x033c0000 0x0 0x20000>,
 				<0 0x03550000 0x0 0x10000>;
-			qcom,adsp-bypass-mode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&lpass_tlmm 0 0 15>;
-- 
2.34.1

