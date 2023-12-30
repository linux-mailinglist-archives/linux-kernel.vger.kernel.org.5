Return-Path: <linux-kernel+bounces-13424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 175AF82066B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60FFBB20E16
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5231BBE7F;
	Sat, 30 Dec 2023 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoS+5tqg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016B946E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so95226511fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703941471; x=1704546271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4H7y7IhYDcsqoZwIjIu5qBzOxLBBKdAUUcwSzTanJQ=;
        b=OoS+5tqgR/LNgWQW5F9pdOQhTJGahVuu+dHP3Bg6whi6kf9zRxLyxxaP/zl7Vw318q
         YyWV8HUeglM3O2B/e4YLbFpFRTTCyWUn14jF9RAa+jFmC2Dh1TZN+U6ls6E3cIzR4l7t
         16/mTE2BAah24+8lIeju/wwqH1ufJEJX/22exMxA0Vu4BsVm06RxB0hf66d0Rp2dB6EA
         yD8fWZA1Ox7xAqaZy5Q8DX/RzgbW9DWNzfOjGbyWquFX9vS91TfpMAnEox9Ovo8ATBJE
         BsClF8dnUdetzBVz/I0JMwDnEUmBEFSbtJ0Gq+tF/3yECHGb/FgxlHt3qHqTaR37gTiE
         yrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703941471; x=1704546271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4H7y7IhYDcsqoZwIjIu5qBzOxLBBKdAUUcwSzTanJQ=;
        b=TRIRlSf7WFmtGD2L4WwBGKntQhU8iIrBhXETBLKxDeiYzzgUkwrjzppOLyheTtPmUC
         axZfmMidBnxynmRWXXsTZ1Gqe18DIFkTTdAKg+px+gK8NJNQc6ijlXQoBAcq7Qd5kzLT
         hWpwsgGZgocmHz9MEhg3WLZ9xRWZbEYoBh6uFVQYkP9aik/r2+9ZFSnUAw0IT5r8wi8P
         GpHH1gEq3TyM3rvV2Zb+TzvHIyBrZT/xkTV64+uCXFlFlE88KTVKT7WFZLbvump1fFkl
         uQ57awccfhWh6OyNbUVtIMmIJJb3+UtKI7Ml6zyX2+UzY/nyuK3DUB5O2mVS34QQJdkR
         TWOQ==
X-Gm-Message-State: AOJu0YxaNTzxGPtStwEnsafjPnLSIMfPFLQYoNUSxLAkYDiwhQU1hpo1
	do6lAUZf9pduHeyEnhmYpnLuLzHS4QFqS1gDryvFHsk46bw=
X-Google-Smtp-Source: AGHT+IGDF2V+e5q/79foO7aj+1aRjuugENoqZW2N7bU8gDVlaW+19sPnfcjMUJTmYaM8P3AZZrqPgg==
X-Received: by 2002:a2e:9e93:0:b0:2cc:74c2:3af2 with SMTP id f19-20020a2e9e93000000b002cc74c23af2mr6712436ljk.28.1703941470963;
        Sat, 30 Dec 2023 05:04:30 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ij14-20020a056402158e00b00554368c9ce8sm11359578edb.1.2023.12.30.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 05:04:30 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 30 Dec 2023 14:04:04 +0100
Subject: [PATCH v4 02/12] clk: qcom: Use qcom_branch_set_clk_en()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v4-2-32c293ded915@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703941465; l=41901;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gMX+rhrAeYvSfxjEnrDvvnUvVDmbH5iJViXlEZhHfxQ=;
 b=VGPTNox/Nabhr9L4Y1WRgiGOrjpadNQthft2gvLS/6eVxEjiUFYKsmMQH+JuLWOgMiQ+gruec
 g2UFnTXOF/DA97otptWqpGmQ/Oj9xRreSsjbpbDkxzBRfdeJjNu7UH+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Instead of magically poking at the bit0 of branch clocks' CBCR, use
