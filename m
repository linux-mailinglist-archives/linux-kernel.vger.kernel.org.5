Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EF7FE005
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjK2TAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjK2TAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:00:02 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5519A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:49 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bca4df746so218593e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701284387; x=1701889187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnGcnoNWNxYJ5LHFVrJjGBCQuuXXbkPVZWF1kgt7oOA=;
        b=uDSibUdFAS/421inLoohKdxmrZqSg0kYBkoTQ8hQPygjtsjpLhC7sMuNY0MlSIW5hP
         pmS7WrgTaBugEbQq3INXT4ld+ZgsM0ZMNfR0pFFkIhE9/wv7B71krwdwp6CutYl92Vb7
         h0SR58/GzKKLIIrE8D+qsHqjIFl1dXvWwyqest4Ipldy7MJ5tI72vhcnCrcjBpjMZfhw
         SjAw1ssSpUjpQK8C2OtsV14WLM7LPmS5/rQbSnDLAN6HANzN6BOJzBNifm4SFVZS91Wa
         ky4vr6cPqqKQdydYnfSvRtDSVb3lcpupVkOOVqqDEa8ymDOuRaO2MfIapR7qx+5Dy7JD
         3SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284387; x=1701889187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnGcnoNWNxYJ5LHFVrJjGBCQuuXXbkPVZWF1kgt7oOA=;
        b=EyomKVO6gKArLpUUUp0lEHcsd4G7HQ1ZdIefvPVvrW3+JHxzVajPp8H7erq0CJp27V
         /WgpaVtADxgED8k0VPQI1CRbsSpmFx+wx0SLFjxKLB2bZjjAEqWp9zdrNlP26qbJejyM
         uIGLYoEGiTihc7f+Qd1rhP4boB6UNfFyoHwRMVJlEEryDFJyU2xm0fuLUkFaSGuLvbyl
         GtOTzoETIhpvJ6LxVdQYydgkBhX40b7Q5482VipvOV/bCHWRhDkbCF9eIse77iDxWAYA
         1yEAspxnzCb4dNNffoVJ2Y67t9PyhfIU/Fo03OZCubaiTpaQvrZQde0/iTIgbdXRMpVO
         GvPQ==
X-Gm-Message-State: AOJu0YwzdVz/V8MqvjPGPGcrQ3tgd9vnnUejjl2goPGDmthhDCp664yh
        c29Ej/gFldIwEsAtmlwWezAOSA==
X-Google-Smtp-Source: AGHT+IH/0P2l8fz8UPKkQxCN4CqZ3p7c/w0DYNi0k3AmNkoJCqQqfSSpXsOrbD1b53l0JOT4PQKTmw==
X-Received: by 2002:a05:6512:15a1:b0:50b:c457:cbe2 with SMTP id bp33-20020a05651215a100b0050bc457cbe2mr2626176lfb.16.1701284387741;
        Wed, 29 Nov 2023 10:59:47 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709061d4b00b009faca59cf38sm8160232ejh.182.2023.11.29.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:59:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 19:59:31 +0100
Subject: [PATCH v2 12/15] arm64: dts: qcom: sm6375: Add VDD_CX to GCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v2-12-2a583460ef26@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701284367; l=718;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=druZ2Tf30UXyUj6qQ5Kb3ShmK1CnSMbZh5vHm6E5a7Y=;
 b=HEm3TAZz84JQRknTXQafnd3Nnamgh+9atipFBnVNp6a5pu7VQewSDbSe/lzleQhY87uPYuPOl
 lIADpQaM0IMCA3/cBxxJsB/pcKtmxGV3KXhFvhe3PWPuI5Iag3B33Xf
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC block is mainly powered by VDD_CX. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 2fba0e7ea4e6..d6d232586260 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -934,6 +934,7 @@ gcc: clock-controller@1400000 {
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&rpmcc RPM_SMD_XO_A_CLK_SRC>,
 				 <&sleep_clk>;
+			power-domains = <&rpmpd SM6375_VDDCX>;
 			#power-domain-cells = <1>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;

-- 
2.43.0

