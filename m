Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4978AB58
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjH1KaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjH1KaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:30:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3021115;
        Mon, 28 Aug 2023 03:30:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c1d03e124so397693966b.2;
        Mon, 28 Aug 2023 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693218603; x=1693823403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DMA68DXA4Lrt7f99MK3rEcfyfoxbw24D8JMgPoNJMJ0=;
        b=dDnNOU8KzLJHgOxPgNCv0P5lSg4IhbyGGWcm/11jU/TN/SSqLypoIxia4r5ohssJkC
         14zH+ajJH/qUqo9xcwJogvqGe+y66+xv+mjxW7FgRTRjqs/+kSwgeCOaBRLd/qCQI+Td
         Djvn1VU7Mq0IBmtSCZWAU42PWMPvw4qhwif3lVJydnfW7JqdsvTmjv+1afY5xjcPvn40
         J9AQQFb+VxX2Mb5y71pc7z2L61Vtlc0MCD5vMeZ8n+DI9fw0m4Qx0I9whDuznmSw7k6a
         zLVbNT3Yqh1LDq9Z1SOAcQeCcjehs4B7t0NryaAY9h887Wh3mN3z3qMh4A18cr8ZXRVl
         AkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218603; x=1693823403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMA68DXA4Lrt7f99MK3rEcfyfoxbw24D8JMgPoNJMJ0=;
        b=h5njn4pqF4O9PHTmpxY2yT+7RoEsdisLRVW3Y+3Ir+5DNk1hA5Ig7D6Ijm5BXOtWoR
         FHPu4URC6rURA6b9LimS/dsVxqNlufTtcNvLiBVM/XzpItivP/RN67ZY8ip4yMSg4Y6I
         T0II947PIhp3+OV8zwoIF0YK28M4hto1ZcQ37Z9pJQw1f4iskD4lngflS0so7Y2BGuSj
         IHxQ54DXuqvFmJjJcHVICiTwx2R9poHZYvQlmLJqJ7bKfnro8RFbG8gNiEBB8pMRbKVO
         86NdrKieLtfzm4yX1u5FG2BpGFq6c5JftIOYie2I+ojyiainB1qks4LqfX56KPbLuYFr
         yZzA==
X-Gm-Message-State: AOJu0YxijIE5sYLuscf3IJnk511JRAxj9TuN7MP75S04jydoSEQ3FHSr
        jF67PYKbr9wnLkY4SStzq61DhxkE7UpYGQ==
X-Google-Smtp-Source: AGHT+IH8tQZMmpS0DmjinA6b8QnPorvuJRQYcArGd0IwUXqneyQ9bXCiMdhOka3iqaipWGSfXClN/g==
X-Received: by 2002:a17:907:2ccb:b0:9a2:232f:6f85 with SMTP id hg11-20020a1709072ccb00b009a2232f6f85mr7802671ejc.52.1693218602083;
        Mon, 28 Aug 2023 03:30:02 -0700 (PDT)
Received: from fedora.. (87-97-90-214.pool.digikabel.hu. [87.97.90.214])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090649d800b009930308425csm4473505ejv.31.2023.08.28.03.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:30:01 -0700 (PDT)
From:   Andras Sebok <sebokandris2009@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     andriseseboke@gmail.com, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, gregkh@linuxfoundation.org,
        Andras Sebok <sebokandris2009@gmail.com>
Subject: [PATCH 1/2] Simplify sysrq help
Date:   Mon, 28 Aug 2023 12:27:53 +0200
Message-ID: <20230828102753.4811-2-sebokandris2009@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplyfies sysrq help menu by moving each command to a 
separate line and by moving the key from brackets to after a semicolon.

before:
sysrq: HELP : loglevel(0-9) reboot(b) crash(c) terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show-task-states(t) unmount(u) force-fb(v) show-blocked-tasks(w) dump-ftrace-buffer(z)

after:
sysrq: HELP :
loglevel : 0-9
reboot : b
crash : c
terminate-all-tasks : e
memory-full-oom-kill : f
kill-all-tasks : i
thaw-filesystems : j
sak : k
show-backtrace-all-active-cpus : l
show-memory-usage : m
nice-all-RT-tasks : n
poweroff : o
show-registers : p
show-all-timers : q
unraw : r
sync : s
show-task-states : t
unmount : u
force-fb : v
show-blocked-tasks : w
dump-ftrace-buffer : z

