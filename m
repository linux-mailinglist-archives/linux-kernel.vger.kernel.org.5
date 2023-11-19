Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F345A7F05A8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKSL2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjKSL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:28:36 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5EFF2;
        Sun, 19 Nov 2023 03:28:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9df8d0c2505so656999666b.0;
        Sun, 19 Nov 2023 03:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700393311; x=1700998111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j9ifWvhNZGTq3IiSm2aJzZT95r7nTZmkK8TlD5sXtw=;
        b=jpgBkGWJLNfEHGV59dqvMM5JpWunYMkuELAYzJ+EzVCosANHXSrjMN+HEc3miQtqbA
         feFw8R+imHJ9F4iEW401Q9LYPNbU0ylpws3xJ/yRMy+R+7mELyHEocNJLjjoHNqzHdRm
         kcL870MtEB0i1ekNcGYUN+jz5UfqFHQjAn/JeiA6ro0IhMkjzYCPwPuWaE29gD+GKm3+
         PQgcs5iVE04kXphCjv4BqluPfTKZR94hD19hkuW5dg5mJS1TTAhvRYl3dl6rx2ju2yaK
         DJW0AP0lzpXhUTb9zaX47U/nSyK4D6bAshcHA3uQI4jv4hrDnHNOw7XXPjHDCvtQIVOt
         ibbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700393311; x=1700998111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3j9ifWvhNZGTq3IiSm2aJzZT95r7nTZmkK8TlD5sXtw=;
        b=Qqy78k5pLgZ2j1zoPrHW6d/nlY7U3nX5igSZSbk8K+3s3sQ8DBM6zTiw1SwUh1wdTo
         eMcDZVsdN2RwR0hsM+gsAUd0thPoDCoL2LIdND/JxG51s3AR1dCxyrxavD/hUvf9zcQT
         xTD5XWtDiiECmoL7+/aF3YQYFz6Ho+lhY4dccwv7sOPHfJ9ZtBSM4Avzv4UKzOMU3E0b
         PdQjQWqQduAsv7+oTSXw+ZdIJQaN6yd9ou3kvMVGREyPK9ZIWYBseVcO5CBar+GU/TyM
         AMuLeJ4yNzsLUPYUCT3VwNxKV9fCJta3SvwoIEM6uwMBW7mqsmzvPS9o0v0lY0s1nEaf
         FKnQ==
X-Gm-Message-State: AOJu0Yy7+EH76OOvNZndic1fr324xI6p0JD29HDjCCDZTRM1uptf3oy4
        EP+2wWOnToys8x8cABsXwy8=
X-Google-Smtp-Source: AGHT+IEolPQnFux6ptEBdIgIWLfFvK+a9fTJaZAE2jvnmd47z8KPXEbmFvRb3A0Nnlw8LWex2IJNnw==
X-Received: by 2002:a17:906:2215:b0:9a1:f1b2:9f2e with SMTP id s21-20020a170906221500b009a1f1b29f2emr4088533ejs.2.1700393311373;
        Sun, 19 Nov 2023 03:28:31 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-bde4-3e00-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:bde4:3e00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b009f8af454d0dsm2420378ejj.112.2023.11.19.03.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 03:28:31 -0800 (PST)
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
Subject: [PATCH v3 02/20] drivers/gpu/drm/mgag200/mgag200_i2c.c: remove I2C_CLASS_DDC support
Date:   Sun, 19 Nov 2023 12:28:07 +0100
Message-ID: <20231119112826.5115-3-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231119112826.5115-1-hkallweit1@gmail.com>
References: <20231119112826.5115-1-hkallweit1@gmail.com>
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

