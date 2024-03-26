Return-Path: <linux-kernel+bounces-119018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8988C2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA42C7E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9274411;
	Tue, 26 Mar 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRBWx4XD"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E65C8FF;
	Tue, 26 Mar 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457870; cv=none; b=KFl+idBrFLc3QtoyAJv4DKzpMwf77zNX3Svrg+TlBSVP0XSk7TTAF+vCXU6fnDhwgDx/jE7dxc8Lw6G2WjGZflAEcEVdaFX4xe0/vyU4OrwF+reZ9QhG16LV7o/npN4iKmnT1YJkp5Q9ydz3jEeCt+fshbFZXCcD8xOgkbrd6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457870; c=relaxed/simple;
	bh=jtwkKQVeaINi50n5+QB3gWMCRMMWhd1xSfejgGJMO4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAbCSkqPhGq3PTASloesr+M2lYrXT0MCeiTZpdSi+KAZ9VuCD/GEBQVgrnN4WCYHl8VBNsezEQUCVdezNxCdXJ2/yHMW8O1C/oqyiUKci1auA/tblXLJj7Z7Nu/5ZE7c/iHOAnO2HtOb3Xll8hzDVwVb9Dj9TTKGKe52xdGJtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRBWx4XD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so6814970a12.2;
        Tue, 26 Mar 2024 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711457867; x=1712062667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5o5heU1qebBdqAer2g0v6uY21+7feCT1n1CrjikQAEo=;
        b=WRBWx4XDfu1i8xzvvg88m44pL3TpkOw93dFpAQTYkS2KndpsRnJFkZ84KxRgxma+KH
         fUdEXNq3QSUVu07Z4twBQQ0mGi7yqlTJmxf+/hGzyZ2lZUKFvuiEJtlJ9Ed/kibpSbw2
         +lk6eqAVTXlkN4CX9YRqj8yG2cLe7haLooOn7F4Y9Kn8mdxv7lTtdPyqLIVNOeCtw68M
         U2GewW8jjog6BPo7fQUzHeyfMOURogS4kF5+l6RSJFal2u7j6KasPgiVwS3njcrBaR3P
         lHg6E6kJjO+qu5A+PaKIwPlbVsRerd/n0zZWfnQJHJqTz3XI6UpzQIZh3ZbFrgrhFzo/
         wGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457867; x=1712062667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o5heU1qebBdqAer2g0v6uY21+7feCT1n1CrjikQAEo=;
        b=pidvnGL76TBqTTbnmnb49TvM38RxjSs/pknI52lOxzYzEfqPVe+lSuXc6fSKu2U6DV
         AQOqXqoiQNZu2pO/RNBBwPjT0aIqjKLA3CBekQmNN7ezO4ApHvpYrSRnAoKbQL32+mBO
         +GU72jSTU8g9K+ISSdAsz0vq6siX+1tE4oyT8xuJVsIs6nDyewsaTiit7wyOALUGgz72
         o2K6ezhILA9nUWwVc45TVRgsUtO80N/T478b8R4E5qb1l2/uPa6MmasA89UokeoBe69U
         /RjGygaAa0B6I8Y7O7QjPi7BU3U4cqT5FquU0O5+UBqml/EKmc4mfFHhaY7PtTWRXdO0
         s0ng==
X-Forwarded-Encrypted: i=1; AJvYcCVEzIBrgepF+uDU2VgL+a8Adl28AWbvT1L7nCE85+mdNkI4jnfvZbZOsnVhHB2zUR0thpHVqK4DPhQjuW12RxOHbo3f42BmT34cmC9AR6eaukRRmsaZWboIpWoYio6885LSiOjASK5l
X-Gm-Message-State: AOJu0YzA49zu2dF2gGEz2AYLtLaRBdUxeM48/A64Ae1lk5c8uE5Z3PcJ
	t9SB1loUoPc9TDLoNR7/hIPAdK2dvjZ94NKh66YVhuZ5d9/jE850bXbkoAgb
X-Google-Smtp-Source: AGHT+IGgl4UD2pxqCIGwcLX3mHofnHrnW0QwWVWh4qSE8CE6Dgb+FUw2ycmNVcdLN9Pp0nYxThDICw==
X-Received: by 2002:a50:d758:0:b0:56b:a969:e742 with SMTP id i24-20020a50d758000000b0056ba969e742mr6546244edj.4.1711457867050;
        Tue, 26 Mar 2024 05:57:47 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n1-20020aa7c781000000b0056bb65f4a1esm4101413eds.94.2024.03.26.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:57:46 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 13:57:38 +0100
Subject: [PATCH v3 1/5] clk: qcom: apss-ipq-pll: reuse Stromer reg offsets
 from 'clk_alpha_pll_regs'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-apss-ipq-pll-cleanup-v3-1-15c4aeeb14ac@gmail.com>
References: <20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com>
In-Reply-To: <20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com>
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


