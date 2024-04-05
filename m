Return-Path: <linux-kernel+bounces-133355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAE589A2BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F017B1F21E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1F172777;
	Fri,  5 Apr 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8RHNJaw"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC604171E5D;
	Fri,  5 Apr 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335299; cv=none; b=qf31wuAsnEzihaFgNBRGvCRcaBibwAPt/1yQtMcfm+9IZiMg7OL2KqYKqXrmu/HeyGH4s/UdzkJN3T1GdH7xxiOzcbEdSIKgqxNpjWRrO6UbptQ5cmHIWolHxBYjxnkfFmJz/yA4E3dQOnGS4x0WooThWQkWkqbMcgm5B8nBBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335299; c=relaxed/simple;
	bh=jITgk9+O3n+Q4NLM3WZrbIrg8ZKTeI5R4YGd6ViSHlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suSKvroOQSnjbMBIndGoxC0PzRodxyvU9Jwj5PcWwEqsUXecBap65wL17qhA6s57ZqK9i08TybwgSZMqKaRi0D+N4IkvuXx2r5ow826UUALMcFpvegu//iIWV51I7MU8sD5OjQtup68FHvRxuCpyJWEbrt12lsauDJ3hqTouIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8RHNJaw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d87450361fso325281fa.2;
        Fri, 05 Apr 2024 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712335296; x=1712940096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62H5zijldS7UAgjZBF68oJb2knjfPpYmL2zhj+Pgjes=;
        b=l8RHNJawIyNGlH3CbNvy3vUG0pmcrrTwKvClo6eRMhXOBP2OhXQvdWifS8qgX8KHid
         k6vtw6Tpv4scZwbL3R7Kz9m6jKA8kKmpyfYa7nZNXGfvJSLl8IyX9ASfSnedYdaH2M4O
         hKtrF+f8gr/pnByhKvXqoXFYzZJaxLP3UdDVTlbXVoHIE1ldgQ6LIo+hh9YFtKYFJmwH
         j75lNxXloCLqD6IlU5J+G32JcQjE3+ogzo6mwPriEEB3xhrZa65yUgd2d5U0lBlNFHoY
         C3vAVw2gpXyaHDCeC6e/c1hriGMUq5iZx2+ykgEeX6FB4nU9bytaTlj3dXBnPHYIKed8
         dsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335296; x=1712940096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62H5zijldS7UAgjZBF68oJb2knjfPpYmL2zhj+Pgjes=;
        b=N1unzNq7wid7A7mYMcIcsYSldjtHMMbjPYNTAlbT8w11kzTZgBYwzG8PUNibKhFkh5
         iPqqZW4pyD1NalakEcdVd0JGK3aKqYZnZOpyN5SWZXx8s8KT5qReEvWdL3+70PwTKrJm
         8znmMxDQuhVn1MqNg/W7tLVIB67ev20eTcETSb2JaUL0WurUYgqvQEYzAVIvXoUMnCU2
         TW1FIVBXOZdkeWFalgSVIIM+uMqhWTeV7PkY6OOPxwoMGwwBB5iKGumsS3ofvQ5tOVw3
         qy5Nimr96Hz8C1JzwvplHecZpQic7TNaz4jEvwdcxz2W4SXtElfhdmaa01s8RSxmS1+6
         L/OA==
X-Forwarded-Encrypted: i=1; AJvYcCVkGs//HCcytyhpgCANklmwyyHbEriqCfp7nhk4xUfgn1GxXA1T6I0jY2snJsRyppCwicl412qIxW53rnJgNIHjFpHdYCPHp+8wEe0zU1JGC6AUJBYuB7jRzqT+Pjz0n0vzpmxp2QgADzY=
X-Gm-Message-State: AOJu0Yy6ns3tpvIR2xHD9cW4htPQ86NvTo5Yv0NsBRXo+qv/sV2vHMo3
	sRWNKKvOUIBOnduvX3ucBIlfmphRumwMy8Ya26sAZgUdx1DS4jtH
X-Google-Smtp-Source: AGHT+IFj43vKwsiRMzyPmVb8jo6/nek+6OJvwte+2tCK1XjhnhtQ+RU54KU2Z27rxNIT+4w/2igGgQ==
X-Received: by 2002:a2e:7209:0:b0:2d6:b98d:c868 with SMTP id n9-20020a2e7209000000b002d6b98dc868mr1609380ljc.14.1712335295740;
        Fri, 05 Apr 2024 09:41:35 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a05651c124d00b002d6c93793f1sm218372ljh.77.2024.04.05.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:41:35 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size" DT prop
Date: Fri,  5 Apr 2024 19:41:08 +0300
Message-ID: <20240405164112.24571-5-brnkv.i1@gmail.com>
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
index 1e631da58e15..9e93969ab6db 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -25,6 +25,7 @@
 struct wave5_match_data {
 	int flags;
 	const char *fw_name;
+	u32 sram_size;
 };
 
 int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
@@ -177,17 +178,12 @@ static int wave5_vpu_probe(struct platform_device *pdev)
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
@@ -281,6 +277,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 static const struct wave5_match_data ti_wave521c_data = {
 	.flags = WAVE5_IS_ENC | WAVE5_IS_DEC,
 	.fw_name = "cnm/wave521c_k3_codec_fw.bin",
+	.sram_size = (64 * 1024),
 };
 
 static const struct of_device_id wave5_dt_ids[] = {
-- 
2.44.0


