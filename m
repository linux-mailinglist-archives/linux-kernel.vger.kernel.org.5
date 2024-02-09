Return-Path: <linux-kernel+bounces-60002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66AB84FE67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369831F22343
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA363DBA1;
	Fri,  9 Feb 2024 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwUObXyk"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AA3D0CF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513010; cv=none; b=hWLxbLTZ0YDis6sEaPnPwfzJ/1Sx3ExKgnkV1g1bz9ldXBTVPhscCrpDHM2ZjQ05GfEuUAW/h7FKHjkyK2fil6yP2nqwklzqHttSONvaRJypP9wnhYtg42HDK1um/JFDDnJz7HhC7xA07kSekmhUKaznlk71s0V4OJ7SFixxtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513010; c=relaxed/simple;
	bh=jT4cYVE3H7d20Q/uwPs8NimA9d74CuArTIfCuOqGfSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdtOY9NPh4FTpXwH/RRmzC+ONQra/As2Mn4m29I0zJ3echM9OwDvbAvRUp94fPqJIPENaFJR4zHWsqkVmekbSai+MXJd1sHdMWLPeHx9OY0+wU4aZKnmqu8CFQdbQK+Ht0eMsc7teCsCX6hJ7J5qkpw4m1F4xPghOktZFFUI0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwUObXyk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a30e445602cso482881266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513007; x=1708117807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkisGcwj7EZsB2uxQJKfFxLa5Zz/RB1HixKJSSlCEXg=;
        b=dwUObXykmmsUQFUV7bkwhGtWVRvqLux/q0/d8b6wzBxOieQk9paU81JtAnXTQRJo1P
         fAjqLlTX8YQaTzFzsc1kAB+Tnr2wB3qvR80qNQCPtFewHTpph6E8EuDkIjC3Pzj5y4h8
         6xTHvaTjJwN1X+EhIThDPu411XsrCvGHZfvQpBphoHTFdv0qNdWHwHOWsLjBqMXmEMIb
         uj0gE82cN3TnrwEqK/8BXP0B6LMR3w8pK5JbrGIkMmRRUI8QKWUg2hKB7Unm3cyHnl1O
         3eo9Gxw0eVjccEq2hCLYNrQlDxaMmc8NebRrLWywi8By68+as04orn5PRzd0ynzNGQEz
         8+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513007; x=1708117807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkisGcwj7EZsB2uxQJKfFxLa5Zz/RB1HixKJSSlCEXg=;
        b=Fzj7QGYO0JoQNfAoQTqFpGHnh0pPemPxaO/qpR1IiJXUjpHXriSYEPb5BdMghA8743
         qvJDuamsR1/ZOmGYTXLjEZhMy90mJhczVKpiF7/8H1bw+0gBVo70GwGQG0n8h6tSQJH6
         51KagOc8crll7BY550LWbsvhtuVEJ482Vm4DgYzFbTGr6gccRtwN7meZ5dbXBBOwG7tB
         d1+iSt9nc80yvxY66UJYNxrv0g4mlqnJ2KmuO8dNXQCmNQuYN+xBTpCDS6IgF6a2U8Bo
         sVm0Fy00NQm6eA+PjA3DKS1d6ztVm7O+y0uAeI7A4ZFz9DzBrKawe4L9v33gzmI8szWg
         P+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU0eUwSYN2wEVIapGPEyuaWI53TaPUtY6UFED2AN+CJ3bDBgaaAli1Nkqxg1KygNGItHvv2dDtpdJnyXOvKI6e4f5lW6o/8dzznRVKD
X-Gm-Message-State: AOJu0Yyg+Tt2elHWzu+kEqeAaWRJpPJXMTC7fMicvdQYI0LzRX+9GyKQ
	pdvNLCjB1CaQ4kc+rzjrFJDP5QfoJT/u67p35uEfjAvN9MhQ9bBfojOAsI/KBNs=
X-Google-Smtp-Source: AGHT+IEV2H34ApePMZXUbaCjKh72AuWAiuYiRsbsouxJ+9ihBWWmei4quy45Vg8EiBRX+XstRPX3xA==
X-Received: by 2002:a17:906:370e:b0:a38:4f6a:4e7e with SMTP id d14-20020a170906370e00b00a384f6a4e7emr261180ejc.32.1707513007230;
        Fri, 09 Feb 2024 13:10:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8qP6K965v6pwV2jGGur2yfOhYX9UkKJcDNbPkJzFLgrzHOvxp4AoTJa1Sm2nuKXPyws3QTpEbCik7ElfeFzX8DpIFvy7t/WA9HOiswLIl/qkqtiKoYF2gcILrvpHx/xVIJXIHc2omny6cad7YDa4lU1pFwu2gLejfRKaDfgO2WrM+kXvBtffyKLFMn4+UhX9m7lMJifL7mV+epibggxhqbXS/ZUi7S5EsOPGARKkJ2h7ItEXSGz0nPY1p1ROdMLhh0AU1bkR64tlfzcxJCz4BRio0toD6xBbx7db3x7/+XssoI+Ob3FxoXBbJH9S+p+CY12XJIZbPiDrz2pdAdDTQFtnTqDVajRJv81Cu4HgjZt1JKa5MQxbXUsyFNnv3hcUdaeNHg3FyfptLlleBOmTRBRf4VxvKJyke7E78hrMQvNGKIu7iD26ymC/uBfecI7MCKBmC0KSUPwQl+otnxMLWCb7M3xoVnV8Jb1sZ9cFLoyjJcNJCqJDmmVlvRiNxtpQjRQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:06 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:55 +0100
Subject: [PATCH v2 11/20] media: venus: core: Use GENMASK for dma_mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-11-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=2706;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jT4cYVE3H7d20Q/uwPs8NimA9d74CuArTIfCuOqGfSo=;
 b=klquj+6pOLak7Axq6ddq02Jht/IyRARYQgLefOrwlb581p4+JvxIEmi6OHz6/y61S/0AJX91F
 bZPG5shtVjqAhAAVOPKTlhsk+dNJHgvmzrbytoDKJ43RPIJf1MukBPz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The raw literals mean very little. Substitute it with more telling
bitops macros.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 43105e765c53..06b78e98cebd 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -562,7 +562,7 @@ static const struct venus_resources msm8916_res = {
 	.clks_num = 3,
 	.max_load = 352800, /* 720p@30 + 1080p@30 */
 	.hfi_version = HFI_VERSION_1XX,
-	.dma_mask = 0xddc00000 - 1,
+	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
 	.fwname = "qcom/venus-1.8/venus.mbn",
 };
 
@@ -592,7 +592,7 @@ static const struct venus_resources msm8996_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
-	.dma_mask = 0xddc00000 - 1,
+	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
 	.fwname = "qcom/venus-4.2/venus.mbn",
 };
 
@@ -693,7 +693,7 @@ static const struct venus_resources sdm845_res = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.fwname = "qcom/venus-5.2/venus.mbn",
 };
 
@@ -715,7 +715,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
@@ -759,7 +759,7 @@ static const struct venus_resources sc7180_res = {
 	.opp_pmdomain = pd_names_cx,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
@@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
 	.num_vpp_pipes = 4,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
 };
 
@@ -868,7 +868,7 @@ static const struct venus_resources sc7280_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.cp_start = 0,
 	.cp_size = 0x25800000,
 	.cp_nonpixel_start = 0x1000000,

-- 
2.43.0


