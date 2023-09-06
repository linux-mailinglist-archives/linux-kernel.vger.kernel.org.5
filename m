Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF446794370
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbjIFTCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243997AbjIFTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:02:35 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE19A172E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:02:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7955636f500so4753239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694026951; x=1694631751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS96irfNC14gdmDiFClarh9DIKJfgD77OErS65jXzQY=;
        b=eQmfVREsP9Dq6gULPu39MebcqIdDAv3hJLAxmDyZu87tgJJF4bE0wCanjLhIurVof0
         buTFlHWTOEdriJ5TUTgwratI54GJe1DKmXJqZprcpPJ6TxITQIeKHflVsMBweM4naVhe
         8X/PN8lwwWfsknnJplLM8a9tu51JNuBLFcM4UDCB4lHXi5G9D2lpl4XM5ipbSlF6utLb
         qoT8QF1+i3j/2TAXb7gL9dSmpW5q/vQjrBTyz0tXD2EBt+03wndLXy57jw0N7guH6Q3b
         fxum04Ga33K/ag3IBlmPG81s2eTqmJzEE6/q8WZzITCjKerGzLwKPgD1ik9iC47q5JWv
         eHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026951; x=1694631751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS96irfNC14gdmDiFClarh9DIKJfgD77OErS65jXzQY=;
        b=Skxhbk2T2MzVmOTlZIxzWKBZj9s1uPCP9Bd2r5GsYIyMUYtvIQ/W2aBTSB2zTvyrbp
         igVFO4XLWGUakiD5sOdyOxI/2TtubgCRg1A0TGvIjIO9Pw/ramEydDbhiCkx4dMH4lZ3
         R5iJCXDQ6CjmBdP7rBx2xomlgRGlkRvqdmkp+xTVzJhrOThiWl2SVtQN66Ra6NNbldHp
         sxA1TzroQFPNEc2sY3cTMQ3xYNXoVdrFYWqQKsImtd/xHwFAWmIA4oNxAuRrWzitrFYH
         F3CXo4QjUma3UlW7aC0iXDZvqiFPXwvgI7c+kaKYiYlO/oaIIlLOJcsA47Xw9slli4jV
         qhpg==
X-Gm-Message-State: AOJu0YwdR7CkmYkYIgt+pcPZGfGjr87+4ve89EFWIV5hZIyOvsBYDjaB
        igodUEvwQ1bfzYKmAZ7UO0IUeRtOkylkJQ==
X-Google-Smtp-Source: AGHT+IEm+/duIejOs4uEx0V1ECGyB/EMXsZAKUYZsERs5kQRkhUOS9SyRyr5dfsXrmwu8JiEQjVuXQ==
X-Received: by 2002:a6b:5c0c:0:b0:787:230f:55b1 with SMTP id z12-20020a6b5c0c000000b00787230f55b1mr18474144ioh.2.1694026950925;
        Wed, 06 Sep 2023 12:02:30 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id w11-20020a5d844b000000b0076ffebfc9fasm5152306ior.47.2023.09.06.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:02:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH v3 1/5] drm/connector: add trailing newlines to drm_dbg msgs
Date:   Wed,  6 Sep 2023 13:02:19 -0600
Message-ID: <20230906190224.583577-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906190224.583577-1-jim.cromie@gmail.com>
References: <20230906190224.583577-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index f28725736237..14020585bdc0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2925,7 +2925,9 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 						     dev->mode_config.max_width,
 						     dev->mode_config.max_height);
 		else
-			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe",
+			drm_dbg_kms(dev,
+				    "User-space requested a forced probe on [CONNECTOR:%d:%s] "
+				    "but is not the DRM master, demoting to read-only probe\n",
 				    connector->base.id, connector->name);
 	}
 
-- 
2.41.0

