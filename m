Return-Path: <linux-kernel+bounces-13290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CD82030F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F20AB22A16
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE0D29D;
	Sat, 30 Dec 2023 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNovx0Vx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C4AD58
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d5ae89c72so35917855e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 16:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703894718; x=1704499518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pz+1qN8sDIROALkVJDfBjISQrkmNVmb7rHVkH8wdcu4=;
        b=dNovx0Vxo9aTSiqTiVzGl0tR9R6FS9CCEywdUmgvAMLgWk9X1IY8rPSd7sD6wrH4Xg
         0oTHMuegGh63FV8KMMdgwCc6wnzoMne8qOWog4MXV+BGZUF5WGD5q6yNFNG0DzsI5O6z
         dy5iprPqlZL6dkZy3Dm/me4OMr3FEoLCE3+L7QiiTno0TcVqI+WCH9zs3SfDfJVCnmcW
         058h5DD+tcJWnV1NLKqcJm3ZXRZbJUZUI8M6GP5Aao29yH2tk98fnZec2MoFePRAdMIl
         ZjCEDPodDsPhygKrwbPRxmetzhtdp4J6KSXpW7HolYTl8L+BhSDt+EqNUM7Q6MYJls2E
         TqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703894718; x=1704499518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pz+1qN8sDIROALkVJDfBjISQrkmNVmb7rHVkH8wdcu4=;
        b=LOA/VghQl7i2rSrQFmdKlZugsIFm82cDRMPcckniBWebh6q30q81MT0/wDDZVNzOMN
         PiVtxDNVKBtIZ2eTqxHNCtT1a+VS3QUrXuHkW8hYFNTbheUiOUQnXltj08unuGY+L3xa
         4J7Fq8KOo+vDyGcdIlkeeKIcViygpznQ1meTab/2v/kaT6iU9ZipSNo5bOetZjvx0tDZ
         Zj1lN5MBF6Pk3Cpf88X+ie69i4K/jfmvRJgyIqU21mZelsR9XpmTMThPblHUQIjnbtZB
         bzTCOuV9OiwbFTtUc+U7ZfO2s25NbVa6yGKgDVvTrwR8fWBxt4pkPataTZHGCMzC3Fqd
         Aymw==
X-Gm-Message-State: AOJu0Yw0hhp6l3ZZ4QifaAAJPKa1BDz33q8QQY31gGyrifVTRFtI9wEP
	FlXQzbDwVis6EtkoysBZMBUMIVCqsqtRBg==
X-Google-Smtp-Source: AGHT+IE0FHIVc03Sz/ZJyAKXNySizHBUErjzlmA0MlsN9HeooNu5zWKJ8aKDPR9avVN7cxLmCrddxg==
X-Received: by 2002:a05:600c:4e8b:b0:40d:5f5a:87a6 with SMTP id f11-20020a05600c4e8b00b0040d5f5a87a6mr1542745wmq.100.1703894718617;
        Fri, 29 Dec 2023 16:05:18 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id wj6-20020a170907050600b00a26a0145c5esm8609623ejb.116.2023.12.29.16.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 16:05:18 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 30 Dec 2023 01:05:09 +0100
Subject: [PATCH 08/10] arm64: dts: qcom: sc8180x: Add missing CPU<->MDP_CFG
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-topic-8180_more_fixes-v1-8-93b5c107ed43@linaro.org>
References: <20231230-topic-8180_more_fixes-v1-0-93b5c107ed43@linaro.org>
In-Reply-To: <20231230-topic-8180_more_fixes-v1-0-93b5c107ed43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703894704; l=1372;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3lJzXe1NstMyF31IEWdMuuhPzQe0FelyDoBLKldb1ks=;
 b=g2ta9sOAkY0T8psma9NOH9zWPm1D7lFIbYyqjepxkjbLSFN9J0FQmj3/bqI+Sy2LVJuuDGIvs
 J7qa9MZz2dDAoC3In7j6GR3hVZI9YA+2U7g+ue+y22zH2lxorjVSA9b
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

To guarantee the required resources are enabled, describe the
interconnect path between the MDSS and the CPU.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 97c139d0399d..960058624a2f 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2701,9 +2701,15 @@ mdss: mdss@ae00000 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
-			interconnects = <&mmss_noc MASTER_MDP_PORT0 0 &mc_virt SLAVE_EBI_CH0 0>,
-					<&mmss_noc MASTER_MDP_PORT1 0 &mc_virt SLAVE_EBI_CH0 0>;
-			interconnect-names = "mdp0-mem", "mdp1-mem";
+			interconnects = <&mmss_noc MASTER_MDP_PORT0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
+					<&mmss_noc MASTER_MDP_PORT1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "mdp0-mem",
+					     "mdp1-mem",
+					     "cpu-cfg";
 
 			iommus = <&apps_smmu 0x800 0x420>;
 

-- 
2.43.0


