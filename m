Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AFF7CB470
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjJPUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjJPUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:16:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876FD9;
        Mon, 16 Oct 2023 13:16:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a6190af24aso819931866b.0;
        Mon, 16 Oct 2023 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487385; x=1698092185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUYZDjo3nNnCe2435X1iMxICDdnMM/czWpG4K+g4SPM=;
        b=KLfIoPOCXOdfC7FxqBDgJfUvb4Dej6DHNXzpUgj17qx3nBXXHCZW7+nhqkRZbkUczc
         a6JTOmkOzTs2Z034Ci86u1fVyQ1T8hPiVl4SGrUgJzZy+qBDKsmp+rs70KhF/U5XMrdq
         FM4XC/fkEfqgAewQwwxQoB2REvVpsUm+1SbDxalw26Jzs/MdRSKcx04woH7T7Ldxrw0r
         P+y/I2EwTAqEqu4+SdKQB52WVeluaSezNsjtdHGvg7UvNGGrHmNV7HJY6jG/1FXpSgbC
         rI389k89MeeBwTwor/+yftSLrbgrQd52IHKOsBkOVVWon5vL7MD/duGvxkK1kURdhfv+
         0yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487385; x=1698092185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUYZDjo3nNnCe2435X1iMxICDdnMM/czWpG4K+g4SPM=;
        b=mEYGpMSAhJB2MwOdCIyuVzFZf1LIeHkD9bNtgWiAmZ2nyXMIG3ycGyBM44CVcLlzm9
         zT2UDFlylvE0wyOcIUeJGLDtftJ5lYQnSQgfDI+hXCkJzl5P3HkQ2Te++SK4O195I6+5
         ckmblWSfWfmQDEY7AXZCdndMJVysyf8UoKNAUESMpUkdb8CZvWApipqfOvm5LSv8DCxh
         ueaN5/kQwWqnWEkm8AyJhSbQ+DLgJhOV7G7YwiqHfYIyDhoUF384V6sgxCfqgsePnL/Q
         BE9lia1kJXy0LE4Wea/1w1HJHzR6Z8EYRWwls4z/gn/41ECCKufe+jYJH4C8wMk6121Q
         iRlw==
X-Gm-Message-State: AOJu0YzOwIECwLJ3L+uUQSe21hKhtWk8TYUbcJ9yGGB9zEOw02+blSHs
        kB5wJYqCWQENgh11WyBu0wY1G62x7QfPpT4=
X-Google-Smtp-Source: AGHT+IHGTayWdsFIKX5DIfZ4bt0TvbqwGILNLrrx0y4VXUYHr2i1Gsj6APfHOHu5gHzlVaup6NOEcA==
X-Received: by 2002:a17:907:3f94:b0:9b9:facb:d950 with SMTP id hr20-20020a1709073f9400b009b9facbd950mr91174ejc.72.1697487385170;
        Mon, 16 Oct 2023 13:16:25 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090657da00b009b97521b58bsm4606055ejr.39.2023.10.16.13.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:16:24 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Staging: sm750fb: Rename ddk750_setModeTiming
Date:   Mon, 16 Oct 2023 23:14:12 +0300
Message-ID: <20231016201434.7880-6-anonolitunya@gmail.com>
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

Rename function ddk750_setModeTiming to ddk750_set_mode_timing. This
patch affects three files as the function is imported to other external
files.

This follows snakecase naming convention and ensures a consistent naming
style throughout the file. Issue found by checkpatch.

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

