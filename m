Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8752802224
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjLCJF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjLCJFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:05:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E0CD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:05:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54bfd4546fbso4189579a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 01:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701594330; x=1702199130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX+3yDbq4orl3F1IwroT1JgXwfqK8BBsS1e+lWobZFk=;
        b=Yd5Z3VS5yBqdmAsMdzEi9nmZ/0MbTU0C/BSHbpZdQW/iU9rEi+mYIPpp8H/3dL7zJ/
         AFZPEcx8WJx1YzLf6854viWaMEtDbwv4Pmj/uh7ce/aTR6SRZmZGqX8bxADEiy+Lfs5m
         1a+kP8sQi7mvtD+LsiXNeDXLzhEfcUYbprmAR40cG3d4YWhu0wWsCiR+jL3/BJUhFQ8K
         0s7EC0PmTJdhBjQnER2tvQQxCKNv/U0+DUBrXz+GldCycw0z2RQWGNNi43xhtAzg51nf
         v9OxN1zLyB4Zy6DYt5DtRt/JN/R1yRVO8osMJFiffitNg9MQJ0pMoUdDO+jIRe44XsLK
         eRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701594330; x=1702199130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX+3yDbq4orl3F1IwroT1JgXwfqK8BBsS1e+lWobZFk=;
        b=wqC9RB/ScKnyeHzpRcG2wRbzqkP1UNnOJ9PVTC20wTTDUGjIPafZ7AXIimtIHMHPfK
         kd8h9SRU7iV582lG2GoUNd9+CPFF+MmVwATbyy97sZaXlIGXRXf8f6TAqxTCxQU+lxQ4
         oLaCTt0p5Dnf+tdxYdz3GJyu2KIVKvRaYvEpFJ9J/onAK5hzIwL0JjggBjCarFGFXIXX
         RqZdmKwT3Hb59AL6AGl33bOyYp1crqQUyV17ZSZigT2BWj4J8W+9TXFWG0s6PrmjEgcQ
         0lMTFAbXQnDHY8crHTufVeh8zAt4XFsfAP+gCHu93+/d9wIxh7cdJSKD0uwckYUVMFlL
         qnag==
X-Gm-Message-State: AOJu0Yx5fmBe893Sxm6iqNneKbbnXQmm9+ZCXQOPDqq+iXnEb3+2rtEc
        9z4Cg4/LnvhpavF1RFtdVSpTRRvWUss=
X-Google-Smtp-Source: AGHT+IFelLFC9Wmf5qutqU6BLAdo89LLEfLZ/g5BD1L7jnm3uHJOdp/XMSIfuCU4C7Ys/gtNcIqg5Q==
X-Received: by 2002:a50:a444:0:b0:54c:67c0:831f with SMTP id v4-20020a50a444000000b0054c67c0831fmr1682569edb.13.1701594329818;
        Sun, 03 Dec 2023 01:05:29 -0800 (PST)
Received: from localhost.lan (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402019700b0054b2040ea46sm3468888edv.61.2023.12.03.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 01:05:29 -0800 (PST)
From:   =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        zboszormenyi@sicom.com,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] egalax_ts_serial: Fix potential buffer overflow
Date:   Sun,  3 Dec 2023 10:05:20 +0100
Message-ID: <20231203090520.85855-1-zboszor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202311171716.uIQY5rT4-lkp@intel.com>
References: <202311171716.uIQY5rT4-lkp@intel.com>
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
index 375922d3a6d1..f8b56896a42f 100644
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
+	char phys[NAME_MAX];
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
2.42.0

