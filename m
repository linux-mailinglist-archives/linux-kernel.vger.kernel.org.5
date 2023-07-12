Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E24750E82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGLQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGLQ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:27:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8BEE8;
        Wed, 12 Jul 2023 09:27:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so6392455e9.0;
        Wed, 12 Jul 2023 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689179221; x=1691771221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJl3fVvqTxy3IObvOvAgC+gdEFfujxGEicBja5DSSB0=;
        b=eGCqYBfaMuQ8WVXZMIZVYMkG+d5n4J3s3WcyOCnT7z32dIPqy7ulZyaRFvXkZlztcK
         fF0Lxw5ZoraBKfuNmAbDkbx6jhjZokijpBya1OaXcy1nyfjW8Yi4cz2HhGaxnbpfrKnj
         rZ7D6sNZNslILlhis83+MNuRKSEGlzbfE/QbG60mGYMWceHoMDYQqu0QVFKz3zX0ZC6s
         4yIjcsu2WmvrzdaREe5wbf4DqYFcyOSxTLdv3fRn6knKhf5o68e30EhNclgoVIKuWUIT
         fdaQmV44r8n3fRlOm4YwBco69CqXm/hOFRkykAK21p0Dk9IVhG8k6rUdzQi/jzFPJ48Z
         gP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689179221; x=1691771221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJl3fVvqTxy3IObvOvAgC+gdEFfujxGEicBja5DSSB0=;
        b=jVrTYQVnue2mKaBhqXjD8E24znXLt3i+KgJfADtdwYZykZHQ1jr7/LR9jc5pdZNq0T
         5jUY8yUMCdgo+5/I1YHwnFocCzctPN3iiNN3Zw+VkM2phgOf7dwHHnEI2T4i6LnrM5WV
         /iCvfxf3KobaW/sFdERzunbeVa/hiIm+l6k1z2WBHumGbnTX3uj05Ta0D25Dgq2oiukA
         v3xfjNbO8y7lx0ILIMN08CiWsIpyo1y0pSQ9nbBoWGXcC1xqXA8W8gznTvlfiTVNRPKU
         XNIdkACIv2FYQKdrbuL4B1zwPZaKBtQ00l4uLAMBQmX5ZglCIqXPetoBi5VjFDXMYuJG
         aJEA==
X-Gm-Message-State: ABy/qLYzgnjSJ2ZsHgn/SO+hPppnFEJLXs86Is3w+flgJkTes+n/udCE
        ZAPFmQYxUCFtfHKxheZJwamjoCpsea0g6g==
X-Google-Smtp-Source: APBJJlH97hOCkLm8PPVqZF2Coy2xKx+azmJ0CZdE9BOK4pQs/hbtIQBURLff589nnhwPHM72vaexsg==
X-Received: by 2002:a5d:67c7:0:b0:314:2f3e:dca5 with SMTP id n7-20020a5d67c7000000b003142f3edca5mr2280473wrw.28.1689179220809;
        Wed, 12 Jul 2023 09:27:00 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d6790000000b003112ab916cdsm5538291wru.73.2023.07.12.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:26:59 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/nouveau/bios/therm: make read-only array duty_lut static const
Date:   Wed, 12 Jul 2023 17:26:59 +0100
Message-Id: <20230712162659.466996-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array on the stack, instead make it static
const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
index 5babc5a7c7d5..31fb20cc5a9b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
@@ -156,8 +156,10 @@ nvbios_therm_fan_parse(struct nvkm_bios *bios, struct nvbios_therm_fan *fan)
 	u8 ver, len, i;
 	u32 entry;
 
-	uint8_t duty_lut[] = { 0, 0, 25, 0, 40, 0, 50, 0,
-				75, 0, 85, 0, 100, 0, 100, 0 };
+	static const uint8_t duty_lut[] = {
+		0, 0, 25, 0, 40, 0, 50, 0,
+		75, 0, 85, 0, 100, 0, 100, 0
+	};
 
 	i = 0;
 	fan->nr_fan_trip = 0;
-- 
2.39.2

