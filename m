Return-Path: <linux-kernel+bounces-25301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E1982CD2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096D71C21507
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFBA63D0;
	Sat, 13 Jan 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLH+GBu5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A392259B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e63bc90f2so18263715e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705157461; x=1705762261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKcMhrufSxn2YOt3KsN7/849IvpZn9FSQAc0Hzkvap0=;
        b=VLH+GBu5Pu6E63DX4YWIrsG5K30iZFt/X5gqK1/yBLVLEAw2P1DS5c4j+J1ye6PUaF
         mmKMRzqeYz9OUxYoHrdnzlf8m6wHZaNJre57k3lBS4k2m7hRB3pfpQHLPNdO7+uvydKd
         XUTieQIoVLKkOMI1RaC8JQG137h/zh5yeNC14Pk22HqtHHI/kBfSvEk5SxHbpmOg8Pjv
         EPjsiSet2cKTUGLpie+Oe+voKvDw5BGG1v2XH/iBiLAVQA0l/4hA5LLPYsCa0Ounik2H
         Sml++wzFQ01d9wyNXsjGILCgLdTYkSDhFwzJ/69GFRPjZvQaDlydtXt8aLRrXjmTO0Lf
         wALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705157461; x=1705762261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKcMhrufSxn2YOt3KsN7/849IvpZn9FSQAc0Hzkvap0=;
        b=Z+q4+YpbgvtEAisYAMzXdyKLnVStlwz8x5d+t7mqokboHqSYPgq2FvvqHd+jiMBw1Z
         IDyo9tZUhNyqAFiXNB88ZJ1GWv4mvtCA48HsQkgjQWH/YFpl7QeBKNKCd8yO9vkRcSsY
         erIj3KGqj/a65a2F7dfsTJmJ/uenPGqBj+hVkp3smrHgITklOYkQ6CVkIO3Rs4J6jb30
         HwG/CCzHRDquifML2xyJvQBe8Ir91n1BsEKsJEnCl97Y09UFchT7WAx8gR2YQFI9yLL+
         HmHW/S4D1k3Rtkky/GYBk/EvQlD5TEvQudtY681btpY4iZVHa0T0Fi3o+u1fkfkWAnaO
         oegQ==
X-Gm-Message-State: AOJu0YxytFuTMQXvsEBYbemwILv7IDEaJQDwVYoYLsrJtUFpa8Ugxp6w
	aekohq+O81hC2OlJZ+in+b+Qk209JW7V/SIWDy49zofoNP0=
X-Google-Smtp-Source: AGHT+IGDYTt1NHkyNJCsNk45Y4PAm9JphkrLE5FHMBBJ7X/4//v1s7TKIkE1DHM2wx/Ac/5O+D9Pdg==
X-Received: by 2002:a05:600c:1c0a:b0:40d:6582:4729 with SMTP id j10-20020a05600c1c0a00b0040d65824729mr1767109wms.130.1705157460865;
        Sat, 13 Jan 2024 06:51:00 -0800 (PST)
Received: from [10.167.154.1] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id es18-20020a056402381200b00554b1d1a934sm3014593edb.27.2024.01.13.06.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 06:51:00 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 13 Jan 2024 15:50:51 +0100
Subject: [PATCH v6 02/12] clk: qcom: Use qcom_branch_set_clk_en()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v6-2-46d136a4e8d0@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705157455; l=41674;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Hqa/SLNxjNawmEvpnyso/fRmpcjU8j9z348q44Gf+fY=;
 b=0+4lQEMUKRUd126u0e2A5dJKn643Fr64OHO0mKxTE3ikV7ZmGv3SkksIl3MSZw+eazs4Pdjxq
 emThN3H86xqBSkiOfO6hFjnCMI7KgIJ6nNgzFwjuj9eUR0hZYN1ZHzx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Instead of magically poking at the bit0 of branch clocks' CBCR, use
the newly introduced helper.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
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
index 3dcd79b01515..84f9caf3ddbf 100644
--- a/drivers/clk/qcom/camcc-sc8280xp.c
+++ b/drivers/clk/qcom/camcc-sc8280xp.c
@@ -3010,10 +3010,8 @@ static int camcc_sc8280xp_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&camcc_pll6, regmap, &camcc_pll6_config);
 	clk_lucid_pll_configure(&camcc_pll7, regmap, &camcc_pll7_config);
 
-	/*
-	 * Keep camcc_gdsc_clk always enabled:
-	 */
-	regmap_update_bits(regmap, 0xc1e4, BIT(0), 1);
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xc1e4); /* CAMCC_GDSC_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &camcc_sc8280xp_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
index dd51ba4ea757..1ef59a96f664 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x1419c); /* CAM_CC_GDSC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x142cc); /* CAM_CC_SLEEP_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &cam_cc_sm8550_desc, regmap);
 
diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index 9206f0eed446..200f81ac4827 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -519,8 +519,8 @@ static int disp_cc_qcm2290_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/* Keep DISP_CC_XO_CLK always-ON */
-	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x604c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_qcm2290_desc, regmap);
 	if (ret) {
diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
index ad596d567f6a..3ba07f08cbdd 100644
--- a/drivers/clk/qcom/dispcc-sc7280.c
+++ b/drivers/clk/qcom/dispcc-sc7280.c
@@ -878,11 +878,8 @@ static int disp_cc_sc7280_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/*
-	 * Keep the clocks always-ON
-	 * DISP_CC_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x5008, BIT(0), BIT(0));
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x5008); /* DISP_CC_XO_CLK */
 
 	return qcom_cc_really_probe(pdev, &disp_cc_sc7280_desc, regmap);
 }
diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 30f636b9f0ec..bd1ffb143e0c 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3178,8 +3178,8 @@ static int disp_cc_sc8280xp_probe(struct platform_device *pdev)
 		goto out_pm_runtime_put;
 	}
 
-	/* DISP_CC_XO_CLK always-on */
-	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x605c); /* DISP_CC_XO_CLK */
 
 out_pm_runtime_put:
 	pm_runtime_put_sync(&pdev->dev);
diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
index 1fab43f08e73..bd07f26af35a 100644
--- a/drivers/clk/qcom/dispcc-sm6115.c
+++ b/drivers/clk/qcom/dispcc-sm6115.c
@@ -583,8 +583,8 @@ static int disp_cc_sm6115_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/* Keep DISP_CC_XO_CLK always-ON */
-	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x604c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm6115_desc, regmap);
 	if (ret) {
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index e17bb8b543b5..ccf696c74dc3 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1365,8 +1365,8 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, 0x8000, 0x10, 0x10);
 
-	/* DISP_CC_XO_CLK always-on */
-	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x605c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8250_desc, regmap);
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index 2c4aecd75186..b358751aba4b 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe05c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8450_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index f96d8b81fd9a..3d86b20e2062 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index f3b1d9d16bae..795ac4d93658 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -1777,8 +1777,8 @@ static int disp_cc_sm8650_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
 
-	/* Keep clocks always enabled */
-	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0)); /* disp_cc_xo_clk */
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8650_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
index 8171d23c96e6..9dbb68f60d86 100644
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
+	/* Keep some clocks always-on */
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
index a3406aadbd17..6a5f785c0ced 100644
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
+	/* Keep some clocks always-on */
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
index 2b661df5de26..f45a8318900c 100644
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
+	/* Keep some clocks always-on */
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
index ae2147381559..c8dfe76f5582 100644
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
+	/* Keep some clocks always-on */
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
index bfb77931e868..816a06bfedb2 100644
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
+	/* Keep some clocks always-on */
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
index d5e17122698c..26279b8d321a 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x6d008); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21)); /* GCC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22)); /* GCC_CPUSS_GNOC_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx55_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sdx65.c b/drivers/clk/qcom/gcc-sdx65.c
index ffddbed5a6db..8fde6463574b 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x6d008); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21)); /* GCC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22)); /* GCC_CPUSS_GNOC_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx65_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sdx75.c b/drivers/clk/qcom/gcc-sdx75.c
index 573af17bd24c..c51338f08ef1 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x3e004); /* GCC_AHB_PCIE_LINK_CLK */
+	qcom_branch_set_clk_en(regmap, 0x3e008); /* GCC_XO_PCIE_LINK_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx75_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sm4450.c b/drivers/clk/qcom/gcc-sm4450.c
index 31abe2775fc8..1226d39e6442 100644
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
+	/* Keep some clocks always-on */
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
index 3dd15d765b22..84639d5b89bf 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x17028); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x2b004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1702c); /* GCC_DISP_XO_CLK */
 
 	clk_lucid_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_lucid_pll_configure(&gpll11, regmap, &gpll11_config);
diff --git a/drivers/clk/qcom/gcc-sm7150.c b/drivers/clk/qcom/gcc-sm7150.c
index d9983bb27475..47c25b3d95ad 100644
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
+	/* Keep some clocks always-on */
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
index c6c5261264f1..9990931aa172 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x0b004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x4818c); /* GCC_CPUSS_DVM_BUS_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x52000); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 				       ARRAY_SIZE(gcc_dfs_clocks));
diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index 1385a98eb3bb..e83a9facc19b 100644
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
+	/* Keep some clocks always-on */
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
index 563542982551..43e9c32921f3 100644
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
+	/* Keep some clocks always-on */
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
index b883dffe5f7a..60895648f281 100644
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
+	/* Keep some clocks always-on */
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
index 9174dd82308c..c4a6540b1522 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26028); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27018); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32030); /* GCC_VIDEO_XO_CLK */
 
 	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
 
diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index d7182d6e9783..1404017be918 100644
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
+	/* Keep some clocks always-on */
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
index 1490cd45a654..293b57080685 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x1170); /* GPU_CC_CB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1098); /* GPUCC_CX_GMU_CLK */
 	regmap_update_bits(regmap, 0x1098, BIT(13), BIT(13));
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sc7280_desc, regmap);
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 8e147ee294ee..a8ea2143057d 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x1170); /* GPU_CC_CB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x109c); /* GPU_CC_CXO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
 	pm_runtime_put(&pdev->dev);
diff --git a/drivers/clk/qcom/gpucc-sm8550.c b/drivers/clk/qcom/gpucc-sm8550.c
index 2fa8673424d7..783d14ef9a0c 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x9004); /* GPU_CC_CXO_AON_CLK */
+	qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sm8550_desc, regmap);
 }
diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 9051fd567112..fd9cd2e3f956 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x24000); /* LPASS_AUDIO_CORE_SYSNOC_SWAY_CORE_CLK */
 
 	/* PLL settings */
 	regmap_write(regmap, 0x1008, 0x20);
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..6fd8666813a8 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -383,9 +383,9 @@ static int video_cc_sm8250_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
 	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
 
-	/* Keep VIDEO_CC_AHB_CLK and VIDEO_CC_XO_CLK ALWAYS-ON */
-	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe58); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xeec); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
 
diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
index 7246f3c99492..002e4c0666fa 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0xe58); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, video_cc_xo_clk_cbcr); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
 	pm_runtime_put(&pdev->dev);
diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
index 16a61146e619..045eee07ea5f 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x80e4); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8130); /* VIDEO_CC_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8114); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
 
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index f3c9dfaee968..fa81e48f83e7 100644
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
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x80f4); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8140); /* VIDEO_CC_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8124); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
 

-- 
2.43.0


