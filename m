Return-Path: <linux-kernel+bounces-60001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186D784FE64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1E528AB91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6483D977;
	Fri,  9 Feb 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbQV9NqJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338EC3D38F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513009; cv=none; b=SwlsWwPF3ifBE+Rr/hfc5CKxUoExHKXyhws1tGpopKp5Ws+JmKrKUDNT0sS3Qr4AQ3pR6yD/cJ8xRPT5ugKAviENEYnUQo/gTNwe/+Bp50kyaDze3eslb36n7Vh0kltAluo3gfVdw2osP1vbr6KY2uds1jpT3La9RhmlTv3ifp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513009; c=relaxed/simple;
	bh=jJfC467DwKCxWKXFg5drWkI8bmv02/WCRY1D3IsQV48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwD3kCpf9Kr/zkwn1N/FH03FEcmq/0Nu6xUhX1zIY6JBa9zEgvsCFZZVgZeeqOWcDm8wPJ90VJF913pl0SNWxhkmk5Rei8KukWV0QGIgz9hxsqc1BHXjcrvitpf9jmknxi/rHe1Q8h6rCNP/x6e0Jr6Sz4rj1h7P6erDiKF5ULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbQV9NqJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26f73732c5so186409266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513005; x=1708117805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHHNIP6WO0gU8OMi/VaI5bJNCojpf+yHVI+2cBfLhcM=;
        b=XbQV9NqJu3uAOFwTnlytVqEfbGhLN8OhYtDSlU1QminDbK3eId3NRdU95EIn/bHfZd
         8p/IjdlxdcpRaOXEYsXAb+mE8nXgxa8td7CBiLge3qrKaicoSRWA2UxGGaqpLD0wqVBk
         QT2bdJIOgqyYowwJuUEeialU6e1WjaKjg90bjq4KL+AHCv95/lgU4pNvmL+gXA3QuN5l
         u3rKFEdzo5tcg2Y9iXcPKst0ioGHSCkReQPUrcerjM+oUBnOH7TI8Xu0b/65VL2cxVfD
         p3r7bUgzrjmLxlk5cUQ+oJRUIrIUlOputhuIEBqqwU9acdrQCtwZjHuLnQkRkgW+Mb/e
         wu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513005; x=1708117805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHHNIP6WO0gU8OMi/VaI5bJNCojpf+yHVI+2cBfLhcM=;
        b=kh8f/y+YhUh7Wea1wsrsNrDLXmc+UFBLEenn92UGWMvU5HBDcDuKSyIs3TyhqCJ6ad
         b1m07XgPE70n3NNnMbWMMGTCoL6/W2zRdQ6s7aALb0nnvc2cXO47NUSjtUWfE8OodkYQ
         uPgUINDp7MVlMP0slr1gSSb7H0vX6+dPEbCJItgl1Nax+SuVLGDou9pWhTJ4IrmUB1B6
         Wf9SQAnBa/8lb+e4jDtRD3dqqJb6zwNvv52dz84z1w+G0QHqtx9q/gzYfCtkcZdAhcLR
         JcxJmGw6QR6ptFbcATDA0P6j4jpf3t/4iP5Kt39wuwjxLZeMEDyI62uGhwOQarr8DqCN
         EqxQ==
X-Gm-Message-State: AOJu0Yw2kAFPm86WEZL43UjKX8Jko24hdo1B7JElNLl92sPhLwVg3qx+
	otfXfGdYQOoHzCMIU/TCGDoN8XbtG0e/ucz4K/Z3bP3GxqdEda4Rg4IxTz2Y0uU=
X-Google-Smtp-Source: AGHT+IFTu5O1af4j7FGN8AmZHbURUGVX7RejHX0HjgmTa32pd0DFpO6fo/iQEOyWK2Le/tKRoTEjbw==
X-Received: by 2002:a17:906:f854:b0:a38:3282:baf0 with SMTP id ks20-20020a170906f85400b00a383282baf0mr149252ejb.75.1707513005496;
        Fri, 09 Feb 2024 13:10:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3nxrvLuug7z8HIMwzF5pJaONxq4VyQ1uei7niONjZO8hCT9RxKe3HKb10yHWsDMd5tmy1PlwwFwH30BdlAGx3d9elZTlrO6AFtiKdzLVjCSKbXgKNeFeInYUQJsCCe18PzwZNxV2C0u0udn/YVNgp73w3VMAgTdlqgSOqObjbb9e/W2/L2/Q6s9mcdWRDa3m9L3EWHLadCAq+GQ5TJ4BW7RlqV5RGt/F7+0ig91FA69dNdbFpejt/5JWjsuHxlUO5hFECDQ2X1oNzDORFufFWH2pqBTiASyZWrjbWNtoHXboBoBZz7t5nDxfkVQ7OK2kTSAYs32M2gpF0lxTGbV1KQhaR9xPbdb+DblBajXCvpZbvnw7ZGtDxziCKzw5FFowVdKLEOx0JO6DxCrXFt0kWdZAhR2ZrfY90wz3aEc+3jMQKjHulJGqsYp+N213xk8pvxZ5mXI6hfyBp6kS8hmn4Vb6WIJm9ReAa+pPE+3m7xp6dWzmOTwAVxwOiYvi2uM2adg==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:04 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:54 +0100
