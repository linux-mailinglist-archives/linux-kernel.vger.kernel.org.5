Return-Path: <linux-kernel+bounces-109740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CB88551A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78614B2166B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1960E5B5A6;
	Thu, 21 Mar 2024 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg99NGJd"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0453819;
	Thu, 21 Mar 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007412; cv=none; b=ZNxELGcxLklYBXHVDJya5AXW1UVrDZZGKLqM0wDisID8bQL49Rg0lWN048PqRss56wZwKzW2Z2jz4/Shr8dMHTRWJ3hvzCm1SMRhbD/FKbxSdtTuypbj6TPBU4bZgZoBUI0RA3Z3DdXUnKAe/5JDeKQlBZ3t+ohn6UfhNrnkXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007412; c=relaxed/simple;
	bh=cYbcthCG9P8DgaJDGamgchXAyi4jJc8vGs7tu9tR3vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/jcVdlHL9Ugf/4xDCGnxiyTlkV+XioY3TWZUK8xFXeA02q2QYZPVjENunKpLRkY1tTMB+npUw6+LfrsX6FeTnLjcA4MJfGLwYHawTW5aMDCLFGnOkHtAKK9FxEKKLMiEYdyaQ9+bU6pemB8APg1xjs7cyt9rDiPJVuc6iy1X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg99NGJd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4146e5c719bso5039035e9.2;
        Thu, 21 Mar 2024 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711007409; x=1711612209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7c6xsBSA+Ep4/2CdGzcOfHT8xx5ktGGm+tKwvoVGkAU=;
        b=Cg99NGJdbFPB0048ZTm2u3IQxjsdlaC74IDNj2WLrVfT7jjGD+TsEcQYHV4KssMBgz
         X7yGstCNSP0p58/koU4ZbzZlsJCXJTR82QvR7qfE5fWr048XO4N+X3LY+r05ev10iUrk
         VovNBnJwKbxdoA6muj+cD4r+ts3Imu+SSbWqkZ0AGVCIqyMHG5/ILA7z1QtG4cC5Xflt
         k53yifGc+UPuf7jGON4vtbYpxfwrsIhjigordKMTlWGIHGyg7cECl1h300fGOsNl5LWP
         KD8K9z2F9dmdRuYAwqPvRnnLXdkk1uZf2awhsLUhiBBiZ0gDdb4sLOGUGdPrpIwUkuGx
         BmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007409; x=1711612209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c6xsBSA+Ep4/2CdGzcOfHT8xx5ktGGm+tKwvoVGkAU=;
        b=cW1gfpYK9FIkYpJwYKxEvCoyIlxDtGd4GE9/krbB1eNl2fdAGNJF1NjTRA5HOIwy/9
         3V8+0KujgRmWOV49cAA4Emeg2+mKYhyXFcYjgqFeo8O5aSmhJU1bmlkUeWR01S5E5J88
         O6vp8yqM8GU28CNYq0ZAmqDGercfjjx8frvTMLRZafJfyppTNqtuMTc358WcYlFvTCeg
         PnpA46DQo48qwo7SbY0/smUqJ+kn6YeD3AeUcc17kyXrWoyB5ARM8NRWZsLthfX4dazC
         qH/0upHNA/0TeM6UWlrLabihzrCLoZmWmla2eQO4oHin+7NeOJ0BTzxZmGY552rP9ojz
         AvWg==
X-Forwarded-Encrypted: i=1; AJvYcCVAr1h56ZbitvqGZXSfISPxsfzlmJTvTkigKwBdgW6Ys8M60iZ/szF38T7YZBkS536n6hNElc74p0Ib5yHyZqwO7t8fLp4Tt//S/CLHD1jT7PeDOhmJso5+MrFvE0gflXOuvaLWxYJU
X-Gm-Message-State: AOJu0YwVYL62RgZtMImDK8/fdGcAG0pxM9Nzb9MNMiAjjS+dfCg1UhoB
	w/PiBnOK6ipyuImPhd8LywjglIVNiTftHr9EJLjh8TE2l0cHY1kq
X-Google-Smtp-Source: AGHT+IHjhhk0y+43R1gh1ylRakmsANYVD+Q7QBsOHW3aFt+RsOaAJyr0fZYG1dg2Mln3M2NwcgN8Iw==
X-Received: by 2002:a05:600c:4f44:b0:414:f60:5d6a with SMTP id m4-20020a05600c4f4400b004140f605d6amr3094529wmq.0.1711007408912;
        Thu, 21 Mar 2024 00:50:08 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id p1-20020a05600c1d8100b004146bda6c32sm4637096wms.9.2024.03.21.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:50:08 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 21 Mar 2024 08:49:54 +0100
Subject: [PATCH v2 1/6] clk: qcom: apss-ipq-pll: reuse Stromer reg offsets
 from 'clk_alpha_pll_regs'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-apss-ipq-pll-cleanup-v2-1-201f3cf79fd4@gmail.com>
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

The register offset array defined locally for the
CLK_ALPHA_PLL_TYPE_STROMER_PLUS is the same as the
entry defined for CLK_ALPHA_PLL_TYPE_STROMER in the
'clk_alpha_pll_regs' array.

To avoid code duplication, remove the local definition
and use the global one instead.

No functional changes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
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


