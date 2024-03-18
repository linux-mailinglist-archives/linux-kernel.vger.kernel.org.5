Return-Path: <linux-kernel+bounces-106245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4EA87EB55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1515A282F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B6535BA;
	Mon, 18 Mar 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhjPekZ+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B452F6B;
	Mon, 18 Mar 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773003; cv=none; b=IODtHiF+VVhwmvFJIfmg3xjwEZlkFDECEh/HuGFUSPzqVfbFK6aQ/BBMsAcHfYA9yjLUBIvvXWORaX1O1RQ4HDLBlVS3DqCvR4owNrnMOuqo/yD3cbjh8I3t0xfruR1rOQiCKWOTpJ3tYSsX+IEV8itt6hskttzPyMd4jq3oUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773003; c=relaxed/simple;
	bh=PDEyN+u5P8l/dVZbm4cWhtgF2+V5OGQW7RvLkXq13JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adzog90m2LlQ0/fWi0XTRb/XzPr0/UWDVrpLilWP1Jr1GWMosKBiku1IsrBCgCmbtldlPb42vIpELmfhH/V78nNtq6Nuu+BgeFK6+hs8BBV8EhPmR1DY+qQAthF1J6UP2NF6dHv65a1TvFC8Cl1maBSRgstGdiAQOisUrsAEFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhjPekZ+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso59456241fa.1;
        Mon, 18 Mar 2024 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710772999; x=1711377799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgdhHbtPQc1JOlImQiWM6nHQZYm0/RQHBl0mfEkdWq8=;
        b=dhjPekZ+U9Yas3H1K0RzwZ3R4jyHp+OQc9bupNqTUaCeitaq5XMLDxxgkbublhGntX
         lYgGEkgjidbEl5+5UBxqckQ1IeagWpcMvgpX+hfSVY7BTEINzM7L8G0KNteOBEcB1kNs
         3gEGiiiCBFldOb14ZkYsFMcAXAn1tIEuPvZ0stA7rPihflcVLYRk9dz9LSuEin5Jo1y/
         s0J3YAmSFcC2phLo4U5Cf+rQUsmVDUXePpKYLsMISSChb3p88o+JzeSw4ITFZA94Cc8U
         CtA1y9JrhGA5aFhTTQ4jxeaxh7q3vNjHj1PJjY5Y/FzWoH9YyFr/5fZoy7RrYzgUz79e
         4ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772999; x=1711377799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgdhHbtPQc1JOlImQiWM6nHQZYm0/RQHBl0mfEkdWq8=;
        b=FpGMr6t48xnElCxcF1Sth5kotawXANDHHBQmTpJU//AAL/GoqSOivDOW0qY31LX7Ph
         W/ZwlZOW7/iPRj8NN02rvrAN8jR6jCQiaCE0tXj0C1iPCzVPkShEa44rqd5PMErSFf4W
         xqOaRQ3lqcSzebNRmbM0jMSK4Gr4weAIb5iiYjHAKak0lQDIRyKcrQSgcfOLskd+L5mK
         pQihBia/AcuHIJowoeaxVoZRCHFyxGLKKf12Rm6Ya9JzKlGfnDhuiBMQKXjeOtQ03DKG
         rdSKNMLuA2G6gDhAhNSBzPDCJg32X+WKOUAd1uufA2TpakcyMK4HyEqiUtCutg8Ij88C
         nUfg==
X-Forwarded-Encrypted: i=1; AJvYcCUvXTc8hbqu3WLw1Vir0CvCufJ3NVrKn2ukFhgKgoavohqwlnUtaGIy3CnkVs+LlI+0UsiNV6VlZ+fCUBhqIdgtll07JYzaNYUD1aCg7KZ/CWXRVvzHKJCjp+hi8fFnrTmaYP0zOC7V3gnI5smnU7sU4Ebtncr/8K4S4npUwDXK+CzqA2TV
X-Gm-Message-State: AOJu0YyX6YuhruKtzFf8J1dkoxPtjbWfY8BzXiriVZe3QhRZ5WiMczZp
	G2U5i5yxCfY51a4qK7fiLjRH+AjG4HyjNH+m3/UZ4Qmb2uXAHkcQ
