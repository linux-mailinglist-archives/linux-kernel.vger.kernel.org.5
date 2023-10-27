Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF707DA298
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346589AbjJ0VrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJ0VrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:47:18 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F6D1BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:47:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 432844C07DB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 072F34C108A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1698443234; a=rsa-sha256;
        cv=none;
        b=lUbDQSe2CBeLlX8uNcOsGur9cQarpa3Q19RDbo1fWtJtzcfZy9B+SyKmanA0PhfrcF/zdk
        9wn/tuZvhU6sQ1NLgSVQK12SoFp0LP3RKnw5SzZ7RqQi8DFhgfKnv6aH2rHZG8c8PozC3y
        J/Vl3AlJr09tAOJTHTKMlFc6kzx9fQQJaJwJm3N4rjbpDMhUaKEEMihsnnugloEXFYZfGt
        yzeyaGCDK5CpY+Broa89gva+i/O3Kp6ROF3pLvHPY4Ll/+jq1RsLBFG//9UtFy7LTzhba+
        BEcocqrcnozm5Q9rRbHBGKZaYqTamGXJsT8n3UT4O0zlDxf5ZwLVQ2rH20x06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1698443234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=0kXzCiZbGPBTOEojx/2Lih4mxRwPi4XPavoOAgVaQRE=;
        b=PGQZ7Vsynj0febWFh/zfAhWCFiW3FloOiE2aPqsoAjtn3PlQovHXwG0vHTQXbdox5gVOgK
        sZxD1bcuomZFVGZWbFxipuzpd8tWsP4e3KNC04FiLmh52yHCVs7XH9t0/2/Mo4LqFHwrf/
        gEmG1ZY3yx+33ZF0bBHdtrm9wx/uQO/ByFVKZ2/XciTCOsQ/Aw3+A+Jiy8l4NXsKFDnnJP
        BqSgK4EzwB9jiGNt6DRFQSPdhu+/uO3XYKcIWe5Hv3FDHovMyTQWq6EMlkV1vfz11URkY4
        52A+zvs0/oEXzd5TRKN9BLyQnMtRn6BS/etMkojIPfQXoLbuIL+wbyHPRfShmQ==
ARC-Authentication-Results: i=1;
        rspamd-86646d89b6-hkkt4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Chief: 6c87491b7a692f71_1698443234143_31038536
X-MC-Loop-Signature: 1698443234142:3967467998
X-MC-Ingress-Time: 1698443234142
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.206.148 (trex/6.9.2);
        Fri, 27 Oct 2023 21:47:14 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4SHGTs1SXVz1NZ
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1698443233;
        bh=0kXzCiZbGPBTOEojx/2Lih4mxRwPi4XPavoOAgVaQRE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Lsd3wiihPliiMMmYhtQI88cIJg9fimvqMqdgkwhuzk65lErIyUvlqM9dOPeNjjg/n
         KHUzIcX+k8Ky1dwm5dnJj6SxA0+hV6RoMyZ7url0UsC2bfIeH/CD6Kx9SehEx6RWgL
         lU3Vws/irQxz3fv+7JOYY2l58I3sGQuIgej8+ib9C19rlEsm6vAO9Rl2kPE5B9bz87
         qyjdkWy3JyUTmTR8E4H0KMUmbuw8YEqh7cVZYN/BrU52hL88b3QSmnLZYGGxflmjy9
         Wk8x3EWdbNkL8BLjo61mTFpaA57ObpiU5ACZySlWEyUv/ViP7xdDdv6QeFzwFAtnli
         MuN8OKCn3/u5w==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00e5
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 27 Oct 2023 14:46:40 -0700
Date:   Fri, 27 Oct 2023 14:46:40 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Hildenbrand <david@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] proc: sysctl: prevent aliased sysctls from getting
 passed to init
Message-ID: <960ced39bec87d22f264ab73eec3e3c1a95ec026.1698441495.git.kjlx@templeofstupid.com>
References: <cover.1698441495.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698441495.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that checks for unknown boot options is unaware of the sysctl
alias facility, which maps bootparams to sysctl values.  If a user sets
an old value that has a valid alias, a message about an invalid
parameter will be printed during boot, and the parameter will get passed
to init.  Fix by checking for the existence of aliased parameters in the
unknown boot parameter code.  If an alias exists, don't return an error
or pass the value to init.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 0a477e1ae21b ("kernel/sysctl: support handling command line aliases")
---
 fs/proc/proc_sysctl.c  | 7 +++++++
 include/linux/sysctl.h | 6 ++++++
 init/main.c            | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c88854df0b62..1c9635dddb70 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1592,6 +1592,13 @@ static const char *sysctl_find_alias(char *param)
 	return NULL;
 }
 
+bool sysctl_is_alias(char *param)
+{
+	const char *alias = sysctl_find_alias(param);
+
+	return alias != NULL;
+}
+
 /* Set sysctl value passed on kernel command line. */
 static int process_sysctl_arg(char *param, char *val,
 			       const char *unused, void *arg)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 09d7429d67c0..61b40ea81f4d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -242,6 +242,7 @@ extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
+bool sysctl_is_alias(char *param);
 int do_proc_douintvec(struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
@@ -287,6 +288,11 @@ static inline void setup_sysctl_set(struct ctl_table_set *p,
 static inline void do_sysctl_args(void)
 {
 }
+
+static inline bool sysctl_is_alias(char *param)
+{
+	return false;
+}
 #endif /* CONFIG_SYSCTL */
 
 int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
diff --git a/init/main.c b/init/main.c
index 436d73261810..e24b0780fdff 100644
--- a/init/main.c
+++ b/init/main.c
@@ -530,6 +530,10 @@ static int __init unknown_bootoption(char *param, char *val,
 {
 	size_t len = strlen(param);
 
+	/* Handle params aliased to sysctls */
+	if (sysctl_is_alias(param))
+		return 0;
+
 	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */
-- 
2.25.1

