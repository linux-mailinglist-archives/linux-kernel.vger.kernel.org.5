Return-Path: <linux-kernel+bounces-121795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9511C88EDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4907C2A25A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD91534F6;
	Wed, 27 Mar 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnixwsXz"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301D152DF5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562946; cv=none; b=J7qm92J9Y5YrkRcnrsgx8cThLU8T9YXZ65Ix4wmLbvlKhHUi1iL+Pl+fPJbeuX2wkHop70WQmnG8GvWza7PC8P6DFjVc+zlrllDXQKO/G2E01gqZAo7Tri0Dj7VA5lJBMEEakch4BptnLfbpSH1OCmyt2V4RX5ASdTBpFKsceeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562946; c=relaxed/simple;
	bh=5deDbCqxm3pbuUkC1x82NgelAh/GpAhJZVmIpVo3Vdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBlqyOkycFYtj2lXudaX2MQNYNC2nJ3bx7kgV+ePjE3wBb9EwzgghYG3jdo/D6ccEwfkWv+2BiCKiDFTDyK8Onku9HUJnhLKdLKYaJGKsOaRER5DtPfPQzL94jwk9e+AXPRM5xhw/P0w7TIVa9FcWQmYzGgDQS4rz1zvauYew/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnixwsXz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513dd2d2415so29327e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711562942; x=1712167742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnJKSpG5I+N8+ub2PloVLx2aQVcpd0l8jh5r+k1tbE4=;
        b=xnixwsXzoJfAU4ii4eMu8NtPoYN4KSM8+//M6LI8ZbUjPXBwFsMmFWlNfutg4LOy69
         8M1SzHq7fQ+2tm1Ykij+X4uyCFS7MOBqviv0bJ0D9c5fa//qaCiixrmlEvvnjzAid6G9
         G71M4DxaaOf3RKvFGQ/qUOzMwsceEq9DyixvdW3yAgbxAzDZdMf0MoMVcrMT1wZkVD+i
         AGkA/HYafS6+nWatA8sOvqOq+9OgvkBN6rJPCrs+w6jCXlhLTsJqV9qG3BoUjClED8UX
         i8p576T2RM83G1Gzef12nVJKYqCQ6Y5Oz3bUwrTOw59mjPsC1Dt5U219oKcvaRFxLKvS
         beaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562942; x=1712167742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnJKSpG5I+N8+ub2PloVLx2aQVcpd0l8jh5r+k1tbE4=;
        b=qY55HIOsJxM91I4K5FkiD/ZFHpnz6k0eEi5K5lu5wbARJeDBhUzQnIi7Ff+oplpo63
         sJTFsyYarQMO1uaE9puQ/WA5wtiPOpoj916Ua/ZH5j/ZXU+JJAf+ccivC68MxP6snnVH
         oLzzxTjD7uTMFDj/rhCpyhKl0y4lgR3PcIYgCaR/HQQpl1cr7/E5xJTgFPPm8meLu+23
         4fkUZFdk2LT3DrMVgSzO6yAszfw6+7uDGKfzfPAeSPAjTbF2rcANdFyzca3WlnhVlKAi
         l+W8NNa5iWuUtKEm5RchNwW44nYcgs7F5Ich8u09kclLDCkUojRy+/ToPMx7xxWYf0z3
         xeAg==
X-Forwarded-Encrypted: i=1; AJvYcCVCG5cbPwAchz875YCOtwi6sL/qOo7tbWsidSr8MjonLczPDHwQA/P1BvwxGpm7J3S3FcB15Uplbk9QfaKOGNwsztumF/e7U42veVv5
X-Gm-Message-State: AOJu0YymtHZsXV8yvN/C21N1khm5YsOsPZAZD038UfQTMWbk4+d0Mm9+
	ECBGKknCA5K2YoaKYSBmO7880VdzLl/TXlfSm5pnNqFzINPGCnWSaQNxlEKSido=
X-Google-Smtp-Source: AGHT+IEikHfkjz5iGGucvA3wmg5PW2Xtt6oYFCRrntX8DgpyEkGmFFW7CqAWkrprwpJQ8XJaxlN4AQ==
X-Received: by 2002:a19:8c03:0:b0:513:5a38:f545 with SMTP id o3-20020a198c03000000b005135a38f545mr158520lfd.62.1711562942530;
        Wed, 27 Mar 2024 11:09:02 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709060be200b00a45f2dc6795sm5702733ejg.137.2024.03.27.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:09:02 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Mar 2024 19:08:47 +0100
Subject: [PATCH v3 09/19] media: venus: core: Drop cache properties in
 resource struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v3-9-79f23b81c261@linaro.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
In-Reply-To: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711562924; l=5260;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5deDbCqxm3pbuUkC1x82NgelAh/GpAhJZVmIpVo3Vdg=;
 b=2QQWrNVPG0+yfJkDg+6wdHGor1QZelE9/HXpUfrZpYPx4xbIijDcNZWcJPEWkMWFmisIZbSet
 5IHXVx3Ylh6CM8KeiJhgq7IRDI2Zl72njPH30tnBktE79PqxtsWe6n5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently VMEM/OCMEM/LLCC is disabled on all platforms.

Make it unconditional to save on space.

These caches will not be enabled until the Venus driver can reference
them as chunks of SRAM (they're modelled as separate devices) to avoid
hardcoding magic addresses and rougely accessing the hardware,
bypassing the normal accessors.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c      | 24 ------------------------
 drivers/media/platform/qcom/venus/core.h      |  3 ---
 drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++------
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 26a0c264685a..51ac9eff244c 100644
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
index 376de1161114..e083ebb3ab4b 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -80,9 +80,6 @@ struct venus_resources {
 	enum vpu_version vpu_version;
 	u8 num_vpp_pipes;
 	u32 max_load;
-	unsigned int vmem_id;
-	u32 vmem_size;
-	u32 vmem_addr;
 	u32 cp_start;
 	u32 cp_size;
 	u32 cp_nonpixel_start;
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
2.44.0


