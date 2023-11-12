Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74387E9170
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKLPbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjKLPbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:31:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213122D62;
        Sun, 12 Nov 2023 07:31:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32f78dcf036so2735308f8f.0;
        Sun, 12 Nov 2023 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699803088; x=1700407888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=obRWuxKD/5egh3mY1N2w+/+ozAFkQxS5SU7QX1mWWT8=;
        b=iZ/Pq3rDjleX2+KRroxutHIQFWdJx+nBaUBmRpslJatB9Shy3Fvnxu2kOYX8fRGOVx
         bN/GvVJf4FvmRZQSD8YIqBDUx51YtyZ0BFw3k4mTeS+ZuObqzJi2RaxnVnG1PyoxFrHt
         JgAyHUFy3QUBiMEXRp5FwUDad+CenMI4N0HvQ/qJxOjSAXDJPt/qfjgVw5eTMv0dqdQL
         JbqIpkagIKioBOpTZq3TCIfUBH3GALRwzeidXmAIqIMQKuAtoQbAJIlgvx9M6FNnqq+T
         RiVJC1PJPCfXXtsPqmIOiNVFN1ySFYo5KJ6cEDBQkX4rSTEi0zch+HG6gNpqZqfVBsgE
         24rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699803088; x=1700407888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obRWuxKD/5egh3mY1N2w+/+ozAFkQxS5SU7QX1mWWT8=;
        b=sou7iUARRCjersmYe/5OAkJllN+VAR7G/YRRVP35ad12NwO88+pIKs0t54rM3itPZF
         r4HCQBjBGHFaQSyCwtvC86MNP0MUsCFTX71XowBF5WQbb3I2ss8frpGFJ4erdhoGtAm5
         7RPsHYoo0SGOg1iGoBwgyt5Tu+umQQehZzREBOjvdGBm1nb6ccOw/Dybff7M6w/G0xln
         pXB4XiKYHH77VNCHzkWqyd0z4e+RMHwFZXYknqYwrPTWAXr8ur6y2AsTb0Bmj97Hrvya
         1yTvto9k4qIhlaV+lJ0XGpsvykpApvTjACqqrl2AvZDANWiqZlmEidnUjFrvLvltOcnn
         PWRQ==
X-Gm-Message-State: AOJu0YyIaiB7FmL/1gqsUquRegffRD83r5jwQ78e811w1+pRx9r92pKi
        PmrRZcuj1IHWDLkstsJK10TPO4XEAMuROw==
X-Google-Smtp-Source: AGHT+IGfotbB3DLf0OlhknXd+Y4emP/hgPDqbDD6hpxGQBA7lZHIiQCoe/i6pTKYI+hJ02oSlQhd4A==
X-Received: by 2002:a05:6000:795:b0:32f:8b1c:106d with SMTP id bu21-20020a056000079500b0032f8b1c106dmr8285059wrb.10.1699803088077;
        Sun, 12 Nov 2023 07:31:28 -0800 (PST)
Received: from localhost.localdomain ([109.175.193.90])
        by smtp.gmail.com with ESMTPSA id fl14-20020a05600c0b8e00b004080f0376a0sm5287551wmb.42.2023.11.12.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 07:31:27 -0800 (PST)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Gross <markgross@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH] platform/x86: ideapad-laptop: Set max_brightness before using it
Date:   Sun, 12 Nov 2023 15:27:53 +0000
Message-ID: <20231112152851.17687-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_brightness would be used in ideapad_kbd_bl_brightness_get() before it was
set, causing ideapad_kbd_bl_brightness_get() to return -EINVAL sometimes

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index ac037540acfc..88eefccb6ed2 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1425,18 +1425,17 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 	if (WARN_ON(priv->kbd_bl.initialized))
 		return -EEXIST;
 
-	brightness = ideapad_kbd_bl_brightness_get(priv);
-	if (brightness < 0)
-		return brightness;
-
-	priv->kbd_bl.last_brightness = brightness;
-
 	if (ideapad_kbd_bl_check_tristate(priv->kbd_bl.type)) {
 		priv->kbd_bl.led.max_brightness = 2;
 	} else {
 		priv->kbd_bl.led.max_brightness = 1;
 	}
 
+	brightness = ideapad_kbd_bl_brightness_get(priv);
+	if (brightness < 0)
+		return brightness;
+
+	priv->kbd_bl.last_brightness = brightness;
 	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
 	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
 	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
-- 
2.42.0

