Return-Path: <linux-kernel+bounces-106244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B2D87EB52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF08282F14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D434E1D1;
	Mon, 18 Mar 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIcr+giI"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7451C36;
	Mon, 18 Mar 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773001; cv=none; b=JvxV+ouIDqn98LZjqRepn7y68hja/z7nnymByCxWBiGjGIjx1uIde4w2/5Hm/iPZRMeu81uN+OxpcP6bU27QCGFy9Yfit0InHtunyC1DKMEcZDtnAU7D9IyrmQX4ft04tbCuObXN9GjZyeWmI48oyG2jp4iyJI6HDdMS0AVq2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773001; c=relaxed/simple;
	bh=Iw/roLvnQUfv9wzpSPJ3jfI+kWH4S/AZCxp5ZuR/yno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKoSunTCfEJMb4Y02lC/ldcjTRy6l3m8JM5OCoiYEQSbFsyaTrFEpfZDLRD3LpLPl8q5cnccXiQ0PtSDk7SUTnmq1u+cnqOq2YGfcRRkKu8FNG5w28Ml2+7De4lr5MqYlb7X4UguWbynAQd7HJ/TIeRzNVqYhcOmifsnb97BM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIcr+giI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513dd2d2415so2931048e87.3;
        Mon, 18 Mar 2024 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710772997; x=1711377797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNCygk3O4LA5dukbekdXan38YGGAOFt/3grrM8WgqDQ=;
        b=WIcr+giIEGl4bBduR2owzUSygnoRMwEAsWkhMy4s4Wo5goamMtofF6p7/FcdBPuaex
         GDK3zVmqORWiqgk+rU92qRP01yzRuxpPM5eJD7jyORYxKoQKBADvht9Cbr8araWne+Wc
         hRJodLVOYdMoSUmXjSsomsC2zHOl3oQjmR5AKAUbVFGPIW/CyIavhWg59QRBilp94kPr
         s+ESbOC0MAhk2ycra7lVBYiHbjaDJNE3IeyxQKSBB+Z90B5lV+Jk4787O4pxqvYQ+96V
         BifHstcubh2H/M2pDrWELEqOkevPolVkyvrTO6iohf8jszNPfZ22NjUqB48rXvniBOir
         MBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772997; x=1711377797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNCygk3O4LA5dukbekdXan38YGGAOFt/3grrM8WgqDQ=;
        b=fOsM135LDgvGczjiu39gBisk9AcEktt/hxzBdoSW1jxBVhvWzVbkB6exyk9N+yWpLr
         VSA6B6/n70edslshpaVSUhArG+K5ogANNOqayQQHEuXS0ZrFjIEs2Xkzv2qfE2wL2k4k
         Z1nA6tql7d9xJh8Gzab+NHydmS6nbUPGEh3Zgj7WPZq6cKyoIzrWe3gzdxyDNPkIyXzX
         EsWaSh1GwgYK1D3T5cmHFyT0SPdDxQpo9NsAd41/rhg9ZqpZZOps6ShJYTEzdoQW6Peg
         dQ/ZTiFBgKQzRh+pzHJjRJw/PqtYVweGiMtcYjAA0ivOdjm9soe5rfj5e1zoQ8N1Pf29
         OaWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjdNVw4Z+jRJaixWc0TtgvCDBxPNd08J/DPdxZn8MpTDsLrcyyulzQDwCp4YyzGf8eTsmy1As1lIwDDNJek4feC/DNpZ+Pj2mN7kbcXU0DcgFCdV8VmWhtY5n/yTAqu+vUBn0V9RUeCr6wUjbBG0SOt0AiJ2YUGe9s2YNGE+UfQAN1PyX7
X-Gm-Message-State: AOJu0Yw2EYahJB3IbUhqMPeJrVTc+yAH8tG0b+w9EJwAuoSoPVjoiu6c
	XfvnVT8XAi6Q+ACe5goJSLsRvhZaGqn+IlzIxl3+0Xo+0/TMaG7m
