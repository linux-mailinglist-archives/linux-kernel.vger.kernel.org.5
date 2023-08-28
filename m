Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE8A78A662
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjH1HVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjH1HVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:21:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ADFE7;
        Mon, 28 Aug 2023 00:21:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bee12e842so1847908b3a.3;
        Mon, 28 Aug 2023 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693207260; x=1693812060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yix1QIvYkCVrQqH7rnPkzsKqXcnw1nS6UvJEKq5/GR4=;
        b=aJYAzMMgyY65Hpr7rJ2lcMhc6IHd+uAt46IatMESb1+OBRo7t0vq6f5aYnaKulMPtQ
         QtkTPp7MoQdlWJ5UHq6E+v5qwO9A4238hvk1vi0jAqYiLEj0JUFHdtPODz+aBUSWtsv3
         8PrAH/d6RDzFF2BG4aOu70Jqt158DghCvyxt3eQrwX+F1PiQ1zubYpt7VB6r28XKYtzG
         QZp4ruiFMJMLa9KwBk7tKO8jCTkcLCsXunSFZsh6v+mwD7WNnpZNl7vLMBHBtY92glb/
         TsAQFh12+DU5hroXAF47nCSOVN2UouQEgeiq3Ccfz8do9AgQZcqlhVo5PL1+All5vgPB
         D/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693207260; x=1693812060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yix1QIvYkCVrQqH7rnPkzsKqXcnw1nS6UvJEKq5/GR4=;
        b=QDXBgf0oqUL+Kb75PsHiph6taM5MRdz7ZLXhisdDfI7rTkYVJz958VS2AUyDV6QKM8
         mceRnhZ6WZN4OkdaMBaDJTnBU1xZOb0BRtUmPB2YeCIYgFwF6GfItcNeQV5mNqF1LmkY
         TRNjiFsH0pRLyNEyUSMSlBwj52I9crSo/qC6B7BNwpMQFPi3EwtTJm6GGnjjLFewOfWn
         V01Of9TFOYfgZEYfTojVuNwrISAg2OB0fSXHchPA+GcQlqCfqRojxTMRCg8kpFxfBwF/
         +sJO7Ab2PVWxTogLYFkjwlbUBNpuuUJJnS7oH3xhJDcIQ9Y5ui3zxGZanOOYMDjkFjcR
         GCXQ==
X-Gm-Message-State: AOJu0YwvD2ZYE3uCN/J1rPO/Bw3cKpyGHfZDjZjioJt04q3F8zVE2Xmt
        9ih0pxnN4OMRU8qVLSfwLDU=
X-Google-Smtp-Source: AGHT+IFahU8UqJ/qhYnAqAcbiymFTVXuR2lxsWv8uOwt3RBW+bSLIGVa9RUjZWeqPaSIzROiaufbCA==
X-Received: by 2002:a05:6a20:a11f:b0:13e:b58a:e3e8 with SMTP id q31-20020a056a20a11f00b0013eb58ae3e8mr22451160pzk.50.1693207260411;
        Mon, 28 Aug 2023 00:21:00 -0700 (PDT)
Received: from archlinux.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id a19-20020a62e213000000b00686bef984e2sm5980184pfi.80.2023.08.28.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:20:59 -0700 (PDT)
From:   Anshul <anshulusr@gmail.com>
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com
Cc:     Anshul <anshulusr@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH] fixed formatting issues
Date:   Mon, 28 Aug 2023 12:48:25 +0530
Message-ID: <20230828071829.64366-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed minor formatting issues as per `scripts/checkpatch.pl`

Six changes to the file and their severity are as follows:
* [WARNING] Removed unnecessary braces from single statement blocks
* [ERROR]   5 fixes are to pointer formatting
* [ERROR]   Removed a trailing whitespace

6 errors and 1 warning of the previously present 6 errors and 5
warnings have been fixed.

Signed-off-by: Anshul <anshulusr@gmail.com>
---
 arch/alpha/boot/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/boot/main.c b/arch/alpha/boot/main.c
index 22a1cb026..f609c3a83 100644
--- a/arch/alpha/boot/main.c
+++ b/arch/alpha/boot/main.c
@@ -20,8 +20,9 @@
 #include "ksize.h"
 
 extern unsigned long switch_to_osf_pal(unsigned long nr,
-	struct pcb_struct * pcb_va, struct pcb_struct * pcb_pa,
-	unsigned long *vptb);
+				       struct pcb_struct *pcb_va,
+				       struct pcb_struct *pcb_pa,
+				       unsigned long *vptb);
 struct hwrpb_struct *hwrpb = INIT_HWRPB;
 static struct pcb_struct pcb_va[1];
 
@@ -42,7 +43,7 @@ find_pa(unsigned long *vptb, void *ptr)
 	result <<= 13;
 	result |= address & 0x1fff;
 	return (void *) result;
-}	
+}
 
 /*
  * This function moves into OSF/1 pal-code, and has a temporary
@@ -62,8 +63,8 @@ void
 pal_init(void)
 {
 	unsigned long i, rev;
-	struct percpu_struct * percpu;
-	struct pcb_struct * pcb_pa;
+	struct percpu_struct *percpu;
+	struct pcb_struct *pcb_pa;
 
 	/* Create the dummy PCB.  */
 	pcb_va->ksp = 0;
@@ -176,11 +177,10 @@ void start_kernel(void)
 	}
 
 	nbytes = callback_getenv(ENV_BOOTED_OSFLAGS, envval, sizeof(envval));
-	if (nbytes < 0) {
+	if (nbytes < 0)
 		nbytes = 0;
-	}
 	envval[nbytes] = '\0';
-	strcpy((char*)ZERO_PGE, envval);
+	strcpy((char *)ZERO_PGE, envval);
 
 	srm_printk(" Ok\nNow booting the kernel\n");
 	runkernel();
-- 
2.42.0

