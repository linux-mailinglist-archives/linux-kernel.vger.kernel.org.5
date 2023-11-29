Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6847FE2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjK2WE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjK2WEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:04:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E53F10E0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:04:19 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9c1e39defso3966761fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701295457; x=1701900257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKHPDx2HvAschhAT4t+Helg6cS13lBVJniqEfNCvja0=;
        b=J49zT4QfpA+GZZxgYEj0wxaANxKQu4XBM0NvdSLFZls940IuXttzisQw+YKfJ2BS97
         l0yoF51Ada6waSujjTyDklAvlZngpN9Xqkr1x3qA9M8l81yBLn/plviWd4ICm+QFusDa
         dU/czxwQFfqDb7iGOaR7de4WDuoSNbkRUWNzA6UnpcHbe1pL0d9TeDJsXbFeng6P6G5C
         yCmqJum5fS0x7Z8GZxA/3EH+4qJpBfZ8+a9AlNC1D/jiahIUdD80RNNU+2vI8Va7g4Ae
         NarladwVmH3+KEsbIOD0AUPghRmVWZECaYyOee1Q/gLQm6L1WFNT2ZFtD4F1+GqOSpEi
         b8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295457; x=1701900257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKHPDx2HvAschhAT4t+Helg6cS13lBVJniqEfNCvja0=;
        b=FiPQDxWf2OwDnBsVt88Pii/kULCRKzvbu+TGFOZ6IH0ud142J98o8+2jIqp0aotM/u
         bpVrKkGSz2kD6W+S6TcHxeiftW0DKkbzUzDSbv/dimj820p95fr4GQrzjkI1fXOClYWO
         oUyEoCFvcqfzcqnFINI6typHKpHbeWIT+veFdoxhgH+JmmScvzxCe5Ou+0FtxyjvFcm1
         P2DqZAj7yUjI8w0RNvO8gx+WKCYOkKVRcSZt8DFiXoYO33S/cQerrjlWjvHaKQ9xMKSr
         7ggetKYvrghEL4SS48f/Wam/CYwXH/TCjj2n6txImZeJedcjaa2z3UvEtsFqmyGxFTIa
         mq3Q==
X-Gm-Message-State: AOJu0YyToDc1yX+3u5sUFBkOB+i3OzzlRt7leOpbUytphFbBKZbtcU0+
        Nn6qzwofF6XcImlutwCir18K06D9KGGXqmssRMA=
X-Google-Smtp-Source: AGHT+IFWmrAg+Dmzq8QmUy4K/ehWB+QhXz+6IfdJ+KHqnDjELCrzZyOeBmO1dxt06NCK8MJSCiWOMQ==
X-Received: by 2002:a2e:b815:0:b0:2c9:95f3:d71f with SMTP id u21-20020a2eb815000000b002c995f3d71fmr8576365ljo.16.1701295457093;
        Wed, 29 Nov 2023 14:04:17 -0800 (PST)
Received: from localhost.localdomain ([87.74.204.186])
        by smtp.gmail.com with ESMTPSA id hg11-20020a05600c538b00b0040b48690c49sm3531673wmb.6.2023.11.29.14.04.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Nov 2023 14:04:16 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        eric_devolder@yahoo.com, agordeev@linux.ibm.com, bhe@redhat.com,
        kernel-team@cloudflare.com, stable@vger.kernel.org
Subject: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
Date:   Wed, 29 Nov 2023 22:04:09 +0000
Message-Id: <20231129220409.55006-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for
CRASH_DUMP") we tried to fix a config regression, where CONFIG_CRASH_DUMP
required CONFIG_KEXEC.

However, it was not enough at least for arm64 platforms. While further testing
the patch with our arm64 config I noticed that CONFIG_CRASH_DUMP is unavailable
in menuconfig. This is because CONFIG_CRASH_DUMP still depends on the new
CONFIG_ARCH_SUPPORTS_KEXEC introduced in commit 91506f7e5d21 ("arm64/kexec:
refactor for kernel/Kconfig.kexec") and on arm64 CONFIG_ARCH_SUPPORTS_KEXEC
requires CONFIG_PM_SLEEP_SMP=y, which in turn requires either CONFIG_SUSPEND=y
or CONFIG_HIBERNATION=y neither of which are set in our config.

Given that we already established that CONFIG_KEXEC (which is a switch for kexec
system call itself) is not required for CONFIG_CRASH_DUMP drop
CONFIG_ARCH_SUPPORTS_KEXEC dependency as well. The arm64 kernel builds just fine
with CONFIG_CRASH_DUMP=y and with both CONFIG_KEXEC=n and CONFIG_KEXEC_FILE=n
after f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP")
and this patch are applied given that the necessary shared bits are included via
CONFIG_KEXEC_CORE dependency.

Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 kernel/Kconfig.kexec | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index fc38f1ae3a30..946dffa048b7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -96,7 +96,6 @@ config KEXEC_JUMP
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-	depends on ARCH_SUPPORTS_KEXEC
 	select CRASH_CORE
 	select KEXEC_CORE
 	help
-- 
2.39.2

