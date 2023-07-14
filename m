Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE4753B37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjGNMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbjGNMlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:41:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4563D30F5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:40:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so2381047e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689338455; x=1691930455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uO3BaxYCZ+L/uORC+pf07E8D9o0fBToXSlhtH2de7rw=;
        b=oxGZgrpIfJhQzZIJqF+aBM+mmaE/bK4naa7fvpgtwek3knax53LGE17XpfHcoS3xJn
         D2ZvIAugeRv+VGHitrRirxUNf87rDIlel0AAT72jssZzbzlpv4CUt+f8lr4B6M1h3jHM
         g4vfDbzXoldY4o33AmlhFZkSEN0DZNT8RXX8Jtue5cDwZEj4WTj9d8sBIxAGf3T10fRC
         vmjqbSwVdd4ExBWkuzSB4hJgG/3dXR9deUWKg/pgdXo8IZMDyZ9srMieLZ78bsaA0xJA
         EPI9sh3PRjXxpoU5GlP1ihK/PGvQyLwWWkl2UvYQZ8A/UBPd7qliGheUntGi69zj5pA2
         0tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689338455; x=1691930455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO3BaxYCZ+L/uORC+pf07E8D9o0fBToXSlhtH2de7rw=;
        b=AKgit+ysV962sCjKMWtenxSYElbqAZK4GqAfKdDTmB4FNLrqLp+y+jmlBC5I1c9LMa
         A6GzI9fRWdsr4Ey93eqcPv/qx1qAwzHl6cckPb0Ugd975ewDVVm27DN+b8D/tQtHDcbx
         zXWjDYGKNigfwBY5XhRA49982iG1DGQPvHlsT/ZFDmbPWd1ctZqPhJvEhmP/Tet5CDCn
         TozMg6LkaNI2itywZzRriZTQRW0deX8AjN30ZVdAJ2FRve54mV0/zHwljixx+eCi27Ht
         zmcqkNGYPoJoNYwhS6SKamithd3+v+5+01Sfiv0S03AZ1p5/qOa821T4ll6VQV8Bjiz1
         yNLQ==
X-Gm-Message-State: ABy/qLbte/CzKMsuSB7HZ/nnaaYUmz1/h0tVQv76UrcsAQ++8wFJ3SXK
        H3kFLLx7/bDFFGuu6UAVRM2VBA==
X-Google-Smtp-Source: APBJJlHlAddaubQ/zueOeGxnPlLqyGKtU17F4/ArIFEtjLQai74eAepMpx7KknX5mdh58a5qmuwxRQ==
X-Received: by 2002:a05:6512:3705:b0:4fb:7a4e:b573 with SMTP id z5-20020a056512370500b004fb7a4eb573mr3610408lfr.5.1689338455608;
        Fri, 14 Jul 2023 05:40:55 -0700 (PDT)
Received: from [192.168.1.101] (abxj146.neoplus.adsl.tpnet.pl. [83.9.3.146])
        by smtp.gmail.com with ESMTPSA id b6-20020ac25e86000000b004fb2244563fsm1482588lfq.289.2023.07.14.05.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:40:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 14 Jul 2023 14:40:48 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sc7280: Remove qcom,adsp-bypass-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-topic-lpass_lpi_cleanup-v1-3-dc18b5bd14f7@linaro.org>
References: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
In-Reply-To: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689338449; l=730;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DyK40mymfrvw8k/ltntuGU1sfhX2SFcLdrpfHTNW0dU=;
 b=qBnOkFZmC996wH1CYdwJcNu3hlwhZiyzrwhXN24QgaMwaVqj+hEgRFwf2kwMfKM31XoMQltpX
 SPVdPsAQ8r9BXTtayuWOtbsupyVAclRjwoHW2RQCeF7FbIyodHXeW5A
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property isn't used or defined anymore. Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 925428a5f6ae..ce7d318afd57 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2510,7 +2510,6 @@ lpass_tlmm: pinctrl@33c0000 {
 			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
 			reg = <0 0x033c0000 0x0 0x20000>,
 				<0 0x03550000 0x0 0x10000>;
-			qcom,adsp-bypass-mode;
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&lpass_tlmm 0 0 15>;

-- 
2.41.0

