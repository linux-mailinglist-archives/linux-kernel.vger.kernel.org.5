Return-Path: <linux-kernel+bounces-116595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36FF889EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599D62A524A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30D9156C7D;
	Mon, 25 Mar 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iitRAe5e"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036515F316;
	Mon, 25 Mar 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348888; cv=none; b=GNTxkefk/BFmUC8Sw8FijX7nBmy7Pmb8cGB2dnMmouSeQDUa5Ep9558Sb+keTv+NNAxTgTafTnPppi4VWR7KdC8RbVaOb1CWQSf90EBBhaMlzp5IQ9+8JziqGFDiQsvE9Mi1Zoup6ia8n9tA3hyWDwbap3fKv61Ez76PQ52FLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348888; c=relaxed/simple;
	bh=qd9OurlGMiM81BMao1aJ4SpekOda8rLsQ9rKx4C/g1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLM0VZJvsV0YulS247LQeXRf+f+2y34A72Vellms1mrUNXlj5ekhMQ2iNudVTvBHbX++rGz/+KcfocLYJDbiiC/ipCc6zhZC/ngurifImKger2I4B5aMOTd7OjpGkUVQ9Dj+vGvNIHvuKBJwJA45ywBjd/lEvxUtYRo11T45jcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iitRAe5e; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a68d45faso1223984e87.3;
        Sun, 24 Mar 2024 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348884; x=1711953684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBcn1nMAdTSCT3A+/DCOtS0XSUKaFGHkFwng8LbwhbQ=;
        b=iitRAe5epbWwo+3LUaUIf6fAusQZb/o4pbfDymaDhwGL1yN9eD2quwjbNzUW/HhmUM
         K0vSc/xsDeHdMXRtKdAZl5P0t0G3hzsfyG9Gq8EBX8kYDqOBMnDNa5HD7qtFt5nJ744v
         MWpkral+DGEuHn53KAyOTT9I8Z2nN/LNsbm7bzgf6m+dyfZ0/NHgdJe4Xz43nCkK4SBs
         +cY8D/BGjIxppZlLkkZwu+P/zSWmqjaPv1WeHaraDfcAP8OlnrkY5wkL6xvYDK5StVJ1
         Tid8ixec0T32+z4oQzSQucSicsF8rbtqKAJKbBtIyDpnj/QzE4lkx7K4qD4q6FhwaPe/
         gE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348884; x=1711953684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBcn1nMAdTSCT3A+/DCOtS0XSUKaFGHkFwng8LbwhbQ=;
        b=X+H+pVuD6ayR3zq7HKG0eyXMNVFQb8yPCtevILO+1rdpRvfpMU4OhMNDO1BC67w5si
         3KWkL+SmqurX8SUzQhqcONVCZ6JJAqtOWjT2NQo3TbLW+herelvQI6N92E3cEQfbNgk7
         PJuujR9DKXwBO+yvvHKoFDRPB3/af/LZpM+KvhhZfBhZ+sNGKWh2YEBjx8faSmnW2NJw
         qEzD0Q479OazerJmswH6AunVDMul2aR+uyu2+0+66dBgOo/B5YNzaUtLz8wASBb6Y9D1
         Y8BMSOCFGKT076lM0fXLuhHZYx5iFWo4Y5x2fkV/FDZUj2QTeXOsHt3OdQumGg/FsXL5
         yTjg==
X-Forwarded-Encrypted: i=1; AJvYcCUTvhpUVgI8DiBd1f4QAg71BgMD9E3D7gVZ9YgO3TzFKWbQlRbgGRV3iMNWzdPCowGSNW3SZBOvryOXLnKKUqkBp/hZ7K7VtDA5XzOkZB7Bzh3Y5bqinwLS8V2ceQePSDSQZapwPl88SyU=
X-Gm-Message-State: AOJu0YwCoGZ7b68sY0dM9cjMw0r1DKYIKVLec1U93oAdahOmj2JKAF8j
	/ftj/vw27izFd9yBzOrWTvWvew45SNNdOoR8IngfsiAEBYQ64XZz