X-Google-Smtp-Source: AGHT+IHS0bvgUzPEUATyXje8foKE00gzKNQW25gd7Z8emDu+LlgJNQrQVsP6ij6PMky8tJBQA75WbQ==
X-Received: by 2002:a05:651c:2129:b0:2d2:b506:d2cb with SMTP id a41-20020a05651c212900b002d2b506d2cbmr8493009ljq.9.1710772999042;
        Mon, 18 Mar 2024 07:43:19 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9c49000000b002d476327311sm1527486ljj.18.2024.03.18.07.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:43:18 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 6/6] media: chips-media: wave5: support Wave515 decoder
Date: Mon, 18 Mar 2024 17:42:21 +0300
Message-ID: <20240318144225.30835-7-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318144225.30835-1-brnkv.i1@gmail.com>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for Wave515 multi-decoder IP. For now it is only
able to decode HEVC Main/Main10 profile videos.

This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
Users of the real hardware with Wave515 IP will have to
 * provide firmware specific to their SoC
 * add struct wave5_match_data like this:

	static const struct wave5_match_data platform_name_wave515_data = {
		.flags = WAVE5_IS_DEC,
		.fw_name = "cnm/wave515_platform_name_fw.bin",
	};

 * add item to wave5_dt_ids[] like this:

	{
		.compatible = "vendor,soc-wave515",
		.data = &platform_name_wave515_data
	},

 * describe new compatible in
   Documentation/devicetree/bindings/media/cnm,wave521c.yaml

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     | 242 ++++++++++++++----
 .../chips-media/wave5/wave5-regdefine.h       |   5 +
 .../platform/chips-media/wave5/wave5-vdi.c    |   6 +-
 .../platform/chips-media/wave5/wave5-vpu.c    |   8 +-
 .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
 .../chips-media/wave5/wave5-vpuconfig.h       |   9 +-
 .../media/platform/chips-media/wave5/wave5.h  |   1 +
 7 files changed, 215 insertions(+), 57 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index cdd0a0948a94..6d74a93cc5a2 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -26,6 +26,7 @@
 /* Decoder support fields */
 #define FEATURE_AVC_DECODER		BIT(3)
 #define FEATURE_HEVC_DECODER		BIT(2)
+#define W515_FEATURE_HEVC_DECODER	BIT(0)
 
 #define FEATURE_BACKBONE		BIT(16)
 #define FEATURE_VCORE_BACKBONE		BIT(22)
