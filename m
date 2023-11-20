Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4927F1FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjKTVrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjKTVq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:46:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2575D45;
        Mon, 20 Nov 2023 13:46:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40859c464daso20068915e9.1;
        Mon, 20 Nov 2023 13:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700516803; x=1701121603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqROwQG7N3qrkO1+o2zNL4maIfyYwDDg69jSMCtjk0o=;
        b=OsNZpvrQIJ53iBOXn0CblDPCFVQAOz1/kmMpbNhgbh6EDubTv4YE+Cx/4waAsdJxAW
         a0e7o8GvPKcud+BPNfc6mtOlEkpUX7HveZi5bfrwwcQe1yxAfMgxF4YePSqf7ux1HDup
         rN4XmD/6/CYLGeiUNu5FcUU8/d71TEwMHmV0kjHo7lKD1y+PzveK3KKUubzPCO9nVSI5
         HCFZCH1sITrNzROieI1ELI7J5y+IA6yPXjUnlKZsQp1wsj74ntwR3A+fNAeZfNIZgrxm
         O2NeL7Gh4Hk9Dka/VOVNKmpBfQ7HLMxf7MToodp+iyqFn6z9Ka+YxYOguzGrjUCO7HRS
         eQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516803; x=1701121603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqROwQG7N3qrkO1+o2zNL4maIfyYwDDg69jSMCtjk0o=;
        b=RQEasv/+NhHIDdqkvEA2bBjG0ulvjbatoYNKKiT+R0Y8skdK16eKi4PQRnC2YZq91m
         bdThtScLNssEtFdhGkt2EfHV5VDuXw7kdQsP+FCa6QmOhiW8MFFg4M7CAbv/dVn1qPVs
         YamWVCY9VNFhxCN3InyyCogrKHvXbv6jFg/Bf4PH838OsIyczv4elMQAd8Q7icx9IvzF
         8fcxtiNqRcV4EGvaSwdK1R7o9KFmthFKYmNeoPrgG0dhr41brvo+PCEihpV8+OhCUeQy
         bZ8/cjvdTi9QAwaTlBXlIe/hvPHt+FALTr8EGcuYPg3WQPmp36xuRRkWJGX+UwU9OGDw
         eXVQ==
X-Gm-Message-State: AOJu0YzDKgo35cfxT1RAnBtMG9oklC4KRzvlqjkN1yX4iehq8i3ELayy
        SOaW7McZbqSJ/kt80mwO8SY=
X-Google-Smtp-Source: AGHT+IHzZWuP7fUYMd2+O3OBOSCHQpJLAk+VbHkWWjSpa7kQzX5njoZWRysEH9t0PNmhOAIArQoRaQ==
X-Received: by 2002:adf:a353:0:b0:332:c4e3:9b09 with SMTP id d19-20020adfa353000000b00332c4e39b09mr3466448wrb.30.1700516803239;
        Mon, 20 Nov 2023 13:46:43 -0800 (PST)
Received: from zotac.lan. (dynamic-2a02-3100-9030-5a00-2223-08ff-fe18-0310.310.pool.telefonica.de. [2a02:3100:9030:5a00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d584d000000b00332cb0937f4sm2667052wrf.33.2023.11.20.13.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:46:42 -0800 (PST)
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
Subject: [PATCH v4 17/20] drivers/gpu/drm/ast/ast_i2c.c: remove I2C_CLASS_DDC support
Date:   Mon, 20 Nov 2023 22:46:20 +0100
Message-ID: <20231120214624.9378-18-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120214624.9378-1-hkallweit1@gmail.com>
References: <20231120214624.9378-1-hkallweit1@gmail.com>
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

