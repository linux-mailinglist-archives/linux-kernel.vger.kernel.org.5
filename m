Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C917772D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjHJIX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjHJIXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:23:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072BDC;
        Thu, 10 Aug 2023 01:23:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26929bf95b6so367737a91.3;
        Thu, 10 Aug 2023 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691655821; x=1692260621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+e1KIdPkZ9W1pyyhd0vEg/XdGpbw4lhXOUhvTsBhFP8=;
        b=TTOA9ZLE7hKSMCbIwQzADz/+r4wuL4LTp2U75XuUd+F7tqRVer2IsUqHdhUTm4I+7e
         EQ8T8tV3MIvU4c6sNRhK1SsTSBMh1WlNdCP6IDXwOo+G3Eo3XzfSoVGb1TuIUDM66Zx1
         phsMLiRCjyZ8YUolNzCy6Je0WdBvVU+G4uZOYQmzc28zHPObIPykgnsBXcDN+SLHqDXC
         eu6yvHjG8KUj5jEjr3/l1NjOgT99tm3j7cGCYJonYBPcpiQVgIkwRGuEsYrtBPLTk4bV
         gIlwQebmAvJq8O77JKv26Nws533bFZAx/UULe9hmAWRaOWc4EQ0YSwJERc77jZjot+2D
         9RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655821; x=1692260621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+e1KIdPkZ9W1pyyhd0vEg/XdGpbw4lhXOUhvTsBhFP8=;
        b=QgK0jSHYm5fVc4aqS/hOTy4Hr0rOCRTlGEGBB8rdvwXw6QApU1O1G9zsIETAeisyC2
         Lk6cPfzCsAxasLWkxlw8SLcgjwTvjf6m8ljLbXTIp0GV4c81YUNj4P1GPbnSqyXok9YJ
         i2MddY5hE9ft9l/X61uGAmd3IwlwNmNtJ8yoWOHAQ45b7b32c7KVvVgeMWNZfHeRzXOq
         t+m7zXLabyThLSuLDdofmJBW/4rX3w8kjPl5bXpma31olCnTYp3KIgnHyMqXMYUUrtpW
         Vpj/fa3+3EHK8hwY8c5xevdol++o13bg2ZQ31/ZuxPKRrWtepF1JzdQCpN71T/VPzu41
         UYfA==
X-Gm-Message-State: AOJu0Yy3bsGyRekfa0PiNS2DtLqGHgp2k/hNlCsMhiSEfuWd5C/pKXO0
        SNHFvoIzbk/I2hN9xUD+jSuG9rEkrsfiVE5B
X-Google-Smtp-Source: AGHT+IF0RBM4ZHsM63NvX20vvcHeYHCe+RlLwL/acMRAMdeJsd+ke0rPK6heeKTWeIZNx8WQyrf4ng==
X-Received: by 2002:a17:90a:384a:b0:268:2b5c:14c with SMTP id l10-20020a17090a384a00b002682b5c014cmr1384067pjf.13.1691655820696;
        Thu, 10 Aug 2023 01:23:40 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090a2b4700b0025dc5749b4csm2772243pjc.21.2023.08.10.01.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:23:40 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wei Chen <harperchen1110@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2] media: vcodec: Fix potential array out-of-bounds in encoder queue_setup
Date:   Thu, 10 Aug 2023 08:23:33 +0000
Message-Id: <20230810082333.972165-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable *nplanes is provided by user via system call argument. The
possible value of q_data->fmt->num_planes is 1-3, while the value
of *nplanes can be 1-8. The array access by index i can cause array
out-of-bounds.

Fix this bug by checking *nplanes against the array size.

Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Add Fixes tag and CC stable email address
- Change the title to be more expressive

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index 9ff439a50f53..9e8817863cb8 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 		return -EINVAL;
 
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->num_planes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++)
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
-- 
2.25.1

