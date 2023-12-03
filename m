Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FD802226
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjLCJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjLCJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:06:00 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C1118
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:06:06 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1b68ae40ffso19866166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 01:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701594364; x=1702199164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX+3yDbq4orl3F1IwroT1JgXwfqK8BBsS1e+lWobZFk=;
        b=m5Q5GpXPi0Wx1uZRd+Vbmilwv/oIJQlC53/6cAfABQT/goXP+jKpoVPoMGWCeQQex9
         XtnzJFoCut2FN0wzoNU+ByXyxSPynrvoH4aUQ3R/faDzK7IwmT6l75seaADeVtN5z+F5
         OzI+VVBoFBQeRIKdfeqoWgfHFg1W6QeGmFr1JygRuFwCwnqWM51CO7NJdqSGpnnW0KqP
         pfo/1+yw31d3THuop9aKH+G2gTi7UPBVvLko5MxD7EyKacAp+z29Hi3bkYMTjedJWSxO
         Ca9xH1FoRwKx1uX9nFdOK+tcumJtU5IiEpqTeu8uzLQzltpPB/eqg5Dayrd2TqdJ3g0O
         nnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701594364; x=1702199164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX+3yDbq4orl3F1IwroT1JgXwfqK8BBsS1e+lWobZFk=;
        b=KPBxHZIJ9aDVlIeVuVLF5meWDmMqxaB4q0DtRClj9XuIcTZxSrQU5icHVL2SqdJHhf
         /LDOqa7xb0kzpTmwtQshjx7hFn2uUHPUKhiZXww/hwP0BNaygIdOLVzvo1f92X8gF0wi
         CNBu688aFYd6QQtuA+JGSE1QGNgB7L0lr46DHegPzJL2F17Ic7KQ0hnL4wLLXiCUC7lA
         +D6jChcEHJMHMBWbbs81A152hNyTr3rytDZ2AF8qtBBFsGdDsb3pPmSOBv1hD32QmXEc
         GxoObFc+dxxUdprxBeNa/yj4JLYECF+DzHHEBcnAnfEoOZuS6b5lzP4gM6StKgL/fEEr
         oDYQ==
X-Gm-Message-State: AOJu0Yzc8sUzyiSr0l8pBEQ+H9VX8vG0GHBPVHWMYlWqOk9mDSYY3ecd
        05URB++yDi0CY+CM7t5gxeyszhA8awk=
X-Google-Smtp-Source: AGHT+IFpTykt5g6ytZ04cyAdHNtbWrSm8cg2twxsPVBHbwUSML/8XczZs9/JKQt/ZLMTG9/KCs1Ipw==
X-Received: by 2002:a17:906:b302:b0:a0f:f117:e2aa with SMTP id n2-20020a170906b30200b00a0ff117e2aamr1292476ejz.42.1701594364281;
        Sun, 03 Dec 2023 01:06:04 -0800 (PST)
Received: from localhost.lan (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id la26-20020a170906ad9a00b009bd9ac83a9fsm3939717ejb.152.2023.12.03.01.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 01:06:04 -0800 (PST)
From:   =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        zboszormenyi@sicom.com,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] egalax_ts_serial: Fix potential buffer overflow
Date:   Sun,  3 Dec 2023 10:06:00 +0100
Message-ID: <20231203090600.85890-1-zboszor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202312021646.cwwvptuB-lkp@intel.com>
References: <202312021646.cwwvptuB-lkp@intel.com>
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

