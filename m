Return-Path: <linux-kernel+bounces-104616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1B87D108
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C791F23CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532D4594C;
	Fri, 15 Mar 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrvBXckd"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834144C64;
	Fri, 15 Mar 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519420; cv=none; b=TawXyb6lsdB2W/IhMJRU5a4q1Rn9vyaP0M1yUpTPkrCDmEqElEuQ2LvYAn/nPO2iG2emBXrOb8U+/3gFABJzFwD/+nfPrHxq7OpO9iPqfVZiMFfd4ulo2h6l39S2OnIQUbdUKacLXmwksGQ7/Sb7z2vAcnI/pN4jpEhHZx3tTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519420; c=relaxed/simple;
	bh=IyytQBo2KIJF54NrANAyUTvbiB6Rzt4f4opggr/aZgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BMT1MXcktiF3QztGfIYZtEdw+WFHBdwmV9+EWSQqwqUhXnhEAmS7CkbalnVveC4CMkyq4sC+2gnTJWZuzkP6/EgbuUonTa6ZPcLoxBM1du1l/i2T58Nqo9h+xa3mMD2JsJXFpz6gM9bfys6S7Quua7FJaEe3GXnTy8uOginRTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrvBXckd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5676788a12.1;
        Fri, 15 Mar 2024 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710519415; x=1711124215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq26cNsD7jowb3hRFtXkhmvH+pk4/HkmfGFyk+22HD0=;
        b=IrvBXckdY6A/y/wKd+r8x33eovdCcnR2Uu31fUAFthMt1oxhncLc86ykoEje2Q6U9R
         j8Fnh6ro9+L0NyNRS2xOeTpaedeyYsFm9pzOzkR1GeeCbcFCo8kRDCk33wwDJc27Cu5e
         jfd5Xs8fSxDzgww3rHaaQW7HSlZgDfjXlsaniG3JrVtp2+RPPIF17jFW9GFQ6FVR9WTW
         cA2DqyqLhkNvAMC+cp/M0aL6JQRVZAfvkdU5SEgys/JVo8pvhHcLn/Nakpf8y7hz3zpC
         HHuulgXFngj+dAA7qJ1PRx+7ZV676/Gzvm44BGJDtVXZ9sc7a8b3CdB680/+UcGC6ots
         Yf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710519415; x=1711124215;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hq26cNsD7jowb3hRFtXkhmvH+pk4/HkmfGFyk+22HD0=;
        b=Z6dDCr7zZ1t1eMUX8OMr6cIZVQ+TLb7fbVyhL1SKv0KfpBQW8hjBrydWLToc9P4Nnd
         NIkU3lUEUQSlsJtSRQLTlU3m+pChS/oA9ognpcMAiD3Iwlt7gaYLSF/FITkY7RYoygtP
         Wkcpm9ewB+XwZEO+DHM9jLrvSRG/Nx7AMr8zsJYB1Ywq0n1wdJlgtlITjfOtXJAkNJUF
         XDqphcdIm9TcVE3SPdAIKDv9jAH9lVp6HnXwsCXPcaEn9xm/dGjISTZiQWKDxPQnqq6T
         1XG0T+PRC12zIZga7Y4k6aU5u5T9oSBUWnt/N7zmnC1vfAjOxYLCzloRNBPySF0aEZ8m
         QRXg==
X-Forwarded-Encrypted: i=1; AJvYcCUET8097kafvap4O3cu7+QNTGbJMbq8Hc8x05kozcPxB43sWSptiuUmn5Tfn/mM11Hn6Lk4fAdl9Gp/cP93oEouBDZ3WwZrP+iQezqGLhrjrDC//0C9yMwAFZxdYJpeviGTyOLEcqGoeDc+0dYGX+pu+/D3r2qtP7ckzCYDy8LF
X-Gm-Message-State: AOJu0YxtDxHIKHg98vvrxj7IemRixNWW3AQjg23ywdL8v+9BzyhRRHSO
	eYGdAMHmJQpd9GfVVZ6cMU8x+mdSw17jQEC970Wvsv7byVm33khg