the newly introduced helper.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/camcc-sc8280xp.c     |  6 ++----
 drivers/clk/qcom/camcc-sm8550.c       | 10 +++-------
 drivers/clk/qcom/dispcc-qcm2290.c     |  4 ++--
 drivers/clk/qcom/dispcc-sc7280.c      |  7 ++-----
 drivers/clk/qcom/dispcc-sc8280xp.c    |  4 ++--
 drivers/clk/qcom/dispcc-sm6115.c      |  4 ++--
 drivers/clk/qcom/dispcc-sm8250.c      |  4 ++--
 drivers/clk/qcom/dispcc-sm8450.c      |  7 ++-----
 drivers/clk/qcom/dispcc-sm8550.c      |  7 ++-----
 drivers/clk/qcom/dispcc-sm8650.c      |  4 ++--
 drivers/clk/qcom/gcc-sa8775p.c        | 25 ++++++++++---------------
 drivers/clk/qcom/gcc-sc7180.c         | 22 +++++++++-------------
 drivers/clk/qcom/gcc-sc7280.c         | 20 ++++++++------------
 drivers/clk/qcom/gcc-sc8180x.c        | 28 +++++++++++-----------------
 drivers/clk/qcom/gcc-sc8280xp.c       | 25 ++++++++++---------------
 drivers/clk/qcom/gcc-sdx55.c          | 12 ++++--------
 drivers/clk/qcom/gcc-sdx65.c          | 13 +++++--------
 drivers/clk/qcom/gcc-sdx75.c          | 10 +++-------
 drivers/clk/qcom/gcc-sm4450.c         | 28 +++++++++-------------------
 drivers/clk/qcom/gcc-sm6375.c         | 11 ++++-------
 drivers/clk/qcom/gcc-sm7150.c         | 23 +++++++++--------------
 drivers/clk/qcom/gcc-sm8250.c         | 19 +++++++------------
 drivers/clk/qcom/gcc-sm8350.c         | 20 ++++++++------------
 drivers/clk/qcom/gcc-sm8450.c         | 21 ++++++++-------------
 drivers/clk/qcom/gcc-sm8550.c         | 21 ++++++++-------------
 drivers/clk/qcom/gcc-sm8650.c         | 16 ++++++++--------
 drivers/clk/qcom/gcc-x1e80100.c       | 16 ++++++++--------
 drivers/clk/qcom/gpucc-sc7280.c       |  9 +++------
 drivers/clk/qcom/gpucc-sc8280xp.c     |  9 +++------
 drivers/clk/qcom/gpucc-sm8550.c       | 10 +++-------
 drivers/clk/qcom/lpasscorecc-sc7180.c |  7 ++-----
 drivers/clk/qcom/videocc-sm8250.c     |  6 +++---
 drivers/clk/qcom/videocc-sm8350.c     | 10 +++-------
 drivers/clk/qcom/videocc-sm8450.c     | 13 ++++---------
 drivers/clk/qcom/videocc-sm8550.c     | 13 ++++---------
 35 files changed, 175 insertions(+), 289 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-sc8280xp.c
index 3dcd79b01515..94db130b85e2 100644
--- a/drivers/clk/qcom/camcc-sc8280xp.c
+++ b/drivers/clk/qcom/camcc-sc8280xp.c
@@ -3010,10 +3010,8 @@ static int camcc_sc8280xp_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&camcc_pll6, regmap, &camcc_pll6_config);
 	clk_lucid_pll_configure(&camcc_pll7, regmap, &camcc_pll7_config);
 
