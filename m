Return-Path: <linux-kernel+bounces-122676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27C88FB44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9552A1F29E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDB77C0BE;
	Thu, 28 Mar 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbFpXJEA"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74E7BB12;
	Thu, 28 Mar 2024 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617809; cv=none; b=LjQ414OtzGQuFm6p1hSrvikrgg3pP0gGbe6g1c8J0Q9bCNqjFfqB59ZrzMJHIR+LVyhGNKSNcXwbWQcvOrX356LAxNcLBgd2ii11VZzTr31wQphfeXgAH15h1nizl3KpN5cjfEQV5GeohgSJUeCu89Gjxupm3z33aUBmj6QZ12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617809; c=relaxed/simple;
	bh=6yqLLrbyRf8n8iGwl36fXaImdnYsuitbiC91ybrCgGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVguuItDV0Hw+jv5VmRfs3RvkPVTm4ztEY9TrF+NAC2f43guzUwJW9zEFUVnbwa6bcWN4rOJB4WGl4Im1YWC5IjBg+7h6WaPadJH2Fvs/o8ss/OXU9ojuZen1hns5vk38gKGvIK9xQKptBrBKNGnKmesfN2nvWU5PlVmSdPWLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbFpXJEA; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d212f818so694220e87.2;
        Thu, 28 Mar 2024 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711617806; x=1712222606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GP9+afefXmxrn552E+5zoI9Qrw0HgBxF5UsTwrTB7R0=;
        b=kbFpXJEA+JfkGAuELbyMYh1cR3Yy8/TgKVBKB66/7G+CrRypi0CU9coA0mxuy7lob0
         L1cyYfgf4Vy1w9PL0gfFX4GG2Mng4pcIQy18XP8tzzUmrySb84fijh2r1Ge7Qmfwy+29
         skLlU4V1b+ucJDVo+eQUPDPD/ovvPlEpMQiUDGRc1xcDMlhNYvnSVVBD2ZLSoZz4r6ja
         c9lq0dWsvj55Waqx3n6YXZWiZNY+sJTj8Qr4xS3RKzld+55PM6sR8d+vpfj4BJOqO76Q
         R+4zvrHrAFJzOt2/nFuxQRx7UgOmCFTQek0N/YzrI6glGjNaiopE0RzwYKmXlXWAezGR
         CbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617806; x=1712222606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP9+afefXmxrn552E+5zoI9Qrw0HgBxF5UsTwrTB7R0=;
        b=hEDR2veY/56/JkHepj80ceBsnLU0KQmo1VzwzEfy7bAN1Kc2RLB/Dm2puFWVM2f+nZ
         DzjN/1L7hogtIoTAITHga47PHvx2ioBlRC8xrGJ4nnISQHuxuWA2tFYGQCdUHslSyve4
         qelwD0OA96EcoTCn0Az6HBulCVCrQ87Kdo/NRg8J4zow+TSy93+F9Hed581sTa88qfv1
         dDHku1CXyWe5hC39XgjK7rHWtgWZN8B1CGE4GApFupwNhMkamjt0eyK8QvHhCJypNHiv
         cNkPBqtOAYokEIRP6FIObMSg2NDH9+8sw7AKOFWHWG8PocjSkCI89aB6uX8MnMOSiTj7
         7IAg==
X-Forwarded-Encrypted: i=1; AJvYcCVb00Ofk5bq8oOUnD2yY3Rwr0vuSu0vHkbaIBAcuPw6JD/a9dpNh6yTUmo8lkta0VhmaTOc9cXX/Mud9ebJwl7UThQdNsVznm3+uouDo0itq2EYBzoWOBLn6Vo01NC6yslv1VIy+1sZ
X-Gm-Message-State: AOJu0YwcF5TzHYMFXM/qu2EOCft5XeSY5bfPuh3uKB+dZJktgnnUjvaa
	WIRHEVq8PgMoAql+5QwAHaa3ykf7LHLRDfWUN0L70038nCREdlbC
X-Google-Smtp-Source: AGHT+IHvVmIQCxcA7PlIBrcec1D2+7h7nhm/CLBpwxxgANk0OC9dseOeAvf5zf7NhgoGf5o2nh0qQw==
X-Received: by 2002:a19:ca43:0:b0:513:d01e:b68 with SMTP id h3-20020a19ca43000000b00513d01e0b68mr1303471lfj.3.1711617805404;
        Thu, 28 Mar 2024 02:23:25 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cf2-20020a0564020b8200b0056b0af78d80sm609298edb.34.2024.03.28.02.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:23:25 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 28 Mar 2024 10:23:10 +0100
Subject: [PATCH v4 1/5] clk: qcom: apss-ipq-pll: reuse Stromer reg offsets
 from 'clk_alpha_pll_regs'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-apss-ipq-pll-cleanup-v4-1-eddbf617f0c8@gmail.com>
References: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
In-Reply-To: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

The register offset array defined locally for the
CLK_ALPHA_PLL_TYPE_STROMER_PLUS is the same as the
entry defined for CLK_ALPHA_PLL_TYPE_STROMER in the
'clk_alpha_pll_regs' array.

To avoid code duplication, remove the local definition
and use the global one instead.

No functional changes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
 - no changes
 - Link to v3: https://lore.kernel.org/r/20240326-apss-ipq-pll-cleanup-v3-1-15c4aeeb14ac@gmail.com

Changes in v3:
 - rebase on top of v6.9-rc1
 - add Reviewed-by tag from Konrad
 - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-1-201f3cf79fd4@gmail.com

Changes in v2:
 - add Reviewed-by tag from Dmitry
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-1-52f795429d5d@gmail.com

Depends on the following patches:
 - "clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure"
   Link: https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
 - "clk: qcom: clk-alpha-pll: Stromer register cleanup"
   Link: https://lore.kernel.org/r/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index dfffec2f06ae..ed3e6405f99c 100644
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


