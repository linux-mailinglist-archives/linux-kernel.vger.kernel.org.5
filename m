Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7215378A730
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjH1IIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjH1IIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:08:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000BDCC9;
        Mon, 28 Aug 2023 01:07:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so2032641b3a.2;
        Mon, 28 Aug 2023 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693210037; x=1693814837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yix1QIvYkCVrQqH7rnPkzsKqXcnw1nS6UvJEKq5/GR4=;
        b=Jcb7kitEIxA1rzhwADOLGW6ciAuGuPi5fZ8+4lR6q37QimTtkuDb+cbceweB+2+Ovq
         dhPYJnhsrXiAg3VRpNhTLjD1w2J1sFZgPp+8eFgvzXigzHIft4yfQcT4DZzOSpTklhV4
         Nt6UGFgOlZkNsR41NlIpcqrGndM0GuYgrrGnynIxe5ov76gEYKhE4hl6iRoLlQ+tFz7r
         8k0ojwrZZx82uJXDSb9OJAczRlL5ae67YQU704yL1mpKRDy9TZ8GPpFmrlyauwNocETg
         lHEIMjilOOUwWIeymkG6/RVEWamc7PHkbEO2+8WCfzN1Wx1m69GUEi8bI2i1OFAnIPQy
         2yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693210037; x=1693814837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yix1QIvYkCVrQqH7rnPkzsKqXcnw1nS6UvJEKq5/GR4=;
        b=GEMYjzOZMNhtguGYcDp2iStfg5bj/Pk3J1RfTUicxs75SE8eY0EBqHAhHhT23oD9cp
         3prRT/ZAWu8sgL2CBSt2KKygfbCJ8UCJV4SF4MvO5VeBI+sW0ZnNPsS8hUXTTOmUH4wh
         dcASp6aPhrEwynx5StGhiQhuWhO1Tr4yACs40Yikqlbe9mcvTs/BILt1eGBmGNSeQy2s
         JE40Gmj5TToLit3l+kWyrN9sVgBJnph/O2zDT0IyqVLQqDrVqfcOHipKGJ2tO3W1gv/d
         Jy1yyrIVf86DxVfBTvZntsi4nmZcp8ndi3O00aPdvWkVMI+abv4nKKk1yJsUKfrJmsF9
         vpFQ==
X-Gm-Message-State: AOJu0YwGhTBdrzBu5AImaliS5t/NhHddETesA+KK3NCB0U04T8GG7Z1Y
        hhnMb18+C9wewTJzJ4LEYME=
X-Google-Smtp-Source: AGHT+IFfkMLCCPw0wLd/iVyqB/lRpa6XtXzGXkA0mEpPf50xM1LMkTq6yJJKL7ZXkb/hM6HSH0s1AQ==
X-Received: by 2002:a05:6a20:1615:b0:14d:f087:c0c7 with SMTP id l21-20020a056a20161500b0014df087c0c7mr430007pzj.58.1693210036806;
        Mon, 28 Aug 2023 01:07:16 -0700 (PDT)
Received: from archlinux.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001bf10059251sm6585294plg.239.2023.08.28.01.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:07:16 -0700 (PDT)
From:   Anshul <anshulusr@gmail.com>
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com
Cc:     Anshul <anshulusr@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH] alpha/boot: fixes formatting issues in `main.c`
Date:   Mon, 28 Aug 2023 13:36:59 +0530
Message-ID: <20230828080703.107031-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828071829.64366-1-anshulusr@gmail.com>
References: <20230828071829.64366-1-anshulusr@gmail.com>
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
* [ERROR] 5 fixes are to pointer formatting
* [ERROR] Removed a trailing whitespace

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