@@ -155,6 +156,8 @@ static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, unsigned int addr)
 {
 	u32 gdi_status_check_value = 0x3f;
 
+	if (vpu_dev->product_code == WAVE515_CODE)
+		gdi_status_check_value = 0x0738;
 	if (vpu_dev->product_code == WAVE521C_CODE ||
 	    vpu_dev->product_code == WAVE521_CODE ||
 	    vpu_dev->product_code == WAVE521E1_CODE)
@@ -186,6 +189,8 @@ unsigned int wave5_vpu_get_product_id(struct vpu_device *vpu_dev)
 	u32 val = vpu_read_reg(vpu_dev, W5_PRODUCT_NUMBER);
 
 	switch (val) {
+	case WAVE515_CODE:
+		return PRODUCT_ID_515;
 	case WAVE521C_CODE:
 		return PRODUCT_ID_521;
 	case WAVE521_CODE:
@@ -349,17 +354,31 @@ static int setup_wave5_properties(struct device *dev)
 	hw_config_def1 = vpu_read_reg(vpu_dev, W5_RET_STD_DEF1);
 	hw_config_feature = vpu_read_reg(vpu_dev, W5_RET_CONF_FEATURE);
 
-	p_attr->support_hevc10bit_enc = FIELD_GET(FEATURE_HEVC10BIT_ENC, hw_config_feature);
-	p_attr->support_avc10bit_enc = FIELD_GET(FEATURE_AVC10BIT_ENC, hw_config_feature);
-
-	p_attr->support_decoders = FIELD_GET(FEATURE_AVC_DECODER, hw_config_def1) << STD_AVC;
-	p_attr->support_decoders |= FIELD_GET(FEATURE_HEVC_DECODER, hw_config_def1) << STD_HEVC;
-	p_attr->support_encoders = FIELD_GET(FEATURE_AVC_ENCODER, hw_config_def1) << STD_AVC;
-	p_attr->support_encoders |= FIELD_GET(FEATURE_HEVC_ENCODER, hw_config_def1) << STD_HEVC;
-
-	p_attr->support_backbone = FIELD_GET(FEATURE_BACKBONE, hw_config_def0);
-	p_attr->support_vcpu_backbone = FIELD_GET(FEATURE_VCPU_BACKBONE, hw_config_def0);
-	p_attr->support_vcore_backbone = FIELD_GET(FEATURE_VCORE_BACKBONE, hw_config_def0);
+	if (vpu_dev->product_code == WAVE515_CODE) {
+		p_attr->support_decoders = FIELD_GET(W515_FEATURE_HEVC_DECODER,
+						     hw_config_def1) << STD_HEVC;
+	} else {
+		p_attr->support_hevc10bit_enc = FIELD_GET(FEATURE_HEVC10BIT_ENC,
+							  hw_config_feature);
+		p_attr->support_avc10bit_enc = FIELD_GET(FEATURE_AVC10BIT_ENC,
+							 hw_config_feature);
+
+		p_attr->support_decoders = FIELD_GET(FEATURE_AVC_DECODER,
+						     hw_config_def1) << STD_AVC;
+		p_attr->support_decoders |= FIELD_GET(FEATURE_HEVC_DECODER,
+						      hw_config_def1) << STD_HEVC;
+		p_attr->support_encoders = FIELD_GET(FEATURE_AVC_ENCODER,
+						     hw_config_def1) << STD_AVC;
+		p_attr->support_encoders |= FIELD_GET(FEATURE_HEVC_ENCODER,
+						      hw_config_def1) << STD_HEVC;
+
+		p_attr->support_backbone = FIELD_GET(FEATURE_BACKBONE,
+						     hw_config_def0);
+		p_attr->support_vcpu_backbone = FIELD_GET(FEATURE_VCPU_BACKBONE,
+							  hw_config_def0);
+		p_attr->support_vcore_backbone = FIELD_GET(FEATURE_VCORE_BACKBONE,
+							   hw_config_def0);
+	}
 
 	setup_wave5_interrupts(vpu_dev);
 
@@ -403,12 +422,18 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
 	common_vb = &vpu_dev->common_mem;
 
 	code_base = common_vb->daddr;
+
+	if (vpu_dev->product_code == WAVE515_CODE)
+		code_size = WAVE515_MAX_CODE_BUF_SIZE;
+	else
+		code_size = WAVE5_MAX_CODE_BUF_SIZE;
+
 	/* ALIGN TO 4KB */
-	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+	code_size &= ~0xfff;
 	if (code_size < size * 2)
 		return -EINVAL;
 
-	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
+	temp_base = code_base + code_size;
 	temp_size = WAVE5_TEMPBUF_SIZE;
 
 	ret = wave5_vdi_write_memory(vpu_dev, common_vb, 0, fw, size);
@@ -436,9 +461,12 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
 
 	/* These register must be reset explicitly */
 	vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
-	wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
-	wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
-	vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
+
+	if (vpu_dev->product_code != WAVE515_CODE) {
+		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
+		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
+		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
+	}
 
 	reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
 	if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
@@ -453,6 +481,24 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
 		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
 	}
 
+	if (vpu_dev->product_code == WAVE515_CODE) {
+		dma_addr_t task_buf_base;
+
+		vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF, WAVE515_COMMAND_QUEUE_DEPTH);
+		vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE, WAVE515_ONE_TASKBUF_SIZE);
+
+		for (i = 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
+			task_buf_base = temp_base + temp_size +
+					(i * WAVE515_ONE_TASKBUF_SIZE);
+			vpu_write_reg(vpu_dev,
+				      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
+				      task_buf_base);
+		}
+
+		vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI, vpu_dev->sram_buf.daddr);
+		vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE, vpu_dev->sram_buf.size);
+	}
+
 	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
 	vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
 	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
@@ -493,29 +539,39 @@ int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
 		return -EINVAL;
 	}
 
-	p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
+	if (vpu_dev->product == PRODUCT_ID_515)
+		p_dec_info->vb_work.size = WAVE515DEC_WORKBUF_SIZE;
+	else
+		p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
+
 	ret = wave5_vdi_allocate_dma_memory(inst->dev, &p_dec_info->vb_work);
 	if (ret)
 		return ret;
 
