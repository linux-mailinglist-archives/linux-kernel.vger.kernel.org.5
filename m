Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E47E7F1F72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjKTVql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjKTVqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:46:35 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44012D2;
        Mon, 20 Nov 2023 13:46:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso13258455e9.0;
        Mon, 20 Nov 2023 13:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700516790; x=1701121590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H76sh9TJa21kiF09BweriFrW/UpEK7sOhe75l5gn76g=;
        b=QRsEeDrOJvqOXuhy8AvA1hY9KeECb+s+x/W1hCWBvubGYEAyfs5l1cRBk4UGrfCSpO
         NvB07SW1gaSEKk8Mwz2uOk6RU8kRFE0gW0POetdoHUmhfSUwdpYVD6sL6sfIHeraGufq
         M3EI5JPs+uSAqgmmlqAm9tbw5TA6xYyJMvS+gDZ8AaHhGLfkf6OecKvhDn08PW2em4OW
         y4hpZ4IupAc20zWNtCkcH0+nB9tEcQkpfUcg5Z/HxQyRXhLz0yan2xkdLwHyBI9cCRca
         1vpQbN3G+NlXkxY6RmH2I+PtvHEbuH+S1akoWZJSCIouckmO1SBu1Lz+jXqRF4PdCnBh
         BFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516790; x=1701121590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H76sh9TJa21kiF09BweriFrW/UpEK7sOhe75l5gn76g=;
        b=Zgv9kv+0o+Pgficic9byDXL4zGrWWZgjPOQ1egPut38LBL+ic2BFw9j1zeeHwqvhM+
         VhOv8CyMrBWJsLQo/64ny3HNLHlMSSfDpKUeDPV0yvWgfv5vCVVD9MVdMTuZJe5OiTy2
         PYItuNTRNBjlWIKhd8Lo2o3/BU2Qzd9eFeba2f2ghDu7jSz3eyvcq9QRFdNT8OD5/UpL
         sq/RGXvaXJn3mltFKv3SQPFXBT4Iuz62JO3ko4BMFnuxEwd5+rD6VCHRLuWs3XvM7sL4
         1SqEBGl//SsMgkCHGSKEpKDYHdyjva9Ld9LbEkPho1pH+V96urG/wfiQDizxDgtyGVlp
         NDZg==
X-Gm-Message-State: AOJu0YywHM2sVOc4kP+d6xW/ViOyiebF8M4YO7qC4jyhmPvM9fxl9S4w
        LEx/3VzlD+Qu1ZNQ89qi0eU=
X-Google-Smtp-Source: AGHT+IE2ErATm2xBrVPTmReU5ycJuHnLDpRJNW4Slun/A9h1smmlE3tedG4RsPPOlF2k6luf9dWXyw==
X-Received: by 2002:a5d:648b:0:b0:332:c726:ed5c with SMTP id o11-20020a5d648b000000b00332c726ed5cmr612415wri.32.1700516789457;
        Mon, 20 Nov 2023 13:46:29 -0800 (PST)
Received: from zotac.lan. (dynamic-2a02-3100-9030-5a00-2223-08ff-fe18-0310.310.pool.telefonica.de. [2a02:3100:9030:5a00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d584d000000b00332cb0937f4sm2667052wrf.33.2023.11.20.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:46:29 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Dave Airlie <airlied@redhat.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/20] drivers/gpu/drm/mgag200/mgag200_i2c.c: remove I2C_CLASS_DDC support
Date:   Mon, 20 Nov 2023 22:46:05 +0100
Message-ID: <20231120214624.9378-3-hkallweit1@gmail.com>
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/mgag200/mgag200_i2c.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_i2c.c b/drivers/gpu/drm/mgag200/mgag200_i2c.c
index 0c48bdf3e..423eb302b 100644
--- a/drivers/gpu/drm/mgag200/mgag200_i2c.c
+++ b/drivers/gpu/drm/mgag200/mgag200_i2c.c
@@ -106,7 +106,6 @@ int mgag200_i2c_init(struct mga_device *mdev, struct mga_i2c_chan *i2c)
 	i2c->data = BIT(info->i2c.data_bit);
 	i2c->clock = BIT(info->i2c.clock_bit);
 	i2c->adapter.owner = THIS_MODULE;
-	i2c->adapter.class = I2C_CLASS_DDC;
 	i2c->adapter.dev.parent = dev->dev;
 	i2c->dev = dev;
 	i2c_set_adapdata(&i2c->adapter, i2c);