Subject: [PATCH v2 10/20] media: venus: core: Drop cache properties in
 resource struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-10-3dac84b88c4b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=5254;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jJfC467DwKCxWKXFg5drWkI8bmv02/WCRY1D3IsQV48=;
 b=UrjaBNsJnTP3co/PybDHFEc1BH/J0yF4VkvNl7d5QtYigamNSZHSR3tZosOJ3woABlRgxaYwg
 c3GZ4Kmx+YdCUW49F1WGK8iVLTkODXwXrAvG+Le8pQjSlrq9Njl2F+l
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently VMEM/OCMEM/LLCC is disabled on all platforms.

Make it unconditional to save on space.

These caches will not be enabled until the Venus driver can reference
them as chunks of SRAM (they're modelled as separate devices) to avoid
hardcoding magic addresses and rougely accessing the hardware,
bypassing the normal accessors.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c      | 24 ------------------------
 drivers/media/platform/qcom/venus/core.h      |  3 ---
 drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++------
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 1307aa9cf951..43105e765c53 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -562,9 +562,6 @@ static const struct venus_resources msm8916_res = {
 	.clks_num = 3,
 	.max_load = 352800, /* 720p@30 + 1080p@30 */
 	.hfi_version = HFI_VERSION_1XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-1.8/venus.mbn",
 };
@@ -595,9 +592,6 @@ static const struct venus_resources msm8996_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-4.2/venus.mbn",
 };
@@ -653,9 +647,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.cp_start = 0,
 	.cp_size = 0x79000000,
 	.cp_nonpixel_start = 0x1000000,
@@ -702,9 +693,6 @@ static const struct venus_resources sdm845_res = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/venus-5.2/venus.mbn",
 };
@@ -727,9 +715,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
@@ -774,9 +759,6 @@ static const struct venus_resources sc7180_res = {
 	.opp_pmdomain = pd_names_cx,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
@@ -832,9 +814,6 @@ static const struct venus_resources sm8250_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
 	.num_vpp_pipes = 4,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
 };
@@ -889,9 +868,6 @@ static const struct venus_resources sc7280_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.cp_start = 0,
 	.cp_size = 0x25800000,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 22f998637618..b1d0687d294f 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -80,9 +80,6 @@ struct venus_resources {
 	const enum vpu_version vpu_version;
 	const u8 num_vpp_pipes;
 	const u32 max_load;
-	const unsigned int vmem_id;
-	const u32 vmem_size;
-	const u32 vmem_addr;
 	const u32 cp_start;
 	const u32 cp_size;
 	const u32 cp_nonpixel_start;
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f9437b6412b9..42ff96f71235 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1067,17 +1067,14 @@ static void venus_process_msg_sys_error(struct venus_hfi_device *hdev,
 static irqreturn_t venus_isr_thread(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
-	const struct venus_resources *res;
 	void *pkt;
 	u32 msg_ret;
 
 	if (!hdev)
 		return IRQ_NONE;
 
-	res = hdev->core->res;
 	pkt = hdev->pkt_buf;
 
-
 	while (!venus_iface_msgq_read(hdev, pkt)) {
 		msg_ret = hfi_process_msg_packet(core, pkt);
 		switch (msg_ret) {
@@ -1085,9 +1082,10 @@ static irqreturn_t venus_isr_thread(struct venus_core *core)
 			venus_process_msg_sys_error(hdev, pkt);
 			break;
 		case HFI_MSG_SYS_INIT:
-			venus_hfi_core_set_resource(core, res->vmem_id,
-						    res->vmem_size,
-						    res->vmem_addr,
+			/* Disable OCMEM/VMEM unconditionally until support is added */
+			venus_hfi_core_set_resource(core, VIDC_RESOURCE_NONE,
+						    0,
+						    0,
 						    hdev);
 			break;
 		case HFI_MSG_SYS_RELEASE_RESOURCE:

-- 
2.43.0


