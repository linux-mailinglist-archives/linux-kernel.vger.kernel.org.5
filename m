Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6617DFE20
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjKCCms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKCCmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C8125
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 19:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698979316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ny2ZFzxeENDJSTZ9wCuQplKwvwWNLKdmgqeowZjx4K4=;
        b=f715odRS+4t7+GIVV0Go+ZC3+jSo4cBcSAIId+4h8kuS4it7zgw0iIW9a+PRFwUf1f4Ch/
        4FESHLoeqLeM6v3B/NNcu7KgytOzpl1r//xpVAtDLWO+apUAuVJSQtb0xrOQsKK7th9fff
        CozPD34hKVKgy7S+8vmKegCLVU70D1g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-kb0Gv_5xPZaJ1bsaMkudEg-1; Thu, 02 Nov 2023 22:41:54 -0400
X-MC-Unique: kb0Gv_5xPZaJ1bsaMkudEg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9be601277c2so112419066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 19:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698979313; x=1699584113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny2ZFzxeENDJSTZ9wCuQplKwvwWNLKdmgqeowZjx4K4=;
        b=RNjWQ8iyrAD/YH8NfIJuE7JX2YvFppyZcHGY0CjZVXCJVI1Gap4UGr5zANyzzGuvBQ
         dF0WBipdrmbvwTotd56UrMRXMQGjCUcfLdFRmulFvO9u2VXEfoPpaI4hNcEunEU3T04C
         wh5tsBnE5o6M1y1/k8DMfevx2e/Uv0RAah+K1QDGCpP40DSHq7EHLKFpE8a5zk2Eb/Pm
         XVq/pfsvmGsF5aaWRjzThZXa1XqLNZ/9XhhSbckn6PH7m5oS7P7hLPvDYpVWaFXeqLAp
         YGyBiUVqlnmHJi9dkhQ8CoYjv7V5QLVlVbDq3Opg5xy5MtvjaMlGN05DDyr41m+5mcs1
         hTtQ==
X-Gm-Message-State: AOJu0YwHFyRolUC8Td36kk5+9VTHKG8zyAX+Tqqc+eseMsJFn5bYPnvG
        lta1uPtFiCaMCLf0FOy5pvIOvPF+XyEgYMi+FA8O+DzQTHBSSPD/zPpFaUBMJzEQxTTgjiYj91I
        4AqaXCxLso/H0mbc6M7uayUec
X-Received: by 2002:a17:907:2d28:b0:9bf:697b:8f44 with SMTP id gs40-20020a1709072d2800b009bf697b8f44mr6733369ejc.6.1698979313486;
        Thu, 02 Nov 2023 19:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj8ItR6ARgpxLWW8ZXsFRD1AjDYC8gptOiYDscDMcYxWPb9yjdvJ+NcwTXCgSU6cBODiLLHQ==
X-Received: by 2002:a17:907:2d28:b0:9bf:697b:8f44 with SMTP id gs40-20020a1709072d2800b009bf697b8f44mr6733360ejc.6.1698979313220;
        Thu, 02 Nov 2023 19:41:53 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709061b1200b009b8a4f9f20esm366691ejg.102.2023.11.02.19.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 19:41:52 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     nouveau@lists.freedesktop.org, faith@gfxstrand.net
Cc:     lyude@redhat.com, kherbst@redhat.com, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/gr/gf100-: unlock mutex failing to create golden context
Date:   Fri,  3 Nov 2023 03:41:06 +0100
Message-ID: <20231103024119.15031-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not return from gf100_gr_chan_new() with fecs mutex held when failing
to create the golden context image.

Cc: <stable@vger.kernel.org> # v6.2+
Fixes: ca081fff6ecc ("drm/nouveau/gr/gf100-: generate golden context during first object alloc")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index c494a1ff2d57..f72d3aa33442 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -442,6 +442,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_chan *fifoch,
 	if (gr->data == NULL) {
 		ret = gf100_grctx_generate(gr, chan, fifoch->inst);
 		if (ret) {
+			mutex_unlock(&gr->fecs.mutex);
 			nvkm_error(&base->engine.subdev, "failed to construct context\n");
 			return ret;
 		}
-- 
2.41.0

