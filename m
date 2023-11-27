Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1EC7FA017
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjK0M4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjK0M4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:56:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF421B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:56:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b473d3debso5080115e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089796; x=1701694596; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIYOB2eU2H+bluz3T89WDZtEixLUpIjEWJSjNBKPfQM=;
        b=rUGcXBq4iWK8F4iT3UXDeOE+1d7jzILvB4lK63tR0pE5q/4YF+ZjKUujXhzk+WzjKv
         idBY7rjdQOprsQMkXwkwcGvCHWTrJk12RcyMKWQckCJge8Gqdj+66rRR9nOm7cHSCTA+
         6tx4tMguBvzBS/x8dHKppM/e7AJ0Vgl9zJp+V/kVhgQ8icgshehTgYrztwG+GLjKhYFp
         pBy9fzYeDf5VgLcHyBF4y5s8aJlPXib5RcX327uwNDiIlnMJGrnDFkBrFnTkNrXG9isd
         b2eneETAf5NvesTrJFcfXfeV4TMzR5Eku2lTNEWrba7UhA55nu+oG3I4KXipafw+7Mga
         Jigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089796; x=1701694596;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIYOB2eU2H+bluz3T89WDZtEixLUpIjEWJSjNBKPfQM=;
        b=so4NtKuz/uHYomd5Q6liIZknKzVCqbNnipg6fT0n3pOKrmuotK9yla9cKok/mNpQzO
         mCnYU1hVRwc8CD97Rdvi72TxoUhBLGPuxUH4n/4bv/eLTH3QiHQZaAqlG9d/o6C59yms
         3lrXtYiAm3kvr21l3mMX8rMqwmWy/rZw97yIy7lEvo7Fbd33cKkslHRTwCj9CtDhTDQS
         ppxuiVtyhrJWWSNHU0Vfjb6kEdSTYZsAe3KtcEk9KMAheySc1uIB+51EnAhY8E/94u4X
         lHyFXiGLC+qAj3XoX3urAwREaL8VUwfe+LBCudfOjrS+sabwqPiPBPWM4aBv5vcubH5m
         5xqw==
X-Gm-Message-State: AOJu0YwtPXJ2PXAj2q3Q/fUJZ4IiCdGSGifPhXhiAo6k8hfKi9TLE9lo
        X3k8z6Kjja3u2QM8YFxretyiFw==
X-Google-Smtp-Source: AGHT+IFPPTGfLzqzJNgYs1IpQL1hsJuI8oapdRcXNEpwBLbJewMCagBAP3dI7Z2zilUHv4TqflpLPA==
X-Received: by 2002:a05:600c:45cf:b0:3f6:58ad:ed85 with SMTP id s15-20020a05600c45cf00b003f658aded85mr8311151wmo.10.1701089796257;
        Mon, 27 Nov 2023 04:56:36 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c220f00b003fe1fe56202sm13576241wml.33.2023.11.27.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:56:36 -0800 (PST)
Date:   Mon, 27 Nov 2023 15:56:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nouveau/gsp/r535: remove a stray unlock in
 r535_gsp_rpc_send()
Message-ID: <a0293812-c05d-45f0-a535-3f24fe582c02@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This unlock doesn't belong here and it leads to a double unlock in
the caller, r535_gsp_rpc_push().

Fixes: 176fdcbddfd2 ("drm/nouveau/gsp/r535: add support for booting GSP-RM")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index dc44f5c7833f..818e5c73b7a6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -365,10 +365,8 @@ r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *argv, bool wait, u32 repc)
 	}
 
 	ret = r535_gsp_cmdq_push(gsp, rpc);
-	if (ret) {
-		mutex_unlock(&gsp->cmdq.mutex);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	if (wait) {
 		msg = r535_gsp_msg_recv(gsp, fn, repc);
-- 
2.42.0

