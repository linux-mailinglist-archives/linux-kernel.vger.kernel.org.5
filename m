Return-Path: <linux-kernel+bounces-116597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E065D889EED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6A21C35A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B815747D;
	Mon, 25 Mar 2024 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkF35Z8g"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA415F3F3;
	Mon, 25 Mar 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348889; cv=none; b=Vo5qMXrOAGg08cfxhDEaM7tImZ1ZRj1P5e7hz5fcWapZanQjoi3a8MPXTzOh8uYMNAb0nDauDe6urw/yRySRAxKseYBkO7AE2OyguslBNcNx6q55z8u61suf3MbvYAkIS4Sm35Wf1cEUBKyjCDWtur8KQJmRkX3Bdip326kop2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348889; c=relaxed/simple;
	bh=WCUsd9wRlKcgYIo1YAVt/aabTPpoE7JMRDqoJPTiBMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arlaQA9Y8JEp46gL7G+56x/yYusd6mOHec/BiDNRD29hdr7/ANvcxTt/tcwXPiJDvkcC+WhJmvS9hxhEs+yTg+kU7fre5F2x8Y14AyAJLIgSTOkpS06F2b/tN8GIM68bSl8281nAcY/wVm9Xx2TkTob7z6p/I8ygAYFclCiV1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkF35Z8g; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a86daf09so1282863e87.3;
        Sun, 24 Mar 2024 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348886; x=1711953686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USH6Nfz0NCBGWMX/IQB4cQ8iG0IHQkGBXucHa0AClMU=;
        b=UkF35Z8gDFuDpTRGIVaeNX/S2WTkhPMBKP8+pQBselwSGQJg9hgOWoEqk8R7V9Sgk/
         8xmZ0iZn1I+J902tv96qGIWOtv9PDBUFie4OBrYz+86DxaPx2559rpKhX95jbLbziiFl
         jrhH0qC/HzAVYOgeCqHLL1dnWBEOseQfRxkiif39EkFlM+HkWpkfKb3CUN1mizqVFaR2
         jXDiVFrE+n95WqOE/4IvogqnoDwWNfqfZ0xPnH3XxPORNE/GLimYu7NdWuCPVPnVhMnN
         Dw03wiaWwubqTV3q4FaHUdrMdElFA8sOS5iTs5UfyDda/VD1C6T+C6sncRRmj5w6zAIq
         byCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348886; x=1711953686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USH6Nfz0NCBGWMX/IQB4cQ8iG0IHQkGBXucHa0AClMU=;
        b=s4rZeNehlXztKJRL4t3DPPcHHeiXDBlec2bpqRlSk8I92pv+jg5+3zNeidzGHvNf6e
         B/ehCCIwzr95r5h+vzXNgS9g4drIXaW1hal9+CE5AyIX7SJbmaFf5IuOremJaU0Jf9Sr
         zh7h8/cOQmv9ondPNQ210n2I/71Viu+rXDmBwc/enQrt8R5bn2/ikemWO87tUeKtQUV4
         cCEH22VTWH8zsKI9XxgzCGqliHHqeXM4PDfUk7q9Bztf7DEUn/Op2VmSb11zi25ulB2a
         HarKdQ8p/xCFUDLCNdwW4wUj0wev68pVvCAKutCt4famQ83dv4zmvqsktdHbrTWEML9G
         ULOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcuhIkqH3ZZHUQCeSBNX7KJqzhOLPUDLE6XvyE8sfvtnrZj5faVdjsnQzH5MzqWuTUNpXja7Vi5e6GTceazwlCUQ8iyfbonkgizLU3j5OF3khvO1uaF9Y8Tn+FKtdFVjNJo/tofARcv5Y=
X-Gm-Message-State: AOJu0YzA+W9rAeGn2jk002aNr+Zq3wT76I/tIVCz6p0sW8z4mwlBvIZ+
	3kg2FYOJ0s5h6eqhoEJfWmbSdi98Iuwdspx9STyT4X591+2Bx+VQ
X-Google-Smtp-Source: AGHT+IGXGxkFkZFLm6+hr+Mw1cisKEtfNT6CUbf967HH0uF75IKvYnDI9/+81I8CyPM/Kh9fsojA9g==
X-Received: by 2002:a05:6512:1c7:b0:513:5c10:309c with SMTP id f7-20020a05651201c700b005135c10309cmr4522562lfp.3.1711348885777;
        Sun, 24 Mar 2024 23:41:25 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a0565123c8c00b00515a411fd20sm828229lfv.105.2024.03.24.23.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:41:25 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT prop
Date: Mon, 25 Mar 2024 09:40:59 +0300
Message-ID: <20240325064102.9278-5-brnkv.i1@gmail.com>
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

Use all available SRAM memory up to WAVE5_MAX_SRAM_SIZE. Remove
excessive "sram-size" device-tree property as genalloc is already able
to determine available memory.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
 .../platform/chips-media/wave5/wave5-vpu.c    |  7 -------
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
 .../chips-media/wave5/wave5-vpuconfig.h       |  2 ++
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
index 3809f70bc0b4..a63fffed55e9 100644
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
+	size = min_t(size_t, WAVE5_MAX_SRAM_SIZE, gen_pool_avail(vpu_dev->sram_pool));
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
index 1e631da58e15..2a972cddf4a6 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -177,13 +177,6 @@ static int wave5_vpu_probe(struct platform_device *pdev)
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
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index da530fd98964..975d96b22191 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -750,7 +750,6 @@ struct vpu_device {
 	struct vpu_attr attr;
 	struct vpu_buf common_mem;
 	u32 last_performance_cycles;
-	u32 sram_size;
 	struct gen_pool *sram_pool;
 	struct vpu_buf sram_buf;
 	void __iomem *vdb_register;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
index d9751eedb0f9..9d99afb78c89 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
@@ -28,6 +28,8 @@
 #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K, AVC 40K
 #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
 
+#define WAVE5_MAX_SRAM_SIZE		(64 * 1024)
+
 #define MAX_NUM_INSTANCE                32
 
 #define W5_MIN_ENC_PIC_WIDTH            256
-- 
2.44.0


