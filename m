Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACE7F5B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbjKWJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjKWJk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:40:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23262BA;
        Thu, 23 Nov 2023 01:41:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54a945861c6so930698a12.3;
        Thu, 23 Nov 2023 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700732459; x=1701337259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqROwQG7N3qrkO1+o2zNL4maIfyYwDDg69jSMCtjk0o=;
        b=YcZ2kT8o0amxp7yzda3BKjoxqUfndekc9RHOUhsMw69tTOUwFcY+CPSZDqqWUztLmU
         dxsKq5RthFoB8XjTN6xSEYaiJYgDu04/kOGfcW5ABsnXaYkoIx2k5u9FhZMrQFYftvtP
         YuxJWp+OQRWNdRce8r4KR3n1NL+jkwC0rUFeCNFYbQWehyFTlHTrmMfp3ssqFyJIQkDx
         hVuHYCY3VGDfK26eKrAfHri+QFHjkXm5UWAfuW5Od/leOs6DyZVd0ZTMGqGaxfbOyClp
         D3tYEhSzDjToEZURYideJdWm1woihPwsDEh/iRC8XSCV9KFNdeEtQ0Y+o6jefBMW9nDU
         b3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700732459; x=1701337259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqROwQG7N3qrkO1+o2zNL4maIfyYwDDg69jSMCtjk0o=;
        b=rxsCuGE0SLWJdFPaRUUqYs8IUTVOClwbFeqPB+LJ4Clwbb+zRKozJfW39pNYRJDvXj
         snDAbzey3KxUwmY1LrWkWxvohL6qfx5YmyhfkRwa2iws+E91JHTtoHjx1kKICJ6/j9i0
         RJztH0YIAqKW++ZVVJl3wCj2Fs2URRzJu9IRgi0gvs8NRswxCWgdRPlES8xoWzfbanGm
         HSzEsSVsyFcrh0UAf+G6xKO4e61I1QDZbpqWm8UvbnSxbrFFg/BGPicJH1a/ZuKTju1C
         eLFBRgON7hwVqvDY0DMO4N3qPtvjYPmkS10a8OhRqcMDVv1uHDTKzRsmXI7Nbniex1Ae
         FE/Q==
X-Gm-Message-State: AOJu0YzUeS9yjagzZ16kTUu0mPeOyVw6eeBmF/K8ckQTcvwH0dhtdB9S
        XVO1bcY/LAPcwqnvd/RlLJM=
X-Google-Smtp-Source: AGHT+IFzDKDdw9ToYZGoNPeCiTiYjGf6iU2HQh3DpjZwk9f0pHAhcqea5zBWX9e6oLqquOqcr6+iMA==
X-Received: by 2002:a17:906:28d:b0:a00:131c:bc3e with SMTP id 13-20020a170906028d00b00a00131cbc3emr3342294ejf.11.1700732459394;
        Thu, 23 Nov 2023 01:40:59 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-c0f2-3200-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:c0f2:3200:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id s9-20020a1709066c8900b009e5ce1acb01sm546199ejr.103.2023.11.23.01.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:40:59 -0800 (PST)
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
Subject: [PATCH v5 17/20] drivers/gpu/drm/ast/ast_i2c.c: remove I2C_CLASS_DDC support
Date:   Thu, 23 Nov 2023 10:40:37 +0100
Message-ID: <20231123094040.592-18-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231123094040.592-1-hkallweit1@gmail.com>
References: <20231123094040.592-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
 drivers/gpu/drm/ast/ast_i2c.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_i2c.c b/drivers/gpu/drm/ast/ast_i2c.c
index 0e845e7ac..e5d3f7121 100644
--- a/drivers/gpu/drm/ast/ast_i2c.c
+++ b/drivers/gpu/drm/ast/ast_i2c.c
@@ -120,7 +120,6 @@ struct ast_i2c_chan *ast_i2c_create(struct drm_device *dev)
 		return NULL;
 
 	i2c->adapter.owner = THIS_MODULE;
-	i2c->adapter.class = I2C_CLASS_DDC;
 	i2c->adapter.dev.parent = dev->dev;
 	i2c->dev = dev;
 	i2c_set_adapdata(&i2c->adapter, i2c);

