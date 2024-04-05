Return-Path: <linux-kernel+bounces-133356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B877189A2BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701252880C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FAC172798;
	Fri,  5 Apr 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+tLWXCA"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF34172761;
	Fri,  5 Apr 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335302; cv=none; b=lcsYG7zOucpwe5c4lZsDfh5UgIjRyd2y89ElfFtHt6P9WCPg7BttQTZBdgoH1TvBUJNS9+HKfS/4wHRGu9IdmHimFYMh/V/dsN0Nw5+8hkK3rkvT7axLSYyn4maT1WUqphHj4yHYXOheLrzYlJFeE9TcqwnSpngoHBHqwRJ4E5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335302; c=relaxed/simple;
	bh=nIhTATi18sVFa8b0d69e5brFuwVgPU/CE49uTfwamN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfArB3WYuiV5TJbKimmMj497+3CahtBFEuhXswP5aodZNB+2EJFVK/AH8ly1kICldp5cQTSSw9glRzh9k/+thAV0qdn+MGdPH3u/fYLZQVbK3GWPPhEOnJfTJCrDog7TsmVZNnqQ/nupDXD49KQa8xpmOYKbdfjpdgL5pn9gwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+tLWXCA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d8743ecebdso518531fa.1;
        Fri, 05 Apr 2024 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712335297; x=1712940097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nipozK0LbwLM4MSvVg9nKzgzcvTf2zC8k/WS3RRN0Rw=;
        b=Q+tLWXCA+y9WGZc2M8AP/5bwmCTZ3M8210zMc+8kPC0Sx98haLYzwQ/+4kbRkHycVG
         ARgl+WtEkGt1kljcE5OPz6/3VlAVTEXiLg4wvl9b5DgacVa4YVfjQzhlUMvyxjHl1N8J
         S9CKIHlmFKVBHcyE13AcgfGy8W4RIcDTWXPcBylgbZ4GUcKW91sQ496juJqWxPXZZ3kV
         xawL4mQ9u9ORavGHo1mi5IGugUm7cualMy7zl50+0bwDxOH5xBfKY1+H4G9WMrGyafqj
         qtiOfV/6knI1JSWJ2gLrV36cVZfLxf/ILaE9sJpveP8N/9C3sSpkGq84xEJrv1I/bexh
         k1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335297; x=1712940097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nipozK0LbwLM4MSvVg9nKzgzcvTf2zC8k/WS3RRN0Rw=;
        b=ZXPGbHvZ3/JRZysIGMM8hzfSkL9p0CKmdxnNmwGgZLYa6Vvo60NazlvuywsDNArYaA
         6z7MreC2Kcln/7onvob+2/65iPs0xaPjhKBDuUKNhSgzxsLzN6lIEmqcSgaOcMXq3eMG
         xqzMukiY1dclri52qL8lhYGAslj/lmeZ2wlnbnIboPIkndzHb5U9GfcYavqOkhy0CTf/
         je22fGkX9nWsRO7taYzRIGq8FvaFDZbmdKHkZc4NWpaLHG1yO8T+H7YVykqxUc9SIH36
         HxFUKGb+xf5T0rVZsTtMh8eC+mNvvIeqrGjtuXVx+/tndnAqU2Lja9itDDl/oKk+MZK8
         bfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTwU4+lQg14zgldVanHXb7TN3lraFCgjpKoWUYLWajDCocjE/OUZT0BWSUWl8Xe18GVyN3/8fo/Jr0RVQoENx+FG05jrwTB+PDjsBcoNuo3+CN3imXbePuAIVALjNezPKq6QasjDfLgH0=
X-Gm-Message-State: AOJu0YzegTZvwwRcV5/AO2EO7Cl1farZi/+AaA0mqAKdWOW8BuU/B/5D
	UGf0C5fZzoEXu6u7B3Qjd9qxcFzVl+l7NKHY4nRo9sypR5BCTmLpeMbzvIpDzUw=
