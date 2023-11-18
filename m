Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E304F7F01A0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjKRRnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjKRRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:43:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1781702;
        Sat, 18 Nov 2023 09:42:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso4619605e9.2;
        Sat, 18 Nov 2023 09:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700329363; x=1700934163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e72KmLCJ3CDoJCk97GYas08RIDfDHJvByQpoDflcW58=;
        b=M/yAZAMXSLO6BWy6Iqq3wPJp5KeBz9v3vLFTXb/zPNHdxeTroHs5V/+CPt7HzBVICC
         tJwP7h0zmcGQHSuM4jSkg10VGqlGRJQVgEovIYtcwT/fiz4HOJsJ8OqWw2MeamaPTK/v
         fsnDyjHh5ZS1snvhLwGMuLL5Ph5OTEy76uHURYFthiNsIdrPyA1Pz/MGb2cuw+c78gAa
         NOF9CFkvvdStRE1Yrg753L5v/hJuVFR3PzUXmQvwjMT4CZfHlJ4nteWHYEuQd9UXZHof
         tsviM8qxDVsTTgVnwR1dvn1lj6u82n/sxMVkqdGSFcjUwj3izJgsj4qlpYg4G0q+fF04
         VDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700329363; x=1700934163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e72KmLCJ3CDoJCk97GYas08RIDfDHJvByQpoDflcW58=;
        b=G1qdEAlcG/NQaktSvXwdKEKyNWLeoFrFkyhTP3RrFxPpfJ8EMH0JsPggABW7fcSllQ
         zJtonnv3w1EXVP6PkiYo/UeXnBULfknHt8DTU0V26fGvibRAMjduacGFdHeKXEpyR92a
         ORtG/R5ISFJY67wWP9eFJvDlD1GzwSchMu+1YwLZUwOdQ9h1bHeWfBs7d5N1s04cERWd
         bQm4F+c0LfO3uvfoEPwBjSrOmZOu38IyPLRHmYMHLxH0tzPre8eYQ+9hYXywv3urOfsd
         a73U0aBHBUzEzqu+pmHga5yGMRdRYplTaJq3y+bnEOJX7THfB7E3glnwZMyYHHVHImED
         aVew==
X-Gm-Message-State: AOJu0Yxll8uUEv8vwGXb4raxByTd1BAtaRFX0AizBH73Ganyz7MvVOFw
        D7d2bWrMF76Q6GWdKR4PybA=
X-Google-Smtp-Source: AGHT+IG/rpSoscDMsjiZahKHW5DKav0OGOlQ6bqp04xYQwKcY1sQ1AOt05hiLcK74Hz4Jvo+yXtCJg==
X-Received: by 2002:a05:600c:3542:b0:408:3f64:6553 with SMTP id i2-20020a05600c354200b004083f646553mr2565974wmq.16.1700329362877;
        Sat, 18 Nov 2023 09:42:42 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c340a00b004068de50c64sm6964211wmp.46.2023.11.18.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 09:42:42 -0800 (PST)
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
Subject: [PATCH v2 17/20] drivers/gpu/drm/ast/ast_i2c.c: remove I2C_CLASS_DDC support
Date:   Sat, 18 Nov 2023 18:42:17 +0100
Message-ID: <20231118174221.851-18-hkallweit1@gmail.com>
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

