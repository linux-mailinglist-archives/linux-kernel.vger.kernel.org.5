Return-Path: <linux-kernel+bounces-106056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA587E86F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 987E8B22505
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884CD38385;
	Mon, 18 Mar 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD3LulJu"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D137162;
	Mon, 18 Mar 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760807; cv=none; b=TvHamWlrqXcAGPXzKKy6kPUgGdOPEJfvhlQM2zri7RJRgCVXpqZ3y93X7akzowQyVzURritHfCZnA0PaWE07Q390Ndn/en2I5YY00ow49mgArOgTNkciJ8vuvNdm7jXLkfO0lXXopGy+8e8dkO+eSdKRB0AR9hoUM48m8qSO+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760807; c=relaxed/simple;
	bh=V5o57Z5lkXjFzPIoDm+QJbV84snZtFSjhMmyvJm0U+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rbl9eEN/n+oc7hkNcYMR5t62GX+dxXYSMqG5AxKgzUVpHCeiZju4OppgE6qOX2nTP6D6BvYM2LqZizrs0XQD8/NJMVglp7YsGnnMczv2DP+A62cbRSs4Ob8IHGTbqwh6fAxigWku7OKyfM2L/lwNJ/gL/e/MIxejUpfJ3eFqqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD3LulJu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ed6078884so1379841f8f.1;
        Mon, 18 Mar 2024 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710760804; x=1711365604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOOkoScv5oPGpoZyfbHf5LnUoWuaxfdY11LbzZmpRD4=;
        b=TD3LulJun0Z1MnmmE6t4lF3WOZsZN795gAqMckoLFkbMLTvF2x5zV9SCE+WjK/yf0l
         pE/vggrIvwcjtdnIsa8g3mbxUU7PHE/mEgzqn+ci1tbf6voDNEl8Kz1UYvUOEPS+eNFg
         mTvoxm1urD9X0zmUfo2GQiM6fn+3lVVwlWEeFg/8ylgs6irCG3NUqp5ElErlrDUXulkV
         ZlM7T9podYFm6hBlX8pTYw5Eadtg3H78ZapbuQZOab6wD8aqYiHU3JfMxxskv2Br2WaR
         ovyovFW8Z8TqdDzsZN+bv33v0l5mNQBHZcpaHi/8D9IKoBmXLVntqXaaTjnYMX1kx4tO
         ifTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760804; x=1711365604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOOkoScv5oPGpoZyfbHf5LnUoWuaxfdY11LbzZmpRD4=;
        b=ARA/Id+kj4nRpTFwThW4Gz4WNuEl9q0REvp49pTikkPbTiJBENGsFirqcpA/ml6Aph
         nboFCPIhbuSQfRutPH/xobPapYu+Dv5S3eHQUnFupuwANlAua7RHug//JQyT/XK0MwwK
         ys+TgB6EDeET8gD+DCN2yzEP2DTs+GEI+Rd8u3l71l48Qd9tdHpDDGqTHUdgsJSGny0v
         krvwBWd8vOQ9pc56KYQxLdHa9gL0cjqbsLckskLtzu9ShJpPFxFy0emyt124vZ3TEMiG
         Ye3P6P1yqBKHZZ1vpujuyagR2ZFa2LGspJT+uG3+SC6iKGl5BUetQJ3y/0oo66oa+WuL
         9Z1g==
X-Forwarded-Encrypted: i=1; AJvYcCVfTE6FQGb3VUTh1wqjyW65xYz9RRxWpHQ/L044MdIxqyKJtKdotbafdoTgolaTs/QI1K81Yn/iLeXmnL1Rb8whiNN9UqOK4xirDuZ4SjZa6noqKGqlMnelWgcidny/fjOB+fkJZMiA
X-Gm-Message-State: AOJu0YyCTMykgfgw4wqq3JriakxlBwYigk0h6oOLUtXxgli9GHOE/3sE
	Iw/6t12KUxsFMoPQcTybAjycNYPzBXysAxJVCqVVru+2symODRkI
X-Google-Smtp-Source: AGHT+IEyHElyuXDvojQ4vmy1EfZn7cim0AYIcSvMOovEKsxIxyP24FMUAVQ2jM84AAla9drSGE53Eg==
X-Received: by 2002:a5d:5741:0:b0:341:6b9e:4ff2 with SMTP id q1-20020a5d5741000000b003416b9e4ff2mr3175809wrw.14.1710760804494;
        Mon, 18 Mar 2024 04:20:04 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm6650421wrb.62.2024.03.18.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:20:04 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 18 Mar 2024 12:19:57 +0100
Subject: [PATCH 3/5] clk: qcom: apss-ipq-pll: remove 'pll_type' field from
 struct 'apss_pll_data'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-apss-ipq-pll-cleanup-v1-3-52f795429d5d@gmail.com>
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
In-Reply-To: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The value of the 'pll_type' field of 'struct apps_pll_data'
is used only by the probe function to decide which config
function should be called for the actual PLL. However this
can be derived also from the 'pll' field  which makes the
'pll_type' field redundant.

Additionally, the CLK_ALPHA_PLL_TYPE_* enumeration values
are meant to be used as indices to the 'clk_alpha_pll_regs'
array so using those to define the pll type in this driver
is misleading anyway.

Change the probe function to use the 'pll' field to determine
the configuration function to be used, and remove the
'pll_type' field to simplify the code.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index f5c7eaf8db374..fb015385dae4b 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -147,37 +147,31 @@ static const struct alpha_pll_config ipq9574_pll_config = {
 };
 
 struct apss_pll_data {
-	int pll_type;
 	struct clk_alpha_pll *pll;
 	const struct alpha_pll_config *pll_config;
 };
 
 static const struct apss_pll_data ipq5018_pll_data = {
-	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER,
 	.pll = &ipq_pll_stromer,
 	.pll_config = &ipq5018_pll_config,
 };
 
 static struct apss_pll_data ipq5332_pll_data = {
-	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
 	.pll = &ipq_pll_stromer_plus,
 	.pll_config = &ipq5332_pll_config,
 };
 
 static struct apss_pll_data ipq8074_pll_data = {
-	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq8074_pll_config,
 };
 
 static struct apss_pll_data ipq6018_pll_data = {
-	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq6018_pll_config,
 };
 
 static struct apss_pll_data ipq9574_pll_data = {
-	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq9574_pll_config,
 };
@@ -210,10 +204,10 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENODEV;
 
-	if (data->pll_type == CLK_ALPHA_PLL_TYPE_HUAYRA)
+	if (data->pll == &ipq_pll_huayra)
 		clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
-	else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER ||
-		 data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
+	else if (data->pll == &ipq_pll_stromer ||
+		 data->pll == &ipq_pll_stromer_plus)
 		clk_stromer_pll_configure(data->pll, regmap, data->pll_config);
 
 	ret = devm_clk_register_regmap(dev, &data->pll->clkr);

-- 
2.44.0


