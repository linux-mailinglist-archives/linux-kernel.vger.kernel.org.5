Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8F7F0559
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjKSKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjKSKPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:15:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046BD6A;
        Sun, 19 Nov 2023 02:15:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9de7a43bd1aso460286366b.3;
        Sun, 19 Nov 2023 02:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700388904; x=1700993704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anw5D9jgaSVgoYwRFPH2zMk9qB9A7j/26DqujJWuba0=;
        b=Ngmh0Zy0HoEGKso8iPe9ll2BnBBLdhuHMeqYKABgIhxrrarcgSoE+32K1em//9UQzM
         TsUPRtyam5YiDRcb3MSBo95c2cU7OOttU8p1wEDPSOwxO0qEn8joZFEghFmuraZX7niI
         R7vpmVKdid0hvLMnOiL3u0Y0c5dg3g0gUt4Wl4X28rA0KswOFETmb1NEsaAyZ33w43KF
         ixS4b9tMXOP9EysMmM9DvN64dvRw8edpTk+ErtlxsiWHlqIuRneulp6VDElvD7F3NAtm
         IVvEv2bB0ilpgpCCdvheKJ5ktthkizktT3PoefL7yhs4l7G0Lbd2zNigw0AP57eAG6U8
         VRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700388904; x=1700993704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anw5D9jgaSVgoYwRFPH2zMk9qB9A7j/26DqujJWuba0=;
        b=D/LmksFouUHmBsr0i59+YhJJj7xObhWon5epG/c/bfJgFDaFFsQbkcoyYTfAyWUNtK
         dGrQqyu3MJ8sz62CMnchSlsW+sFpyXm8FoVyy9Hs3dZwHwj/NyZ/snZmYBi5zb+Etmqj
         3VQcGNQyIpGWwX3DLY5t1faIdgqupj0NVFI6/b4l5S+BBLLE+oWgRRlzMWUIKLFc8fK8
         XVH6yJwv7h18yoPxFFS0khkvHnxYgziI0LKXyIrPvl42OOx42LK38pMaRvJxAL80rJKv
         h+X1U6VEJYBjqmI92TEuHb5upTE+08BBRSprF9PToGNQM6AJRV7qNTY/qJYsFUvU8lEc
         n6RA==
X-Gm-Message-State: AOJu0YyppuJHh6IaerEGE7mM8+pSiIJo6DP8yTPkebzAYAYiqMHsUKvh
        JcjOCfO81h6pym3JndDEayE=
X-Google-Smtp-Source: AGHT+IE8GHFq7uiHSNV4+P+yG9Uk8xKqFaoBRiYyFD0p/QlJu9rTxI9UZij7OIQ47Q1zPCUxvVwxGw==
X-Received: by 2002:a17:907:8b90:b0:9dd:7133:881 with SMTP id tb16-20020a1709078b9000b009dd71330881mr4222135ejc.40.1700388904176;
        Sun, 19 Nov 2023 02:15:04 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-bde4-3e00-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:bde4:3e00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090628d400b009928b4e3b9fsm2743581ejd.114.2023.11.19.02.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:15:03 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        John Stultz <jstultz@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/20] drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c: remove I2C_CLASS_DDC support
Date:   Sun, 19 Nov 2023 11:14:41 +0100
Message-ID: <20231119101445.4737-17-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231119101445.4737-1-hkallweit1@gmail.com>
References: <20231119101445.4737-1-hkallweit1@gmail.com>
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
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
index 410bd019b..e6e48651c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
@@ -81,7 +81,6 @@ int hibmc_ddc_create(struct drm_device *drm_dev,
 		     struct hibmc_connector *connector)
 {
 	connector->adapter.owner = THIS_MODULE;
-	connector->adapter.class = I2C_CLASS_DDC;
 	snprintf(connector->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
 	connector->adapter.dev.parent = drm_dev->dev;
 	i2c_set_adapdata(&connector->adapter, connector);

