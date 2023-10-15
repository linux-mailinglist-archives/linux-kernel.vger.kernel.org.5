Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518C87C9B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjJOUOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjJOUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:14:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC4B7;
        Sun, 15 Oct 2023 13:14:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9becde9ea7bso249726066b.0;
        Sun, 15 Oct 2023 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697400869; x=1698005669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E01GM7WTt8O9z43gWlZ2wCLn5WJWwuOIiG1N7ZnbIAk=;
        b=c2N+if2iQ4A/3YH69wzSvgcoal4R6ai82gHhjekJ3oJo8L6ZofUp0K07vkNtU1U+zi
         x8onL0K9Q2gJwOA1U8smxomo27CRtD9R+A4fjcoDzFmvLIdrdwqO5BCIGVQxpVtUV1yq
         eqBySc0mWyoHG1EZiPq1qk5QsnlCNLJXzUZ5/h1AMOTg0ji5o8/415prED+vxyOqseAr
         r7BzaAvcL4wamKsZ4bKRm/4TnbNoIK1WBmvTYm1BJX4dQafMtb5t+ui+IlKdMITx7KIX
         4K1I5IpX1bWNKdsjhAT7lH/739eWwHTpwI6ET5Bj5hCsnE9tiwm3H7zXWFBVhhehUTgN
         8Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697400869; x=1698005669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E01GM7WTt8O9z43gWlZ2wCLn5WJWwuOIiG1N7ZnbIAk=;
        b=ct0TZQadAgZPSU7tL7o90g13fSKOZotnNJwkzuY7XmhoX7KgT9cO9NFxyHKlVZA/cP
         jfRfzvBdEPmmA6ecGS2Jdp3xTZZntO9CQ/PgpJU9+FddGZdXhKc72RWhunyzTWA1e42N
         LqHonGphflLclFOW4QmOrdUM8msuAUiL0Q9ShXsCFplFeJUL2ELWYgB8G9WOiQGaGbY9
         jYy35DKPzrw4uDmPAkpROd+tNcPDacpiDJGVBYYWAYGh6XP7TAyFciFo591CHBOL4Mi5
         JgTewcgrbVr64pHB2ZH166+kHLzBP91xQEYnZ+9cCWlCwn7ambq8ys3QAy+8WVt43IQ1
         8Hsg==
X-Gm-Message-State: AOJu0YylmC5192IW/fegEiQ8+/cm0HqkXhIUtGz6h3Upm+ZWMP4yV8dY
        dSBpEiRxDaYGehXNRzdaaGCqar75AhayWPQ=
X-Google-Smtp-Source: AGHT+IEzZG/3pGHapm1wmqB24H+D+DFxbgwenYhV7bi/4YFWFECn87yHreYV9h1q7mMoZz2ScF1V+w==
X-Received: by 2002:a17:907:1c10:b0:9a5:7dec:fab9 with SMTP id nc16-20020a1709071c1000b009a57decfab9mr5752145ejc.9.1697400869239;
        Sun, 15 Oct 2023 13:14:29 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.157.6])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906234a00b009ae587ce133sm2721766eja.188.2023.10.15.13.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:14:28 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Staging: sm750fb: Rename displayControlAdjust_SM750E
Date:   Sun, 15 Oct 2023 23:12:34 +0300
Message-ID: <16a9ad33ef67993482da0d350d7239aee3f0dd22.1697400022.git.anonolitunya@gmail.com>
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

Rename function displayControlAdjust_SM750E to
display_control_adjust_SM750E.This follows snakecase naming convention
and ensures consistent naming style throughout the file.Issue by
checkpatch.

Mutes the following error:
CHECK:Avoid CamelCase: <displayControlAdjust_SM750E>

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index e00a6cb31947..8708995f676c 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -14,8 +14,8 @@
  * in bit 29:27 of Display Control register.
  */
 static unsigned long
-displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
-			     unsigned long dispControl)
+display_control_adjust_SM750LE(struct mode_parameter *pModeParam,
+			       unsigned long dispControl)
 {
 	unsigned long x, y;
 
@@ -125,7 +125,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
 
 		if (sm750_get_chip_type() == SM750LE) {
-			displayControlAdjust_SM750LE(pModeParam, tmp);
+			display_control_adjust_SM750LE(pModeParam, tmp);
 		} else {
 			reg = peek32(CRT_DISPLAY_CTRL) &
 				~(DISPLAY_CTRL_VSYNC_PHASE |
-- 
2.42.0.345.gaab89be2eb

