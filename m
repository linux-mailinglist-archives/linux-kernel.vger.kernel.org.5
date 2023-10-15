Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36D7C9B53
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJOUP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjJOUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:15:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675CDE;
        Sun, 15 Oct 2023 13:15:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9bdf5829000so302795666b.0;
        Sun, 15 Oct 2023 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697400919; x=1698005719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7fHtR18EgBCEQREVmue4LTAycmdBOG4IGNb7hGTz+I=;
        b=nATkoitibM/AAgt6s/fIXj6InUHVPS7SYtFBhUrOcMJ1Afhxj9qw3jZrRmueEg6HIG
         RgNN7nIr/NP82igIasOSKjZ7iuhznXr2to4FEdYGZo4yEPjhTtc+aovOzGRQASwYEjct
         h625nqZPeZE76f3uk9t3ZzRYMM2V2jJr1Y0mq6U+1b2HZXevvTClLLgZHRx5mV60eVCd
         0ErAme9X97NE6uJoh7kAL7QdfWMJyCu489pr2Pu+vK2VSY9qKF1Qfxv/Z0qpx1DhkwJx
         q3ZGqPwR1GXL4KvV73iJyP84KORSbZzkQCimB2b+znQ6R0Qn6vy6uBvGM7+OzIEjHmnQ
         sQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697400919; x=1698005719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7fHtR18EgBCEQREVmue4LTAycmdBOG4IGNb7hGTz+I=;
        b=fKP3fvy1NfOEe2WH4mlN8qJiubLaMt9TA/Wwy+bgu366gqbS9+FAHzhDU97ekEtGeM
         +XassxNX5IMKKw7bDzQ0v24ckO7NTAEv9pMwA/IotIWBjs8YT4pVJnbAg8EEuWe3jyyB
         Of4fsng4xvJIHZwjzLGaBv7iXFqWwXgR1IYo+mMWQnZ/wUiaSTJhs5HP6z5ndSctpYD5
         OFKAfrQruC84VshLObtGvHjAEZ8EpAnXYWM3juFj8+12rOF+nkHSxclOrF2prU1iXDyB
         Vuo4u8LVHVQpElRgOAguBGde9aPdfhdHHIIzpBFGxyePROGaytWGCEdBEitcgv6dzmvz
         q1Kg==
X-Gm-Message-State: AOJu0Yw1dITniLsjliSNkKNzC0ZKYvfrdPfyVhdIY6lT0zL2IQD0Q7Df
        KGqvU8GjsooWuDqiEP1eIA==
X-Google-Smtp-Source: AGHT+IFcUmakawG4mi5/cnj+QCu8NJpy46yrrOtg/488uT9MrdczN+fnaVgKvaEaH9uw+uTcrwKvww==
X-Received: by 2002:a17:907:31c2:b0:9be:2b53:ac4d with SMTP id xf2-20020a17090731c200b009be2b53ac4dmr4493560ejb.74.1697400918792;
        Sun, 15 Oct 2023 13:15:18 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.157.6])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906234a00b009ae587ce133sm2721766eja.188.2023.10.15.13.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:15:18 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Staging: sm750fb: Rename displayControl
Date:   Sun, 15 Oct 2023 23:12:36 +0300
Message-ID: <596de9b4cf3483d872b1ba25e1b02194aec34bac.1697400022.git.anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <cover.1697400022.git.anonolitunya@gmail.com>
References: <cover.1697400022.git.anonolitunya@gmail.com>
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

Rename variable displayControl to display_control. This follows
snakecase naming convention and ensures consistent naming style
throughout the file.Issue by checkpatch.

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