Signed-off-by: Andras Sebok <sebokandris2009@gmail.com>
---
 arch/alpha/kernel/setup.c       |  2 +-
 arch/loongarch/kernel/sysrq.c   |  2 +-
 arch/mips/kernel/sysrq.c        |  2 +-
 arch/powerpc/xmon/xmon.c        |  2 +-
 arch/sparc/kernel/process_64.c  |  4 +--
 drivers/gpu/drm/drm_fb_helper.c |  2 +-
 drivers/tty/sysrq.c             | 44 ++++++++++++++++-----------------
 kernel/debug/debug_core.c       |  2 +-
 kernel/power/poweroff.c         |  2 +-
 kernel/rcu/tree_stall.h         |  2 +-
 10 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 3d7473531ab1..d660a363fab8 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -428,7 +428,7 @@ static void sysrq_reboot_handler(int unused)
 
 static const struct sysrq_key_op srm_sysrq_reboot_op = {
 	.handler	= sysrq_reboot_handler,
-	.help_msg       = "reboot(b)",
+	.help_msg       = "reboot : b",
 	.action_msg     = "Resetting",
 	.enable_mask    = SYSRQ_ENABLE_BOOT,
 };
diff --git a/arch/loongarch/kernel/sysrq.c b/arch/loongarch/kernel/sysrq.c
index 366baef72d29..470a9017ca84 100644
--- a/arch/loongarch/kernel/sysrq.c
+++ b/arch/loongarch/kernel/sysrq.c
@@ -53,7 +53,7 @@ static void sysrq_handle_tlbdump(int key)
 
 static struct sysrq_key_op sysrq_tlbdump_op = {
 	.handler        = sysrq_handle_tlbdump,
-	.help_msg       = "show-tlbs(x)",
+	.help_msg       = "show-tlbs : x",
 	.action_msg     = "Show TLB entries",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
diff --git a/arch/mips/kernel/sysrq.c b/arch/mips/kernel/sysrq.c
index 9c1a2019113b..ac0265a96cbe 100644
--- a/arch/mips/kernel/sysrq.c
+++ b/arch/mips/kernel/sysrq.c
@@ -54,7 +54,7 @@ static void sysrq_handle_tlbdump(int key)
 
 static const struct sysrq_key_op sysrq_tlbdump_op = {
 	.handler        = sysrq_handle_tlbdump,
-	.help_msg       = "show-tlbs(x)",
+	.help_msg       = "show-tlbs : x",
 	.action_msg     = "Show TLB entries",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index fae747cc57d2..bcfca6ccd8ae 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -4007,7 +4007,7 @@ static void sysrq_handle_xmon(int key)
 
 static const struct sysrq_key_op sysrq_xmon_op = {
 	.handler =	sysrq_handle_xmon,
-	.help_msg =	"xmon(x)",
+	.help_msg =	"xmon : x",
 	.action_msg =	"Entering xmon",
 };
 
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index b51d8fb0ecdc..11b85c326362 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -302,7 +302,7 @@ static void sysrq_handle_globreg(int key)
 
 static const struct sysrq_key_op sparc_globalreg_op = {
 	.handler	= sysrq_handle_globreg,
-	.help_msg	= "global-regs(y)",
+	.help_msg	= "global-regs : y",
 	.action_msg	= "Show Global CPU Regs",
 };
 
@@ -377,7 +377,7 @@ static void sysrq_handle_globpmu(int key)
 
 static const struct sysrq_key_op sparc_globalpmu_op = {
 	.handler	= sysrq_handle_globpmu,
-	.help_msg	= "global-pmu(x)",
+	.help_msg	= "global-pmu : x",
 	.action_msg	= "Show Global PMU Regs",
 };
 
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 61a5d450cc20..105b296b17db 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -308,7 +308,7 @@ static void drm_fb_helper_sysrq(int dummy1)
 
 static const struct sysrq_key_op sysrq_drm_fb_helper_restore_op = {
 	.handler = drm_fb_helper_sysrq,
-	.help_msg = "force-fb(v)",
+	.help_msg = "force-fb : v",
 	.action_msg = "Restore framebuffer console",
 };
 #else
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index b6e70c5cfa17..831cdadf366f 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -109,7 +109,7 @@ static void sysrq_handle_loglevel(int key)
 }
 static const struct sysrq_key_op sysrq_loglevel_op = {
 	.handler	= sysrq_handle_loglevel,
-	.help_msg	= "loglevel(0-9)",
+	.help_msg	= "loglevel : 0-9",
 	.action_msg	= "Changing Loglevel",
 	.enable_mask	= SYSRQ_ENABLE_LOG,
 };
@@ -123,7 +123,7 @@ static void sysrq_handle_SAK(int key)
 }
 static const struct sysrq_key_op sysrq_SAK_op = {
 	.handler	= sysrq_handle_SAK,
-	.help_msg	= "sak(k)",
+	.help_msg	= "sak : k",
 	.action_msg	= "SAK",
 	.enable_mask	= SYSRQ_ENABLE_KEYBOARD,
 };
