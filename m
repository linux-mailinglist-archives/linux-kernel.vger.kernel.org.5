Return-Path: <linux-kernel+bounces-109745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD5885529
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B051C20A64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470D77828D;
	Thu, 21 Mar 2024 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKmDXSHx"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA577F2D;
	Thu, 21 Mar 2024 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007419; cv=none; b=Vgwb1X2qXEeK1ny2NU8qJrLw7j5slpP3NXWo0R2s+0lFTjNSJSGlXAtB8oTK3EGRNnqgGoqbYiPbbfPCmXhnoTLbYZadm7L6YRoIQLThcyn1uP6BWh4rTDdopXeIbRP2uVJJVgSi1MXZC8eUdReXMh68OaSDpLeQVynxtELb9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007419; c=relaxed/simple;
	bh=DVHMTHd9cw8fYFLji10BJ/X3RxtwR7CoHYOkARmz740=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EuGhK9tfwJGqV9vY7bPDAduvOZ06mP5gt3w1X3Ytmn5txPK/dYJKh3enw6Al7EdZHlWyRB7FJnq+YMCbZKLfpX5HSAO80JMcfC2T/2J7ubxr8cRwp8Urwnq/fPQyP4S4EA5lqvu/+s1Sdb+vvN3QRnxhASgTXsXzxlpKgK3SXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKmDXSHx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-414633f7a52so6643835e9.0;
        Thu, 21 Mar 2024 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711007416; x=1711612216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMgePyPqtHXUGa3piv5tLSTW7fonCxVeBttImy15UeU=;
        b=WKmDXSHxfAGf1M8z878XISsHFU27GtgGfK2HK5hAf+33iDw3nArWqRO8Pja+FakqnL
         PimkPmmYapL0KdeBnjqN+A1XPlytNlcqXHBUYsiA9/L9ZrlpGV0psEUGwLbPEj0dM8VJ
         rwxiBqUSeZMRqnxZal4HkK33vHoIwBgmC05dSJuFjJ1Edr3+sAQ4aj0CMgQL1Mz6pWSD
         lFCrMT8/+nT+rXIwQ20ospXF64nH2WqTx9jq7Eck2JYvImuUd55TYP7XyA/oBQ8II4RX
         n8b2Tc+J1HEkYT0gmGS78IrZNpSsM2kPVIoQK1XrrELnlraAcAz2YSqwkd3nO2n5Uafa
         l6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007416; x=1711612216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMgePyPqtHXUGa3piv5tLSTW7fonCxVeBttImy15UeU=;
        b=ecPa+KiI87g1A689S5MDE1lnAXNtuvhHEldAWk6zbqUg/deexvCH+9at9SMpTPiBmS
         rWD2SQMPbAuRhHoS8RT9ADXbzX6J+naSrnbfc1rorsqiXyIkETSEWPsWhfaI/MbWbv2L
         bufJ7XPQFLl37tUQbqVVUGHnlNdHy9AFOCKaUcFVfI80mFhX7Cjc+1GRJo1HOMUZctdO
         6Aq5SUpRg+gWcew8jNtgUlCBtd+ZAPJ8nHfaYslDRjhjtuF7ORzmTeBzscMR2J4TS19O
         bWW6m1D4uEA3rIgFNDO4przUmxbxyA/CRCrU4TvllDOzcRvT7OH62Mly4rgK7DOjpGBB
         7rHw==
X-Forwarded-Encrypted: i=1; AJvYcCWHVppMovZqx5d8C9ncBwPRyWf0QDC+VbHAzRwyln2T4W0jodEEjXCwe+FbFn6EYFkM6Lmn/2vLpCKqYzUlunX3aAI1GkO6qlyPqFsAUtKkq+rTdvcgg7aLCAhc5uzq+xH7c0A0WY/7
X-Gm-Message-State: AOJu0YyWohmZY1KG9WeTOAOFho9La9t2PL+hEARc9+NzdgDpoQoAR0JS
	oCDbjFee2G5X2mX55KiYZ9f3BDVEfWHAjLkcTwF8vQJhG9u0MdNUhFT2rAOh
X-Google-Smtp-Source: AGHT+IFBxiVcxHlAt0MfenJ1sZGVg/Umm4dOVc/7FHqmtl04FBAihzW5AKA70GImVUAiAUI6QCTPhg==
X-Received: by 2002:a05:600c:1395:b0:413:271d:8889 with SMTP id u21-20020a05600c139500b00413271d8889mr970161wmf.11.1711007416283;
        Thu, 21 Mar 2024 00:50:16 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id p1-20020a05600c1d8100b004146bda6c32sm4637096wms.9.2024.03.21.00.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:50:15 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 21 Mar 2024 08:49:59 +0100
Subject: [PATCH v2 6/6] clk: qcom: clk-cbf-8996: use HUAYRA_APPS register
 map for cbf_pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-apss-ipq-pll-cleanup-v2-6-201f3cf79fd4@gmail.com>
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

The register map used for 'cbf_pll' is the same as the one defined for
the CLK_ALPHA_PLL_TYPE_HUAYRA_APSS indice in the 'clk_alpha_pll_regs'
array.

Drop the local register map and use the global one instead to reduce
code duplication.

No functional changes intended. Compile tested only.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes since v1:
  - new patch

Note: Although this patch is not strictly related to the subject of the
series but as the change has been suggested by Dmitry during the review
process it has been added here for completeness.
---
 drivers/clk/qcom/clk-cbf-8996.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
index fe24b4abeab48..76bf523431b85 100644
--- a/drivers/clk/qcom/clk-cbf-8996.c
+++ b/drivers/clk/qcom/clk-cbf-8996.c
@@ -41,17 +41,6 @@ enum {
 
 #define CBF_PLL_OFFSET 0xf000
 
-static const u8 cbf_pll_regs[PLL_OFF_MAX_REGS] = {
-	[PLL_OFF_L_VAL] = 0x08,
-	[PLL_OFF_ALPHA_VAL] = 0x10,
-	[PLL_OFF_USER_CTL] = 0x18,
-	[PLL_OFF_CONFIG_CTL] = 0x20,
-	[PLL_OFF_CONFIG_CTL_U] = 0x24,
-	[PLL_OFF_TEST_CTL] = 0x30,
-	[PLL_OFF_TEST_CTL_U] = 0x34,
-	[PLL_OFF_STATUS] = 0x28,
-};
-
 static struct alpha_pll_config cbfpll_config = {
 	.l = 72,
 	.config_ctl_val = 0x200d4828,
@@ -67,7 +56,7 @@ static struct alpha_pll_config cbfpll_config = {
 
 static struct clk_alpha_pll cbf_pll = {
 	.offset = CBF_PLL_OFFSET,
-	.regs = cbf_pll_regs,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_APSS],
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "cbf_pll",

-- 
2.44.0


