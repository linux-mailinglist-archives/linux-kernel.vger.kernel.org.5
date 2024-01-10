Return-Path: <linux-kernel+bounces-19535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E25826E7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755F5B227B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BE754F9E;
	Mon,  8 Jan 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6AE8bUR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857F54BF9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso1978094a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704717174; x=1705321974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2jFsk8miEcGzRv0SVas60MpuNUWFzdzdQXxQ+W+fTI=;
        b=n6AE8bURieBlyr6+kAOYhpIhlhCJqx1tV4EUIAl9CaXQ6UrgNJtGz+T7t+9I2BVKos
         yfrb0Ak3+8wKlHt5KjmxCQXSQmYOdAU0HPEW/i1nwqMEZb4jFiZx1GR2LW1bMAw0BIQw
         MWdOFiAmu9B9oNFGrlcJ8my2M0V712AjJr0EK2yTYQk2AJWJLKhO3kXCs2PukeEEtBPL
         r+a4at7aK4n5+GCBVLsXjYGXtE/Pfq1HS3O26bygIvdfSDMPwDBJZExQPEdQp/1MGxpI
         +f2qlD3tfKvmQ4qfOnMdo5F/Vw4F06bI8Q2kin77K96j9ymLLNS36lOgrHdrzd777HPK
         G9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717174; x=1705321974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2jFsk8miEcGzRv0SVas60MpuNUWFzdzdQXxQ+W+fTI=;
        b=nJcq2upeuLctzBJlETGGnh7Dr+fw5BxupzZi9qh1UPqZJ+5La3xUxFsSxkYkWGN7RA
         9zQuzalbq3rTliLi+e9i/SUK3uC10PHkGo5GqTY1ZJiJoOqDEEowTyuBk5OdEhgaK/wU
         LheUHwDrWOTn28yMr7DVqoBUF4drSZWS8lJjH4WDI9UZtxA2Wyl1MnBekeUDH+AHKE0L
         npFVjPdgH+H3wxnuLxqzfdnjJdcwjTyiYMIx5NdyzEoIxhAsouBdLycr+gT6dBV0lsQI
         TpoiP57vOowRcq/gqyjLqUHDCRTgwUwJ72W6lwE2JxFZf56ce6JKGELK3k6CxdZfPKTw
         JZ4Q==
X-Gm-Message-State: AOJu0Yx5n5BQ9woj+EXIvT8EGRKDtK9F2bVw5br0G/yMTbEFeUY+fhSQ
	vtv64c0ieSbx6sF2Z37bauyE8tYRJRRxGqZ62YJiHKMUdrE=
X-Google-Smtp-Source: AGHT+IGcQH9xoEAu7sZbSriC9jHFmL7RYQiWdAFtYC1g4lR9e97Pu2N03qLLo+MfvHxzCvLJSApCYw==
X-Received: by 2002:a17:907:9444:b0:a28:9d0b:e5b7 with SMTP id dl4-20020a170907944400b00a289d0be5b7mr968685ejc.128.1704717173869;
        Mon, 08 Jan 2024 04:32:53 -0800 (PST)
Received: from [10.167.154.1] (178235179081.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.81])
        by smtp.gmail.com with ESMTPSA id bs18-20020a170906d1d200b00a2808ee8ab1sm3892978ejb.150.2024.01.08.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:32:53 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jan 2024 13:32:30 +0100
Subject: [PATCH 13/18] clk: qcom: gcc-sm8650: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v1-13-981c7a624855@linaro.org>
References: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
In-Reply-To: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704717148; l=936;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dafvtEWyd3ePEI1J3OalDI7TTuNFzH14q4snLe82PJg=;
 b=NI87ryvzv//26vUgahL2fypxMM744QQUuJQUfZUCGcZmzgWGN6CDcXr3QEvKfQuvcpUunnYTc
 4Mv3h4PQDSCDfaHI/kaVMhPgTpKgl/5gErEXGmuFmOHKNBB5GBu05K6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm8650.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8650.c b/drivers/clk/qcom/gcc-sm8650.c
index 9174dd82308c..63becb03cd90 100644
--- a/drivers/clk/qcom/gcc-sm8650.c
+++ b/drivers/clk/qcom/gcc-sm8650.c
@@ -3734,8 +3734,8 @@ static const struct qcom_reset_map gcc_sm8650_resets[] = {
 	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
 	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
 	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
-	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x32018, 2 },
-	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x32024, 2 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { .reg = 0x32018, .bit = 2, .udelay = 1000 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { .reg = 0x32024, .bit = 2, .udelay = 1000 },
 	[GCC_VIDEO_BCR] = { 0x32000 },
 };
 

-- 
2.43.0


