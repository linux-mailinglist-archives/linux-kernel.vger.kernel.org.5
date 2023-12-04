Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A37802BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 07:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjLDGks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 01:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 01:40:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D859FA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 22:40:52 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54cae99a48aso1659712a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 22:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701672050; x=1702276850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDfeXHBgAfFsS3kz+9ALH+0KcxsECsx+6opLECVdRcU=;
        b=kT0XINOmvgBDksKEXL3ZbnH6i4Mo7ZuB5LPyvoK8qZj14lim91ACJ38XQLLMAKJJd5
         AgT69VEugM5QZtqYK3cV0NvCTpeV0gTZqldj3TBRIDue1frC0xcRDhmqK2ceNwHP8YFK
         +heonD+why8J5XTHPBhgHqw59zX/tJCd6f861kTeXcIQZLllad74SDtkorYaxSmf/08A
         ltWD5E6IH4FgXkeDAHDptSSXT7Q6EpV6bDS6L16it3xa/fKDUx653bWTY96d8pgvlPWt
         y8Q/uwume5rwmlSaNDjI7i+G6AM6COKmHRJYUQn01ACZaOEdRAM9b5kaob9JMlulSG2Z
         lonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701672050; x=1702276850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDfeXHBgAfFsS3kz+9ALH+0KcxsECsx+6opLECVdRcU=;
        b=IR0os6Nd0ntD89hq+9+SFeP4KY+sjIRAWfXtRVN0Pt3wv9t6hUS8WAuZJAKYVweU60
         VrEF9w6p1eulkHinx6m0H26aaIhoDmDuD/qYcDy0Ou6Akc78qKs5ejDmP8qRJfBtYc6k
         cY9RHvKhy6YPCitcroC3RF22kOQqnF1nJsykcylvkH/R/98F7EL1pW+wF3yvZGItrW8m
         CXTWUcAYf/tdolNQCPqAxZl/LTqGPrEa1+SYazET3n5AuWOIWW5eveWNQvXpIdqCd5Fu
         lxn//sdQ3VhAUoNDbH7DdOGVyQ0g5pKf4mPbybegbIu8rVWM+8StP0rUBSOrkbxTQgUh
         nk6A==
X-Gm-Message-State: AOJu0YzdwczAVGnSVgtEx+qU3XX/YT1W+A518WizIJM117NcVjYoeLCw
        1ics5zntJWtgm0mn5yZZYF0=
X-Google-Smtp-Source: AGHT+IF4bB47Cu4bUc1C6sMsav97IbM6BVHB259v+ojEgBHNZx+1daFPbEu6TS3ZAfWM6UFJiyw/dQ==
X-Received: by 2002:aa7:da04:0:b0:54b:38f:7263 with SMTP id r4-20020aa7da04000000b0054b038f7263mr5237868eds.8.1701672050227;
        Sun, 03 Dec 2023 22:40:50 -0800 (PST)
Received: from localhost.lan (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id eh4-20020a0564020f8400b0054c9b0bd576sm1998754edb.26.2023.12.03.22.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 22:40:50 -0800 (PST)
From:   =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>,
        zboszormenyi@sicom.com,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>
Subject: [PATCH v2] egalax_ts_serial: Fix potential buffer overflow
Date:   Mon,  4 Dec 2023 07:40:47 +0100
Message-ID: <20231204064047.158514-1-zboszor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c825b030-1520-426e-a6ad-7df0c276b3ea@gmail.com>
References: <c825b030-1520-426e-a6ad-7df0c276b3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase phys[] array size to 40 bytes to avoid
this warning:

  CC [M]  drivers/input/touchscreen/egalax_ts_serial.o
drivers/input/touchscreen/egalax_ts_serial.c: In function ‘egalax_connect’:
drivers/input/touchscreen/egalax_ts_serial.c:112:21: warning: ‘/input0’ directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
  112 |                  "%s/input0", serio->phys);
      |                     ^~~~~~~
drivers/input/touchscreen/egalax_ts_serial.c:111:9: note: ‘snprintf’ output between 8 and 39 bytes into a destination of size 32
  111 |         snprintf(egalax->phys, sizeof(egalax->phys),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  112 |                  "%s/input0", serio->phys);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~

Update my old (defunct) email addresses in passing.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311171716.uIQY5rT4-lkp@intel.com/
Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
---
 CREDITS                                      | 3 ++-
 drivers/input/touchscreen/egalax_ts_serial.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index f33a33fd2371..5efccb40d577 100644
--- a/CREDITS
+++ b/CREDITS
@@ -470,8 +470,9 @@ S: Montreal, Quebec
 S: Canada
 
 N: Zoltán Böszörményi
-E: zboszor@mail.externet.hu
+E: zboszor@gmail.com
 D: MTRR emulation with Cyrix style ARR registers, Athlon MTRR support
+D: eGalax serial touchscreen support
 
 N: John Boyd
 E: boyd@cis.ohio-state.edu
diff --git a/drivers/input/touchscreen/egalax_ts_serial.c b/drivers/input/touchscreen/egalax_ts_serial.c
index 375922d3a6d1..390b3a670bfa 100644
--- a/drivers/input/touchscreen/egalax_ts_serial.c
+++ b/drivers/input/touchscreen/egalax_ts_serial.c
@@ -2,7 +2,7 @@
 /*
  * EETI Egalax serial touchscreen driver
  *
- * Copyright (c) 2015 Zoltán Böszörményi <zboszor@pr.hu>
+ * Copyright (c) 2015 Zoltán Böszörményi <zboszor@gmail.com>
  *
  * based on the
  *
@@ -42,7 +42,7 @@ struct egalax {
 	struct serio *serio;
 	int idx;
 	u8 data[EGALAX_FORMAT_MAX_LENGTH];
-	char phys[32];
+	char phys[40];
 };
 
 static void egalax_process_data(struct egalax *egalax)
@@ -185,6 +185,6 @@ static struct serio_driver egalax_drv = {
 };
 module_serio_driver(egalax_drv);
 
-MODULE_AUTHOR("Zoltán Böszörményi <zboszor@pr.hu>");
+MODULE_AUTHOR("Zoltán Böszörményi <zboszor@gmail.com>");
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

