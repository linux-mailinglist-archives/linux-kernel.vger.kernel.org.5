Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C59771EE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjHGKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHGKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:54:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D741701
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:54:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so3692681f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691405654; x=1692010454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKxx/3gVhDKeQ+5Xp1I2ndcs8RM4CqYRJfi33pczdYw=;
        b=ai+xBYASjmix6+fhq4OpsVE7Bl8u5Z2vA69XGfyE39TdYmf7Kwlgn+wPoELh/FW/qF
         HE+3SstGf2Qe8PXkMNX52eQBJatXmP6KUNfHa/Nra6VrspmO7fUKeLKeXxfQnaVQlTmT
         iJ1HWBYFxRC4bHbmkuJoWQaa4JFpf8byan82Hs0Y7yQc06bhx7rkJ7my7i0Iup8WIUUk
         zR1I1PvhsTzZ2/vQx7eoa4sNvvOGRxSrL7M5CQN2rgXm4+9EAvsjaBkzaL+y0P9Yw5+z
         f4jl/VeupN9F7GbwbpoApWXcy60qxmH/sd57hpFU9DjfWMfUSHYZ0XUkvGeYpswZxBEi
         VUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691405654; x=1692010454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKxx/3gVhDKeQ+5Xp1I2ndcs8RM4CqYRJfi33pczdYw=;
        b=MJ2zjGzm6jph8Z/bqBerk620mC5fUBMNg41tpH7VcNYM0UWckw1rZ0EQWAoi2r0mVO
         IBwUmCiNJv1cHKsdsKaZ/TY8IFlPU+WA4swZ2Nz0L0t67eDxxlR93j7aZE/nykt0qnz8
         Spm2MHIYJzpRAqXeeAmkR2saV6BJZLbqEKDGecfoi/sy12DHmHgQ9454FBh2TvKujKuL
         vG+rpBQ7NP5Z/YS5PvwuiMsMWEb1H0DOlCFkfSB0akEchkeQXI6lV637VwDpADZ28jjj
         1ES36KGJTQz+m7Bnzev3o/Eg8v2osIed1FZEjqUtFU5GTrxtHoAGL6RoDP0yAkRcJSzY
         h28w==
X-Gm-Message-State: AOJu0YzR2spJQbakLUl4z9aEKGqyYClJ+GZa5nEdVE8xDWRt1XClfqII
        9J0zKOJLrsNW6xjhExocAFmj3WSWaRzrjQ==
X-Google-Smtp-Source: AGHT+IF+aqfX0z4y8+FcFdisghKRm5Jv45soYTVWt/c6AH2z4wv/T8nCxMSOKJJweVpRn4ujDE/zFg==
X-Received: by 2002:adf:ec01:0:b0:313:fe1b:f441 with SMTP id x1-20020adfec01000000b00313fe1bf441mr6769979wrn.29.1691405653677;
        Mon, 07 Aug 2023 03:54:13 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id d18-20020adffbd2000000b003176c6e87b1sm10104646wrs.81.2023.08.07.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 03:54:13 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     martin.blumenstingl@googlemail.com, jbrunet@baylibre.com,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        p.zabel@pengutronix.de, Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] reset: meson: remove unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 13:54:00 +0300
Message-Id: <20230807105400.11560-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/reset/reset-meson.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 13878ca2779d..e35c3364e722 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -129,8 +129,6 @@ static int meson_reset_probe(struct platform_device *pdev)
 	if (!data->param)
 		return -ENODEV;
 
-	platform_set_drvdata(pdev, data);
-
 	spin_lock_init(&data->lock);
 
 	data->rcdev.owner = THIS_MODULE;
-- 
2.34.1

