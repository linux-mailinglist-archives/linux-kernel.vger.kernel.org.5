Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC407E9C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjKMMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKMMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:32:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EFF1718
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:32:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc3388621cso39173005ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699878731; x=1700483531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utq/LEPd9MWgyjAIqUwG3FJmsCfoE7UdWxPvzIdPYb8=;
        b=JL1Y+W16jEXlhhMmbJNd7oC20YSvNbYVrK34qRtP8iTfkRIw+ELdAowPXNQfWWQalH
         b4/LrcQ1tRaITLVpsEP+yfNffkDQnBOHpTbaBaeTdAFnIMJryxUS7mfdH3g5Nd94bWv1
         6be/DBqYGUvy2wFz7D9YwjbFgspHwZtkZH3y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699878731; x=1700483531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utq/LEPd9MWgyjAIqUwG3FJmsCfoE7UdWxPvzIdPYb8=;
        b=PGtZO8WUUs7iLOHJ+WdOP1j2/eurkpQSGtNBtMX9zdBoo5KZG5V4FmD2Wv7VxsZXK7
         T8kdX5/+au6csZPomvn+om04Q5YdV8FllILZeS6pZP/CXbOZzdREpdEenIl91whju16M
         tvs46nsDhM9qE3QKCQN8XXiC/DbM4C6BlxL/787Zy2fO2lA0yo6tgpXINs0dH3+5H/2c
         UrxoF/tYfx8hztm/VJjhNMWHhngcSEPqtkp1YQbipjXNyJ1ROGEuiJaekbxIMp0dCR2Q
         57eVXPNcywNpNEo9s+oYMYhD/N+r7Yv0hl1tvWukjDRiJHM75qrx7iwcL60eBv9AUc2J
         U0Gw==
X-Gm-Message-State: AOJu0YwGgk1UB8dSRn2YAUG5R+ZL1GciQlSkMS78zv2s1orlwdzi6h4d
        iFGVSs12D1U3HxH/UQHeUNzidw==
X-Google-Smtp-Source: AGHT+IGG/zF/QwLP8a9jX0YqCzyCMTgh29CNbFu1TQxkbJZaAa/VU3oDqMMh5ijHm1SKJCkxOnMJZQ==
X-Received: by 2002:a17:902:dac6:b0:1cc:42d0:dbc5 with SMTP id q6-20020a170902dac600b001cc42d0dbc5mr9611281plx.13.1699878731524;
        Mon, 13 Nov 2023 04:32:11 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:bc9:4777:173:8be3])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001bde65894c8sm3924104pld.268.2023.11.13.04.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:32:11 -0800 (PST)
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
Subject: [PATCH 3/4] media: mediatek: vcodec: Fix mtk_vcodec_mem_free() error log criteria
Date:   Mon, 13 Nov 2023 20:26:51 +0800
Message-ID: <20231113123049.4117280-4-fshao@chromium.org>
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

mtk_vcodec_mem_free() shouldn't print error if the target DMA buffer has
never been allocated or was freed properly in the previous call. That
makes log confusing.

Update the error path to print log only when the caller attempts to free
nonzero-size buffer with VA being NULL, which indicates something indeed
went wrong.

This brings another benefit that the callers no more need to check
mem->va explicitly to avoid the error, which can make the code more
compact and neat.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 .../media/platform/mediatek/vcodec/common/mtk_vcodec_util.c  | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index 23bea2702c9a..5eb267decfb6 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -96,8 +96,9 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 	}
 
 	if (!mem->va) {
-		mtk_v4l2_err(plat_dev, "%s dma_free size=0x%zx failed!",
-			     __func__, mem->size);
+		if (mem->size)
+			mtk_v4l2_err(plat_dev, "%s VA is NULL but size = 0x%zx",
+				     __func__, mem->size);
 		return;
 	}
 
-- 
2.42.0.869.gea05f2083d-goog

