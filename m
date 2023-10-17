Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3F57CC19D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjJQLPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:15:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BEB6;
        Tue, 17 Oct 2023 04:15:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-565334377d0so4139799a12.2;
        Tue, 17 Oct 2023 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697541342; x=1698146142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+44+Hzb0z6pVz0b4amjrQwdXkC/qEJs/4XOggo1kQEk=;
        b=DTm13Y5x2Jsu5A/yuWaEyhTYOXCOyqGWoiZT9PijxcKWSYUiXugtiZvQU51yfeNAiJ
         QgzG05rWkHwfWh5n8pt0OsXfPHxsiHDx7oBGfcsezUoiuVq24CF4C6cuo7JMYs1pP1CQ
         +n0kXy57f9I8Z0uS1Pjt/cCWGEUZ3lBVFPdaHNBQ1L9sv/L81Fj9C83z9B+qo7dSMeLS
         snNI+n3ljjnAkBaV99fUjdgmtVkNxNeQEjtePckhtR82qqZfBKGGQ4catYx1yMT9kEa0
         ZerLwVDmLIPXtX4MC/8p+UIddxcVCuKrqWRFXgqvlqWMWzbtzOriLpVXwQDzBAhD4coM
         v6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697541342; x=1698146142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+44+Hzb0z6pVz0b4amjrQwdXkC/qEJs/4XOggo1kQEk=;
        b=FRbTPK7yy5XGLFbs//MG6baBlf6Nb/wLb5NpyIO73OkFm6Sz3xHHdQUpj4g+S1ZbjD
         8PiwM+8LiTkyyOcKFa3UJpyKmHeh3H18iCZVMJswU/c/j7/BAMq/NiKM4PpdNWasFfpv
         ToxE4KwcgaTDDPDW+CJVnFenOtNne+P/izUSikM1vnGdw875rBRrFbQL5/hyN+03yS2z
         UHnm/YK7uujM9AcwVj9rKIZSVlfsubtrcisyrlfavD5PrcPgrYoxCVlCOoQiZpTAC7HQ
         9i7Yi8dz7iz2UFe7JVmotfJNMEQYp7BKGV9x70WTNpieuDLsQ6WpkkG4l7P9DDKONLWR
         SDxA==
X-Gm-Message-State: AOJu0YyGrPHlr6Ju3OLHkiOGMFxsax+zatHPbHgJBYTCB56NOmyiQR5A
        QAMRyacbKoTcpXng1KE4kVM=
X-Google-Smtp-Source: AGHT+IG3u6DgkJvVWi5rXc1il/sVVRclpATJPGzF90qfdTNoZy367Sk9Qoz5is6yEQhjSyDmQnCzhQ==
X-Received: by 2002:a05:6a21:47c1:b0:179:fbd6:95f1 with SMTP id as1-20020a056a2147c100b00179fbd695f1mr1573236pzc.26.1697541341850;
        Tue, 17 Oct 2023 04:15:41 -0700 (PDT)
Received: from localhost.localdomain (59-102-24-27.tpgi.com.au. [59.102.24.27])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001c60635c13esm1269794plb.115.2023.10.17.04.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:15:41 -0700 (PDT)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Karsten Leipold <poldi@dfn.de>
Subject: [PATCH 1/1] apple-gmux: Hard Code max brightness for MMIO gmux
Date:   Tue, 17 Oct 2023 22:14:45 +1100
Message-ID: <20231017111444.19304-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data in the max brightness port for iMacs with MMIO gmux incorrectly
reports 0x03ff, but it should be 0xffff. As all other MMIO gmux models
have 0xffff, hard code this for all MMIO gmux's so they all have the
proper brightness range accessible.

Reported-by: Karsten Leipold <poldi@dfn.de>
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index cadbb557a108..1417e230edbd 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -105,6 +105,8 @@ struct apple_gmux_config {
 #define GMUX_BRIGHTNESS_MASK		0x00ffffff
 #define GMUX_MAX_BRIGHTNESS		GMUX_BRIGHTNESS_MASK
 
+# define MMIO_GMUX_MAX_BRIGHTNESS	0xffff
+
 static u8 gmux_pio_read8(struct apple_gmux_data *gmux_data, int port)
 {
 	return inb(gmux_data->iostart + port);
@@ -857,7 +859,17 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_PLATFORM;
-	props.max_brightness = gmux_read32(gmux_data, GMUX_PORT_MAX_BRIGHTNESS);
+
+	/*
+	 * All MMIO gmux's have 0xffff as max brightness, but some iMacs incorrectly
+	 * report 0x03ff, despite the firmware being happy to set 0xffff as the brightness
+	 * at boot. Force 0xffff for all MMIO gmux's so they all have the correct brightness
+	 * range.
+	 */
+	if (type == APPLE_GMUX_TYPE_MMIO)
+		props.max_brightness = MMIO_GMUX_MAX_BRIGHTNESS;
+	else
+		props.max_brightness = gmux_read32(gmux_data, GMUX_PORT_MAX_BRIGHTNESS);
 
 #if IS_REACHABLE(CONFIG_ACPI_VIDEO)
 	register_bdev = acpi_video_get_backlight_type() == acpi_backlight_apple_gmux;
-- 
2.42.0