-	vpu_write_reg(inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
+	if (inst->dev->product_code != WAVE515_CODE)
+		vpu_write_reg(inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
 
 	wave5_vdi_clear_memory(inst->dev, &p_dec_info->vb_work);
 
 	vpu_write_reg(inst->dev, W5_ADDR_WORK_BASE, p_dec_info->vb_work.daddr);
 	vpu_write_reg(inst->dev, W5_WORK_SIZE, p_dec_info->vb_work.size);
 
-	vpu_write_reg(inst->dev, W5_CMD_ADDR_SEC_AXI, vpu_dev->sram_buf.daddr);
-	vpu_write_reg(inst->dev, W5_CMD_SEC_AXI_SIZE, vpu_dev->sram_buf.size);
+	if (inst->dev->product_code != WAVE515_CODE) {
+		vpu_write_reg(inst->dev, W5_CMD_ADDR_SEC_AXI, vpu_dev->sram_buf.daddr);
+		vpu_write_reg(inst->dev, W5_CMD_SEC_AXI_SIZE, vpu_dev->sram_buf.size);
+	}
 
 	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_START_ADDR, p_dec_info->stream_buf_start_addr);
 	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_SIZE, p_dec_info->stream_buf_size);
 
 	/* NOTE: SDMA reads MSB first */
 	vpu_write_reg(inst->dev, W5_CMD_BS_PARAM, BITSTREAM_ENDIANNESS_BIG_ENDIAN);
