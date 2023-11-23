Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3087F5B72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjKWJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjKWJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:40:47 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D61BA;
        Thu, 23 Nov 2023 01:40:53 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a02cc476581so80118266b.2;
        Thu, 23 Nov 2023 01:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700732451; x=1701337251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE3vmdF0wanDhCYGlSWZub+/X2exFV1gowAmEM/g0Pw=;
        b=XF6Yf/8y9yAjqNPNJn4LCtc1KnxkywrRMBJwkAv+VdzFe9rMpNApJD4SZU5EoAJ0z/
         DecJ8R//xKs4kN1Qa4iIL5o+XlrpcEojjJZTtJD3EgyMn9H4ejyo40M/4f0NLbyg4NEp
         Na5ivFczRP8/nkuWptprIhjivKcCrHzoZ7mO+0cZ7fgmSAy//x+F3UgBgX+HQ/Wvw/Q9
         YKrxMND9O9ZZQF46nGlIRB7fxeBj2xHjlkOtvI5QskaHGB2u4NTvKDD2KFPxZ77nT4Wd
         gaa55Z/G4ea5DjGFaJWpkzyJw/KYzWB8SboDmKkrNQu9P8uvtPL+IvAQjFV715UH4oXm
         Xgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700732451; x=1701337251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE3vmdF0wanDhCYGlSWZub+/X2exFV1gowAmEM/g0Pw=;
        b=SAAGkGQ6mbZnOUPIYRNXIA3biX7Pwkh9fCpvqOq49IklZ8JUvpo2JyU44LEVs5sA9r
         +LbrmjtCY41sRJlNhfseTk09Wm/8spffMwT8WLCj87q9PNGUVICBMUc9LwvOT7nqA61L
         g45kZDR2EYxA3nVPPHdkmKK/9V5FGt8xGOn5x7x2WHkcKuU3uokGUUWePDiCBmORvPnT
         DPgk4EFfcFlPabpt8CAYN2KvDwUv8vJ6ZjtwCN3wle7Sak6gL+pg6GYIsNPIZw0W3m10
         Hhl6K5sT2lD/L6pb77ZEOO0bMiFrUnteOi3bRI0fNDcqYLocwhrVMsCbfLKDzKMwuXTm
         wfgw==
X-Gm-Message-State: AOJu0YzHuZXI4rPNX3+kXpUshiQzLU4Mh7n8TwRsx5tFCnyfv+dEU03t
        DjydwPW5Op6Iq7SNTVYLzkI=
X-Google-Smtp-Source: AGHT+IEsOmKWsqrRI9wn8tyepMe2HWVZeZdZCX+kXs5QK5xUIlIuKwnFMGVkK2jR0mQNB43pWbZGag==
X-Received: by 2002:a17:907:30d0:b0:9fe:6508:a051 with SMTP id vl16-20020a17090730d000b009fe6508a051mr1921733ejb.71.1700732451429;
        Thu, 23 Nov 2023 01:40:51 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-c0f2-3200-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:c0f2:3200:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id s9-20020a1709066c8900b009e5ce1acb01sm546199ejr.103.2023.11.23.01.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:40:51 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/20] drivers/gpu/drm/loongson/lsdc_i2c.c: remove I2C_CLASS_DDC support
Date:   Thu, 23 Nov 2023 10:40:28 +0100
Message-ID: <20231123094040.592-9-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231123094040.592-1-hkallweit1@gmail.com>
References: <20231123094040.592-1-hkallweit1@gmail.com>
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

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/loongson/lsdc_i2c.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_i2c.c b/drivers/gpu/drm/loongson/lsdc_i2c.c
index 9625d0b1d..ce90c2553 100644
--- a/drivers/gpu/drm/loongson/lsdc_i2c.c
+++ b/drivers/gpu/drm/loongson/lsdc_i2c.c
@@ -154,7 +154,6 @@ int lsdc_create_i2c_chan(struct drm_device *ddev,
 	adapter = &li2c->adapter;
 	adapter->algo_data = &li2c->bit;
 	adapter->owner = THIS_MODULE;
-	adapter->class = I2C_CLASS_DDC;
 	adapter->dev.parent = ddev->dev;
 	adapter->nr = -1;
 

