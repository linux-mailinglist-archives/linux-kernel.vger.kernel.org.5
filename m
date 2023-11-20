Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F477F1F87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjKTVqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjKTVqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:46:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AD9D8;
        Mon, 20 Nov 2023 13:46:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so3253146f8f.1;
        Mon, 20 Nov 2023 13:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700516794; x=1701121594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXnYU9L0SxzpQBJjG8833LUnrTfJuWwdCW2h6rtJH0c=;
        b=UmMYzjFABp5FR6+c792VIxyCNsh5J22xYhxpewIJT3fqu+HWxYPBNqGLRJWCyoPDZk
         Wb2cKzj3CGmdDt7btZN3pMjhVoKyhNlc4f0Q2vhEj//ANr0RdBdiFVEjIBvq+sq4rJek
         FL0DP5ephdponzAoTaxlp/1gHHD71h2lYXV25dLyUUdf1CBNFl0tIjLa1jTj2Onyjxsk
         N52vaP5Tl6WXSyWwShuWE3HXRbsAQOlbe6gqN+p0ZrPLEDyMupLFYfCop695z6SqQEuS
         0K6jU1Qvyia9mvoYQfCQVihdCheFuN/RqErgABDgtKoXjVnKbgG9HC/DYwaEWGSYUMob
         mM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516794; x=1701121594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXnYU9L0SxzpQBJjG8833LUnrTfJuWwdCW2h6rtJH0c=;
        b=pWMtGYc7JpTbXJFRs8yyxUyRx6Z6R3rRrMTjBXVlbDTymxmKkemNesq0Qo6egVFlGD
         de3FHbRwo9aI8GmXoD31g9trlXzkXMDb4TMR/WEiUqWb0k9ZOl3a4C8EePOWHyLEcmP4
         IO6w5629FoVgdNsA9q9JOILQUjx5PNAaZzECPb6Sh1SwIkMNxVGEShEMtDBRNe12FwC7
         G/EwkT2IPG4Or3e/sA6s3QRakp0oeLG9vcZ3AzUKoLkPu+uIiZw8qhyDnqAxhZxak/2k
         lfGtSfv9SH5ucvnth+rhoLYGuNpTjCTwkoJMiksG/VDm4aN85Oh8yEfaPQok5MY20Gp5
         6tSA==
X-Gm-Message-State: AOJu0Ywa7zM/mvaUnsbsKlRfog2k0phcscGfKd3FUW+XaIYnSzhnxMXp
        wUvPl0soYvC2Dme0Qr+1mNU=
X-Google-Smtp-Source: AGHT+IG7oJFy7m7GTxwuKt8k7oUtMWjUdpocB0tG7v5Jyio1SAIq6jBjcVPqQfsuIcvy5PtuzIb31g==
X-Received: by 2002:a05:6000:186d:b0:32f:80cf:c3cd with SMTP id d13-20020a056000186d00b0032f80cfc3cdmr7426776wri.4.1700516794213;
        Mon, 20 Nov 2023 13:46:34 -0800 (PST)
Received: from zotac.lan. (dynamic-2a02-3100-9030-5a00-2223-08ff-fe18-0310.310.pool.telefonica.de. [2a02:3100:9030:5a00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d584d000000b00332cb0937f4sm2667052wrf.33.2023.11.20.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:46:33 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/20] drivers/gpu/drm: remove I2C_CLASS_DDC support
Date:   Mon, 20 Nov 2023 22:46:10 +0100
Message-ID: <20231120214624.9378-8-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120214624.9378-1-hkallweit1@gmail.com>
References: <20231120214624.9378-1-hkallweit1@gmail.com>
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

