Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD79B7CD78C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJRJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJRJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:08:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A493;
        Wed, 18 Oct 2023 02:08:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso3160975e9.3;
        Wed, 18 Oct 2023 02:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697620117; x=1698224917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzwyhcJNZa6arJQKPZmLNcj0YJDSwAR/dJyY9R0VHn8=;
        b=TamCD6XMq2DDPU1wZxN8Ka/0Z5GNyRX0tZ5lu99EttXa1HtXFPJpBykPgaelj4ShEr
         zKGo9/v9VqNmu9A1GQWG2a9d4uuBH42r3RSn6sDLI3UEezXaqIdF9WXF1SfJXAKZ1ev0
         yJiPSKsdfj3wQnGXzSFOMMNOJPXt6gGeWM4b9PWbEnvZbYyB5M+ei1QuSj5V8gEPuxZD
         BudfoXUIR0rm3w0cr1EftJo7OYnxKC8PEILPHHQG/6GoaVizmqBZraBSu8n1gH3hXYmx
         yU5nLgzMrJxxe78f4tcjw7YIqOaQdPpOeRFdTb8d4VPd4qqxtjGgnqno5ldrY1qanVmn
         rpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620117; x=1698224917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzwyhcJNZa6arJQKPZmLNcj0YJDSwAR/dJyY9R0VHn8=;
        b=GRSy+T+uTZi7NlDCXOqtPHor675NkdX9NYBGqLvTuzmw0Q+wLg6IVCTMIVudia13aC
         l4qmZ91tiSQgfVeP3bCDd2EY7X9JKLWoD1aK+2guLDEKDp0Wsldz5Qk32t8w+rlbgTB3
         UrePA1b+3uESm/K7aRDK1zyzd8ug36wVJqxOslN71Yg55+zRVE/Wg7RVe7zrjnlYcaP5
         trvytFJ1syoS17QeFUBz37a1QLFdZsVgH94JaGrpRp3FQE+ED9DKhiOn3aCKiGP9eSUp
         zzUmg1zHKtvVQaGIEGb5eLJPxpJTqpj89/e0HjpPn6Z/mi+wcsAhMjUK/QhGha0ViXVD
         JVsw==
X-Gm-Message-State: AOJu0YzDHGS7ojUeaSYLkUWxQPvCDX7d0YsbtLX+6pRg08DgZXT5bfTK
        8ac++AL3PGqit0o/329U8g==
X-Google-Smtp-Source: AGHT+IE8Jb8g3iq2lM11tjT+znYj1cfMj3eJY/zNAnipfGZEi/tRU8f65xrzYMXswghDqHtMCAOCMA==
X-Received: by 2002:a05:600c:444c:b0:401:b2c7:34a4 with SMTP id v12-20020a05600c444c00b00401b2c734a4mr3718752wmn.11.1697620116890;
        Wed, 18 Oct 2023 02:08:36 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.0.227])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b003fee6e170f9sm1107397wmi.45.2023.10.18.02.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:08:36 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        andi.shyti@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: sm750fb: Remove unused return value in display_control_adjust_sm750le()
Date:   Wed, 18 Oct 2023 12:07:35 +0300
Message-ID: <3997a009dff211fe4865644ecfb77406328a6607.1697619623.git.anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <cover.1697619623.git.anonolitunya@gmail.com>
References: <cover.1697619623.git.anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifies the return type of display_control_adjust_sm750le()
to void from unsigned long as the return value is being ignored in
all subsequent function calls.

This improves code readability and maintainability.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index bcdd291d25c9..83ace6cc9583 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -13,7 +13,7 @@
  * HW only supports 7 predefined pixel clocks, and clock select is
  * in bit 29:27 of Display Control register.
  */
-static unsigned long
+static void
 display_control_adjust_sm750le(struct mode_parameter *mode_param,
 			       unsigned long disp_control)
 {
@@ -70,8 +70,6 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
 	disp_control |= DISPLAY_CTRL_CLOCK_PHASE;
 
 	poke32(CRT_DISPLAY_CTRL, disp_control);
-
-	return disp_control;
 }
 
 /* only timing related registers will be  programed */
-- 
2.42.0.345.gaab89be2eb