X-Google-Smtp-Source: AGHT+IGVndhLPqoirJN09VBIuSb4iTegAW3tcnbI3uhVUGgCvWkUc7yShPiNlaR/Oq5MhrmUUWeYeg==
X-Received: by 2002:a2e:888f:0:b0:2d6:cd05:1890 with SMTP id k15-20020a2e888f000000b002d6cd051890mr1451605lji.0.1712335297377;
        Fri, 05 Apr 2024 09:41:37 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a05651c124d00b002d6c93793f1sm218372ljh.77.2024.04.05.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:41:37 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] media: chips-media: wave5: support Wave515 decoder
Date: Fri,  5 Apr 2024 19:41:09 +0300
Message-ID: <20240405164112.24571-6-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405164112.24571-1-brnkv.i1@gmail.com>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for Wave515 multi-decoder IP. For now it is only
able to decode HEVC Main/Main10 profile videos into YUV420.

This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
Users of the real hardware with Wave515 IP will have to
 * provide firmware specific to their SoC
 * add struct wave5_match_data like this:

	static const struct wave5_match_data platform_name_wave515_data = {
		.flags = WAVE5_IS_DEC,
		.fw_name = "cnm/wave515_platform_name_fw.bin",
		.sram_size = (71 * 1024),
	};

 * add item to wave5_dt_ids[] like this:

	{
		.compatible = "vendor,soc-wave515",
		.data = &platform_name_wave515_data,
	},

 * describe new compatible in
   Documentation/devicetree/bindings/media/cnm,wave521c.yaml

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../platform/chips-media/wave5/wave5-helper.c |   8 +-
 .../platform/chips-media/wave5/wave5-hw.c     | 286 +++++++++++++-----
 .../chips-media/wave5/wave5-regdefine.h       |   5 +
 .../platform/chips-media/wave5/wave5-vdi.c    |   6 +-
 .../chips-media/wave5/wave5-vpu-dec.c         |  21 +-
 .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
 .../platform/chips-media/wave5/wave5-vpu.c    |   8 +-
 .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
 .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
 .../media/platform/chips-media/wave5/wave5.h  |   6 +
 10 files changed, 280 insertions(+), 79 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/drivers/media/platform/chips-media/wave5/wave5-helper.c
