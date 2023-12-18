Return-Path: <linux-kernel+bounces-4016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEAB8176B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9F81C2575E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFD5A87F;
	Mon, 18 Dec 2023 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+MLZ9y4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B160D4FF8A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a1ca24776c3so835751166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702915342; x=1703520142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/einnfOMlZZ67QTI1k3LN2oLp4rlOytUU6/FZwO/Q8=;
        b=X+MLZ9y4uNnGehAG2SpmhDtJn2VnM8iBNxYJGxRNav9EKzCGRJFrB8U8bk1BOFZWgd
         /IT56EcXg1gQ99OBuY0K44QMWvy1QgmHKl/bktXj0+0EzMHVMypahut5IFjQG/W2t7VW
         sNNGn1O7CywS+3VYup7EVaWIJGanuzHyDNT+2kb9nriDy/axukwvxaEGDxLqENmNgoEK
         oFEhJRw7dzNXgX8eTjGvxyNdsIreK5bVA80UcLMXHjtZr+ITKidmVSFP383F0M0yX/VG
         ys4cXFXrPZrcGgOYcOOxUbR+tlRKgOBqKjS5SfOzPqaOCcfNWG2z9MgtmYSaglhKjT03
         8AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915342; x=1703520142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/einnfOMlZZ67QTI1k3LN2oLp4rlOytUU6/FZwO/Q8=;
        b=OHvSHvDz9vuKMkdX4Jah4216C20wrcu8zWanhTBHBD/VJH0+XsUTQs8rnX145P4uNj
         h7qdm8O8SurJcAkLm/RTLlUXWie8pqMouq0ZfF5q3uTUu+PrHEY0fXLxpFe/GxlW0Ao1
         IfhxDvxoAh0oaa4flpXp54ywH4Hq8oAsjzgSaIqShRnwp8fBF/VnOEh4+ICuLPrgexOq
         e5tzkCFJk+J1vfXeMVZqWSHt5vDvT8wi88bwAqCrL5CHhfWLaeQ0chg/6+GA8j9dbd+s
         bgBW29Yx2K7NNwTVkGWCpfe/tjJpstQIk4cSAPZrZO9zbW6ihX131SUt07xONafpFkYi
         uhDQ==
X-Gm-Message-State: AOJu0YwQZlooWDY/SnNim6hCpguDX4smk78MKNFMySU59PjDN6tgC3R/
	OTJYUEZyE4erKGAUrRJlgQbGpQ==
X-Google-Smtp-Source: AGHT+IHtObdFAHPJSSw3kqb0DyxPAxgAAn4ocnx2KQ3aU2c2MIq03tw7/GR9cXWRvd99tBDrw5Cvaw==
X-Received: by 2002:a17:906:4581:b0:a1f:74e7:8bdd with SMTP id qs1-20020a170906458100b00a1f74e78bddmr15873731ejc.25.1702915341867;
        Mon, 18 Dec 2023 08:02:21 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1dd58874b8sm14260693ejc.119.2023.12.18.08.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:02:21 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 17:02:04 +0100
Subject: [PATCH 03/12] clk: qcom: gcc-sm8550: Add the missing
 RETAIN_FF_ENABLE GDSC flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-8550_fixes-v1-3-ce1272d77540@linaro.org>
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
In-Reply-To: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702915332; l=2558;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=keR6/82q0ryYI3TMPWNKSZJMZ6EXNo8Q0Uj0Y7Gl5JI=;
 b=NI9KfFleXMMZcLpWmmKdvXd1fYIDFDUf1YtNoSJ+ydiG02n7+cnA+qlY+8qyADxuNXFQH/Uu2
 oP5mTxkd9vuB9MbdSTwd3vHwdlNLnTOY/13dqjgUOqrnawO4zZxy3iM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

All of the 8550's GCC GDSCs can and should use the retain registers so
as not to lose their state when entering lower power modes.

Fixes: 955f2ea3b9e9 ("clk: qcom: Add GCC driver for SM8550")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm8550.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index 586126c4dd90..1c3d78500392 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -3002,7 +3002,7 @@ static struct gdsc pcie_0_gdsc = {
 		.name = "pcie_0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc pcie_0_phy_gdsc = {
@@ -3011,7 +3011,7 @@ static struct gdsc pcie_0_phy_gdsc = {
 		.name = "pcie_0_phy_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc pcie_1_gdsc = {
@@ -3020,7 +3020,7 @@ static struct gdsc pcie_1_gdsc = {
 		.name = "pcie_1_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc pcie_1_phy_gdsc = {
@@ -3029,7 +3029,7 @@ static struct gdsc pcie_1_phy_gdsc = {
 		.name = "pcie_1_phy_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc ufs_phy_gdsc = {
@@ -3038,7 +3038,7 @@ static struct gdsc ufs_phy_gdsc = {
 		.name = "ufs_phy_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc ufs_mem_phy_gdsc = {
@@ -3047,7 +3047,7 @@ static struct gdsc ufs_mem_phy_gdsc = {
 		.name = "ufs_mem_phy_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc usb30_prim_gdsc = {
@@ -3056,7 +3056,7 @@ static struct gdsc usb30_prim_gdsc = {
 		.name = "usb30_prim_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc usb3_phy_gdsc = {
@@ -3065,7 +3065,7 @@ static struct gdsc usb3_phy_gdsc = {
 		.name = "usb3_phy_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
 static struct clk_regmap *gcc_sm8550_clocks[] = {

-- 
2.43.0


