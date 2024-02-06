Return-Path: <linux-kernel+bounces-55481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C184BD38
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883A21C20BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078E1C295;
	Tue,  6 Feb 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGFSScWQ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9891B960
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245040; cv=none; b=XfJ/XjyZHVrAQiVbPtxsBLX6433ZGT/sJEet5YW24ZZkRR6SpzPlYwxJeRY2Rf+7E2Q84FSaKDBv3WTfNmg9WFkhkC+hWXsHN93uWiUDyl/rpEOwL2cmbHTLHsM0V0wO8zkqsANSGVSQR/5BjZjtf7SFBpIBqAB9i4dzcoB1c9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245040; c=relaxed/simple;
	bh=Wzt1u2nUXpu17TbhBAtUYSKbvWX7vxBCCMtjsfpido0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccYfBbqf0YY0v/zscy+/P3lEEvLgwBzipXCTJ+JMAKImAdMNFuzFw5Hc084vP+kAWvhQYmPSKXlJ+bv6wUl6W4fCcqksafWwmS4R7P9PvBkgEgJcZUho8n73GL5qU+mBs/aalqp9EZT+Kb8CmnmRMlz5+9B17+qy4b4OUVumYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pGFSScWQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26f73732c5so845189866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245037; x=1707849837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeqI4K6XpkMUVEuF0Qf5K9m4XIcii/fSlxfZsb36s+Q=;
        b=pGFSScWQsTUKJdYa+KHIZKth++r9izSrK876oy6C1iZkDjXkIW/DUL8ISm2F01Uz+7
         hCQ7EX9+JSHMf0GRBEbX7Z7pfxoEqu9r3lxvwoWnG3jRmqMzu20pReQ9eWlnCDbZnqmg
         wY9zjWQ7D5bcnWZPKdPW1WN/a9GzQeOLGR6LBgS3WwqqtBILH6Ot5SbG8EM5dBMHSPzp
         xmPYZYc8h+baJgW0Peh8Pp62ccLEb0btRLjG0hcobNyq2wQhHochNzK46Q4Pl24WwQ/6
         vzxyKtnRbfSY0/aZyl8dFp54BQH4DYIKBMHQpyjqx5PYZMI1nAzE+abewHcViV2tbqB8
         t16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245037; x=1707849837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeqI4K6XpkMUVEuF0Qf5K9m4XIcii/fSlxfZsb36s+Q=;
        b=GP0M3CcoNFDWTDPxsmbTnLkhMGFoFbHJEZ033WdzCa4nUctggWFVoXyOSZKlVgE3Sc
         bgIxcrp7BNn90RC46aBrxbkjY++Qzrc8aYMm9gwwS3nFyOlnwvci83z+MF5J6TBprh8A
         tGzxgVf3r/Qt7BTERrpZ7VXmXWO/KQA06gw3Ijh70xc6o6+FUwxQV8qJ4XuIeVOiGtcg
         Fa6fumBCio7JFAQGyy6aN8jcXXTEzPgQTi4XFzbG6wNBVv2etiVu48ynwXXUaaj1uB1+
         Jx5r1SknIbozkJmAfmVOfOytXsQI9WLjsEJbTxrX+dVXEmSPxsRul+RS86sqqmDdAznQ
         CCDg==
X-Gm-Message-State: AOJu0Yxv1nMNYH7cUQQyfzrnUz50X4rwh+ofdu6GjX011uXxMdd6D2QH
	QFCnXyEqehTiqUv4N8IDezyjqAx2zEJLqAomVB6aUSQ1CEgEbrzDathDj6mEN5s=
X-Google-Smtp-Source: AGHT+IE0Bcbl4ouGIaXw6lKWZbbmLrV6tznq5JI5cVJtPSd87CRzvk4Xxe/3TXXMAHSmP4E5058j9g==
X-Received: by 2002:a17:906:e2da:b0:a37:3922:8838 with SMTP id gr26-20020a170906e2da00b00a3739228838mr2607142ejb.70.1707245036907;
        Tue, 06 Feb 2024 10:43:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWC3CrpRdnOTKl6LZR3TO+z2rNAi33UNYzq1ERwr1E+mbAMT6IehWKF4IEyvQIMeAiAh4WYKdgnIvJbdotgTZYi8iWdksvaoCHkvvh1c+WWfcgc6/0K7r0Ie9G69G4GRvPcu8IjW60+gPwQNIHvbcoJB5edBjNN7hOlNHmbniw8X/KUgQyM+aKyXxGhJK9EmetSufi5DVWjeCDuoT0UUo13DRq9Bi72ZxVctwMzi0Yivje2k+Iault+gFAVM//eJQLhT//udlWXP7fswIVqPVzb2+zB55nsJ6LxPzaiJE+rfBBYu8RG59PBpU/J0HykFjneT0s9tOYOWJn6BPTSTj7J82mwzwU9/WtUmIWpztlcjAOg6V+dc0royuHqZ1laROdzR9+nszzUBA1zeyYVh0wLeqFwQOUut20SGKUTJihe6wkDQvkkln7kpk/QlX2xKHx/fD44Gf89
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a384365e3b9sm562305ejc.195.2024.02.06.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:43:56 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Feb 2024 19:43:45 +0100
Subject: [PATCH v2 12/18] clk: qcom: gcc-sm8550: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v2-12-c37eba13b5ce@linaro.org>
References: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
In-Reply-To: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707245017; l=1016;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Wzt1u2nUXpu17TbhBAtUYSKbvWX7vxBCCMtjsfpido0=;
 b=DcjLxfc2Cefhlse0tnRH627Hek7w2VYLS5W5OTY42IWK6t0FXg4QEljQv5cx8usNri2oN4Lv0
 3lWhm18CbCxBHx8445DKFDmvq4sppy1LA9N/b6BLwI4eabVQtfAv8VS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

The value for SM8550 is known and extracted from the msm-5.15 driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm8550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index b883dffe5f7a..4cbc728f5c72 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -3276,8 +3276,8 @@ static const struct qcom_reset_map gcc_sm8550_resets[] = {
 	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
 	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
-	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x32018, 2 },
-	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x32024, 2 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { .reg = 0x32018, .bit = 2, .udelay = 1000 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { .reg = 0x32024, .bit = 2, .udelay = 1000 },
 	[GCC_VIDEO_BCR] = { 0x32000 },
 };
 

-- 
2.43.0