-	/*
-	 * Keep camcc_gdsc_clk always enabled:
-	 */
-	regmap_update_bits(regmap, 0xc1e4, BIT(0), 1);
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xc1e4); /* CAMCC_GDSC_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &camcc_sc8280xp_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
index dd51ba4ea757..e8d1e7cae1a4 100644
--- a/drivers/clk/qcom/camcc-sm8550.c
+++ b/drivers/clk/qcom/camcc-sm8550.c
@@ -3536,13 +3536,9 @@ static int cam_cc_sm8550_probe(struct platform_device *pdev)
 	clk_lucid_ole_pll_configure(&cam_cc_pll11, regmap, &cam_cc_pll11_config);
 	clk_lucid_ole_pll_configure(&cam_cc_pll12, regmap, &cam_cc_pll12_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	cam_cc_gdsc_clk
-	 *	cam_cc_sleep_clk
-	 */
-	regmap_update_bits(regmap, 0x1419c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x142cc, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x1419c); /* CAM_CC_GDSC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x142cc); /* CAM_CC_SLEEP_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &cam_cc_sm8550_desc, regmap);
 
diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index 9206f0eed446..52e1a2fb2a0e 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -519,8 +519,8 @@ static int disp_cc_qcm2290_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/* Keep DISP_CC_XO_CLK always-ON */
-	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x604c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_qcm2290_desc, regmap);
 	if (ret) {
diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
index ad596d567f6a..45ef3682d621 100644
--- a/drivers/clk/qcom/dispcc-sc7280.c
+++ b/drivers/clk/qcom/dispcc-sc7280.c
@@ -878,11 +878,8 @@ static int disp_cc_sc7280_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/*
-	 * Keep the clocks always-ON
-	 * DISP_CC_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x5008, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x5008); /* DISP_CC_XO_CLK */
 
 	return qcom_cc_really_probe(pdev, &disp_cc_sc7280_desc, regmap);
 }
diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 30f636b9f0ec..6356bc4b6403 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3178,8 +3178,8 @@ static int disp_cc_sc8280xp_probe(struct platform_device *pdev)
 		goto out_pm_runtime_put;
 	}
 
-	/* DISP_CC_XO_CLK always-on */
-	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x605c); /* DISP_CC_XO_CLK */
 
 out_pm_runtime_put:
 	pm_runtime_put_sync(&pdev->dev);
diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
index 1fab43f08e73..d7ce30ac4674 100644
--- a/drivers/clk/qcom/dispcc-sm6115.c
+++ b/drivers/clk/qcom/dispcc-sm6115.c
@@ -583,8 +583,8 @@ static int disp_cc_sm6115_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/* Keep DISP_CC_XO_CLK always-ON */
-	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x604c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm6115_desc, regmap);
 	if (ret) {
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index e17bb8b543b5..457629e2abfe 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1365,8 +1365,8 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, 0x8000, 0x10, 0x10);
 
-	/* DISP_CC_XO_CLK always-on */
-	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x605c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8250_desc, regmap);
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index 2c4aecd75186..eb8749473623 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -1787,11 +1787,8 @@ static int disp_cc_sm8450_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	disp_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0xe05c, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe05c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8450_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index f96d8b81fd9a..cd7e45bca830 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1780,11 +1780,8 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	disp_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index f3b1d9d16bae..73a6fc79ca94 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -1777,8 +1777,8 @@ static int disp_cc_sm8650_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
 
