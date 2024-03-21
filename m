Return-Path: <linux-kernel+bounces-109742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC8885520
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F42EB217C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63BA6A8DD;
	Thu, 21 Mar 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glDBXnLc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A3657A7;
	Thu, 21 Mar 2024 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007415; cv=none; b=Va7bNavxUg++uhT+yJnq9NbrNFs6vVCl6l+pNthOwuyiuXoO1v1xI6+iUJLnxP/ATWuHqt2dMLWI8JJCQhwJcK15q8uywlduAAqMOUBt+u1eJLsQbBvqRXcbr97lpsJwLno9r48pcKBCKwG0ln3sROtO3fgrL0IXAg3kFFb9QlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007415; c=relaxed/simple;
	bh=UvTo8QBYeQLV3PuMvoWcILVTc6H9jSID+qTr6Vz8NBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTizmub5g66ZZjf0hOPwolg+ItAopQLbV4mf3bpK8m3KGv/ZNACsW/JYTvjC7dn9fv/Hw1vK+e8cQFJ2PK0nzCoIowrDJTy2T8vCfREJgzckKZFHbJD7Bv6YWqrZ+fQTAO2t90iRhGeJVv8dd+/VgKqH/+Nd8q2PV0Dz/itCqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glDBXnLc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41412411622so4818325e9.2;
        Thu, 21 Mar 2024 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711007412; x=1711612212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YU9jaC6xqKM+QmdGJCmjA9LeXXuHKL87qwRP8YiRjAU=;
        b=glDBXnLcvjffVWtAseEfNPJzpWCpYKXVDaE0B2yt476lmEtcBSe1oGnIEzzFlZ5Ob1
         QsIx/e2sPWJD7eR8QzVIxFIeNX/XC9yS90JEAj+kKZ1Fd6Xng7+Z4lQZQaYAsSaWN5pw
         DIyYaodWW7PGdEihE7YPCKQMHiwQ79dRjM86nIo6fwNM/4KNbp0zlMMRKH+XQJ1WcIdf
         90zxQEpM5jOAXnCMoPkI+whmaBEEVwFHSCSDWh7k8CU2C4SX6NNSBAOsXRH5K2o/Nusj
         PeaL1oIgO1KU5/ce8OQykIZt013C/AArGj3xAg5hYDGezecNDlAexuZe1dQMMdgVJFcu
         WjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007412; x=1711612212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU9jaC6xqKM+QmdGJCmjA9LeXXuHKL87qwRP8YiRjAU=;
        b=xC1A+YcuhrvtivWRA9vch4z6iB5gNTbqPercQOU2ULx95tGCgMr7ca5ZObZnORdbUP
         APs56svoWdTjV0ocr0Qzllxob6DcRt5zdBGGB35ce4aLh7JmNJaQWUyMhfBcofkE3dvn
         6+LXEdwbBnzH7DNX9nUtN2t00nDa3WDaxdBr3/pwcU4ndcuBP/dQq7wBzXQCB8ZrnDul
         uljRZic2tGVww4OkFWtMJOvtJBMAo9XCAvmCepQzYQlj4gLp6wi4E5NnIzW62q86WwdF
         IR+GapPGtEWxEaUN6NSrPTm4DhPk2de77Xo+b1IfJBvLqhV2YyEVCgaDsHEvwtOoYKTo
         SBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4lpZYuIFn0ne3OotwoYHNTnp+o7BOGF0aw//bzGDxPHrriv+DpltrV40ZWoP/mvns1llP5HwuHHAzlMg3naaVgm+cWnz4XW2Gm6gociuZuO2t9lrK0c/ZXuvR4lmkkzuGe/1dqQwY
X-Gm-Message-State: AOJu0Yxzxse6XiBuYbSJcUzYYOQj3d01V3dissvqeM5TTnKoKvu0z4/u
	LcCe//6zq5o3H4ECz52PEDCwGVDDRl/N1n1/qB4eYEHWtoRSvm8s
X-Google-Smtp-Source: AGHT+IHbSjTmUAYcjmFlhbvazW9Kj5/6k2CITs59Ro9fqQ68aJ1wzi4bxIXAqi50LlzBon/+ym3Shg==
X-Received: by 2002:a05:600c:46c8:b0:414:4d82:e4dd with SMTP id q8-20020a05600c46c800b004144d82e4ddmr782997wmo.7.1711007411815;
        Thu, 21 Mar 2024 00:50:11 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id p1-20020a05600c1d8100b004146bda6c32sm4637096wms.9.2024.03.21.00.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:50:11 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 21 Mar 2024 08:49:56 +0100
Subject: [PATCH v2 3/6] clk: qcom: apss-ipq-pll: remove 'pll_type' field
 from struct 'apss_pll_data'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-apss-ipq-pll-cleanup-v2-3-201f3cf79fd4@gmail.com>
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
In-Reply-To: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
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
Changes in v2:
 - no changes
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-3-52f795429d5d@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 8cf17374a2e2a..816b0d1f8d8c8 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -131,37 +131,31 @@ static const struct alpha_pll_config ipq9574_pll_config = {
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
@@ -194,10 +188,10 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
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


