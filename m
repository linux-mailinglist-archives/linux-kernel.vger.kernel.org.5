Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D29753A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjGNMOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjGNMOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:14:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B900830C6;
        Fri, 14 Jul 2023 05:14:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so2322995a12.1;
        Fri, 14 Jul 2023 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689336889; x=1691928889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgPMyqhcYOSoB/wLOssO63qlIlM49Q140+nxqiBvG58=;
        b=EbmcQKgul6r57U77VkLKxO0Std3+UK3ldoAw+5il/pbmMcEIV1j+yevY/ZXv9VkR1J
         +/4YKAtOae75xN9J3tA3yU6G/kVO8Gp0bFwl5dIJuAwF2wZIh3TyV4U7YEdginHL/7Wb
         7Q1POHwuTeLeqtDaHV/M3Jf86N/52phGiATyqOFX3N/F+/oJdH8fEQuZ8P4tssx7VF0i
         cnKyIvsUWZ8cnnyPsUwLjS0mxRidx3JCST4tNTSARsNIg+Uq4qVposX3W9wSB2mTqIYb
         deDgxSM8kXx180pIPlKeKPAAvQEkHfxRwlsp0RxiOIOL/chzdSVfhdoEG8qejnhK4qJg
         EGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689336889; x=1691928889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgPMyqhcYOSoB/wLOssO63qlIlM49Q140+nxqiBvG58=;
        b=J4m0ASrhAdtqOWC6961OqdEcxQowHTt9QXvx0HHbSuvhn9IYW5OcOBuzXbZ6c0NxlV
         aKrx/enIQwN+7KRk7ugmf+P3YeTQuXaWGFLQ95VYFWRj/lnmdq1kmWoTomHShvOQrKV/
         YYiV2ZgFVcA+McNU8TX9fjhrsydLnWgdez8uqVebnXqRy4satd3Anx1jzVTkaQC0f5QK
         6h2s2+8jIjaT/0EwQsvA+sFw/zotM/7ocluprpYdfi/jKk3UDxMkxgApizievSljDlEB
         O6qpWMiwzFPle7LwSuD6L6ORnzrZLg63HSO69xw3d6o2ei4OExf+Ml0nFWcRtCBF9tm1
         PvtA==
X-Gm-Message-State: ABy/qLaHEic7zGGanZgnK7Y6qDVw4Iz3WrtPcEdPFjNkrGkR5an0zAW3
        CIn8xsx0leEvs9FcgHTbPxg=
X-Google-Smtp-Source: APBJJlGCZk5eIAzsAIRe5sakyckPhJ0aqKFTBus5ia20xD48WrEFzxV5rsu/e+vLMLzskRlnKNWdwQ==
X-Received: by 2002:a50:fa98:0:b0:51e:4bc7:3976 with SMTP id w24-20020a50fa98000000b0051e4bc73976mr5022133edr.10.1689336888953;
        Fri, 14 Jul 2023 05:14:48 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-105.multi.internet.cyfrowypolsat.pl. [37.248.157.105])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7d150000000b0051e19bf66a4sm5680666edo.83.2023.07.14.05.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:14:48 -0700 (PDT)
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
Subject: [PATCH 2/2] backlight: lp855x: Catch errors when changing brightness
Date:   Fri, 14 Jul 2023 14:14:40 +0200
Message-ID: <20230714121440.7717-3-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714121440.7717-1-aweber.kernel@gmail.com>
References: <20230714121440.7717-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
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

The lp855x_bl_update_status function's return type is int, but
it always returns 0, without checking for the results of the
write_byte/pwm_ctrl functions called within.

Make this function return the return values of the functions it
calls, and modify the lp855x_pwm_ctrl function to return errors.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/video/backlight/lp855x_bl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 349ec324bc1e..61a7f45bfad8 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -217,7 +217,7 @@ static int lp855x_configure(struct lp855x *lp)
 	return ret;
 }
 
-static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
+static int lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
 	struct pwm_state state;
 
@@ -234,23 +234,26 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 	state.duty_cycle = div_u64(br * state.period, max_br);
 	state.enabled = state.duty_cycle;
 
-	pwm_apply_state(lp->pwm, &state);
+	return pwm_apply_state(lp->pwm, &state);
 }
 
 static int lp855x_bl_update_status(struct backlight_device *bl)
 {
 	struct lp855x *lp = bl_get_data(bl);
 	int brightness = bl->props.brightness;
+	int ret;
 
 	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
 		brightness = 0;
 
 	if (lp->mode == PWM_BASED)
-		lp855x_pwm_ctrl(lp, brightness, bl->props.max_brightness);
+		ret = lp855x_pwm_ctrl(lp, brightness,
+				      bl->props.max_brightness);
 	else if (lp->mode == REGISTER_BASED)
-		lp855x_write_byte(lp, lp->cfg->reg_brightness, (u8)brightness);
+		ret = lp855x_write_byte(lp, lp->cfg->reg_brightness,
+					(u8)brightness);
 
-	return 0;
+	return ret;
 }
 
 static const struct backlight_ops lp855x_bl_ops = {
-- 
2.41.0