-	/* Keep clocks always enabled */
-	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0)); /* disp_cc_xo_clk */
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8650_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
index 8171d23c96e6..668baa732ffe 100644
--- a/drivers/clk/qcom/gcc-sa8775p.c
+++ b/drivers/clk/qcom/gcc-sa8775p.c
@@ -4742,21 +4742,16 @@ static int gcc_sa8775p_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP1_AHB_CLK,
-	 * GCC_DISP1_XO_CLK, GCC_DISP_AHB_CLK, GCC_DISP_XO_CLK,
-	 * GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK, GCC_VIDEO_XO_CLK.
-	 */
-	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xc7004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xc7018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x33004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x33018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x7d004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x34004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x34024, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x32004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32020); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0xc7004); /* GCC_DISP1_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xc7018); /* GCC_DISP1_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x33004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x33018); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x7d004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x34004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x34024); /* GCC_VIDEO_XO_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sa8775p_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index a3406aadbd17..bacacdc20e4a 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -2443,19 +2443,15 @@ static int gcc_sc7180_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_CPUSS_GNOC_CLK, GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK,
-	 * GCC_DISP_AHB_CLK, GCC_GPU_CFG_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b02c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b030, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x48004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b02c); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b028); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b030); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 					ARRAY_SIZE(gcc_dfs_clocks));
diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 2b661df5de26..178705035b01 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3453,18 +3453,14 @@ static int gcc_sc7280_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_CAMERA_AHB_CLK/XO_CLK, GCC_DISP_AHB_CLK/XO_CLK
-	 * GCC_VIDEO_AHB_CLK/XO_CLK, GCC_GPU_CFG_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2701C, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28014, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x26004);/* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26028);/* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004);/* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x2701c);/* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28004);/* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28014);/* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004);/* GCC_GPU_CFG_AHB_CLK */
 	regmap_update_bits(regmap, 0x7100C, BIT(13), BIT(13));
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index ae2147381559..dc8dfc25ae40 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -4579,23 +4579,17 @@ static int gcc_sc8180x_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	/*
-	 * Enable the following always-on clocks:
-	 * GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK, GCC_DISP_AHB_CLK,
-	 * GCC_VIDEO_XO_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_XO_CLK,
-	 * GCC_CPUSS_GNOC_CLK, GCC_CPUSS_DVM_BUS_CLK, GCC_NPU_CFG_AHB_CLK and
-	 * GCC_GPU_CFG_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0xb004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb040, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb044, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb048, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x48190, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x4d004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xb004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb040); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb044); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb048); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x48004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x48190); /* GCC_CPUSS_DVM_BUS_CLK */
+	qcom_branch_set_clk_en(regmap, 0x4d004); /* GCC_NPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
 
 	/* Disable the GPLL0 active input to NPU and GPU via MISC registers */
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index bfb77931e868..131756800daf 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7543,21 +7543,16 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 		goto err_put_rpm;
 	}
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_AHB_CLK,
-	 * GCC_DISP_XO_CLK, GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK,
-	 * GCC_VIDEO_XO_CLK, GCC_DISP1_AHB_CLK, GCC_DISP1_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xbb004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xbb028, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26020); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27028); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28028); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0xbb004); /* GCC_DISP1_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xbb028); /* GCC_DISP1_XO_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sdx55.c b/drivers/clk/qcom/gcc-sdx55.c
index d5e17122698c..d249e136dc66 100644
--- a/drivers/clk/qcom/gcc-sdx55.c
+++ b/drivers/clk/qcom/gcc-sdx55.c
@@ -1611,14 +1611,10 @@ static int gcc_sdx55_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	/*
-	 * Keep the clocks always-ON as they are critical to the functioning
-	 * of the system:
-	 * GCC_SYS_NOC_CPUSS_AHB_CLK, GCC_CPUSS_AHB_CLK, GCC_CPUSS_GNOC_CLK
-	 */
-	regmap_update_bits(regmap, 0x6d008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21));
-	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x6d008); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21)); /* GCC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22)); /* GCC_CPUSS_GNOC_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx55_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sdx65.c b/drivers/clk/qcom/gcc-sdx65.c
index ffddbed5a6db..452ab2fce28a 100644
--- a/drivers/clk/qcom/gcc-sdx65.c
+++ b/drivers/clk/qcom/gcc-sdx65.c
@@ -1574,14 +1574,11 @@ static int gcc_sdx65_probe(struct platform_device *pdev)
 	regmap = qcom_cc_map(pdev, &gcc_sdx65_desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-	/*
-	 * Keep the clocks always-ON as they are critical to the functioning
-	 * of the system:
-	 * GCC_SYS_NOC_CPUSS_AHB_CLK, GCC_CPUSS_AHB_CLK, GCC_CPUSS_GNOC_CLK
-	 */
-	regmap_update_bits(regmap, 0x6d008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21));
-	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22));
+
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x6d008); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21)); /* GCC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22)); /* GCC_CPUSS_GNOC_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx65_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sdx75.c b/drivers/clk/qcom/gcc-sdx75.c
index 573af17bd24c..99f1e43b1fb1 100644
--- a/drivers/clk/qcom/gcc-sdx75.c
+++ b/drivers/clk/qcom/gcc-sdx75.c
@@ -2936,13 +2936,9 @@ static int gcc_sdx75_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Keep clocks always enabled:
-	 * gcc_ahb_pcie_link_clk
-	 * gcc_xo_pcie_link_clk
-	 */
-	regmap_update_bits(regmap, 0x3e004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x3e008, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x3e004); /* GCC_AHB_PCIE_LINK_CLK */
+	qcom_branch_set_clk_en(regmap, 0x3e008); /* GCC_XO_PCIE_LINK_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx75_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sm4450.c b/drivers/clk/qcom/gcc-sm4450.c
index 31abe2775fc8..f317b68556cf 100644
--- a/drivers/clk/qcom/gcc-sm4450.c
+++ b/drivers/clk/qcom/gcc-sm4450.c
@@ -2849,25 +2849,15 @@ static int gcc_sm4450_probe(struct platform_device *pdev)
 
 	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
 
-	/*
-	 * Keep clocks always enabled:
-	 * gcc_camera_ahb_clk
-	 * gcc_camera_sleep_clk
-	 * gcc_camera_xo_clk
-	 * gcc_disp_ahb_clk
-	 * gcc_disp_xo_clk
-	 * gcc_gpu_cfg_ahb_clk
-	 * gcc_video_ahb_clk
-	 * gcc_video_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x36004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x36018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x3601c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x37004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x37014, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x81004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42018, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x36004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x36018); /* GCC_CAMERA_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, 0x3601c); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x37004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x37014); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x81004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x42004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x42018); /* GCC_VIDEO_XO_CLK */
 
 	regmap_update_bits(regmap, 0x4201c, BIT(21), BIT(21));
 
diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 3dd15d765b22..c795b5db70bb 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -3882,13 +3882,10 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Keep the following clocks always on:
-	 * GCC_CAMERA_XO_CLK, GCC_CPUSS_GNOC_CLK, GCC_DISP_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x17028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x1702c, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x17028); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x2b004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1702c); /* GCC_DISP_XO_CLK */
 
 	clk_lucid_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_lucid_pll_configure(&gpll11, regmap, &gpll11_config);
diff --git a/drivers/clk/qcom/gcc-sm7150.c b/drivers/clk/qcom/gcc-sm7150.c
index d9983bb27475..d025457cdca8 100644
--- a/drivers/clk/qcom/gcc-sm7150.c
+++ b/drivers/clk/qcom/gcc-sm7150.c
@@ -3002,20 +3002,15 @@ static int gcc_sm7150_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
-	/*
-	 * Keep the critical clocks always-ON
-	 * GCC_CPUSS_GNOC_CLK, GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK,
-	 * GCC_DISP_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_VIDEO_XO_CLK,
-	 * GCC_DISP_XO_CLK, GCC_GPU_CFG_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b02c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b030, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x48004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b02c); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b028); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b030); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_sm7150_dfs_desc,
 					ARRAY_SIZE(gcc_sm7150_dfs_desc));
diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index c6c5261264f1..b8e9b5f7e02b 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -3643,18 +3643,13 @@ static int gcc_sm8250_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK, GCC_DISP_AHB_CLK,
-	 * GCC_CPUSS_DVM_BUS_CLK, GCC_GPU_CFG_AHB_CLK,
-	 * GCC_SYS_NOC_CPUSS_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x4818c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x52000, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x0b004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x4818c); /* GCC_CPUSS_DVM_BUS_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x52000); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 				       ARRAY_SIZE(gcc_dfs_clocks));
diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index 1385a98eb3bb..eb9d6244e2e3 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -3806,18 +3806,14 @@ static int gcc_sm8350_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
-	/*
-	 * Keep the critical clock always-On
-	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_AHB_CLK, GCC_DISP_XO_CLK,
-	 * GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK, GCC_VIDEO_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2701c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28020, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26018); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x2701c); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28020); /* GCC_VIDEO_XO_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 563542982551..db1b84756b0d 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -3280,19 +3280,14 @@ static int gcc_sm8450_probe(struct platform_device *pdev)
 	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
 	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg, BIT(14), BIT(14));
 
-	/*
-	 * Keep the critical clock always-On
-	 * gcc_camera_ahb_clk, gcc_camera_xo_clk, gcc_disp_ahb_clk,
-	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
-	 * gcc_video_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x36004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x36020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x37004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x3701c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x81004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42028, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x36004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x36020); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x37004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x3701c); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x81004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x42004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x42028); /* GCC_VIDEO_XO_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sm8450_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index b883dffe5f7a..3704e6beaba9 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -3352,19 +3352,14 @@ static int gcc_sm8550_probe(struct platform_device *pdev)
 	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
 	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg, BIT(14), BIT(14));
 
-	/*
-	 * Keep the critical clock always-On
-	 * gcc_camera_ahb_clk, gcc_camera_xo_clk, gcc_disp_ahb_clk,
-	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
-	 * gcc_video_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32030, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26028); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27018); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32030); /* GCC_VIDEO_XO_CLK */
 
 	/* Clear GDSC_SLEEP_ENA_VOTE to stop votes being auto-removed in sleep. */
 	regmap_write(regmap, 0x52024, 0x0);
