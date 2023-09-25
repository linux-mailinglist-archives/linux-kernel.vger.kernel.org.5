Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC37AD473
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjIYJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjIYJXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:23:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0205C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:23:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50309daf971so9421108e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695633790; x=1696238590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDyabU/ctSGF4K3dTAmchO6EjvdapGJuzpqjXfhEki0=;
        b=USr70ALjq34CJviBj8kMoycih62RdwNPFTGT2aGyuSP4xNzALrY/0c90lS7sFv3rKf
         pD0+20MG7i/jGdwvDxef1ZWrHBdR51UufmRSrQQOZgxe0mM+zRDUx30PP9YSXGWKZ3ts
         G8FVuO5jlbhcuMI8jEFmvwKeXcSuW+3Z7qPrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695633790; x=1696238590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDyabU/ctSGF4K3dTAmchO6EjvdapGJuzpqjXfhEki0=;
        b=IkrU216go4ZM9s2Jf0pd7HxKfv9AQmEOMBXUBNPxzi8QIbTaUZ+byw+k4kt0OS3mH4
         k2LDNiw/S8+8pLXdYnhqtrguX4QJ1nGYYAsJAEsSFaLL5vwT5qbg1rOALvFJs90RcXxQ
         9v+6fOQ7+GpcUIfE4phqvKXGKsIWFVC5WumrCQXn+W3pEQBzBg9lLSdwUMzPpRnRqw0z
         NqQx+bmHdHYnmC2N6E6r85B6ibE5hbgpFd5ebg0CC2aGXWG8/ito6bVIFxckjY7MScsY
         I+7o90AOJIaEqHW6IsAEz8XedXODKyG6dqqu0xM8QNueiyCQCRLG8W/QAab1spsaXJYG
         qzqA==
X-Gm-Message-State: AOJu0YzXFrMLJlXMksg4rFbcwu/xcm7uec4rhIQuN9gL5ViGwaY/BTQM
        eSggumTlVmjAJTCiV/2Rc3dY5w==
X-Google-Smtp-Source: AGHT+IFdJhgh0QBpQXEzpkLS8WILLnuoY/8uaH456FPwyO42nXmJ7Ufixv3ar0REWsyD1mqtS+FBRg==
X-Received: by 2002:a05:6512:b0a:b0:4fb:9fa7:dcda with SMTP id w10-20020a0565120b0a00b004fb9fa7dcdamr6155313lfu.26.1695633789773;
        Mon, 25 Sep 2023 02:23:09 -0700 (PDT)
Received: from elfwind.c.googlers.com.com (49.240.189.35.bc.googleusercontent.com. [35.189.240.49])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c320500b003fc0505be19sm6494837wmp.37.2023.09.25.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 02:23:09 -0700 (PDT)
From:   Hubert Mazur <hmazur@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Michal Krawczyk <mikrawczyk@google.com>, upstream@semihalf.com,
        Hubert Mazur <hmazur@chromium.org>
Subject: [PATCH] drm/mediatek: Check GEM buffer size
Date:   Mon, 25 Sep 2023 09:22:49 +0000
Message-ID: <20230925092249.2228743-1-hmazur@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer size is derived from parameters supplied by the userspace.
Having the size equal 0 causes allocation failure leading to kernel
panic.

Fix this by checking if size equals 0.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")

Signed-off-by: Hubert Mazur <hmazur@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 9f364df52478..3b985b99d5c6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -62,6 +62,11 @@ struct mtk_drm_gem_obj *mtk_drm_gem_create(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	int ret;
 
+	if (size == 0) {
+		DRM_ERROR("Invalid allocation size: %zu", size);
+		return ERR_PTR(-EINVAL);
+	}
+
 	mtk_gem = mtk_drm_gem_init(dev, size);
 	if (IS_ERR(mtk_gem))
 		return ERR_CAST(mtk_gem);
-- 
2.42.0.515.g380fc7ccd1-goog

