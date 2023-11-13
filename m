Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F97D7E9C28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjKMMcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKMMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:32:09 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F61711
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:32:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc7077d34aso30899765ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699878726; x=1700483526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmCcZKWWwZWAAIdygGTS4bHPElBN0IgCDYBXIzaN8Rc=;
        b=aNqurdmgkmGfuTxNJqmnOfJzRGVyYlqIYJzI3BT9KeFCTY/OXqpWPtO7wNXec5Owqe
         S65pP9bTUWWCs3E25V/7nY7x426+S/fXBwhZ/RiTXAo58SemfLLTbz8Q7qmq9cWfIo0n
         2zGVAkaCUSuYFITm2nvbrgNMvNxcZqJIPtwTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699878726; x=1700483526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmCcZKWWwZWAAIdygGTS4bHPElBN0IgCDYBXIzaN8Rc=;
        b=J0nBi7hTghmCDcnG9dPUPxS1WNJMHjEdwaYbPJZ26oijibkTFgta7m80m++tPI95c8
         x8yV1TSwIGz/9PJlXD6ik2C+s9Q5lixvSH3++OGrK2NZG5uD/VuhOlICXunb2Ta7BWtU
         5pjTThLvi9dXwZwpb/YkTgOdv7UtcYWxyGI5tl7fJL+NkIBGnRZHZ9cyiPUAxTVkW135
         QpFWywnuNDVZDfKQxmY9S+XAM3R/bfhdeFRRM4ZOfr5oSX8JhGXiBTRLnlPCE9Z8Q989
         /OYdeMS9HXZyOhIEmKX0dX+a2T/Sah7vzeMXjMTAFGxOG7iablwXzGm5BkQQoPh4L+cs
         wPMA==
X-Gm-Message-State: AOJu0YwED1nfietMEGUKhUsEigdWu02za/IwK5C5Y+xUcT7LkgAYSfT5
        3wNq6gTTVYQRaf+8kKxkDa+t8w==
X-Google-Smtp-Source: AGHT+IExf7ObUmbvOTrAkJwVf7MguRRwDwFguon7N78CqrwPhBqwig/xn/knQ10TaWNK8GigQiHqwA==
X-Received: by 2002:a17:903:1c4:b0:1cc:3fc9:1802 with SMTP id e4-20020a17090301c400b001cc3fc91802mr4826133plh.61.1699878725604;
        Mon, 13 Nov 2023 04:32:05 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:bc9:4777:173:8be3])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001bde65894c8sm3924104pld.268.2023.11.13.04.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:32:05 -0800 (PST)
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
Subject: [PATCH 1/4] media: mediatek: vcodec: Replace dev_name in error string
Date:   Mon, 13 Nov 2023 20:26:49 +0800
Message-ID: <20231113123049.4117280-2-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113123049.4117280-1-fshao@chromium.org>
References: <20231113123049.4117280-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_v4l2_err() already uses dev_err(), so don't print the device name
again. Print function name instead.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 .../media/platform/mediatek/vcodec/common/mtk_vcodec_util.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index 9ce34a3b5ee6..ea8c35c0e667 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -67,7 +67,7 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 	mem->va = dma_alloc_coherent(&plat_dev->dev, size, &mem->dma_addr, GFP_KERNEL);
 	if (!mem->va) {
 		mtk_v4l2_err(plat_dev, "%s dma_alloc size=%ld failed!",
-			     dev_name(&plat_dev->dev), size);
+			     __func__, size);
 		return -ENOMEM;
 	}
 
@@ -99,7 +99,7 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 
 	if (!mem->va) {
 		mtk_v4l2_err(plat_dev, "%s dma_free size=%ld failed!",
-			     dev_name(&plat_dev->dev), size);
+			     __func__, size);
 		return;
 	}
 
-- 
2.42.0.869.gea05f2083d-goog