diff --git a/drivers/clk/qcom/gcc-sm8650.c b/drivers/clk/qcom/gcc-sm8650.c
index 9174dd82308c..beedd2221006 100644
--- a/drivers/clk/qcom/gcc-sm8650.c
+++ b/drivers/clk/qcom/gcc-sm8650.c
@@ -3808,14 +3808,14 @@ static int gcc_sm8650_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Keep the critical clock always-On */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0)); /* gcc_camera_ahb_clk */
-	regmap_update_bits(regmap, 0x26028, BIT(0), BIT(0)); /* gcc_camera_xo_clk */
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0)); /* gcc_disp_ahb_clk */
-	regmap_update_bits(regmap, 0x27018, BIT(0), BIT(0)); /* gcc_disp_xo_clk */
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0)); /* gcc_gpu_cfg_ahb_clk */
-	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0)); /* gcc_video_ahb_clk */
-	regmap_update_bits(regmap, 0x32030, BIT(0), BIT(0)); /* gcc_video_xo_clk */
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26028); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27018); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32030); /* GCC_VIDEO_XO_CLK */
 
 	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
 
diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index d7182d6e9783..a2a65ed31079 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -6769,14 +6769,14 @@ static int gcc_x1e80100_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Keep the critical clock always-On */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0)); /* gcc_camera_ahb_clk */
-	regmap_update_bits(regmap, 0x26028, BIT(0), BIT(0)); /* gcc_camera_xo_clk */
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0)); /* gcc_disp_ahb_clk */
-	regmap_update_bits(regmap, 0x27018, BIT(0), BIT(0)); /* gcc_disp_xo_clk */
-	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0)); /* gcc_video_ahb_clk */
-	regmap_update_bits(regmap, 0x32030, BIT(0), BIT(0)); /* gcc_video_xo_clk */
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0)); /* gcc_gpu_cfg_ahb_clk */
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26028); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27018); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32030); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
 
 	/* Clear GDSC_SLEEP_ENA_VOTE to stop votes being auto-removed in sleep. */
 	regmap_write(regmap, 0x52224, 0x0);
diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
index 1490cd45a654..272a723b4247 100644
--- a/drivers/clk/qcom/gpucc-sc7280.c
+++ b/drivers/clk/qcom/gpucc-sc7280.c
@@ -457,12 +457,9 @@ static int gpu_cc_sc7280_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GPU_CC_CB_CLK, GPUCC_CX_GMU_CLK
-	 */
-	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x1098, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x1170); /* GPU_CC_CB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1098); /* GPUCC_CX_GMU_CLK */
 	regmap_update_bits(regmap, 0x1098, BIT(13), BIT(13));
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sc7280_desc, regmap);
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 8e147ee294ee..f7bc81eee54f 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -444,12 +444,9 @@ static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GPU_CC_CB_CLK, GPU_CC_CXO_CLK
-	 */
-	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x109c, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x1170); /* GPU_CC_CB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x109c); /* GPU_CC_CXO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
 	pm_runtime_put(&pdev->dev);
diff --git a/drivers/clk/qcom/gpucc-sm8550.c b/drivers/clk/qcom/gpucc-sm8550.c
index 2fa8673424d7..fe3ced90b7c1 100644
--- a/drivers/clk/qcom/gpucc-sm8550.c
+++ b/drivers/clk/qcom/gpucc-sm8550.c
@@ -575,13 +575,9 @@ static int gpu_cc_sm8550_probe(struct platform_device *pdev)
 	clk_lucid_ole_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_lucid_ole_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	gpu_cc_cxo_aon_clk
-	 *	gpu_cc_demet_clk
-	 */
-	regmap_update_bits(regmap, 0x9004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x900c, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x9004); /* GPU_CC_CXO_AON_CLK */
+	qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sm8550_desc, regmap);
 }
diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 9051fd567112..6b1ac78de8d7 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -401,11 +401,8 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	/*
-	 * Keep the CLK always-ON
-	 * LPASS_AUDIO_CORE_SYSNOC_SWAY_CORE_CLK
-	 */
-	regmap_update_bits(regmap, 0x24000, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x24000); /* LPASS_AUDIO_CORE_SYSNOC_SWAY_CORE_CLK */
 
 	/* PLL settings */
 	regmap_write(regmap, 0x1008, 0x20);
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..c4b0b8bcbc80 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -383,9 +383,9 @@ static int video_cc_sm8250_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
 	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
 
-	/* Keep VIDEO_CC_AHB_CLK and VIDEO_CC_XO_CLK ALWAYS-ON */
-	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe58); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xeec); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
 
diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
index 7246f3c99492..3e2f20826820 100644
--- a/drivers/clk/qcom/videocc-sm8350.c
+++ b/drivers/clk/qcom/videocc-sm8350.c
@@ -558,13 +558,9 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
 	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *      video_cc_ahb_clk
-	 *      video_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
-	regmap_update_bits(regmap, video_cc_xo_clk_cbcr, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe58); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, video_cc_xo_clk_cbcr); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
 	pm_runtime_put(&pdev->dev);
diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
index 16a61146e619..fa85f8edcf32 100644
--- a/drivers/clk/qcom/videocc-sm8450.c
+++ b/drivers/clk/qcom/videocc-sm8450.c
@@ -423,15 +423,10 @@ static int video_cc_sm8450_probe(struct platform_device *pdev)
 	clk_lucid_evo_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
 	clk_lucid_evo_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	video_cc_ahb_clk
-	 *	video_cc_sleep_clk
-	 *	video_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x80e4); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8130); /* VIDEO_CC_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8114); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
 
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index f3c9dfaee968..2df44edcab3a 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -428,15 +428,10 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 	clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
 	clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	video_cc_ahb_clk
-	 *	video_cc_sleep_clk
-	 *	video_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
+	/* Keep the critical clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x80f4); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8140); /* VIDEO_CC_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8124); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
 

-- 
2.43.0


