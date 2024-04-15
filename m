Return-Path: <linux-kernel+bounces-144893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60F8A4C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A617B286E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA254FBB;
	Mon, 15 Apr 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKAHzj36"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9EBE4F;
	Mon, 15 Apr 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175674; cv=none; b=YhAkWq/wAzLdBvUcDAGAhRCsfoowwpVYhJI4LrXwk6RsNzI3+gTrIpGCIPckBhK7cTIa8eSQl2F/ebeGN52lRngvYK4Y5WcMqx3YsocsTDbj/dxsVpwt/GUoqyKTunyNr7tdfMSq74on33az1i+9vjYLvhdbs9Am6rSMAaECMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175674; c=relaxed/simple;
	bh=cjeuMb7PxJMP2ybeas/sKy6PI5rQlEByAuf0U3IXdmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5ZmLrc/mYCFOvSTxYIs753zOvQa+8yFNOPrrRrJ2mxchsHbiHvLGP3IWHg7ql5+cxkpWY8douEYjmKHJ2Zgzd6vJMy+GmcdgXhjQ/Xk+lZakH8kbcZrtLd7v9CUtYqh6E5VCQDpn4SvP8sEAPtxIJ0/AFZ+nkRnIpGssV5boYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKAHzj36; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5171a529224so3748629e87.0;
        Mon, 15 Apr 2024 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713175671; x=1713780471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiIAqND7mUT5v8z+Y4jEQ7Nnbd7IOhlISQM20C+Cc64=;
        b=HKAHzj36jQgPVgin1kgWBn8yzRFeDxVcfkMHN34+SAPpHVIWJnttzu8NHE4ZP5gY1I
         Tg2RjjSsqRTH8buXPrtVOrtAUCTMWYFw0CEJhRKAZ87HYxRnidsEUw0YyutXRG424tql
         Zi+AQtac20roRc9nd4DLxbimsoe/NUi+SDb1ejLW+3q02LxC/C7ORix0fwn2Ck3GuG/j
         2W1Xnig3n5XDNajP1zU4hJGMMeMFTmm8F/cys5lsaXjlq5CLY4uTwktjzJHEYdDTFpAV
         2er1O4MQGft/lumrUAA2AccL19dyNqO8+AlPJECSjjNgj9GlZ2gdxZCY5B7QnANtMVxk
         oUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175671; x=1713780471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiIAqND7mUT5v8z+Y4jEQ7Nnbd7IOhlISQM20C+Cc64=;
        b=Wd3C3z3iOiAHRa26wV/W/SaDpVqVBUpmRlsUtV/aQLjid7aVw0QnvTm5Br6RdSMv26
         1XBen6duMmR1ztNOvwX2WN9Iq4MIUCS//p+h6jnoB8kFrdQY/NuuW08AmH6cHoQ9amAk
         j8u254JRAK1z6E2y86jymJpZeKzj08uQizY4CGhWvjRlZJIj4Wv48eweynaGYZeOZamb
         os0CVi3j9PMHhvSj05IHfry9aT1hRHWjApXPGxxSnZj/NzOcGKRsxH3mmpK/FEIJ2JjG
         pagejj/J4rQn77SXdySAvbNzFvcwKkI09z1Gb40bZoVTuQ3qiPSeLlMcjKybsGRIIERm
         XLeg==
X-Forwarded-Encrypted: i=1; AJvYcCWGdAFQk93IqytGiCaD4rBk5zx2ISh1xbtiQNzaPojUf/ce3kSQT9Lc/RkXfLVq8wtEgjvmWHRiudzrUeJey5g+uFjbp+hpY3Oa+1ikWhLmd+Z8uvlkksGfcvdolnHtmX01teO7wZZn9DY=
X-Gm-Message-State: AOJu0YwJkbPO/Mx6uZAfaf8lcM9Kd7ci5bt9ZE5S5ijpATkscZQIfEki
	MsuY/DKk3JUMMSiE2TyXzZ7DN4YVP/S0MpYOkJU7RUypdRbK3KgF
