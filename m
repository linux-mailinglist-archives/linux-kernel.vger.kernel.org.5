Return-Path: <linux-kernel+bounces-133354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7F89A2BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F44287D33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A0171E74;
	Fri,  5 Apr 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O207QbHU"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA72171E49;
	Fri,  5 Apr 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335298; cv=none; b=FH4GbmWiYMaAZ55PA79VinWgEZjVOpo7SPkvMkowhbM+NzyEyWp2M+36Ay/CyJqqLziMigvnXp01QkrnBcM3uUi4DGjkcGc60mlj9I+CCLIa2KdPOjyq8XwHmoV0W5SlBhZwhWLzcqIltO788N78kYrxmVDsjkRfCVRonUC+4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335298; c=relaxed/simple;
	bh=aDbcpQbcbf0YX/mOf1pvgn7kmm9ITS7w0AmOppIc5a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OO6QT7IWpJIzuWNDqTp36w8XGkUaT36tzZ3q0sooEl5RYVfIIDXr0xDcQSCokCMUsv0vvnPUeu/crzzMRtmtZteLi4pJd+YKOmuu0vS6KDUksOh8QHdfzKGSGxK8J0drpOdMqvlvxq6VNNfvcvlHiTpmBvY3BKb1FHR16d2y6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O207QbHU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d86e6908ecso7801091fa.2;
        Fri, 05 Apr 2024 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712335294; x=1712940094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcWuWwbYDzN/Eba2XHYlH7krkiOlk1hd506TNmQ/SjY=;
        b=O207QbHURNgItat4yVH5QXLWUiUwU/0Pq5/dcEG09BH1KZjRntC46SZRgUUfP/tI+2
         wDmlZeWx4dwbrW5ycDa2ZwiuvSW//5Co7/YOqvT1N/Zu75P2lAe3EvqvMENuRXvohmvi
         5zQx+u8tRtCrw+ZpQXZ23bJxr0LaQ2wU0fHCmyTHfI7Znbe9ydWsPH2MmaxN+bMcwWqm
         Ry9aWt+i5epXCVSGZ8ZS9MBDTbm9Zp3J1rno5mtcQh/eEopIel2akfNOv/Mt46uVlXOf
         RiTStcqQE858AFzWzsqL59SVJh/uh8pUMWkgjxwzP+Vkx5zi/zU+jCO5A88JXi1o+Tq9
         Q+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335294; x=1712940094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcWuWwbYDzN/Eba2XHYlH7krkiOlk1hd506TNmQ/SjY=;
        b=Z7Rux40OJw/t2eaOu0pD+IUSQxr+j5AYCne6qBUaKGwPYPViZjjiLByCZGYv3Ij3gi
         bWHOr2E0DTGlINrYvVBMQ7+bWRGPoFjinlnON3xKt18wk5cxKXnXfegqB7cgHH6K7Nxz
         81vU1D9RI2wYiKFDph+IQDlKhy8AaRuWFoanTYkmoNxKE+Rxdpwxph+ocuwe3PeHsY33
         sNTwGFi5EXkvgj/5Tz5W4j9/QhgQU6Twg4Vkt9oyRNef+JxYVDrOKi8z6ookY9O9f/hv
         1QqpEPyulRgGvVq3/AxNbYMJdlqsA+i5Gw2qBHhsrIKk/MD/dr/gDZdZHkVGW20mDnoy
         rREg==
X-Forwarded-Encrypted: i=1; AJvYcCWOguD6Jk/W+pDd4mSid54Y4SMROiVvPldugtcVkshB/G4GWjVgBEfcDugRJS4urzQtthugNgshv+OBUaMKpdrlgn1b2oEn/nHT8iXdvZyVLH7JKUuRJvTSG5uXBGk/YxJjf3/eylIFBME=
X-Gm-Message-State: AOJu0YxTzpfrs3ZvfmWxRzneBQEumhCFE0CAH/D+Ku/z1viEytZS/g3Y
	vbnbu52VTKpXMFdxKGItzYKkDS8p3L2zA4Lfg+spOZUYRR0imxxPYQHParr9u7Q=
X-Google-Smtp-Source: AGHT+IGl9F4dDCyChCMVoGYfXSICfhCtrpA1CCVSJDV4PiNlLxXJekc8k+xez46y2labugUQne6I8w==
X-Received: by 2002:a2e:914b:0:b0:2d8:4897:39a0 with SMTP id q11-20020a2e914b000000b002d8489739a0mr1619646ljg.15.1712335294013;
        Fri, 05 Apr 2024 09:41:34 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a05651c124d00b002d6c93793f1sm218372ljh.77.2024.04.05.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:41:33 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] media: chips-media: wave5: separate irq setup routine
Date: Fri,  5 Apr 2024 19:41:07 +0300
Message-ID: <20240405164112.24571-4-brnkv.i1@gmail.com>
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

Implement a separate setup routine for interrupts to reduce code
duplication. Also enable interrupts based on vpu_attr->support_encoders
and vpu_attr->support_decoders fields to facilitate support for other
Wave5xx IPs, because not all of them are both encoders and decoders.

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