X-Google-Smtp-Source: AGHT+IEbp9BSSIYvBpgQ5OzZMtwrAE7JxYZUhvNxNOIUJU8eReaml8Hi3C/KUmT9d90QR2EjR65JAw==
X-Received: by 2002:a19:ca07:0:b0:512:fabd:8075 with SMTP id a7-20020a19ca07000000b00512fabd8075mr3636661lfg.48.1711348884375;
        Sun, 24 Mar 2024 23:41:24 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a0565123c8c00b00515a411fd20sm828229lfv.105.2024.03.24.23.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:41:23 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] media: chips-media: wave5: separate irq setup routine
Date: Mon, 25 Mar 2024 09:40:58 +0300
Message-ID: <20240325064102.9278-4-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325064102.9278-1-brnkv.i1@gmail.com>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate interrupts setup routine to reduce code duplication. Also
enable interrupts based on vpu_attr->support_encoders and
vpu_attr->support_decoders fields to facilitate other Wave5xx IPs
support, because not all of them are both encoders and decoders.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     | 53 +++++++++----------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index 2d82791f575e..cdd0a0948a94 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -299,6 +299,27 @@ static int wave5_send_query(struct vpu_device *vpu_dev, struct vpu_instance *ins
 	return wave5_vpu_firmware_command_queue_error_check(vpu_dev, NULL);
 }
 
+static void setup_wave5_interrupts(struct vpu_device *vpu_dev)
+{
+	u32 reg_val = 0;
+
+	if (vpu_dev->attr.support_encoders) {
+		/* Encoder interrupt */
+		reg_val |= BIT(INT_WAVE5_ENC_SET_PARAM);
+		reg_val |= BIT(INT_WAVE5_ENC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
+	}
+
+	if (vpu_dev->attr.support_decoders) {
+		/* Decoder interrupt */
+		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
+		reg_val |= BIT(INT_WAVE5_DEC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
+	}
+
+	return vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+}
+
 static int setup_wave5_properties(struct device *dev)
 {
 	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
@@ -340,6 +361,8 @@ static int setup_wave5_properties(struct device *dev)
 	p_attr->support_vcpu_backbone = FIELD_GET(FEATURE_VCPU_BACKBONE, hw_config_def0);
 	p_attr->support_vcore_backbone = FIELD_GET(FEATURE_VCORE_BACKBONE, hw_config_def0);
 
+	setup_wave5_interrupts(vpu_dev);
+
 	return 0;
 }
 
@@ -417,16 +440,6 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
 	wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
 	vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
 
-	/* Encoder interrupt */
-	reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
-	reg_val |= BIT(INT_WAVE5_ENC_PIC);
-	reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
-	/* Decoder interrupt */
-	reg_val |= BIT(INT_WAVE5_INIT_SEQ);
-	reg_val |= BIT(INT_WAVE5_DEC_PIC);
-	reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
-	vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
-
 	reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
 	if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
 		reg_val = ((WAVE5_PROC_AXI_ID << 28) |
@@ -1034,16 +1047,6 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
 		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
 
-		/* Encoder interrupt */
-		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
-		reg_val |= BIT(INT_WAVE5_ENC_PIC);
-		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
-		/* Decoder interrupt */
-		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
-		reg_val |= BIT(INT_WAVE5_DEC_PIC);
-		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
-		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
-
 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
 			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
@@ -1134,15 +1137,7 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
 		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
 
-		/* Encoder interrupt */
-		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
-		reg_val |= BIT(INT_WAVE5_ENC_PIC);
-		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
-		/* Decoder interrupt */
-		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
-		reg_val |= BIT(INT_WAVE5_DEC_PIC);
-		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
-		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+		setup_wave5_interrupts(vpu_dev);
 
 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
-- 
2.44.0