@@ -139,7 +139,7 @@ static void sysrq_handle_unraw(int key)
 
 static const struct sysrq_key_op sysrq_unraw_op = {
 	.handler	= sysrq_handle_unraw,
-	.help_msg	= "unraw(r)",
+	.help_msg	= "unraw : r",
 	.action_msg	= "Keyboard mode set to system default",
 	.enable_mask	= SYSRQ_ENABLE_KEYBOARD,
 };
@@ -156,7 +156,7 @@ static void sysrq_handle_crash(int key)
 }
 static const struct sysrq_key_op sysrq_crash_op = {
 	.handler	= sysrq_handle_crash,
-	.help_msg	= "crash(c)",
+	.help_msg	= "crash : c",
 	.action_msg	= "Trigger a crash",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -169,7 +169,7 @@ static void sysrq_handle_reboot(int key)
 }
 static const struct sysrq_key_op sysrq_reboot_op = {
 	.handler	= sysrq_handle_reboot,
-	.help_msg	= "reboot(b)",
+	.help_msg	= "reboot : b",
 	.action_msg	= "Resetting",
 	.enable_mask	= SYSRQ_ENABLE_BOOT,
 };
@@ -182,7 +182,7 @@ static void sysrq_handle_sync(int key)
 }
 static const struct sysrq_key_op sysrq_sync_op = {
 	.handler	= sysrq_handle_sync,
-	.help_msg	= "sync(s)",
+	.help_msg	= "sync : s",
 	.action_msg	= "Emergency Sync",
 	.enable_mask	= SYSRQ_ENABLE_SYNC,
 };
@@ -194,7 +194,7 @@ static void sysrq_handle_show_timers(int key)
 
 static const struct sysrq_key_op sysrq_show_timers_op = {
 	.handler	= sysrq_handle_show_timers,
-	.help_msg	= "show-all-timers(q)",
+	.help_msg	= "show-all-timers : q",
 	.action_msg	= "Show clockevent devices & pending hrtimers (no others)",
 };
 
@@ -204,7 +204,7 @@ static void sysrq_handle_mountro(int key)
 }
 static const struct sysrq_key_op sysrq_mountro_op = {
 	.handler	= sysrq_handle_mountro,
-	.help_msg	= "unmount(u)",
+	.help_msg	= "unmount : u",
 	.action_msg	= "Emergency Remount R/O",
 	.enable_mask	= SYSRQ_ENABLE_REMOUNT,
 };
@@ -217,7 +217,7 @@ static void sysrq_handle_showlocks(int key)
 
 static const struct sysrq_key_op sysrq_showlocks_op = {
 	.handler	= sysrq_handle_showlocks,
-	.help_msg	= "show-all-locks(d)",
+	.help_msg	= "show-all-locks : d",
 	.action_msg	= "Show Locks Held",
 };
 #else
