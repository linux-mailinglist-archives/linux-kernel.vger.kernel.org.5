Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87DE7CB46B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjJPUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjJPUQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:16:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C8EB;
        Mon, 16 Oct 2023 13:16:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso819898666b.0;
        Mon, 16 Oct 2023 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487370; x=1698092170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2er7JB8jIkXQe34e+6rn2A2O3NXCbB1tG8VCC+j1DPg=;
        b=LC9UVfJHGun1C3jRgm0wxqKit8dRgwQu5lt6Mm/+310j7dI3fNyjWYvKke/ojYw8B3
         nxq8rp4nSpkLnguw8eC7bwujva4PsQdyhU3pQdvnAJmMTXI3xpZH619a1QNYoNdlu7m0
         vgSHwoxZjZLc6EwY7+Bev6jArkzWG+gf1jUTyuajbHgze9nIItXHhFl0Ps/XrRl4nH7t
         TH4YE1AWD6LvUEJZsiCnn6AqK1IrZR1f3fC4DvOjVP6Mf8N6NpzRK05+9Y3yR6KCkCRf
         h+k837QwFeHiPFX8hZRiDI7BkH5swPl96CyQfgUJPgrN7FlGcZlF13M7kd7g9679imAt
         hDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487370; x=1698092170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2er7JB8jIkXQe34e+6rn2A2O3NXCbB1tG8VCC+j1DPg=;
        b=ii43f2TVWlLplhMVLVFzkzUzEI+ChttpCmTM3MEP9yjeuO1C8eT6PqsIo//NCzVt18
         R2GaU1XMouDpVN0VjK0gKMo/NJYklNwDzQXb4kitDCeuL0L8PwGLRZ4D50uiDedYIIno
         AeGM45/ZRNFd2Icqj0+3Om3yoNd63JwhkqcJIPqFCtQJaPlYdzndBdI6E+DF38FAp1Oo
         OBcNNmEiApG4IOJ8Hzfw/IFQ/J+RUlPvmTE6+QTB05pJmsy5Qwkb4WXmq3q0PdL8vM67
         HZDyofI9cj2agPgmxO6mUf7OaQVleXaYt51y1ZLDWd9KZ7Vfp3/5E0NMVXj4FqujgZtG
         7CeA==
X-Gm-Message-State: AOJu0YwCDm+n1nuUt4idvM5EGZqqrm97QASTp4s38x/5WACUxa3zb8EI
        cuJgjCGKtjkG8DIrmWLh5g==
X-Google-Smtp-Source: AGHT+IHWvvumzCca8IrLGKyo/ug4+NUAAWfsvFhVqwVrLIkbo4M6KjuUc+maFc1OrBWdSkCANVGyjg==
X-Received: by 2002:a17:906:ee8a:b0:9ad:c763:bc7a with SMTP id wt10-20020a170906ee8a00b009adc763bc7amr117253ejb.23.1697487370147;
        Mon, 16 Oct 2023 13:16:10 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090657da00b009b97521b58bsm4606055ejr.39.2023.10.16.13.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:16:09 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] Staging: sm750fb: Rename dispControl
Date:   Mon, 16 Oct 2023 23:14:10 +0300
Message-ID: <20231016201434.7880-4-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <20231016201434.7880-1-anonolitunya@gmail.com>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable dispControl to disp_control. This follows
snakecase naming convention and ensures a consistent naming style
throughout the file. Issue found by checkpatch.

Mutes the following checkpatch error:
CHECK: Avoid CamelCase: <dispControl>

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 431b273a347a..fc3db09de9ae 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -15,7 +15,7 @@
  */
 static unsigned long
 display_control_adjust_SM750LE(struct mode_parameter *mode_param,
-			       unsigned long dispControl)
+			       unsigned long disp_control)
 {
 	unsigned long x, y;
 
@@ -36,42 +36,42 @@ display_control_adjust_SM750LE(struct mode_parameter *mode_param,
 	       ((x - 1) & CRT_AUTO_CENTERING_BR_RIGHT_MASK));
 
 	/*
-	 * Assume common fields in dispControl have been properly set before
+	 * Assume common fields in disp_control have been properly set before
 	 * calling this function.
-	 * This function only sets the extra fields in dispControl.
+	 * This function only sets the extra fields in disp_control.
 	 */
 
 	/* Clear bit 29:27 of display control register */
-	dispControl &= ~CRT_DISPLAY_CTRL_CLK_MASK;
+	disp_control &= ~CRT_DISPLAY_CTRL_CLK_MASK;
 
 	/* Set bit 29:27 of display control register for the right clock */
 	/* Note that SM750LE only need to supported 7 resolutions. */
 	if (x == 800 && y == 600)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL41;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL41;
 	else if (x == 1024 && y == 768)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL65;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL65;
 	else if (x == 1152 && y == 864)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL80;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL80;
 	else if (x == 1280 && y == 768)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL80;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL80;
 	else if (x == 1280 && y == 720)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL74;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL74;
 	else if (x == 1280 && y == 960)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL108;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL108;
 	else if (x == 1280 && y == 1024)
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL108;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL108;
 	else /* default to VGA clock */
-		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL25;
+		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL25;
 
 	/* Set bit 25:24 of display controller */
-	dispControl |= (CRT_DISPLAY_CTRL_CRTSELECT | CRT_DISPLAY_CTRL_RGBBIT);
+	disp_control |= (CRT_DISPLAY_CTRL_CRTSELECT | CRT_DISPLAY_CTRL_RGBBIT);
 
 	/* Set bit 14 of display controller */
-	dispControl |= DISPLAY_CTRL_CLOCK_PHASE;
+	disp_control |= DISPLAY_CTRL_CLOCK_PHASE;
 
-	poke32(CRT_DISPLAY_CTRL, dispControl);
+	poke32(CRT_DISPLAY_CTRL, disp_control);
 
-	return dispControl;
+	return disp_control;
 }
 
 /* only timing related registers will be  programed */
-- 
2.42.0.345.gaab89be2eb