index 8433ecab230c..bb89b279ca8f 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
@@ -29,7 +29,13 @@ void wave5_cleanup_instance(struct vpu_instance *inst)
 {
 	int i;
 
-	if (list_is_singular(&inst->list))
+	/*
+	 * For Wave515 SRAM memory is allocated at
+	 * wave5_vpu_dec_register_device() and freed at
+	 * wave5_vpu_dec_unregister_device().
+	 */
+	if (list_is_singular(&inst->list) &&
+	    inst->dev->product_code != WAVE515_CODE)
 		wave5_vdi_free_sram(inst->dev);
 
 	for (i = 0; i < inst->fbc_buf_count; i++)
diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index 36f2fc818013..c89aafabc742 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -18,18 +18,20 @@
 #define QUEUE_REPORT_MASK		0xffff
 
 /* Encoder support fields */
-#define FEATURE_HEVC10BIT_ENC		BIT(3)
-#define FEATURE_AVC10BIT_ENC		BIT(11)
-#define FEATURE_AVC_ENCODER		BIT(1)
-#define FEATURE_HEVC_ENCODER		BIT(0)
+#define W521_FEATURE_HEVC10BIT_ENC	BIT(3)
+#define W521_FEATURE_AVC10BIT_ENC	BIT(11)
+#define W521_FEATURE_AVC_ENCODER	BIT(1)
+#define W521_FEATURE_HEVC_ENCODER	BIT(0)
 
 /* Decoder support fields */
-#define FEATURE_AVC_DECODER		BIT(3)
-#define FEATURE_HEVC_DECODER		BIT(2)
+#define W521_FEATURE_AVC_DECODER	BIT(3)
+#define W521_FEATURE_HEVC_DECODER	BIT(2)
+#define W515_FEATURE_HEVC10BIT_DEC	BIT(1)
+#define W515_FEATURE_HEVC_DECODER	BIT(0)
 
-#define FEATURE_BACKBONE		BIT(16)
-#define FEATURE_VCORE_BACKBONE		BIT(22)
-#define FEATURE_VCPU_BACKBONE		BIT(28)
+#define W521_FEATURE_BACKBONE		BIT(16)
+#define W521_FEATURE_VCORE_BACKBONE	BIT(22)
+#define W521_FEATURE_VCPU_BACKBONE	BIT(28)
 
 #define REMAP_CTRL_MAX_SIZE_BITS	((W5_REMAP_MAX_SIZE >> 12) & 0x1ff)
 #define REMAP_CTRL_REGISTER_VALUE(index)	(			\
@@ -155,6 +157,8 @@ static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, unsigned int addr)
 {
 	u32 gdi_status_check_value = 0x3f;
 
+	if (vpu_dev->product_code == WAVE515_CODE)
+		gdi_status_check_value = 0x0738;
 	if (vpu_dev->product_code == WAVE521C_CODE ||
 	    vpu_dev->product_code == WAVE521_CODE ||
 	    vpu_dev->product_code == WAVE521E1_CODE)
@@ -186,6 +190,8 @@ unsigned int wave5_vpu_get_product_id(struct vpu_device *vpu_dev)
 	u32 val = vpu_read_reg(vpu_dev, W5_PRODUCT_NUMBER);
 
 	switch (val) {
+	case WAVE515_CODE:
+		return PRODUCT_ID_515;
 	case WAVE521C_CODE:
 		return PRODUCT_ID_521;
 	case WAVE521_CODE:
@@ -349,17 +355,33 @@ static int setup_wave5_properties(struct device *dev)
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
+		p_attr->support_hevc10bit_dec = FIELD_GET(W515_FEATURE_HEVC10BIT_DEC,
+							  hw_config_feature);
+		p_attr->support_decoders = FIELD_GET(W515_FEATURE_HEVC_DECODER,
+						     hw_config_def1) << STD_HEVC;
+	} else {
+		p_attr->support_hevc10bit_enc = FIELD_GET(W521_FEATURE_HEVC10BIT_ENC,
+							  hw_config_feature);
+		p_attr->support_avc10bit_enc = FIELD_GET(W521_FEATURE_AVC10BIT_ENC,
+							 hw_config_feature);
+
+		p_attr->support_decoders = FIELD_GET(W521_FEATURE_AVC_DECODER,
+						     hw_config_def1) << STD_AVC;
+		p_attr->support_decoders |= FIELD_GET(W521_FEATURE_HEVC_DECODER,
+						      hw_config_def1) << STD_HEVC;
+		p_attr->support_encoders = FIELD_GET(W521_FEATURE_AVC_ENCODER,
+						     hw_config_def1) << STD_AVC;
+		p_attr->support_encoders |= FIELD_GET(W521_FEATURE_HEVC_ENCODER,
+						      hw_config_def1) << STD_HEVC;
+
+		p_attr->support_backbone = FIELD_GET(W521_FEATURE_BACKBONE,
+						     hw_config_def0);
+		p_attr->support_vcpu_backbone = FIELD_GET(W521_FEATURE_VCPU_BACKBONE,
+							  hw_config_def0);
+		p_attr->support_vcore_backbone = FIELD_GET(W521_FEATURE_VCORE_BACKBONE,
+							   hw_config_def0);
+	}
 
 	setup_wave5_interrupts(vpu_dev);
 
@@ -403,12 +425,18 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
 	common_vb = &vpu_dev->common_mem;
 
 	code_base = common_vb->daddr;
+
+	if (vpu_dev->product_code == WAVE515_CODE)
+		code_size = WAVE515_MAX_CODE_BUF_SIZE;
+	else
+		code_size = WAVE521_MAX_CODE_BUF_SIZE;
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
@@ -436,12 +464,15 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
 
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
-	if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
+	if (FIELD_GET(W521_FEATURE_BACKBONE, reg_val)) {
 		reg_val = ((WAVE5_PROC_AXI_ID << 28) |
 			   (WAVE5_PRP_AXI_ID << 24) |
 			   (WAVE5_FBD_Y_AXI_ID << 20) |
@@ -453,6 +484,24 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
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
@@ -493,29 +542,40 @@ int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
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
+		vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1,
+			      WAVE521_COMMAND_QUEUE_DEPTH - 1);
+	}
 
 	ret = send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL, NULL);
 	if (ret) {
@@ -566,7 +626,7 @@ static u32 get_bitstream_options(struct dec_info *info)
 int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
 {
 	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
-	u32 cmd_option = INIT_SEQ_NORMAL;
+	u32 bs_option, cmd_option = INIT_SEQ_NORMAL;
 	u32 reg_val, fail_res;
 	int ret;
 
@@ -576,7 +636,13 @@ int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
 	vpu_write_reg(inst->dev, W5_BS_RD_PTR, p_dec_info->stream_rd_ptr);
 	vpu_write_reg(inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
 
-	vpu_write_reg(inst->dev, W5_BS_OPTION, get_bitstream_options(p_dec_info));
+	bs_option = get_bitstream_options(p_dec_info);
+
+	/* Without RD_PTR_VALID_FLAG Wave515 ignores RD_PTR value */
+	if (inst->dev->product_code == WAVE515_CODE)
+		bs_option |= BSOPTION_RD_PTR_VALID_FLAG;
+
+	vpu_write_reg(inst->dev, W5_BS_OPTION, bs_option);
 
 	vpu_write_reg(inst->dev, W5_COMMAND_OPTION, cmd_option);
 	vpu_write_reg(inst->dev, W5_CMD_DEC_USER_MASK, p_dec_info->user_data_enable);
@@ -642,10 +708,12 @@ static void wave5_get_dec_seq_result(struct vpu_instance *inst, struct dec_initi
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
@@ -747,22 +815,27 @@ int wave5_vpu_dec_register_framebuffer(struct vpu_instance *inst, struct frame_b
 
 		pic_size = (init_info->pic_width << 16) | (init_info->pic_height);
 
-		vb_buf.size = (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
-				(p_dec_info->param_buf_size * COMMAND_QUEUE_DEPTH);
-		vb_buf.daddr = 0;
+		if (inst->dev->product_code != WAVE515_CODE) {
+			vb_buf.size = (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
+				(p_dec_info->param_buf_size * WAVE521_COMMAND_QUEUE_DEPTH);
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
 
@@ -845,17 +918,24 @@ int wave5_vpu_dec_register_framebuffer(struct vpu_instance *inst, struct frame_b
 
 static u32 wave5_vpu_dec_validate_sec_axi(struct vpu_instance *inst)
 {
+	u32 bitdepth = inst->codec_info->dec_info.initial_info.luma_bitdepth;
 	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
 	u32 bit_size = 0, ip_size = 0, lf_size = 0, ret = 0;
 	u32 sram_size = inst->dev->sram_size;
+	u32 width = inst->src_fmt.width;
 
 	if (!sram_size)
 		return 0;
 
 	/*
-	 * TODO: calculate bit_size, ip_size, lf_size from inst->src_fmt.width
-	 * and inst->codec_info->dec_info.initial_info.luma_bitdepth
+	 * TODO: calculate bit_size, ip_size, lf_size from width and bitdepth
+	 * for Wave521.
 	 */
+	if (inst->dev->product_code == WAVE515_CODE) {
+		bit_size = DIV_ROUND_UP(width, 16) * 5 * 8;
+		ip_size = ALIGN(width, 16) * 2 * bitdepth / 8;
+		lf_size = ALIGN(width, 16) * 10 * bitdepth / 8;
+	}
 
 	if (p_dec_info->sec_axi_info.use_bit_enable && sram_size >= bit_size) {
 		ret |= BIT(0);
@@ -1033,11 +1113,18 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 	common_vb = &vpu_dev->common_mem;
 
 	code_base = common_vb->daddr;
+
+	if (vpu_dev->product_code == WAVE515_CODE)
+		code_size = WAVE515_MAX_CODE_BUF_SIZE;
+	else
+		code_size = WAVE521_MAX_CODE_BUF_SIZE;
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
@@ -1071,12 +1158,15 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 
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
-		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
+		if (FIELD_GET(W521_FEATURE_BACKBONE, reg_val)) {
 			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
 					(WAVE5_PRP_AXI_ID << 24) |
 					(WAVE5_FBD_Y_AXI_ID << 20) |
@@ -1088,6 +1178,29 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
 		}
 
+		if (vpu_dev->product_code == WAVE515_CODE) {
+			dma_addr_t task_buf_base;
+			u32 i;
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
@@ -1111,8 +1224,8 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 {
 	u32 reg_val;
 	struct vpu_buf *common_vb;
-	dma_addr_t code_base;
-	u32 code_size, reason_code;
+	dma_addr_t code_base, temp_base;
+	u32 code_size, temp_size, reason_code;
 	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
 	int ret;
 
@@ -1142,13 +1255,22 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 		common_vb = &vpu_dev->common_mem;
 
 		code_base = common_vb->daddr;
+
+		if (vpu_dev->product_code == WAVE515_CODE)
+			code_size = WAVE515_MAX_CODE_BUF_SIZE;
+		else
+			code_size = WAVE521_MAX_CODE_BUF_SIZE;
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
 
@@ -1161,14 +1283,17 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 
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
 
 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
-		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
+		if (FIELD_GET(W521_FEATURE_BACKBONE, reg_val)) {
 			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
 					(WAVE5_PRP_AXI_ID << 24) |
 					(WAVE5_FBD_Y_AXI_ID << 20) |
@@ -1180,6 +1305,29 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
 		}
 
+		if (vpu_dev->product_code == WAVE515_CODE) {
+			dma_addr_t task_buf_base;
+			u32 i;
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
@@ -1424,7 +1572,7 @@ int wave5_vpu_build_up_enc_param(struct device *dev, struct vpu_instance *inst,
 	reg_val = (open_param->line_buf_int_en << 6) | BITSTREAM_ENDIANNESS_BIG_ENDIAN;
 	vpu_write_reg(inst->dev, W5_CMD_BS_PARAM, reg_val);
 	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
-	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, WAVE521_COMMAND_QUEUE_DEPTH - 1);
 
 	/* This register must be reset explicitly */
 	vpu_write_reg(inst->dev, W5_CMD_ENC_SRC_OPTIONS, 0);
@@ -1878,7 +2026,7 @@ int wave5_vpu_enc_register_framebuffer(struct device *dev, struct vpu_instance *
 	p_enc_info->vb_sub_sam_buf = vb_sub_sam_buf;
 
 	vb_task.size = (p_enc_info->vlc_buf_size * VLC_BUF_NUM) +
-			(p_enc_info->param_buf_size * COMMAND_QUEUE_DEPTH);
+			(p_enc_info->param_buf_size * WAVE521_COMMAND_QUEUE_DEPTH);
 	vb_task.daddr = 0;
 	if (p_enc_info->vb_task.size == 0) {
 		ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_task);
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
index 556de2f043fe..bb13267ced38 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
@@ -18,7 +18,11 @@ static int wave5_vdi_allocate_common_memory(struct device *dev)
 	if (!vpu_dev->common_mem.vaddr) {
 		int ret;
 
-		vpu_dev->common_mem.size = SIZE_COMMON;
+		if (vpu_dev->product_code == WAVE515_CODE)
+			vpu_dev->common_mem.size = WAVE515_SIZE_COMMON;
+		else
+			vpu_dev->common_mem.size = WAVE521_SIZE_COMMON;
+
 		ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vpu_dev->common_mem);
 		if (ret) {
 			dev_err(dev, "unable to allocate common buffer\n");
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 5a71a711f2e8..6697534e9a12 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1869,7 +1869,12 @@ static int wave5_vpu_open_dec(struct file *filp)
 		goto cleanup_inst;
 	}
 
-	wave5_vdi_allocate_sram(inst->dev);
+	/*
+	 * For Wave515 SRAM memory was already allocated
+	 * at wave5_vpu_dec_register_device()
+	 */
+	if (inst->dev->product_code != WAVE515_CODE)
+		wave5_vdi_allocate_sram(inst->dev);
 
 	return 0;
 
@@ -1897,6 +1902,13 @@ int wave5_vpu_dec_register_device(struct vpu_device *dev)
 	struct video_device *vdev_dec;
 	int ret;
 
+	/*
+	 * Secondary AXI setup for Wave515 is done by INIT_VPU command,
+	 * i.e. wave5_vpu_init(), that's why we allocate SRAM memory early.
+	 */
+	if (dev->product_code == WAVE515_CODE)
+		wave5_vdi_allocate_sram(dev);
+
 	vdev_dec = devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_dec), GFP_KERNEL);
 	if (!vdev_dec)
 		return -ENOMEM;
@@ -1930,6 +1942,13 @@ int wave5_vpu_dec_register_device(struct vpu_device *dev)
 
 void wave5_vpu_dec_unregister_device(struct vpu_device *dev)
 {
+	/*
+	 * Here is a freeing pair for Wave515 SRAM memory allocation
+	 * happened at wave5_vpu_dec_register_device().
+	 */
+	if (dev->product_code == WAVE515_CODE)
+		wave5_vdi_free_sram(dev);
+
 	video_unregister_device(dev->video_dev_dec);
 	if (dev->v4l2_m2m_dec_dev)
 		v4l2_m2m_release(dev->v4l2_m2m_dec_dev);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 8bbf9d10b467..9d2a490d2516 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1247,7 +1247,7 @@ static int initialize_sequence(struct vpu_instance *inst)
 		__func__, initial_info.min_frame_buffer_count,
 		initial_info.min_src_frame_count);
 	inst->min_src_buf_count = initial_info.min_src_frame_count +
-				  COMMAND_QUEUE_DEPTH;
+				  WAVE521_COMMAND_QUEUE_DEPTH;
 
 	ctrl = v4l2_ctrl_find(&inst->v4l2_ctrl_hdl,
 			      V4L2_CID_MIN_BUFFERS_FOR_OUTPUT);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 9e93969ab6db..da254b422cff 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -61,7 +61,13 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
 
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
index da530fd98964..71c6d3e6bb20 100644
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
index d9751eedb0f9..e4bc2e467cb5 100644
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
 
@@ -49,17 +51,21 @@
 /************************************************************************/
 #define VLC_BUF_NUM                     (2)
 
-#define COMMAND_QUEUE_DEPTH             (2)
+#define WAVE521_COMMAND_QUEUE_DEPTH	(2)
+#define WAVE515_COMMAND_QUEUE_DEPTH	(4)
 
 #define W5_REMAP_INDEX0                 0
 #define W5_REMAP_INDEX1                 1
 #define W5_REMAP_MAX_SIZE               (1024 * 1024)
 
-#define WAVE5_MAX_CODE_BUF_SIZE         (2 * 1024 * 1024)
-#define WAVE5_TEMPBUF_OFFSET            WAVE5_MAX_CODE_BUF_SIZE
+#define WAVE521_MAX_CODE_BUF_SIZE	(2 * 1024 * 1024)
+#define WAVE515_MAX_CODE_BUF_SIZE	(1024 * 1024)
 #define WAVE5_TEMPBUF_SIZE              (1024 * 1024)
 
-#define SIZE_COMMON                 (WAVE5_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE)
+#define WAVE521_SIZE_COMMON		(WAVE521_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE)
+#define WAVE515_ONE_TASKBUF_SIZE	(8 * 1024 * 1024)
+#define WAVE515_SIZE_COMMON		(WAVE515_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE + \
+					 WAVE515_COMMAND_QUEUE_DEPTH * WAVE515_ONE_TASKBUF_SIZE)
 
 //=====4. VPU REPORT MEMORY  ======================//
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5.h b/drivers/media/platform/chips-media/wave5/wave5.h
index 063028eccd3b..2a29b9164f97 100644
--- a/drivers/media/platform/chips-media/wave5/wave5.h
+++ b/drivers/media/platform/chips-media/wave5/wave5.h
@@ -22,6 +22,12 @@
  */
 #define BSOPTION_ENABLE_EXPLICIT_END		BIT(0)
 #define BSOPTION_HIGHLIGHT_STREAM_END		BIT(1)
+/*
+ * When RD_PTR_VALID_FLAG is 0 Wave515 ignores RD_PTR value and starts to
+ * decode from the access unit end position of the last decoded picture in
+ * bitstream buffer.
+ */
+#define BSOPTION_RD_PTR_VALID_FLAG		BIT(31)
 
 /*
  * Currently the driver only supports hardware with little endian but for source
-- 
2.44.0


