Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4E57FE9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjK3H1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjK3H1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:27:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9710DF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:27:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3331974c2d2so444887f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701329225; x=1701934025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x09g6G18OJ4KcEcTHhYJRdvLAtb4UmkCF9sOQ3/Txus=;
        b=Dzn7XD0gltIe0SPdCy+jw1iMN67c1mZ3QEdI6Gcv2J+6W0FIOjfzvr/ybeMzxDbC10
         rJl9ABvBF8O7Z3m+Gt0eoiZmW4i8I80hi0Bn/Yw0ePRqKZnJDVUkMN5ZZxnwXsRPLWzh
         EJHD8cpRXIDpCQMiHHvapyKhScdg+zSpTH43kbhC3+1iZh5qDeZZlZxFVVIn9K3nrM58
         daYja0xfgeVrEwDdG9Hm0jiNLNkJT4Rk/GIGAowGWUcrnVPcBCuB0wB8cRSgNUM8AkH4
         NZrHgvAr2ZMgGIUcsEbPhYaiowwBU48NBdp/XZ5/xBK8J2UJdvMGt1/E/FkLNVADMKr+
         hpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701329225; x=1701934025;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x09g6G18OJ4KcEcTHhYJRdvLAtb4UmkCF9sOQ3/Txus=;
        b=PKB2c8ky8+pMUkYcuC3LssR3un5A0DZBVN0VSz6HxmnXM6oY28oipF6q9/vSSMXH+0
         08dH4eh028Qum1/GzDY7Pv8i3ZtWHgmdMWXG620OkHx0cRpkaOeyKioPaUGUWt8HZvTN
         9bX8LjxKyM2uNgMYOEY+CbcCEfHLExVOsviifi4U60GLQQXctu7U8RFIJQx3HQFzuWJT
         sVHRyFzFRSxNclSLOJEXbJIwB5kOuI1HY3Uj162gEtKWZ3lFwTUtIiMAGck6Wkmcf0Xp
         YVPJfv5lWvwuAQflPweuEmqlmMnwH8ckwLdOvYl6gq8+zxLTbdb3hr2tJVtpDTgXC9VH
         hl1Q==
X-Gm-Message-State: AOJu0YyVYE+0a6GyYYzJn/LvSahsOo1irjcEjkYRM/JP0YKC+6cIDfVF
        42usK/EYj8Q6KzXNZXbj3VipdA==
X-Google-Smtp-Source: AGHT+IEPpmMxWY7kuPeVsp/4wZTQWAaoK7shEBxCxTgQhdfynB/VG26OKEMXa8H2xecLoUqmGYdG9A==
X-Received: by 2002:a5d:5987:0:b0:333:145c:ac01 with SMTP id n7-20020a5d5987000000b00333145cac01mr4260949wri.44.1701329225311;
        Wed, 29 Nov 2023 23:27:05 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6092000000b003142e438e8csm693983wrt.26.2023.11.29.23.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:27:04 -0800 (PST)
Date:   Thu, 30 Nov 2023 10:27:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] drm/imagination: Fix IS_ERR() vs NULL bug in
 pvr_request_firmware()
Message-ID: <384288de-a779-46c7-869d-b3c63462e12b@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649c66b-3eea-40d2-9687-592124f968cf@moroto.mountain>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pvr_build_firmware_filename() function returns NULL on error.  It
doesn't return error pointers.

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/imagination/pvr_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index e1dcc4e42087..5389aea7ff21 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -286,8 +286,8 @@ pvr_request_firmware(struct pvr_device *pvr_dev)
 
 	filename = pvr_build_firmware_filename(pvr_dev, "powervr/rogue",
 					       PVR_FW_VERSION_MAJOR);
-	if (IS_ERR(filename))
-		return PTR_ERR(filename);
+	if (!filename)
+		return -ENOMEM;
 
 	/*
 	 * This function takes a copy of &filename, meaning we can free our
-- 
2.42.0