-	/* This register must be reset explicitly */
-	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
-	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+
+	if (inst->dev->product_code != WAVE515_CODE) {
+		/* This register must be reset explicitly */
+		vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
+		vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+	}
 
 	ret = send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL, NULL);
 	if (ret) {
@@ -566,7 +622,7 @@ static u32 get_bitstream_options(struct dec_info *info)
 int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
 {
 	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
-	u32 cmd_option = INIT_SEQ_NORMAL;
+	u32 bs_option, cmd_option = INIT_SEQ_NORMAL;
 	u32 reg_val, fail_res;
 	int ret;
 
@@ -576,7 +632,12 @@ int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
 	vpu_write_reg(inst->dev, W5_BS_RD_PTR, p_dec_info->stream_rd_ptr);
 	vpu_write_reg(inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
 
-	vpu_write_reg(inst->dev, W5_BS_OPTION, get_bitstream_options(p_dec_info));
+	bs_option = get_bitstream_options(p_dec_info);
+
+	if (inst->dev->product_code == WAVE515_CODE)
+		bs_option |= BSOPTION_RD_PTR_VALID_FLAG;
+
+	vpu_write_reg(inst->dev, W5_BS_OPTION, bs_option);
 
 	vpu_write_reg(inst->dev, W5_COMMAND_OPTION, cmd_option);
 	vpu_write_reg(inst->dev, W5_CMD_DEC_USER_MASK, p_dec_info->user_data_enable);
@@ -642,10 +703,12 @@ static void wave5_get_dec_seq_result(struct vpu_instance *inst, struct dec_initi
 		info->profile = FIELD_GET(SEQ_PARAM_PROFILE_MASK, reg_val);
 	}
 
-	info->vlc_buf_size = vpu_read_reg(inst->dev, W5_RET_VLC_BUF_SIZE);
-	info->param_buf_size = vpu_read_reg(inst->dev, W5_RET_PARAM_BUF_SIZE);
-	p_dec_info->vlc_buf_size = info->vlc_buf_size;
-	p_dec_info->param_buf_size = info->param_buf_size;
+	if (inst->dev->product_code != WAVE515_CODE) {
+		info->vlc_buf_size = vpu_read_reg(inst->dev, W5_RET_VLC_BUF_SIZE);
+		info->param_buf_size = vpu_read_reg(inst->dev, W5_RET_PARAM_BUF_SIZE);
+		p_dec_info->vlc_buf_size = info->vlc_buf_size;
+		p_dec_info->param_buf_size = info->param_buf_size;
+	}
 }
 
 int wave5_vpu_dec_get_seq_info(struct vpu_instance *inst, struct dec_initial_info *info)
@@ -747,22 +810,27 @@ int wave5_vpu_dec_register_framebuffer(struct vpu_instance *inst, struct frame_b
 
 		pic_size = (init_info->pic_width << 16) | (init_info->pic_height);
 
-		vb_buf.size = (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
+		if (inst->dev->product_code != WAVE515_CODE) {
+			vb_buf.size = (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
 				(p_dec_info->param_buf_size * COMMAND_QUEUE_DEPTH);
-		vb_buf.daddr = 0;
+			vb_buf.daddr = 0;
 
-		if (vb_buf.size != p_dec_info->vb_task.size) {
-			wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_task);
-			ret = wave5_vdi_allocate_dma_memory(inst->dev, &vb_buf);
-			if (ret)
-				goto free_fbc_c_tbl_buffers;
+			if (vb_buf.size != p_dec_info->vb_task.size) {
+				wave5_vdi_free_dma_memory(inst->dev,
+							  &p_dec_info->vb_task);
+				ret = wave5_vdi_allocate_dma_memory(inst->dev,
+								    &vb_buf);
+				if (ret)
+					goto free_fbc_c_tbl_buffers;
 
-			p_dec_info->vb_task = vb_buf;
-		}
+				p_dec_info->vb_task = vb_buf;
+			}
 
-		vpu_write_reg(inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
-			      p_dec_info->vb_task.daddr);
-		vpu_write_reg(inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE, vb_buf.size);
+			vpu_write_reg(inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
+				      p_dec_info->vb_task.daddr);
+			vpu_write_reg(inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE,
+				      vb_buf.size);
+		}
 	} else {
 		pic_size = (init_info->pic_width << 16) | (init_info->pic_height);
 
@@ -999,17 +1067,24 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 	dma_addr_t code_base, temp_base;
 	dma_addr_t old_code_base, temp_size;
 	u32 code_size, reason_code;
-	u32 reg_val;
+	u32 i, reg_val;
 	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
 
 	common_vb = &vpu_dev->common_mem;
 
 	code_base = common_vb->daddr;
+
+	if (vpu_dev->product_code == WAVE515_CODE)
+		code_size = WAVE515_MAX_CODE_BUF_SIZE;
+	else
+		code_size = WAVE5_MAX_CODE_BUF_SIZE;
+
 	/* ALIGN TO 4KB */
-	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+	code_size &= ~0xfff;
 	if (code_size < size * 2)
 		return -EINVAL;
-	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
+
+	temp_base = code_base + code_size;
 	temp_size = WAVE5_TEMPBUF_SIZE;
 
 	old_code_base = vpu_read_reg(vpu_dev, W5_VPU_REMAP_PADDR);
@@ -1043,9 +1118,12 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 
 		/* These register must be reset explicitly */
 		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
-		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
-		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
-		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
+
+		if (vpu_dev->product_code != WAVE515_CODE) {
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
+			vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
+		}
 
 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
@@ -1060,6 +1138,28 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
 		}
 
+		if (vpu_dev->product_code == WAVE515_CODE) {
+			dma_addr_t task_buf_base;
+
+			vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF,
+				      WAVE515_COMMAND_QUEUE_DEPTH);
+			vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE,
+				      WAVE515_ONE_TASKBUF_SIZE);
+
+			for (i = 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
+				task_buf_base = temp_base + temp_size +
+						(i * WAVE515_ONE_TASKBUF_SIZE);
+				vpu_write_reg(vpu_dev,
+					      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
+					      task_buf_base);
+			}
+
+			vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI,
+				      vpu_dev->sram_buf.daddr);
+			vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE,
+				      vpu_dev->sram_buf.size);
+		}
+
 		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
 		vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
 		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
