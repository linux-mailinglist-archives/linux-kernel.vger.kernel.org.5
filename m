Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F747E9AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKMLYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjKMLYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:07 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B212D58;
        Mon, 13 Nov 2023 03:24:04 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so54938671fa.1;
        Mon, 13 Nov 2023 03:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874642; x=1700479442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j9ifWvhNZGTq3IiSm2aJzZT95r7nTZmkK8TlD5sXtw=;
        b=h44Kv/Ynnjoz9XjExNnt7Vd/PZvdqYAiSaI6GL8hgef11CLdrRV1+mTtJtbzP/nQFs
         +nGA4/S/mBMhT5dWZgjZYYvhLa8udJTKw5J5iGhZ/nYFrtuMAwBbh0AsJsU/gemfPnWN
         yMhnRs7ooYuwhnVgynFaQHBXty25CExlXpsfX9/UDnXPBqF1tps5VvnzoMkW5K7pMriv
         hQ92oyvaqWWMN5bSQPf5wwLMCI32lsLkcU6wuE8VLvQLMFBI22+ure0IAhoiIf+3uEDk
         0XYVWJzqTFrDMKqU3vlFJJUTorQTq2Pxx05b7DQL2d+/fAvAdtUhJfH/U9Bg945JYSO1
         pxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874642; x=1700479442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3j9ifWvhNZGTq3IiSm2aJzZT95r7nTZmkK8TlD5sXtw=;
        b=PcNOXykIMyNm8bKFlLflLoZY9oDIKl1gf0ZcGS7mBua0HOBEyoC0N3Zlercv/406Bz
         LxTNKFivGYOJjotnMNAK8pYYTEIoUpZx6Os7S6AmX5OoYAdXXPjbxzV6NCbNOXHd/FpT
         wuh0nylGkqbmpyHuLYuG+96uYEmVzxFrDqT+fK8jXpnIHj6GiBqUZTjGK1gZDTRcr5sI
         RqmfVlhehSjzgig6qoVfcHbCOfKFgXQUMUgwGqZ2UpLiCdF5Pg/JONZCeB5AnXhKlGAx
         oBPeo1Sb+l7o7olnu/PdxVOF3He6ikmBDnLttAdCLVIYRLgQ9wP+nvsRjKp6Mc4UuZ8r
         5zrw==
X-Gm-Message-State: AOJu0YydmeFW1V+E8YO/1kVCa4iu5aV5+Hv3rxo100ZLHFjh73owEJai
        se2RQxHTuhf5mT6jbb4+7Ds=
X-Google-Smtp-Source: AGHT+IE36bB2OzfEe98E4kghGaMPiIC5IuFFaTAdSXGE7DLScBaoAyzyOno2sf4r1XZ7tYHmWv/iyg==
X-Received: by 2002:a2e:9d95:0:b0:2c6:ee98:de85 with SMTP id c21-20020a2e9d95000000b002c6ee98de85mr4239843ljj.23.1699874642417;
        Mon, 13 Nov 2023 03:24:02 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:01 -0800 (PST)
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
Subject: [PATCH 02/20] drivers/gpu/drm/mgag200/mgag200_i2c.c: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:26 +0100
Message-ID: <20231113112344.719-3-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
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

