Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F507688AD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjG3V6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 17:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjG3V6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:58:32 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3301737
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:58:25 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3490eacf4d5so10128115ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690754304; x=1691359104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbdMUo5HBcvY3eA/Wfik+1Hzr5RoZnPa0wj8fbM2oVc=;
        b=agVaMhk3pEDzjsQ5PJyT8TavFw+ZA1YIJ4H/s3iaFPJoI8A+JU9zgKcNSrJCgxUl/r
         gYWsjp9fZNe4vt7RemD5oACo4VCjF07da+eVPFlVJIkfktYDXcy5Oq+0ekv9WXTj7pcm
         hmEnSEYYhhmntvlDW4g70h2LR2HkvQn5FqAST7z6k08AS8fAEwVkjuN8tRLiIF0a5ZIV
         zqZnaBhzbuwwTxWL4loRMEodWBeftbndPQeDTMmB1/vwK4WwDkrY7l5AJVSHTEYTFO29
         s5w0iqu/j3yx3l/WX3aD+U1AhW9tHhIrbBDMXu+ZSBw+XLzelPALaICnC91VG1juNtbi
         c5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690754304; x=1691359104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbdMUo5HBcvY3eA/Wfik+1Hzr5RoZnPa0wj8fbM2oVc=;
        b=XyFHcYERUmwimyalSJpJnw2s2dSnTLxBfquoLDvmlXVvuA79aDzuQpXnM2ntLwtUSd
         o46EtrZ/SQLs1dSBNatKgx6pUC/A1woAhPi4b70O4XDSu4P6fWOU0vlhkOKJ6Vsx2ch8
         2LsTKD/woTMbZmK1tbHhF1AXtoDmX+PuACyKGoJxUc1IalxcpmH2Mbc2zuM9JiqGU2kx
         CoKBe2/Evrz5dLnb1Wfba4oQDy7EmvyUXtJ6N+L33la6J/nJa3eFi+XlwhhmEL1P6OBg
         R/FJFCej3fMkLp5YvOf70HpNw3WDAVJmXJD3hdvZHtJI+upaZlvX7COY3O8BN87GAYCR
         2azw==
X-Gm-Message-State: ABy/qLa/fKtmEUs4g46RR7WXJOakMn608mWTkK01DZkakxos2VYVaCgG
        tp5vduC3fuh24kMddXfp1+4=
X-Google-Smtp-Source: APBJJlHWzXyQhdHLBN6Z9svWK4MZ1KGWPcL9B/eTSCudiAIzkRE+6jckTWaAdZVRO5La86sBKnRHQw==
X-Received: by 2002:a05:6e02:1aad:b0:346:50ce:d602 with SMTP id l13-20020a056e021aad00b0034650ced602mr8965298ilv.1.1690754304330;
        Sun, 30 Jul 2023 14:58:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e18-20020a92de52000000b003424b3d6d37sm2747520ilr.24.2023.07.30.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 14:58:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH 5/5] drm_dbg: add trailing newlines
Date:   Sun, 30 Jul 2023 15:57:54 -0600
Message-ID: <20230730215758.54010-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730215758.54010-1-jim.cromie@gmail.com>
References: <20230730215758.54010-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 48df7a5ea503..39eab45649c8 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2868,7 +2868,9 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
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

