Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8F775DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjHILms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjHILmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:42:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709721FD8;
        Wed,  9 Aug 2023 04:42:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so41039105e9.3;
        Wed, 09 Aug 2023 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581363; x=1692186163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7b0FNEltUgJre7QUi/LlASENLPDFiW1RiJtPuEPcdsk=;
        b=H8bxlFuEJAgtd/W8tH75enhERPJK8n1rNmG7P1oaBuUdwMEbeVDeV8AFbviUIsf0mH
         L79na/TmkmFu1gjUUH/sP0SO9j8XQgOew6Z5h6lX7S+NBciQ7/gtGkCqB7U7GnJbSbLU
         JX0V+S4/Vi/pmNYsA+UYUns4yF6HK/6ur3f/YSJaCNPeb0rICJhAoFbMVr8nFXdF8+b7
         4Zrpng/iX6JbBvRzpVXE33vXPPaUkp92fxJmqaesWhXDHRYQZsfIWz5+LpKvTbnUonTG
         LxudexIvdvdxUUgNJMeLVtk0I4MGi0sxootYT7F96hgSLWBFws8YM5Psla7H88O4YARw
         JtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581363; x=1692186163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7b0FNEltUgJre7QUi/LlASENLPDFiW1RiJtPuEPcdsk=;
        b=bNAUyb/h/kDGRX+J3+NJZCXJe5NcQzTxzq7G0DjLxlYgu/Z6nxaj1Buihmgctz2SSL
         BGsSMpIe/BPTVtagZgLwjIqUnqiecAbUClSb6S2hvK3YrQB54mHTzsyDTq3P+FmJGqgr
         p3HNj8CPIHOP1v7Yy/3O6H430FjBAzPTDbaXemjd0/HuO3EqnsCIQJEONOY0rJwpbsdx
         C9ItNYhrYCuZl/73Jn29AKPcmbNDMrnKvo3qeaRIYVMj1O/hXmjFCkKGtRUTW89YBrxK
         i47Hv77DVT50c18LfIiyWJexztALrTl8TirOJklrM+oNtbhdmiSxc9VsUdayNaufJV/C
         z/tA==
X-Gm-Message-State: AOJu0Yw/J2iA/U/tFMwjxbGdlz4jmiY+OtC4uokuDvS36EyASVprAu1S
        lB4i3a5ZQvUa9bAtI+yJh6w=
X-Google-Smtp-Source: AGHT+IEPX6iqfJAofbYRgtwhfoVTbBfQv99Q0SLYNlvol7nryGa7eR81jSaBuhS6K5USsGMESw/AOQ==
X-Received: by 2002:a1c:7213:0:b0:3fe:179d:d42e with SMTP id n19-20020a1c7213000000b003fe179dd42emr1932458wmc.23.1691581362742;
        Wed, 09 Aug 2023 04:42:42 -0700 (PDT)
Received: from tablet.my.domain (ip-5-172-235-199.multi.internet.cyfrowypolsat.pl. [5.172.235.199])
        by smtp.gmail.com with ESMTPSA id z4-20020a1c4c04000000b003fe11148055sm1727938wmf.27.2023.08.09.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:42:42 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] backlight: lp855x: Drop ret variable in brightness change function
Date:   Wed,  9 Aug 2023 13:42:16 +0200
Message-ID: <20230809114216.4078-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning:

drivers/video/backlight/lp855x_bl.c:252:7: warning: variable 'ret' is used
uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
Fixes: 5145531be5fb ("backlight: lp855x: Catch errors when changing brightness")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308091728.NEJhgUPP-lkp@intel.com/
---
 drivers/video/backlight/lp855x_bl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 61a7f45bfad8..da1f124db69c 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -241,19 +241,17 @@ static int lp855x_bl_update_status(struct backlight_device *bl)
 {
 	struct lp855x *lp = bl_get_data(bl);
 	int brightness = bl->props.brightness;
-	int ret;
 
 	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
 		brightness = 0;
 
 	if (lp->mode == PWM_BASED)
-		ret = lp855x_pwm_ctrl(lp, brightness,
+		return lp855x_pwm_ctrl(lp, brightness,
 				      bl->props.max_brightness);
 	else if (lp->mode == REGISTER_BASED)
-		ret = lp855x_write_byte(lp, lp->cfg->reg_brightness,
+		return lp855x_write_byte(lp, lp->cfg->reg_brightness,
 					(u8)brightness);
-
-	return ret;
+	return -EINVAL;
 }
 
 static const struct backlight_ops lp855x_bl_ops = {

base-commit: 21ef7b1e17d039053edaeaf41142423810572741
-- 
2.41.0

