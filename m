Return-Path: <linux-kernel+bounces-106054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46787E867
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600912827CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE53374C4;
	Mon, 18 Mar 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duIiUsqf"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716E3612C;
	Mon, 18 Mar 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760805; cv=none; b=akRV5v3SSvHAIVoNKFS8NINnPh2jfd9eAu/v9la1h99blw2xU+iD55d8HrNiwgJ/EA7EatZKYu6jQtcK7MagbY1gZf9kI9B+ZecrNiiC8rduCqyfowIiO5s1utKPSkOvVJdMy+E19+oP7O00/BhiQfWeZcMWLWnLf6zrlNSBDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760805; c=relaxed/simple;
	bh=jCMlUD363vKn0zpjdZVsYHL06TzEt3kc0rtURswgGdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/49qRn9JTHCLbh0dWZiyEYfOEdUKK8LFvHbSOOAK06qMMWPLsz//dGUu7og7TZWXWPaKdayRvKHklk/KKPawLg0yP/Fw6rymndzsnfYTNwVSLx+2WFKvcv5AdfIKjareu+04FjB0WdSb8XO8GT71go85FpSP1awB+1uiP++Ky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duIiUsqf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34173b6b985so623305f8f.1;
        Mon, 18 Mar 2024 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710760802; x=1711365602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3r3uArMSydiicjQk9mYV5YzMaVndZLKq/8gP3JJ/JE=;
        b=duIiUsqffiU6JuvsBKJvOCZIc/9HroEbQ1XF/12a0bhP+lOLHuwLw+71ohu8hw2EIg
         wYid4JBL97ArO21T2EmeozajvaD1iaboJLwvy2wloBm5jM/tNwNJ2MrMr45PsZLf3BnA
         Mbt0WN9rkhVReb0FzBS3wssHU9kkTappqPjKXl+GL5ZwIe04jvm13E7PGBctf6/MvMYs
         qtvvEFysYzeSAfPkbooC8TueP10qTepfkX7ckNk6OnFVuy/mpDfirE6oCzXwvkJNEfRU
         lz7tYtZ834eI1Y0E5V88oyZkxuyIum9Jp9K3HmqOwuN22jLP07lw6Srs5gzKjEvPHr06
         vdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760802; x=1711365602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3r3uArMSydiicjQk9mYV5YzMaVndZLKq/8gP3JJ/JE=;
        b=BmiTL9Nvg5/R3m7iSWc6EmYr0F1vNMAy7pjiiqJ6kTWtIBmb3dK+siv9TqsFWMsaBX
         +nXV2YhbMwNKoK9y0ylB5boIUqer+r/dSU7hbCt8GB/4hgDGooOUcaS7IqzT0KJ7ZP86
         EvUl3TPV0sf80fMEzA44VwZZH/YYoKBlj1Qqtxm3ppBRNd6oph0mrcHUbvUjLU3Vx7Kk
         ZyEkEOUC9mZwUOsSXJvqfCFGJHLsBdo8CwRTd0USx8vHl6LoJ7TPN6l7ehjK/4pqzOzf
         0JwkegOwj6lwIzGNeufoGUJlZXnYVZKNOkt36rqtnQP4vP5MfmwHXjJGwNcYJGho1+B2
         nLUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFHfATjncLO3IPvfS8rAfv7yjKi6Bam5DiSuup68Dw+2N6nJC/WzGG+qmybLbIoP55TfvLtskH0YfVTcMVtNuTwrqZwTsw8xfDQf+R+Jx1NvetMB+aTu4BVqYUDTo3IL9HAKFh4vkI
X-Gm-Message-State: AOJu0Yyw0FOvsPHZS6kabc2WWGgcnX72wvJAp2FtDOOjFMSjlYmAQ10V
	OoKOLGSY2de59gGxASb5gGFMztzKkxwEjHaKe5FUALvzWaGeEEo3
X-Google-Smtp-Source: AGHT+IG88dAqHC3lFegUtZWffLsyW7CFuwEhcCai/p4DpoxNEGzGMi1dFtmwOT500PpQkK6ryoYWWA==
X-Received: by 2002:a5d:468e:0:b0:33e:8b95:b350 with SMTP id u14-20020a5d468e000000b0033e8b95b350mr5808943wrq.7.1710760802241;
        Mon, 18 Mar 2024 04:20:02 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm6650421wrb.62.2024.03.18.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:20:01 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 18 Mar 2024 12:19:55 +0100
Subject: [PATCH 1/5] clk: qcom: apss-ipq-pll: reuse Stromer reg offsets
 from 'clk_alpha_pll_regs'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-apss-ipq-pll-cleanup-v1-1-52f795429d5d@gmail.com>
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
In-Reply-To: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The register offset array defined locally for the
CLK_ALPHA_PLL_TYPE_STROMER_PLUS is the same as the
entry defined for CLK_ALPHA_PLL_TYPE_STROMER in the
'clk_alpha_pll_regs' array.

To avoid code duplication, remove the local definition
and use the global one instead.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Depends on the following patches:
 - "clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure"
   Link: https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
 - "clk: qcom: clk-alpha-pll: Stromer register cleanup"
   Link: https://lore.kernel.org/r/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index dfffec2f06ae7..ed3e6405f99cb 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -24,17 +24,6 @@ static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL] = 0x30,
 		[PLL_OFF_TEST_CTL_U] = 0x34,
 	},
-	[CLK_ALPHA_PLL_TYPE_STROMER_PLUS] = {
-		[PLL_OFF_L_VAL] = 0x08,
-		[PLL_OFF_ALPHA_VAL] = 0x10,
-		[PLL_OFF_ALPHA_VAL_U] = 0x14,
-		[PLL_OFF_USER_CTL] = 0x18,
-		[PLL_OFF_USER_CTL_U] = 0x1c,
-		[PLL_OFF_CONFIG_CTL] = 0x20,
-		[PLL_OFF_STATUS] = 0x28,
-		[PLL_OFF_TEST_CTL] = 0x30,
-		[PLL_OFF_TEST_CTL_U] = 0x34,
-	},
 };
 
 static struct clk_alpha_pll ipq_pll_huayra = {
@@ -57,12 +46,7 @@ static struct clk_alpha_pll ipq_pll_huayra = {
 
 static struct clk_alpha_pll ipq_pll_stromer = {
 	.offset = 0x0,
-	/*
-	 * Reuse CLK_ALPHA_PLL_TYPE_STROMER_PLUS register offsets.
-	 * Although this is a bit confusing, but the offset values
-	 * are correct nevertheless.
-	 */
-	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x0,
@@ -80,7 +64,11 @@ static struct clk_alpha_pll ipq_pll_stromer = {
 
 static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	.offset = 0x0,
-	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
+	/*
+	 * The register offsets of the Stromer Plus PLL used in IPQ5332
+	 * are the same as the Stromer PLL's offsets.
+	 */
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER],
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x0,

-- 
2.44.0


