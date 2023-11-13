Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7C7E9B04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjKMLYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjKMLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:13 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73020D68;
        Mon, 13 Nov 2023 03:24:09 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso60713081fa.1;
        Mon, 13 Nov 2023 03:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874647; x=1700479447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Op/de/de9WVnMjIIu+X6jQDnWmnKOCxjgzgj2VkHDA=;
        b=CWbxVelfwIj9gYt86n5iK2fDrfqB3lGbqjT6ZswuhmuvSkCaDz81Whz84Lv44X734q
         maX7CjSxAUyDM3QJWvrpunCDtLdDVl2puoJ7qnp6K1Agc7tCVu7a71wdq6ki7XhFk2/7
         1W9w1X659rzuvLhZ3eKze2tT1UUxB+KZwQVWGqhHzYY5tkQKNGl7/MJfAD1X4cRS9P3J
         QyfdNWPHcXnMTzlN2J+QJPyuBwDnB7T+lp1Te7icR/xae8d7f8oMSrfODLcoWtxy3uWh
         rQ3Ahz7OKvNroaQ3DDKBsVE/B4qfrq8AxNQbSEekOsRFZNIBQlkn4qV6BH/+C4Qr5+am
         d06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874647; x=1700479447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Op/de/de9WVnMjIIu+X6jQDnWmnKOCxjgzgj2VkHDA=;
        b=p2nHglkVUN9jtke2EgYUvZId9XBjsaJYRAaWIzFnRKCQS+eMG1KdBBjo/RE9LyheF4
         Ps7ja1Ly7hbBrTdMF16+GmOxd3PUFfQ5K2nJdoc0tV/9DF/lvm8/dVE+JzFWVpEY5hFA
         /h1asVpNcnKKuKm2ErJlZBPck5LN00SV1J3Tf0vbTBWOxW5InGNaNN+jxhfEE9h3F2d7
         hW2NGvle93+ZhVaTH64lnEVihOzcFK9XPEwngailXgX3pE6rtLI9fDdYyyhkwwJ4ehbl
         Hlicq0BHropcOu2xT8ISf0G9hLohEp5xdKoYagKqFnYMKTmVpKQxttX1QWle+jJ3roZY
         h+SA==
X-Gm-Message-State: AOJu0YwKexP8Wn4v/PPknF3V9Ye6Pyipv9wm6Pb96aYjLfSyg5AR/Jof
        9bw+IAkD8mhF4YuIDQKIB42FpE5kKEo=
X-Google-Smtp-Source: AGHT+IEJsBMp4JbvFi4pspNX0Uzx9z5MBDoZN9PZxWzXZcpLsSgHiFtlq5yu+gjphO5CZmj++0wsZw==
X-Received: by 2002:a05:651c:1049:b0:2c5:1f70:a266 with SMTP id x9-20020a05651c104900b002c51f70a266mr4020462ljm.50.1699874647541;
        Mon, 13 Nov 2023 03:24:07 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:07 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] drivers/gpu/drm: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:31 +0100
Message-ID: <20231113112344.719-8-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c |    1 -
 drivers/gpu/drm/radeon/radeon_i2c.c     |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 82608df43..d79cb13e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -175,7 +175,6 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 
 	i2c->rec = *rec;
 	i2c->adapter.owner = THIS_MODULE;
-	i2c->adapter.class = I2C_CLASS_DDC;
 	i2c->adapter.dev.parent = dev->dev;
 	i2c->dev = dev;
 	i2c_set_adapdata(&i2c->adapter, i2c);
diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon/radeon_i2c.c
index 314d066e6..3d174390a 100644
--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -918,7 +918,6 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_device *dev,
 
 	i2c->rec = *rec;
 	i2c->adapter.owner = THIS_MODULE;
-	i2c->adapter.class = I2C_CLASS_DDC;
 	i2c->adapter.dev.parent = dev->dev;
 	i2c->dev = dev;
 	i2c_set_adapdata(&i2c->adapter, i2c);

