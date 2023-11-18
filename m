Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC07F01A2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKRRmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjKRRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:42:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41DC0;
        Sat, 18 Nov 2023 09:42:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so3849745e9.1;
        Sat, 18 Nov 2023 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700329353; x=1700934153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXnYU9L0SxzpQBJjG8833LUnrTfJuWwdCW2h6rtJH0c=;
        b=EWssYaZhCnS7AhXOElNbBA9dD8+DJA+frz4w2qhg1j3zs1NlhgKxNzW6SBlQaIKo+t
         MrUUW2VH0RH76d01ZqNrh2Jr8lD6D3+m7LOVUD3iRiJ37ysMj+qrYHZxCdJaStCIEFOL
         Ho7WtLD7xJXlApOLcKsbii4XUSQPRilBXXPXEhs/N3CV69d66BFvmRwGeZTfb09LtuPO
         dVZ2L8q+PqF88AT15oItBUJEfyw5nIZl2o+XVFLCYnDGCwuMwzt6mDVxpsVMXpFN7rix
         cbuZUldH1L9aefoNWi14bMGhvE2GJZKyAI0R85lv0q4HIdrEL9Y+quoGVnmmxiakfXLW
         Lk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700329353; x=1700934153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXnYU9L0SxzpQBJjG8833LUnrTfJuWwdCW2h6rtJH0c=;
        b=dem/CAlpSz37uuFGezivk1ApDvL9IFd6B8TX7rB2Ing+xwwbdC62dwieIgX4FksKff
         YJofNvRDq2OaKaaAq5PSBJ4MDoGDLb36NhuliLZeGBknSqXEhTN6+owpXvyFZQhURs31
         g2ylM3cqYVRoZPVRnDdroJGU0sj9ghCbBVsjJ1rByXed7LyIG0LcNL6s4xZ6/EdDBANF
         cU9nMAeaI4W8ooHJo1G7brYwU4engXfLbpaX3UtyY/UQvr0ZrykeOiBSlvCSwZ6UYudp
         3N7OScbzekAIczS2NdM9HYFsGtXIcRvYIrQCAAWfeMR2olT4zF7WOZbxhNE7zY6ERmso
         jxRA==
X-Gm-Message-State: AOJu0Yy31aTjASR1wtV6GNoJM30Y3wcsWjgExzywO+TSJjzd9blq3iZf
        +C5WBND3kC27qPALpZIIhiI=
X-Google-Smtp-Source: AGHT+IH+vVNTNRuNzx5HCBAwdawDR0oj+mid80kQSKCziiwvte/UEe7naf5BwwoyEL1Bwr25F9JxEg==
X-Received: by 2002:a05:600c:1f94:b0:408:4160:1528 with SMTP id je20-20020a05600c1f9400b0040841601528mr2146365wmb.30.1700329352609;
        Sat, 18 Nov 2023 09:42:32 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c340a00b004068de50c64sm6964211wmp.46.2023.11.18.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 09:42:32 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/20] drivers/gpu/drm: remove I2C_CLASS_DDC support
Date:   Sat, 18 Nov 2023 18:42:07 +0100
Message-ID: <20231118174221.851-8-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118174221.851-1-hkallweit1@gmail.com>
References: <20231118174221.851-1-hkallweit1@gmail.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>
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