X-Google-Smtp-Source: AGHT+IHbYlTfMAJI5gagUyQqMJP2INhnpBeYHUYSiTelBcho0iJb2Cp2jUEGL7/lUE6YwYGL5PFKUw==
X-Received: by 2002:ac2:518c:0:b0:516:d09b:cbd6 with SMTP id u12-20020ac2518c000000b00516d09bcbd6mr5749771lfi.15.1713175670810;
        Mon, 15 Apr 2024 03:07:50 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a0565123b8b00b00518f53da2dfsm149571lfv.291.2024.04.15.03.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:07:50 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] media: chips-media: wave5: drop "sram-size" DT prop
Date: Mon, 15 Apr 2024 13:07:22 +0300
Message-ID: <20240415100726.19911-5-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415100726.19911-1-brnkv.i1@gmail.com>
References: <20240415100726.19911-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move excessive "sram-size" device-tree property to device match data.
Also change SRAM memory allocation strategy: instead of allocation exact
sram_size bytes, allocate all available SRAM memory up to sram_size.
Add placeholders wave5_vpu_dec_validate_sec_axi() and
wave5_vpu_enc_validate_sec_axi() for validation that allocated SRAM
memory is enough to decode/encode bitstream of given resolution.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     | 62 +++++++++++++++++--
 .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++---
 .../platform/chips-media/wave5/wave5-vpu.c    | 11 ++--
 3 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index cdd0a0948a94..36f2fc818013 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -843,6 +843,36 @@ int wave5_vpu_dec_register_framebuffer(struct vpu_instance *inst, struct frame_b
 	return ret;
 }
 
+static u32 wave5_vpu_dec_validate_sec_axi(struct vpu_instance *inst)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	u32 bit_size = 0, ip_size = 0, lf_size = 0, ret = 0;
+	u32 sram_size = inst->dev->sram_size;
+
+	if (!sram_size)
+		return 0;
+
+	/*
+	 * TODO: calculate bit_size, ip_size, lf_size from inst->src_fmt.width
+	 * and inst->codec_info->dec_info.initial_info.luma_bitdepth
+	 */
+
+	if (p_dec_info->sec_axi_info.use_bit_enable && sram_size >= bit_size) {
+		ret |= BIT(0);
+		sram_size -= bit_size;
+	}
+
+	if (p_dec_info->sec_axi_info.use_ip_enable && sram_size >= ip_size) {
+		ret |= BIT(9);
+		sram_size -= ip_size;
+	}
+
+	if (p_dec_info->sec_axi_info.use_lf_row_enable && sram_size >= lf_size)
+		ret |= BIT(15);
+
+	return ret;
+}
+
 int wave5_vpu_decode(struct vpu_instance *inst, u32 *fail_res)
 {
 	u32 reg_val;
@@ -855,9 +885,7 @@ int wave5_vpu_decode(struct vpu_instance *inst, u32 *fail_res)
 	vpu_write_reg(inst->dev, W5_BS_OPTION, get_bitstream_options(p_dec_info));
 
 	/* secondary AXI */
-	reg_val = p_dec_info->sec_axi_info.use_bit_enable |
-		(p_dec_info->sec_axi_info.use_ip_enable << 9) |
-		(p_dec_info->sec_axi_info.use_lf_row_enable << 15);
+	reg_val = wave5_vpu_dec_validate_sec_axi(inst);
 	vpu_write_reg(inst->dev, W5_USE_SEC_AXI, reg_val);
 
 	/* set attributes of user buffer */
@@ -1938,6 +1966,31 @@ int wave5_vpu_enc_register_framebuffer(struct device *dev, struct vpu_instance *
 	return ret;
 }
 
+static u32 wave5_vpu_enc_validate_sec_axi(struct vpu_instance *inst)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	u32 rdo_size = 0, lf_size = 0, ret = 0;
+	u32 sram_size = inst->dev->sram_size;
+
+	if (!sram_size)
+		return 0;
+
+	/*
+	 * TODO: calculate rdo_size and lf_size from inst->src_fmt.width and
+	 * inst->codec_info->enc_info.open_param.wave_param.internal_bit_depth
+	 */
+
+	if (p_enc_info->sec_axi_info.use_enc_rdo_enable && sram_size >= rdo_size) {
+		ret |= BIT(11);
+		sram_size -= rdo_size;
+	}
+
+	if (p_enc_info->sec_axi_info.use_enc_lf_enable && sram_size >= lf_size)
+		ret |= BIT(15);
+
+	return ret;
+}
+
 int wave5_vpu_encode(struct vpu_instance *inst, struct enc_param *option, u32 *fail_res)
 {
 	u32 src_frame_format;
@@ -1959,8 +2012,7 @@ int wave5_vpu_encode(struct vpu_instance *inst, struct enc_param *option, u32 *f
 
 	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_AXI_SEL, DEFAULT_SRC_AXI);
 	/* secondary AXI */
-	reg_val = (p_enc_info->sec_axi_info.use_enc_rdo_enable << 11) |
-		(p_enc_info->sec_axi_info.use_enc_lf_enable << 15);
+	reg_val = wave5_vpu_enc_validate_sec_axi(inst);
 	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_USE_SEC_AXI, reg_val);
 
 	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_REPORT_PARAM, 0);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
