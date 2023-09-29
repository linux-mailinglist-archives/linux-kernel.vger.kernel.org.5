Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290867B376D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjI2QDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjI2QDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:03:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8881199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:03:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ad810be221so1947247466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696003379; x=1696608179; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTHdLZvZRtA3Iqqnp6A3lBx/EWxmXoRrCoZvxKDaOvU=;
        b=WhOnBXgizzvXYWGzxvsJiFJFYEPo0sdZz8JtDw7KnI+yrHi8lCZyKlMo9jTmGpYeZA
         LAb5LNKXnQi39wmut0wNGaJ0TfqMoIKZGj/24Jow7g0RqbZexEtdzqP7UXiAjbXiPBrv
         6XIrxFfV7AFJfin83EnjgIIPyGAcjvfmrgCKH4zZN5UL3fSG09F36ZSfSj1LVbVbsEmj
         7YERpqQiMTYADQIaZfSqn/vwIDT5DPTYwVcpxX0XH3fmRy3NgH7yxUyh64CZ5YwyGwD1
         Qdwy1iUuyBgHYVCDdF+4hpvXgaEphc5CCZtJsFJRHAsttcDeYu23aWUkP9CCfZzwFCIx
         NTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696003379; x=1696608179;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTHdLZvZRtA3Iqqnp6A3lBx/EWxmXoRrCoZvxKDaOvU=;
        b=J1MCGfb33mRbercwClxa4c6/LLnZcRYh6FqFoaGHH22Nv237tXhj6a1elLDFhbUJwQ
         t7H/AT68U9Mt1nZ4b5VCge7/+2LcgHQcN3n3p2OsuLums9GT+5YTWc1T2qnOZ7uCRGs/
         m/6pracaZfeRG+/UY4MbSMB3Gj/4eEtS6UbRLLEyOhGNfRZBuA0OqCwoFSm0/vG6iMYO
         P2yo4E+Eupmx8nR1hVvXGV71mL/te18bTTWcqzvBHf8j+s3LTjI6wtmy59UfvvKpwb2A
         p6h3cfqTbcXXbVSpJh85qSBeM/d2IMzvV3ewu1vg5ghqUkWUmqLV8cGEDhDUCNd20N4t
         wYvw==
X-Gm-Message-State: AOJu0Yxtt2Xf3zMhvh/yhW/m41MbjEZN8EQOJVN4JnvUAnSzDRiuPq56
        BKL3sL5X/bLVqSemtnejl5Aacg==
X-Google-Smtp-Source: AGHT+IHlEFZoEPtOotAcO1KkbMwAGgoW7SHy/fG9D21gqt5w7mtThDxvG4U2zeM7HoMLxKlkFCllUQ==
X-Received: by 2002:a17:906:5dc1:b0:9aa:16c4:be16 with SMTP id p1-20020a1709065dc100b009aa16c4be16mr3898907ejv.57.1696003379099;
        Fri, 29 Sep 2023 09:02:59 -0700 (PDT)
Received: from [127.0.1.1] (178235177217.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.217])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906380600b0099c53c4407dsm12548202ejc.78.2023.09.29.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:02:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 29 Sep 2023 18:02:57 +0200
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-topic-x13s_edpphy-v1-1-ce59f9eb4226@linaro.org>
X-B4-Tracking: v=1; b=H4sIADD1FmUC/x3MQQqAIBBA0avErBN0FMquEhFhU87GRCMK6e5Jy
 7f4v0CmxJRhaAokujjzESpU24DzS9hJ8FoNKFFLi1acR2QnbqXzTGuM/hGSVIfG9s5ohNrFRBv
 f/3Oc3vcDIE2DzWMAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DP PHY needs different settings when an eDP display is used.
Make sure these apply on the X13s.

FWIW
I could not notice any user-facing change stemming from this commit.

Fixes: f48c70b111b4 ("arm64: dts: qcom: sc8280xp-x13s: enable eDP display")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
I have no idea whether DP3 is hardwired to be eDP, like it
seems to be on the last DP controller of SC7280. In that
case this would be moved to the SoC DTSI.
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 38edaf51aa34..6a4c6cc19c09 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -601,6 +601,7 @@ mdss0_dp3_out: endpoint {
 };
 
 &mdss0_dp3_phy {
+	compatible = "qcom,sc8280xp-edp-phy";
 	vdda-phy-supply = <&vreg_l6b>;
 	vdda-pll-supply = <&vreg_l3b>;
 

---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230929-topic-x13s_edpphy-0e172498c432

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

