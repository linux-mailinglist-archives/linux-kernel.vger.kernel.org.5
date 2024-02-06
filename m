Return-Path: <linux-kernel+bounces-55487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8DD84BD4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220AD1F24891
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999021DA22;
	Tue,  6 Feb 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUT5mvbg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DE14002
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245049; cv=none; b=o+uBh11vvCJSw/nhJ1e02YL3oGB0/IOCpOIB1//u2d8A/Zx/cgWcVNac9qaXp0dVMB6u1eJe/x13LvxsrWAoWiZ56PSCxQK7xN9giDC3DanH5H7/8o3LoBOpYPXmdCLAGbxJ1K1s5RnHielsypglHLlSJidiJ5/Pj4oyfV9MWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245049; c=relaxed/simple;
	bh=2S463+CzMDGi1rLOIQTPuNUpuMASFzJ+jxXDDyz8//Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2Og4+Yvm5qG7tWob/MaWziJc5AY3x8LaJoKUDn+N0JpUzVKnxBoJDGpIi8wLtDjK36/zL4A/48TWMtTlCXuWeS/Ux+bu0Suokt5Ibi2orNN2UWGiZ5ZYOcxZe9epMDKbQOTyQ5HUCBMApD06Os2OqFpii+9scRyHjTd7C9XHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUT5mvbg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511234430a4so10462363e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245046; x=1707849846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FWDxrvCgCbA9bRUaJGRlYCcz0F0+PB8LWtXBkaTaps=;
        b=mUT5mvbgHGDXea3HhlkrDiC6fZZfkH2d5F7PwBr6P3CCMETgzFpDKg7P8cdzJsclXh
         RahIK9xdywobyr3f8yI5U3B62VKcChjogIljWLbjwvwREC8wgbUDRETHeUmypGmxhhGM
         eFEBaiHDch8hLIIsF9r3DtHuIRE9KdbaeBBl8d6KE3RCF8xGuBgb8V32OGidArvKggmJ
         4Kjjz8N9Q9H5MGPl+SbvM+O1+CuHlTf+Pm59F2hflpEEdslAwHmQ73WsmnZsdrCCRqc9
         FoB+iryXYxtSdRkUS0yyRyna4w9RmJs6cXpTfR8xEa0vdv1BhtdY4kbsf+L4DiD0d58a
         ORdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245046; x=1707849846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FWDxrvCgCbA9bRUaJGRlYCcz0F0+PB8LWtXBkaTaps=;
        b=IzFWPTR546Nhjv8whezLMQ4LHOqmGIJsu6b7jmxVPr6Eycv09Ybq/Eg1zL3Nm1mkiu
         YxAqxkgN2KJJecP8p1kcpJ/fR61BdhJptihdlO33t9HQLcGJI/HYyiXkbD6IJRerfKiz
         z/dwUwL8c7/z0f7C4n9UDzRQUjNGDuor6VRVryp24jlTzCtSJ3Gkm21/+e3/OeWladcL
         Lxazv7gjZiFCMm9Ni5bYpTzvCIKJOonXwbNvhCUbZwZM4h5kw3GWRxRDKjUwyaLl/K4Y
         kARVJJwjNb7ZT3jzaZqe3kLrNbQZcWzSzblQWpp5SucnkrCMirTPprkufvsDZjk4Dl9z
         tMEw==
X-Gm-Message-State: AOJu0YyCpjlv0xedoDW2l0cGQLZZTIMxk/xgf1+U6YA0gIkkeOMax2uO
	9oAVSxhQRnJdoFBsOuT02XXaHBRiTvU6erCj3H3ev4vCO8aKXAPS8ZVVRle90ks=
X-Google-Smtp-Source: AGHT+IGGBKFsyt5zrjZScDXyPO3BCFXTskqE4t6XXzVKivuiP8AJ1yhmWjWzJDtFBd12pKeTmwTOlA==
X-Received: by 2002:ac2:562d:0:b0:511:4dac:f1ad with SMTP id b13-20020ac2562d000000b005114dacf1admr2218225lff.27.1707245046079;
        Tue, 06 Feb 2024 10:44:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1J9vOUZA9QcZquhv1h6rFUybIMyzOPWWAadU1ThYGN9vrqTSlsGZV0U/gIsFFomwydN2RDJ86QdKFCvWBExpMJuJKBcdQ1EycfvM3UJL14WPJhLBxq4mkf+OWshKm5OSN8smNZW8XVWtaQLhTuLvW+uS20lUQiQX0MXDgIpq/VLPX1uUPU3wj84Kh37dg6M1R6FwhagxhPZ7VjQdLeBo7LJciju4Plg/spetatd2nsl8fYE8va8hxSSn7z9JGIen/pn+/X4ZoHBisWdgmf1GVWZw9f22B0AjvWj2pMlxDVv+mXI/aozOlZ1btpgPrfd+rsnSg7YfZHT5ZH2rKvy/L7KTH9gokncih+lKrwj8jIC9ALFq5SRaC8fvV96G0dPlvEi3jXwqF2EKmfCI7RZltivOvBP6yyFUcH+pl/7cwFmomJQuO60nZyvAN7uS/oV7sD5cpjMEK
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a384365e3b9sm562305ejc.195.2024.02.06.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:44:05 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Feb 2024 19:43:51 +0100
Subject: [PATCH v2 18/18] clk: qcom: videocc-sm8550: Set delay for Venus
 CLK resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v2-18-c37eba13b5ce@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707245017; l=1059;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2S463+CzMDGi1rLOIQTPuNUpuMASFzJ+jxXDDyz8//Y=;
 b=JtB6YmGeACZ5ppxwuHnTrt7f/4pkjhJ0YGo1eDbaSeJw1S4VNh2TJJtc1y6unKQzQ5E9eFWNo
 SqlzIc204aAAvMWFLB5Z4LyITGz1kNJuuhU8XvdM+Qen7hM/JFxjL+i
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

The value for SM8550 is known and extracted from the msm-5.15 driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/videocc-sm8550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index f3c9dfaee968..e3f146347da7 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -378,8 +378,8 @@ static const struct qcom_reset_map video_cc_sm8550_resets[] = {
 	[CVP_VIDEO_CC_MVS0C_BCR] = { 0x8048 },
 	[CVP_VIDEO_CC_MVS1_BCR] = { 0x80c8 },
 	[CVP_VIDEO_CC_MVS1C_BCR] = { 0x8074 },
-	[VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
-	[VIDEO_CC_MVS1C_CLK_ARES] = { 0x8090, 2 },
+	[VIDEO_CC_MVS0C_CLK_ARES] = { .reg = 0x8064, .bit = 2, .udelay = 1000 },
+	[VIDEO_CC_MVS1C_CLK_ARES] = { .reg = 0x8090, .bit = 2, .udelay = 1000 },
 };
 
 static const struct regmap_config video_cc_sm8550_regmap_config = {

-- 
2.43.0