index 3809f70bc0b4..556de2f043fe 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device *vpu_dev, struct vpu_buf *array,
 void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
 {
 	struct vpu_buf *vb = &vpu_dev->sram_buf;
+	dma_addr_t daddr;
+	void *vaddr;
+	size_t size;
 
-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
+	if (!vpu_dev->sram_pool || vb->vaddr)
 		return;
 
-	if (!vb->vaddr) {
-		vb->size = vpu_dev->sram_size;
-		vb->vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
-					       &vb->daddr);
-		if (!vb->vaddr)
-			vb->size = 0;
+	size = min_t(size_t, vpu_dev->sram_size, gen_pool_avail(vpu_dev->sram_pool));
+	vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
+	if (vaddr) {
+		vb->vaddr = vaddr;
+		vb->daddr = daddr;
+		vb->size = size;
 	}
 
 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr: 0x%p\n",
@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device *vpu_dev)
 	if (!vb->size || !vb->vaddr)
 		return;
 
-	if (vb->vaddr)
-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
-			      vb->size);
+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb->size);
 
 	memset(vb, 0, sizeof(*vb));
 }
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 54d1d44ed35a..901dbfdf1e4f 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -25,6 +25,7 @@
 struct wave5_match_data {
 	int flags;
 	const char *fw_name;
+	u32 sram_size;
 };
 
 static int vpu_poll_interval = 5;
@@ -205,17 +206,12 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		goto err_reset_assert;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
-				   &dev->sram_size);
-	if (ret) {
-		dev_warn(&pdev->dev, "sram-size not found\n");
-		dev->sram_size = 0;
-	}
-
 	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
 	if (!dev->sram_pool)
 		dev_warn(&pdev->dev, "sram node not found\n");
 
+	dev->sram_size = match_data->sram_size;
+
 	dev->product_code = wave5_vdi_read_register(dev, VPU_PRODUCT_CODE_REGISTER);
 	ret = wave5_vdi_init(&pdev->dev);
 	if (ret < 0) {
@@ -322,6 +318,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 static const struct wave5_match_data ti_wave521c_data = {
 	.flags = WAVE5_IS_ENC | WAVE5_IS_DEC,
 	.fw_name = "cnm/wave521c_k3_codec_fw.bin",
+	.sram_size = (64 * 1024),
 };
 
 static const struct of_device_id wave5_dt_ids[] = {
-- 
2.44.0


