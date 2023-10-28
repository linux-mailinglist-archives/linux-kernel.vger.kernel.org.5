Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC17DA954
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjJ1UlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1UlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:41:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD885B8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:41:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso5390167a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698525666; x=1699130466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUwuPAGIMhP+TGZwObiRcnR6XL7LRMumnWTuP6cfE6U=;
        b=kQrSpQIs9T8wMgbOxi+uIMn3AqTMP1EJmACZia0OmHTrhFwBXAvjk8hK7vz/6VUvY6
         KV02D/wafVm0gOFgXuh0pcfCvJgLN/i0tIX0USwP2TP3+THCvQetapCk29cl/VqpFOKK
         UiANEvi6rlNXokcJl+JEe6WFzfr1xtLm8BWPSZo/s/Nns4HxGHrTPHV/WSXviknIdBSe
         sJCLxLtwQPK8ySVunyPoWHr+yclPTInHGdaD0PTd9mwpvme3bgzfAsllYcgGRP6LvuJW
         qbj3X6gWZ2W52PQcVpyDnCAHAZLjh84jjZzIz0B4OpuRVVRMkFCiSB+y8MffuAmV6WFm
         zdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698525666; x=1699130466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUwuPAGIMhP+TGZwObiRcnR6XL7LRMumnWTuP6cfE6U=;
        b=rIAhRubvha1iVDUcReamryF7U8uAiE6MawKbMkBdHSXEkIcSX/DjbSFLBNDD3HfG3x
         LJBeymU2/0kdWhOhaLssVFM4Ra/dlxMJOxSP9EZ3f2JppizTMgI57P+Sk7kV8RAxLCye
         yf5T2X+xVWBi23s5IlBmLHmu/9/Z1ZqmXumpHL0d0W6K/s7AnHbE0xJnpYvUf9vlK1/a
         9h+S9qn+UxUkgmvzjVrbNpARWIpQ198q7vuyWNga0DXTK9EgKIn+rIa23xz8x7w8DofT
         OXBiIf4rMhOmA+CUT+/w/jCOYixzc3yLgjpKe1YX+o44fsN/8LlKN6hwsx6pOQ726E6a
         FcSA==
X-Gm-Message-State: AOJu0YxvVvMORpOrtO5hbkVc++EVlc8mFi8w19uNrrke9HT++UJoMzVb
        G51bDpyUdR8Dv8Ye//zychE=
X-Google-Smtp-Source: AGHT+IHx5hChq4Kp3jfRifFGG7sxlZN0YEC4o09eESjYj2PiXa9aJVq+NI8mMD0Bg+VdZXaCZ7vyPg==
X-Received: by 2002:a05:6402:12c4:b0:540:b95b:6ecf with SMTP id k4-20020a05640212c400b00540b95b6ecfmr4951411edx.7.1698525666182;
        Sat, 28 Oct 2023 13:41:06 -0700 (PDT)
Received: from yjn-Lenovo-V14-G2-ITL.Speedport_W_724V_01011603_07_008 (p200300cddf179b700f8b32cb72feaa13.dip0.t-ipconnect.de. [2003:cd:df17:9b70:f8b:32cb:72fe:aa13])
        by smtp.gmail.com with ESMTPSA id r17-20020a50aad1000000b0053e2a64b5f8sm3381499edc.14.2023.10.28.13.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:41:05 -0700 (PDT)
From:   York Jasper Niebuhr <yjnworkstation@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] Added empty sys_ememz
Date:   Sat, 28 Oct 2023 22:40:46 +0200
Message-Id: <20231028204046.11258-1-yjnworkstation@gmail.com>
X-Mailer: git-send-email 2.34.1
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

---
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/syscalls.h               |  1 +
 include/uapi/asm-generic/unistd.h      |  5 ++++-
 kernel/sys_ni.c                        |  3 +++
 mm/Kconfig                             |  7 +++++++
 mm/ememz.c                             | 18 ++++++++++++++++++
 7 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 mm/ememz.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2d0b1bd866ea..7803b2303da4 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,4 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+453	i386	ememz			sys_ememz
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb..39530de435e1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,7 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	ememz			sys_ememz
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22bc6bc147f8..4127689798e2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -940,6 +940,7 @@ asmlinkage long sys_cachestat(unsigned int fd,
 		struct cachestat_range __user *cstat_range,
 		struct cachestat __user *cstat, unsigned int flags);
 asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
+asmlinkage long sys_ememz(int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c53b4b..63ec7611af63 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,8 +823,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 
+#define __NR_ememz 453
+__SYSCALL(__NR_ememz, sys_ememz)
+
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 454
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e137c1385c56..108ff4c6113c 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -253,6 +253,9 @@ COND_SYSCALL(pkey_free);
 /* memfd_secret */
 COND_SYSCALL(memfd_secret);
 
+/* ememz */
+COND_SYSCALL(ememz);
+
 /*
  * Architecture specific weak syscall entries.
  */
diff --git a/mm/Kconfig b/mm/Kconfig
index 264a2df5ecf5..dd4d505cf52e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1260,4 +1260,11 @@ config LOCK_MM_AND_FIND_VMA
 
 source "mm/damon/Kconfig"
 
+config EMEMZ_SYSCALL
+        bool "Ememz syscall" if EXPERT
+        default y
+        help
+          sys_ememz is a system call to flag a process' memory to be filled
+          with zeros on exit.
+
 endmenu
diff --git a/mm/ememz.c b/mm/ememz.c
new file mode 100644
index 000000000000..d7765375122a
--- /dev/null
+++ b/mm/ememz.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/syscalls.h>
+
+#ifdef CONFIG_EMEMZ_SYSCALL
+/*
+ * Set task_struct flag to fill any memory associated with process on
+ * exit to zero.
+ */
+SYSCALL_DEFINE1(ememz, int, flags)
+{
+	if (flags & ~(0))
+		return -EINVAL;
+
+	// Set flag atomically
+	return 0;
+}
+#endif
-- 
2.34.1

Hi,
I am looking for a more fine grained alternative with less system
overhead to CONFIG_INIT_ON_FREE_DEFAULT_ON. My idea was to add a system
call (ememz) to set a flag in the task_struct that causes initialization
of all a process' pages on exit. Are there already any other
alternatives I should consider and is this the proper way to go on with
it? Any suggestions are welcome.

Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>