X-Google-Smtp-Source: AGHT+IGpy8dcSYHfrnAJqWvz6yQTy5Fk7eg/8C1YqTDyGTXOnaVbc0FChp1WzaRhGlLTapkkFjjz+g==
X-Received: by 2002:a2e:9cc2:0:b0:2d4:8d75:7a69 with SMTP id g2-20020a2e9cc2000000b002d48d757a69mr5212578ljj.45.1710772997244;
        Mon, 18 Mar 2024 07:43:17 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9c49000000b002d476327311sm1527486ljj.18.2024.03.18.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:43:16 -0700 (PDT)
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
Subject: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Date: Mon, 18 Mar 2024 17:42:20 +0300
Message-ID: <20240318144225.30835-6-brnkv.i1@gmail.com>
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

Allocate SRAM memory on module probe, free on remove. There is no need
to allocate on device open, free on close, the memory is the same every
time.

Also use gen_pool_size() to determine SRAM memory size to be allocated
instead of separate "sram-size" DT property to reduce duplication.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../platform/chips-media/wave5/wave5-helper.c |  3 ---
 .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
 .../chips-media/wave5/wave5-vpu-dec.c         |  2 --
 .../chips-media/wave5/wave5-vpu-enc.c         |  2 --
 .../platform/chips-media/wave5/wave5-vpu.c    | 12 +++++------
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
 6 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/drivers/media/platform/chips-media/wave5/wave5-helper.c
index 8433ecab230c..ec710b838dfe 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
@@ -29,9 +29,6 @@ void wave5_cleanup_instance(struct vpu_instance *inst)
 {
 	int i;
 
-	if (list_is_singular(&inst->list))
-		wave5_vdi_free_sram(inst->dev);
-
 	for (i = 0; i < inst->fbc_buf_count; i++)
 		wave5_vpu_dec_reset_framebuffer(inst, i);
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
index 3809f70bc0b4..ee671f5a2f37 100644
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
+	size = gen_pool_size(vpu_dev->sram_pool);
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
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index aa0401f35d32..84dbe56216ad 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1854,8 +1854,6 @@ static int wave5_vpu_open_dec(struct file *filp)
 		goto cleanup_inst;
 	}
 
-	wave5_vdi_allocate_sram(inst->dev);
-
 	return 0;
 
 cleanup_inst:
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 8bbf9d10b467..86ddcb82443b 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1727,8 +1727,6 @@ static int wave5_vpu_open_enc(struct file *filp)
 		goto cleanup_inst;
 	}
 
-	wave5_vdi_allocate_sram(inst->dev);
-
 	return 0;
 
 cleanup_inst:
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index f3ecadefd37a..2a0a70dd7062 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -178,16 +178,11 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		return ret;
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
+	else
+		wave5_vdi_allocate_sram(dev);
 
 	dev->product_code = wave5_vdi_read_register(dev, VPU_PRODUCT_CODE_REGISTER);
 	ret = wave5_vdi_init(&pdev->dev);
@@ -259,6 +254,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 err_clk_dis:
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
 
+	wave5_vdi_free_sram(dev);
+
 	return ret;
 }
 
@@ -275,6 +272,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 	v4l2_device_unregister(&dev->v4l2_dev);
 	wave5_vdi_release(&pdev->dev);
 	ida_destroy(&dev->inst_ida);
+	wave5_vdi_free_sram(dev);
 }
 
 static const struct wave5_match_data ti_wave521c_data = {
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index fa62a85080b5..8d88381ac55e 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -749,7 +749,6 @@ struct vpu_device {
 	struct vpu_attr attr;
 	struct vpu_buf common_mem;
 	u32 last_performance_cycles;
-	u32 sram_size;
 	struct gen_pool *sram_pool;
 	struct vpu_buf sram_buf;
 	void __iomem *vdb_register;
-- 
2.44.0