@@ -275,7 +275,7 @@ static void sysrq_handle_showallcpus(int key)
 
 static const struct sysrq_key_op sysrq_showallcpus_op = {
 	.handler	= sysrq_handle_showallcpus,
-	.help_msg	= "show-backtrace-all-active-cpus(l)",
+	.help_msg	= "show-backtrace-all-active-cpus : l",
 	.action_msg	= "Show backtrace of all active CPUs",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -295,7 +295,7 @@ static void sysrq_handle_showregs(int key)
 }
 static const struct sysrq_key_op sysrq_showregs_op = {
 	.handler	= sysrq_handle_showregs,
-	.help_msg	= "show-registers(p)",
+	.help_msg	= "show-registers : p",
 	.action_msg	= "Show Regs",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -307,7 +307,7 @@ static void sysrq_handle_showstate(int key)
 }
 static const struct sysrq_key_op sysrq_showstate_op = {
 	.handler	= sysrq_handle_showstate,
-	.help_msg	= "show-task-states(t)",
+	.help_msg	= "show-task-states : t",
 	.action_msg	= "Show State",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -318,7 +318,7 @@ static void sysrq_handle_showstate_blocked(int key)
 }
 static const struct sysrq_key_op sysrq_showstate_blocked_op = {
 	.handler	= sysrq_handle_showstate_blocked,
-	.help_msg	= "show-blocked-tasks(w)",
+	.help_msg	= "show-blocked-tasks : w",
 	.action_msg	= "Show Blocked State",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -332,7 +332,7 @@ static void sysrq_ftrace_dump(int key)
 }
 static const struct sysrq_key_op sysrq_ftrace_dump_op = {
 	.handler	= sysrq_ftrace_dump,
-	.help_msg	= "dump-ftrace-buffer(z)",
+	.help_msg	= "dump-ftrace-buffer : z",
 	.action_msg	= "Dump ftrace buffer",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -346,7 +346,7 @@ static void sysrq_handle_showmem(int key)
 }
 static const struct sysrq_key_op sysrq_showmem_op = {
 	.handler	= sysrq_handle_showmem,
-	.help_msg	= "show-memory-usage(m)",
+	.help_msg	= "show-memory-usage : m",
 	.action_msg	= "Show Memory",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -377,7 +377,7 @@ static void sysrq_handle_term(int key)
 }
 static const struct sysrq_key_op sysrq_term_op = {
 	.handler	= sysrq_handle_term,
-	.help_msg	= "terminate-all-tasks(e)",
+	.help_msg	= "terminate-all-tasks : e",
 	.action_msg	= "Terminate All Tasks",
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
@@ -407,7 +407,7 @@ static void sysrq_handle_moom(int key)
 }
 static const struct sysrq_key_op sysrq_moom_op = {
 	.handler	= sysrq_handle_moom,
-	.help_msg	= "memory-full-oom-kill(f)",
+	.help_msg	= "memory-full-oom-kill : f",
 	.action_msg	= "Manual OOM execution",
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
@@ -419,7 +419,7 @@ static void sysrq_handle_thaw(int key)
 }
 static const struct sysrq_key_op sysrq_thaw_op = {
 	.handler	= sysrq_handle_thaw,
-	.help_msg	= "thaw-filesystems(j)",
+	.help_msg	= "thaw-filesystems : j",
 	.action_msg	= "Emergency Thaw of all frozen filesystems",
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
@@ -434,7 +434,7 @@ static void sysrq_handle_kill(int key)
 }
 static const struct sysrq_key_op sysrq_kill_op = {
 	.handler	= sysrq_handle_kill,
-	.help_msg	= "kill-all-tasks(i)",
+	.help_msg	= "kill-all-tasks : i",
 	.action_msg	= "Kill All Tasks",
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
@@ -445,7 +445,7 @@ static void sysrq_handle_unrt(int key)
 }
 static const struct sysrq_key_op sysrq_unrt_op = {
 	.handler	= sysrq_handle_unrt,
-	.help_msg	= "nice-all-RT-tasks(n)",
+	.help_msg	= "nice-all-RT-tasks : n",
 	.action_msg	= "Nice All RT Tasks",
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
@@ -605,7 +605,7 @@ void __handle_sysrq(int key, bool check_mask)
 			console_loglevel = orig_log_level;
 		}
 	} else {
-		pr_info("HELP : ");
+		pr_info("HELP : \n");
 		/* Only print the help msg once per handler */
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
 			if (sysrq_key_table[i]) {
@@ -617,9 +617,9 @@ void __handle_sysrq(int key, bool check_mask)
 				if (j != i)
 					continue;
 				pr_cont("%s ", sysrq_key_table[i]->help_msg);
+				pr_cont("\n");
 			}
 		}
-		pr_cont("\n");
 		console_loglevel = orig_log_level;
 	}
 	rcu_read_unlock();
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index d5e9ccde3ab8..561721e124cd 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -988,7 +988,7 @@ static void sysrq_handle_dbg(int key)
 
 static const struct sysrq_key_op sysrq_dbg_op = {
 	.handler	= sysrq_handle_dbg,
-	.help_msg	= "debug(g)",
+	.help_msg	= "debug : g",
 	.action_msg	= "DEBUG",
 };
 #endif
diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
index 562aa0e450ed..d9c0e6ea079a 100644
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -31,7 +31,7 @@ static void handle_poweroff(int key)
 
 static const struct sysrq_key_op	sysrq_poweroff_op = {
 	.handler        = handle_poweroff,
-	.help_msg       = "poweroff(o)",
+	.help_msg       = "poweroff : o",
 	.action_msg     = "Power Off",
 	.enable_mask	= SYSRQ_ENABLE_BOOT,
 };
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a..17a7bf7b0a2b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -1042,7 +1042,7 @@ static void sysrq_show_rcu(int key)
 
 static const struct sysrq_key_op sysrq_rcudump_op = {
 	.handler = sysrq_show_rcu,
-	.help_msg = "show-rcu(y)",
+	.help_msg = "show-rcu : y",
 	.action_msg = "Show RCU tree",
 	.enable_mask = SYSRQ_ENABLE_DUMP,
 };
-- 
2.41.0