@@ -1081,10 +1181,10 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
 				size_t size)
 {
-	u32 reg_val;
+	u32 i, reg_val;
 	struct vpu_buf *common_vb;
-	dma_addr_t code_base;
-	u32 code_size, reason_code;
+	dma_addr_t code_base, temp_base;
+	u32 code_size, temp_size, reason_code;
 	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
 	int ret;
 
@@ -1114,13 +1214,22 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 		common_vb = &vpu_dev->common_mem;
 
 		code_base = common_vb->daddr;
+
+		if (vpu_dev->product_code == WAVE515_CODE)
+			code_size = WAVE515_MAX_CODE_BUF_SIZE;
+		else
+			code_size = WAVE5_MAX_CODE_BUF_SIZE;
+
 		/* ALIGN TO 4KB */
-		code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+		code_size &= ~0xfff;
 		if (code_size < size * 2) {
 			dev_err(dev, "size too small\n");
 			return -EINVAL;
 		}
 
+		temp_base = code_base + code_size;
+		temp_size = WAVE5_TEMPBUF_SIZE;
+
 		/* Power on without DEBUG mode */
 		vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
 
@@ -1133,9 +1242,12 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 
 		/* These register must be reset explicitly */
 		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
-		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
-		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
-		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
+
+		if (vpu_dev->product_code != WAVE515_CODE) {
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
+			vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
+		}
 
 		setup_wave5_interrupts(vpu_dev);
 
@@ -1152,6 +1264,28 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
 		}
 
+		if (vpu_dev->product_code == WAVE515_CODE) {
+			dma_addr_t task_buf_base;
+
+			vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF,
+				      WAVE515_COMMAND_QUEUE_DEPTH);
+			vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE,
+				      WAVE515_ONE_TASKBUF_SIZE);
+
+			for (i = 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
+				task_buf_base = temp_base + temp_size +
+						(i * WAVE515_ONE_TASKBUF_SIZE);
+				vpu_write_reg(vpu_dev,
+					      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
+					      task_buf_base);
+			}
+
+			vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI,
+				      vpu_dev->sram_buf.daddr);
+			vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE,
+				      vpu_dev->sram_buf.size);
+		}
+
 		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
 		vpu_write_reg(vpu_dev, W5_COMMAND, W5_WAKEUP_VPU);
 		/* Start VPU after settings */
