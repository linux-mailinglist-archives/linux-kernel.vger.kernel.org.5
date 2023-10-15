Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB87C9B57
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjJOUPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjJOUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:15:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB2D9;
        Sun, 15 Oct 2023 13:15:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so4978647a12.2;
        Sun, 15 Oct 2023 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697400936; x=1698005736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh2e0sxZPUbHxzk4qSfOyASeBQgiUPXTS5/RpBzGDJ8=;
        b=QG3bX8KDkaNhiiMco09vlpY33T7XbLm68u0qMZshfZv70c7cMxruEpprLsmWnsiH3q
         Q4HmrGJcMMlAa76J7kpfTC9dr31DcGAjjbIFN6X4f7wIG4j/Q9Hxmtow03sC2QQsrDvL
         JzPSsmDZprVxjCK55EfcHiU3pklqtiReCQrc44rX9Osfc36B49F6UwxqnbWZtS0lBsQs
         h94EQIR88eijpcM9mBUcM2zKLIu3t4aHlHM9KhinQtfb1JAuqhbJj28DehM5gyeDE0iI
         j35iby58Oeq5FkCcfidxJ95NO3nQhOZVq/QjkWxFzYdaZRW0PT+hw52dQyu4lWrW3JWf
         i2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697400936; x=1698005736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh2e0sxZPUbHxzk4qSfOyASeBQgiUPXTS5/RpBzGDJ8=;
        b=iMGrtnHJsYEEVlUWOArBd1vgStUh56IPFaewWxJI74cOi6g4JP1rNQPE4KxwSs2URb
         czMO8D3xqFXQW4O/24v71bpxMt747jHVJ/PQ7p52qpbyxhPBaLMsZAXilkaGlTUAqMlT
         bLCPXVzbuhElU/jhTDi4A9cPPPxG/Ngdpv3kxL9Wri3gUCE228z3CSFQtNaAFIsdiLu6
         e3M1fKUd/Zo7hF+4W9U/ySvnO2+18IVGLrn9AogSvF4NDrNypSYlejnAQ9Tru8LMeVjg
         VKzR9BSy+tWTZxHjVg9J0Z1pu6GataPlmWT5p3TNe4ZAKN14SZw8QjjDhRYKsBh93suX
         zQXw==
X-Gm-Message-State: AOJu0Yxk9QsR9w4b+Ead1Zo5qSPDUptqH8xu2nLyLKowZcJoik/cqTJO
        IV5z6im+xqakq0XvR291gg==
X-Google-Smtp-Source: AGHT+IFqzTsU6PuT+EvGO/BJNuln/2IQzK8j3ikapXlYLlZLg5TqQn6SCwu5v+2ZILaHz6gL/ZAZew==
X-Received: by 2002:a17:907:6d2a:b0:9bd:d1e8:57f1 with SMTP id sa42-20020a1709076d2a00b009bdd1e857f1mr5290693ejc.50.1697400935496;
        Sun, 15 Oct 2023 13:15:35 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.157.6])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906234a00b009ae587ce133sm2721766eja.188.2023.10.15.13.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:15:35 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Staging: sm750fb: Rename ddk750_setModeTiming
Date:   Sun, 15 Oct 2023 23:12:38 +0300
Message-ID: <a74a7782b02275a19e7002581855ec23f70b83fa.1697400022.git.anonolitunya@gmail.com>
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

Rename function ddk750_setModeTiming to ddk750_set_mode_timing.This
patch affects three files as the function is imported to other external
files.

Renaming the function ensures snakecase naming convention is followed
thus enabling consistent naming style throughout.Issue by checkpatch.

Mutes the following checkpatch error:
CHECK:Avoid CamelCase: <ddk750_setModeTiming>

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 2 +-
 drivers/staging/sm750fb/ddk750_mode.h | 2 +-
 drivers/staging/sm750fb/sm750_hw.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index e901855fa9b6..f3f354831617 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -207,7 +207,7 @@ static int program_mode_registers(struct mode_parameter *mode_param,
 	return ret;
 }
 
-int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock)
+int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
 {
 	struct pll_value pll;
 
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 2df78a0937b2..1b70885f85e5 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -33,5 +33,5 @@ struct mode_parameter {
 	enum spolarity clock_phase_polarity;
 };
 
-int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock);
+int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 71247eaf26ee..4bc89218c11c 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -305,7 +305,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		clock = SECONDARY_PLL;
 
 	pr_debug("Request pixel clock = %lu\n", modparm.pixel_clock);
-	ret = ddk750_setModeTiming(&modparm, clock);
+	ret = ddk750_set_mode_timing(&modparm, clock);
 	if (ret) {
 		pr_err("Set mode timing failed\n");
 		goto exit;
-- 
2.42.0.345.gaab89be2eb

