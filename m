Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E17E9C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjKMMcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKMMcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:32:12 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE1D53
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:32:08 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc2fc281cdso31068285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699878728; x=1700483528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA3vrhjtHczEnyT2vUfzyuZkQIQYPfca5IqlMdK//sY=;
        b=JQWnwovACGdnfbYKzgRVI1WrgOV3pLfRM/U3LnJUE5JopaN00HYt9HtUcgO2klz/RV
         AQd2OdB93xXlGs3ylLnwYOjM0yPr8rjOsdCua5R6MZRyapO46Ly/ddC6wkntgaOY9daz
         1elcWxByj5NdQFEkGBo+gT0WoeRiJA/Deq71g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699878728; x=1700483528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA3vrhjtHczEnyT2vUfzyuZkQIQYPfca5IqlMdK//sY=;
        b=ZnGcgmIX0e48/Nbys0/e3ZTQ1pYuHUoKhnALIq9Av5pfb1xUiTczAQWyirp70Hln9s
         1ukbjEOqEaIx2LtlRRIJKEblI1DepZQuRM5WdM42sjYr1zTRQjcwa2rAnieEJKbNy3l0
         EBSzE1tL1xBOR+m9YQ0e8bRDa2n+hkfUnuifSgDHaWW4VATObumue9Q8VB4M9bkKOiee
         Zpr9QeUba8A4zrVKucP7Wl2v1x697jJXlZv2ss9ZoRdJX3zxC+jVcRxdYAeYx0q4SrDd
         CFgAL33XZx7S39+z644VoYTgVDgR+69XS2ZgMEZ/qL5wZSzJ+KfgrnjOHs/lBzk8rvVx
         UYaA==
X-Gm-Message-State: AOJu0Yz8UIN+gGIRPOV3EQlqvMnZvNj9r6Riktwpk+H9uBAQW7UaBv2n
        tFcI5NvjPyHKAJ8wLAQ8vZfBfw==
X-Google-Smtp-Source: AGHT+IEr5rZTDntYdnCbJXhkwHgXRSGpCEuLpk6rdQ6ZqC29tJK66Fgqa1UZM40bjEsYv6dxLGnGbg==
X-Received: by 2002:a17:903:1249:b0:1cc:5378:6a40 with SMTP id u9-20020a170903124900b001cc53786a40mr4502566plh.23.1699878728461;
        Mon, 13 Nov 2023 04:32:08 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:bc9:4777:173:8be3])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001bde65894c8sm3924104pld.268.2023.11.13.04.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:32:08 -0800 (PST)
From:   Fei Shao <fshao@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Fei Shao <fshao@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 2/4] media: mediatek: vcodec: Drop unnecessary variable
Date:   Mon, 13 Nov 2023 20:26:50 +0800
Message-ID: <20231113123049.4117280-3-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113123049.4117280-1-fshao@chromium.org>
References: <20231113123049.4117280-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unclear why only mem->size has local copies without particular
usage in mtk_vcodec_mem_alloc() and mtk_vcodec_mem_free(), and they
seem removable.

Drop them to make the code visually consistent, and update printk format
identifier accordingly.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index ea8c35c0e667..23bea2702c9a 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -49,7 +49,6 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 {
 	enum mtk_instance_type inst_type = *((unsigned int *)priv);
 	struct platform_device *plat_dev;
-	unsigned long size = mem->size;
 	int id;
 
 	if (inst_type == MTK_INST_ENCODER) {
@@ -64,15 +63,15 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 		id = dec_ctx->id;
 	}
 
-	mem->va = dma_alloc_coherent(&plat_dev->dev, size, &mem->dma_addr, GFP_KERNEL);
+	mem->va = dma_alloc_coherent(&plat_dev->dev, mem->size, &mem->dma_addr, GFP_KERNEL);
 	if (!mem->va) {
-		mtk_v4l2_err(plat_dev, "%s dma_alloc size=%ld failed!",
-			     __func__, size);
+		mtk_v4l2_err(plat_dev, "%s dma_alloc size=0x%zx failed!",
+			     __func__, mem->size);
 		return -ENOMEM;
 	}
 
-	mtk_v4l2_debug(plat_dev, 3, "[%d] - va = %p dma = 0x%lx size = 0x%lx", id, mem->va,
-		       (unsigned long)mem->dma_addr, size);
+	mtk_v4l2_debug(plat_dev, 3, "[%d] - va = %p dma = 0x%lx size = 0x%zx", id, mem->va,
+		       (unsigned long)mem->dma_addr, mem->size);
 
 	return 0;
 }
@@ -82,7 +81,6 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 {
 	enum mtk_instance_type inst_type = *((unsigned int *)priv);
 	struct platform_device *plat_dev;
-	unsigned long size = mem->size;
 	int id;
 
 	if (inst_type == MTK_INST_ENCODER) {
@@ -98,15 +96,15 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 	}
 
 	if (!mem->va) {
-		mtk_v4l2_err(plat_dev, "%s dma_free size=%ld failed!",
-			     __func__, size);
+		mtk_v4l2_err(plat_dev, "%s dma_free size=0x%zx failed!",
+			     __func__, mem->size);
 		return;
 	}
 
-	mtk_v4l2_debug(plat_dev, 3, "[%d] - va = %p dma = 0x%lx size = 0x%lx", id, mem->va,
-		       (unsigned long)mem->dma_addr, size);
+	mtk_v4l2_debug(plat_dev, 3, "[%d] - va = %p dma = 0x%lx size = 0x%zx", id, mem->va,
+		       (unsigned long)mem->dma_addr, mem->size);
 
-	dma_free_coherent(&plat_dev->dev, size, mem->va, mem->dma_addr);
+	dma_free_coherent(&plat_dev->dev, mem->size, mem->va, mem->dma_addr);
 	mem->va = NULL;
 	mem->dma_addr = 0;
 	mem->size = 0;
-- 
2.42.0.869.gea05f2083d-goog

