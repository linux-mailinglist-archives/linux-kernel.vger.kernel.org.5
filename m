Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179AF779636
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbjHKRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbjHKRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:35:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0672130D8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:35:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso3677104e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691775328; x=1692380128;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6x+/lLfRdrdDeapOVJjNUZr/qrt9jnkjTgOGO97QVY=;
        b=vAyMT44jwL4gyaRdxQeziRX5takgcAELg1X/sOBj/Mbh3xdd/4POwfNplt53bxFTSp
         2YDajg7g6vNyy3mYgd0/sNsa3K7IjlU6IKNrd25Xv5w/QST4dPcx3FpJ20Ent3OkNKNk
         UnHa10/NTKJ6AJHIvcNhfDnRrG0QnIC6l9v15ETGrVPgjF/nGv0AksFUHiwZUKSxDbQJ
         5p1OapV6EuAj7aRortVBbdhEO2V3XYi6HOPjn6Njgo6EM6+tVQk4pT4OiAwddl61Hxe6
         3bTkWxB9c1Gs8kGuZY3uU5/uy5Za6WFn4HHqYDJW0I2xtoWnHY3pa7KZ39TVuyh/PyGt
         jxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775328; x=1692380128;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6x+/lLfRdrdDeapOVJjNUZr/qrt9jnkjTgOGO97QVY=;
        b=kQ3I+A4kvHXrHrkya80gjz74a/o//k6/3zg4bo5GXFEv/CpWUSuSJgtACdo4tyu2Rk
         OrSfvWyycRci/RjpLGwfsnVpwiIrCfeo5CxosG1CLOQZP24/IFADbTWT5zeKKayjAOJu
         LLkqUgB+zxdYzJJ8/Sl1jJqe5PRyaY3xgFHg9+/i5X2PfZWQa3d0MQYqLhZT+L1riDXZ
         1YLzxAigig0u40qbhdmjInX5HGJM9vGk36CCnnyDqTL65LgL0i7k767Pt2AFA6LMqyxD
         zu+aSjXqTivfAyf6FWy1SeVMHNcRSvUFmX5Hij36On4ldpqCFagqGUk/uxSgk+LTJgdb
         6QLg==
X-Gm-Message-State: AOJu0YwZsAhT0AwqxyQkDu5Ym6hUaoE5AZTPDSLlwJ/bEHvZE9zFGaLv
        wL9iolkUcUQo62RGReDSjtmtMw==
X-Google-Smtp-Source: AGHT+IEopb6B/9NeZ249d/UrX0///BY/2QX30Rpgh/pcm5l3HFlO5tNCEs40hppuG3GkJwCjRQ8pqg==
X-Received: by 2002:a05:6512:3d0d:b0:4fe:1f27:8856 with SMTP id d13-20020a0565123d0d00b004fe1f278856mr2305536lfv.7.1691775328126;
        Fri, 11 Aug 2023 10:35:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id j14-20020ac2550e000000b004fbb011c9bcsm791551lfk.161.2023.08.11.10.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:35:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 19:35:27 +0200
Subject: [PATCH] arm64: dts: qcom: sm8450: Add RPMh stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-8450_stats-v1-1-f26ae3fdf2cf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF5x1mQC/x2N0QrCMAwAf2Xk2UBTtQx/RUSyLnOB0Y2mijD27
 wYf7+C4HUyqisGt26HKR03X4kCnDvLM5SWoozPEEM+hJ8K2bpqxv1zD0xo3w5gCpTGRRJ7As4F
 NcKhc8uxheS+Ly63KpN//5/44jh8j6QtgdwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691775327; l=930;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/FwfVYZjCAaU2UDf89MXxIqgCTPBoyrxmnyx+Hm98O4=;
 b=0WnDW5pULZifNk2Ae6/l6ymSQp/4/n3FG066Q+JXJWvtTAvGEYuXEaltxJNmPBV198og6qv4l
 AwPAhLCAzLlAVygen8RCtfPG4x3O8a9VTMYR+IDdqXxTU9QJ6Oz940J
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8450 also exposes RPMh stats, hook them up for low power state
monitoring.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 4bc1c46a5f44..6ae64059cea5 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3141,6 +3141,11 @@ aoss_qmp: power-management@c300000 {
 			#clock-cells = <0>;
 		};
 
+		sram@c3f0000 {
+			compatible = "qcom,rpmh-stats";
+			reg = <0 0x0c3f0000 0 0x400>;
+		};
+
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c400000 0 0x00003000>,

---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230811-topic-8450_stats-26016d61e2af

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