X-Google-Smtp-Source: AGHT+IFv/E9MBLkyKgj7qZIVTGEgGlu0AGvsb77hVYdllp23GXPaquSMaDb/YqvQ3JdCNN4cWhrsMw==
X-Received: by 2002:a17:906:5a95:b0:a46:74fe:9177 with SMTP id l21-20020a1709065a9500b00a4674fe9177mr4056795ejq.21.1710519414942;
        Fri, 15 Mar 2024 09:16:54 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id me17-20020a170906aed100b00a4679ce191csm1330205ejb.121.2024.03.15.09.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 09:16:54 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 15 Mar 2024 17:16:41 +0100
Subject: [PATCH v2] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to
 fix boot failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGh09GUC/42NTQ6CMBCFr0Jm7ZhOqRZceQ/DotICk/BTW0M0h
 LvbcgJXL9/L+9kgusAuwq3YILiVIy9zAnkqoB3M3DtkmxikkEqURGh8jMj+hX4cs14EVZiTqJW
 tTdUpTeUVUt8H1/Hn2H40iQeO7yV8j6uVsvvP6kpIWDmr5FObWih77yfD47ldJmj2ff8Boz155
 8IAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

Booting v6.8 results in a hang on various IPQ5018 based boards.
Investigating the problem showed that the hang happens when the
clk_alpha_pll_stromer_plus_set_rate() function tries to write
into the PLL_MODE register of the APSS PLL.

Checking the downstream code revealed that it uses [1] stromer
specific operations for IPQ5018, whereas in the current code
the stromer plus specific operations are used.

The ops in the 'ipq_pll_stromer_plus' clock definition can't be
changed since that is needed for IPQ5332, so add a new alpha pll
clock declaration which uses the correct stromer ops and use this
new clock for IPQ5018 to avoid the boot failure.

Also, change pll_type in 'ipq5018_pll_data' to
CLK_ALPHA_PLL_TYPE_STROMER to better reflect that it is a Stromer
PLL and change the apss_ipq_pll_probe() function accordingly.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/drivers/clk/qcom/apss-ipq5018.c#L67

Cc: stable@vger.kernel.org
Fixes: 50492f929486 ("clk: qcom: apss-ipq-pll: add support for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - extend commit description due to the changes
  - add a comment about why CLK_ALPHA_PLL_TYPE_STROMER_PLUS register offsets
    are used
  - constify hw clock init data (Stephen)
  - change pll_type in ipq5018_pll_data to CLK_ALPHA_PLL_TYPE_STROMER (Konrad)
  - Link to v1: https://lore.kernel.org/r/20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com
---
Based on v6.8.
---
 drivers/clk/qcom/apss-ipq-pll.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 678b805f13d45..dfffec2f06ae7 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -55,6 +55,29 @@ static struct clk_alpha_pll ipq_pll_huayra = {
 	},
 };
 
+static struct clk_alpha_pll ipq_pll_stromer = {
+	.offset = 0x0,
+	/*
+	 * Reuse CLK_ALPHA_PLL_TYPE_STROMER_PLUS register offsets.
+	 * Although this is a bit confusing, but the offset values
+	 * are correct nevertheless.
+	 */
+	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "a53pll",
+			.parent_data = &(const struct clk_parent_data) {
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_stromer_ops,
+		},
+	},
+};
+
 static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	.offset = 0x0,
 	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
@@ -144,8 +167,8 @@ struct apss_pll_data {
 };
 
 static const struct apss_pll_data ipq5018_pll_data = {
-	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
-	.pll = &ipq_pll_stromer_plus,
+	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER,
+	.pll = &ipq_pll_stromer,
 	.pll_config = &ipq5018_pll_config,
 };
 
@@ -203,7 +226,8 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 
 	if (data->pll_type == CLK_ALPHA_PLL_TYPE_HUAYRA)
 		clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
-	else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
+	else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER ||
+		 data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
 		clk_stromer_pll_configure(data->pll, regmap, data->pll_config);
 
 	ret = devm_clk_register_regmap(dev, &data->pll->clkr);

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240311-apss-ipq-pll-ipq5018-hang-74d9a8f47136

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