diff --git a/drivers/media/platform/chips-media/wave5/wave5-regdefine.h b/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
index a15c6b2c3d8b..557344754c4c 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
@@ -205,6 +205,9 @@ enum query_opt {
 #define W5_ADDR_TEMP_BASE                       (W5_REG_BASE + 0x011C)
 #define W5_TEMP_SIZE                            (W5_REG_BASE + 0x0120)
 #define W5_HW_OPTION                            (W5_REG_BASE + 0x012C)
+#define W5_CMD_INIT_NUM_TASK_BUF		(W5_REG_BASE + 0x0134)
+#define W5_CMD_INIT_ADDR_TASK_BUF0		(W5_REG_BASE + 0x0138)
+#define W5_CMD_INIT_TASK_BUF_SIZE		(W5_REG_BASE + 0x0178)
 #define W5_SEC_AXI_PARAM                        (W5_REG_BASE + 0x0180)
 
 /************************************************************************/
@@ -216,7 +219,9 @@ enum query_opt {
 #define W5_CMD_DEC_BS_SIZE                      (W5_REG_BASE + 0x0120)
 #define W5_CMD_BS_PARAM                         (W5_REG_BASE + 0x0124)
 #define W5_CMD_ADDR_SEC_AXI                     (W5_REG_BASE + 0x0130)
+#define W515_CMD_ADDR_SEC_AXI			(W5_REG_BASE + 0x0124)
 #define W5_CMD_SEC_AXI_SIZE                     (W5_REG_BASE + 0x0134)
+#define W515_CMD_SEC_AXI_SIZE			(W5_REG_BASE + 0x0128)
 #define W5_CMD_EXT_ADDR                         (W5_REG_BASE + 0x0138)
 #define W5_CMD_NUM_CQ_DEPTH_M1                  (W5_REG_BASE + 0x013C)
 #define W5_CMD_ERR_CONCEAL                      (W5_REG_BASE + 0x0140)
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
index ee671f5a2f37..1b1baf5caed9 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
@@ -18,7 +18,11 @@ static int wave5_vdi_allocate_common_memory(struct device *dev)
 	if (!vpu_dev->common_mem.vaddr) {
 		int ret;
 
-		vpu_dev->common_mem.size = SIZE_COMMON;
+		if (vpu_dev->product_code == WAVE515_CODE)
+			vpu_dev->common_mem.size = WAVE515_SIZE_COMMON;
+		else
+			vpu_dev->common_mem.size = SIZE_COMMON;
+
 		ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vpu_dev->common_mem);
 		if (ret) {
 			dev_err(dev, "unable to allocate common buffer\n");
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 2a0a70dd7062..99deaabc0bcc 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -60,7 +60,13 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
 
 			if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
 			    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
-				if (seq_done & BIT(inst->id)) {
+				if ((dev->product_code == WAVE515_CODE) &&
+				    (cmd_done & BIT(inst->id))) {
+					cmd_done &= ~BIT(inst->id);
+					wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
+								 cmd_done);
+					complete(&inst->irq_done);
+				} else if (seq_done & BIT(inst->id)) {
 					seq_done &= ~BIT(inst->id);
 					wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
 								 seq_done);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 8d88381ac55e..d0e135c65bf6 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -18,6 +18,7 @@
 #include "wave5-vdi.h"
 
 enum product_id {
+	PRODUCT_ID_515,
 	PRODUCT_ID_521,
 	PRODUCT_ID_511,
 	PRODUCT_ID_517,
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
index d9751eedb0f9..b435630633b5 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
@@ -8,6 +8,7 @@
 #ifndef _VPU_CONFIG_H_
 #define _VPU_CONFIG_H_
 
+#define WAVE515_CODE			0x5150
 #define WAVE517_CODE                    0x5170
 #define WAVE537_CODE                    0x5370
 #define WAVE511_CODE                    0x5110
@@ -21,12 +22,13 @@
 		((c) == WAVE517_CODE ||	(c) == WAVE537_CODE ||		\
 		 (c) == WAVE511_CODE || (c) == WAVE521_CODE ||		\
 		 (c) == WAVE521E1_CODE || (c) == WAVE521C_CODE ||	\
-		 (c) == WAVE521C_DUAL_CODE);				\
+		 (c) == WAVE521C_DUAL_CODE) || (c) == WAVE515_CODE;	\
 })
 
 #define WAVE517_WORKBUF_SIZE            (2 * 1024 * 1024)
 #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K, AVC 40K
 #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
+#define WAVE515DEC_WORKBUF_SIZE		(2 * 1024 * 1024)
 
 #define MAX_NUM_INSTANCE                32
 
@@ -50,16 +52,21 @@
 #define VLC_BUF_NUM                     (2)
 
 #define COMMAND_QUEUE_DEPTH             (2)
+#define WAVE515_COMMAND_QUEUE_DEPTH	(4)
 
 #define W5_REMAP_INDEX0                 0
 #define W5_REMAP_INDEX1                 1
 #define W5_REMAP_MAX_SIZE               (1024 * 1024)
 
 #define WAVE5_MAX_CODE_BUF_SIZE         (2 * 1024 * 1024)
+#define WAVE515_MAX_CODE_BUF_SIZE	(1024 * 1024)
 #define WAVE5_TEMPBUF_OFFSET            WAVE5_MAX_CODE_BUF_SIZE
 #define WAVE5_TEMPBUF_SIZE              (1024 * 1024)
+#define WAVE515_TASKBUF_OFFSET		(WAVE515_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE)
 
 #define SIZE_COMMON                 (WAVE5_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE)
+#define WAVE515_ONE_TASKBUF_SIZE	(8 * 1024 * 1024)
+#define WAVE515_SIZE_COMMON	(WAVE515_TASKBUF_OFFSET + WAVE515_COMMAND_QUEUE_DEPTH * WAVE515_ONE_TASKBUF_SIZE)
 
 //=====4. VPU REPORT MEMORY  ======================//
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5.h b/drivers/media/platform/chips-media/wave5/wave5.h
index 063028eccd3b..57b00e182b6e 100644
--- a/drivers/media/platform/chips-media/wave5/wave5.h
+++ b/drivers/media/platform/chips-media/wave5/wave5.h
@@ -22,6 +22,7 @@
  */
 #define BSOPTION_ENABLE_EXPLICIT_END		BIT(0)
 #define BSOPTION_HIGHLIGHT_STREAM_END		BIT(1)
+#define BSOPTION_RD_PTR_VALID_FLAG		BIT(31)
 
 /*
  * Currently the driver only supports hardware with little endian but for source
-- 
2.44.0


