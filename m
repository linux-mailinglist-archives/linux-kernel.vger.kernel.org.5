Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A6753A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjGNMOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjGNMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:14:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB972D68;
        Fri, 14 Jul 2023 05:14:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7589b187so3133878e87.1;
        Fri, 14 Jul 2023 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689336887; x=1691928887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u06tgDOD7cwIlWOvnR6QjrDtX4w5Uq2Dumh06lblnLk=;
        b=ZizL2KNz/0ekwzdN2fp2PsVPMxigv2//r6fIw5YtSY1gfA26UnViwFAwKYTeWE+ry1
         J1mY/W0BMGlW8T0OqGzdODUNivKMJWVH4xzAVctXIIPNatG5gHyphQ4XsGzOmMM3TQBC
         QdkyetoY5N8aa96YceojRE2LJCSb7gkwLADV5FbwXaqGaO4PX9eqx0B+WLIZVyuJtwIB
         Yc5DwxgsZboK+aMDgrgpR3EWF3o5/yyd5r6Vn8zyPoCWEuZWK+M5R3q1Sw4iDOMZBK+M
         Re87sH+EYylefiUsfAgCRdm3rVXKnp6vmCtPT4dQGA0vDErYl53o1h4V0LTIYq4ymyO4
         SYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689336887; x=1691928887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u06tgDOD7cwIlWOvnR6QjrDtX4w5Uq2Dumh06lblnLk=;
        b=jHJTae3iZLrXOwXERUsmIAmR84BnxKTrXd0wEZMjyj3F6bPxND4TBGEjCl7QeqtU4G
         9nwWOd8cKv0cRRwXbEv2cGi727hk/eIp4JqBDuVMAiifyZTUi/2NAffsroQyCN65ex2w
         tpX2Q45P0lipIlfR9JzBJRla1yJJyr7Eau4XKqJlNFKc5OSK02ZNjfkSZ5f2PAk8gV8o
         8zHZuGVmiI/gUInKZYhDAlAtGx1xT+MnL+gOvkXSgrocSAWQjTTIJ+RT2WM1gMpE+fff
         k52n+jkZtdlMQxEmIxY3uWPsKR93Lb8cIQY++l5nLwRZdRwzWfWuChGdKQpoORJglJNc
         f3YA==
X-Gm-Message-State: ABy/qLYWmFxF9xbLmY70LZtD3Pwpddivr3jVB7uGAGhlq7ukiTOpGUwY
        wVuyHssEwOuU4jyUfoKiwuc=
X-Google-Smtp-Source: APBJJlGNPi8pSZ8rf/rWqB+YjLfzQrM1dD3D5TWqynTfLfRfWzSrKRfBIO1TOT36Zd5dZpJAfkCn3g==
X-Received: by 2002:a19:5003:0:b0:4fc:3756:754e with SMTP id e3-20020a195003000000b004fc3756754emr3201988lfb.56.1689336887104;
        Fri, 14 Jul 2023 05:14:47 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-105.multi.internet.cyfrowypolsat.pl. [37.248.157.105])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7d150000000b0051e19bf66a4sm5680666edo.83.2023.07.14.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:14:46 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 1/2] backlight: lp855x: Initialize PWM state on first brightness change
Date:   Fri, 14 Jul 2023 14:14:39 +0200
Message-ID: <20230714121440.7717-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714121440.7717-1-aweber.kernel@gmail.com>
References: <20230714121440.7717-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Uwe Kleine-König[1], the changes introduced in
commit c1ff7da03e16 ("video: backlight: lp855x: Get PWM for PWM mode
during probe") caused the PWM state set up by the bootloader to be
re-set when the driver is probed. This differs from the behavior from
before that patch, where the PWM state would be initialized on the
first brightness change.

Fix this by moving the PWM state initialization into the PWM control
function. Add a new variable, needs_pwm_init, to the device info struct
to allow us to check whether we need the initialization, or whether it
has already been done.

[1] https://lore.kernel.org/lkml/20230614083953.e4kkweddjz7wztby@pengutronix.de/

Fixes: c1ff7da03e16 ("video: backlight: lp855x: Get PWM for PWM mode during probe")
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/video/backlight/lp855x_bl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 1c9e921bca14..349ec324bc1e 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -71,6 +71,7 @@ struct lp855x {
 	struct device *dev;
 	struct lp855x_platform_data *pdata;
 	struct pwm_device *pwm;
+	bool needs_pwm_init;
 	struct regulator *supply;	/* regulator for VDD input */
 	struct regulator *enable;	/* regulator for EN/VDDIO input */
 };
@@ -220,7 +221,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
 	struct pwm_state state;
 
-	pwm_get_state(lp->pwm, &state);
+	if (lp->needs_pwm_init) {
+		pwm_init_state(lp->pwm, &state);
+		/* Legacy platform data compatibility */
+		if (lp->pdata->period_ns > 0)
+			state.period = lp->pdata->period_ns;
+		lp->needs_pwm_init = false;
+	} else {
+		pwm_get_state(lp->pwm, &state);
+	}
 
 	state.duty_cycle = div_u64(br * state.period, max_br);
 	state.enabled = state.duty_cycle;
@@ -387,7 +396,6 @@ static int lp855x_probe(struct i2c_client *cl)
 	const struct i2c_device_id *id = i2c_client_get_device_id(cl);
 	const struct acpi_device_id *acpi_id = NULL;
 	struct device *dev = &cl->dev;
-	struct pwm_state pwmstate;
 	struct lp855x *lp;
 	int ret;
 
@@ -470,15 +478,11 @@ static int lp855x_probe(struct i2c_client *cl)
 		else
 			return dev_err_probe(dev, ret, "getting PWM\n");
 
+		lp->needs_pwm_init = false;
 		lp->mode = REGISTER_BASED;
 		dev_dbg(dev, "mode: register based\n");
 	} else {
-		pwm_init_state(lp->pwm, &pwmstate);
-		/* Legacy platform data compatibility */
-		if (lp->pdata->period_ns > 0)
-			pwmstate.period = lp->pdata->period_ns;
-		pwm_apply_state(lp->pwm, &pwmstate);
-
+		lp->needs_pwm_init = true;
 		lp->mode = PWM_BASED;
 		dev_dbg(dev, "mode: PWM based\n");
 	}
-- 
2.41.0

