Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C8576D5CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjHBRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjHBRoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:44:46 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4053170D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998282; bh=A6mBf0PznOnjsH4Cba6KEUzaZF6cjM9jVGUhLmag6CU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MbzXD/Bvb+Hmqp00RBO0RNE5/wYhV6pEA0Oxtk/ztsSWeCQqOD7cbgpwXyJaSOo0Y8DqRe8EDvdNFj7wJSGqI8T/b56rs3PPyBRc7Tz39u0QO5NCtEYjg6pA2LOsepPC8WtQ7+x1uTHnFw9887QK2xYGGko2NK/k5tux2Rh/f3dRCPxYo9jbUod/155mrs2GtBhWD4SlwvIovTdg7q4VY92/oev4iT+6Wmr6SkI9Wqk5YtfCK9n29lAPggOIuyTRofxoTrsk1xWhxNIG685ViOgx2SpMWk4/CBdmRiP6vFhFacQYouS0nD2hNCKEs0ZLMDRGSMAjWjdXYVSYerHcFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998282; bh=uDtwqe/r6cp/vL9O5jCXlp3+1w6KGL1Dzghmvcrl+Po=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gJQGf1K+3ywqogNte4eBXyLQZ7VOofopL+JpJEbUPp5Fd11c23AMufHLIpzEjPmuEAB4zQ3EtdCDND23UbrZS+R3IxJLUa2OnStAsIFzjnGe7aWZKpVOmAMlEP1Q1fedBgAdnn0Bxj7yGpEPtnzIQ12PNPNQhQpx+0xpegnK/ciitr0BQqkUaVny2ysz8chcSduwdn3Sd14wWjfvPWtnn63vsv/cCT8YptGhFXPY3U8WzN4vqnCmeB4AfQayIn5MKpLQtnvp5jfkwuoopeMbaHFQm4KLd2WHuGdld8pDMUhBLBkdvh6N6oyIyeiYNRnECVfbGs/f8uBtvCTVAy7Lfw==
X-YMail-OSG: 0OI.3PMVM1m4iWg2fji92h3D_M0DKixR5TDcHOEvkepleGCu2ZXTdk.4q39Igik
 BCq5uIgSrZPirXoupCVHE32wZB4TFcLEg21xk1lqbsPqy52xViHz1A5Fg9mWKbXGwS3R2uCXR.p7
 ry5mdJO.S93YaCufttw6XfHqLbmU3wjs0Kd2Mtc.jeWQfS7hF.MQrOMYbpbhPhviOv_ZAP6i69bz
 CBz4MWR.jW6GVltn02QvxZQ75eiekjokmGSxnL6YJNL25v07PEoLaxbo.3DBFr8X9OUrIfCEZbaE
 WRs203X0A29tluxkztoAr.BqpiPAB9qIC.zIJMRX7cfKPC_3F16BohdraKcLx0Y_qtmlmax3Em.Q
 LzkZqYjV9Gr5WRpjWtAbdO5f7plnVL8t4OqgljBp9urIDXvUXchQwziEIfIAakjRzV6Nswj6oYFo
 DM.IM8bDc7LtcbIoocmmvkiZQ5wqYU5QzudBTnQX3RQ1kT6DLNXvt3sKZiNstf_D4IU9Rr0f3hE4
 rfspEu90SyGjzgx074v0o96PRhCW6hxRjIOPoJh.AleVWorCGxiZpsbAYyKZtVra7lYp.jFi3ee9
 nRZqTIiHhlo0FfkFP2CZ50OBayfKh7gauqbKjR2jNmC38q2qs_76FX8FUqCcGYRzxfuDOeGBQ1a2
 G.bBsGFmotwn1_fa3g2RRiO6FL9FNRXZSNapAFzSJjdPup_ozdzt6j5jE7Xsx4IA3ukW46TLdq5I
 frH_M0wLHSSAZr2ZiizDvc5X2MlGGxzoxP5YqiVAHKLeExA_WTc81UFQu9yF2TM.4hdtIjKr0DRL
 RajByiuVWchTrdAoTtVDUjtVNs8m4U8PtJWu_mDae4CshMx_LyxtDduI0d8ZpM4Fj28wH8IzIvks
 wiMYnCUPvEW8eumLCmcx.TC1ipBqdF9GY_sVKKR3Z8ekxPFZxnQkIVpujPve6X3jqM5avOjQYTgu
 nl.A8Mepcbwda37npPRDJjtPNdYT9kt07hdZWMOrxrgxI7UBx9y5JbZjDoDGMj_c5kwmFRP6HmR2
 Gm0M8x3bVvkzgFa9iVIU36J1HlTwyETqxUwIbE0XWlJh0i8F2_.qSObZR81dg4aoDZ1A7lbXrI1J
 JsG9CoBFs70.Tdl90tygY9mrNYGFNMqDNj4qjS9f.rWL7CybMWU_GaCQUMTTQ3SEjX_cMYq1SECs
 xSRNlJhHKmfDjSucgqGdA6nh1nJO1u0SIaIzxHidOV1Rbpx6DmCz.3LHn6wGeOnNKMrbRb.Z9Cab
 pglFXQcRuimLf.NALIfMsKJlfLuqVB4J3EwDPwySttPhwfArg_qv8KNdPOH0KH56DoQezuc28bL4
 UyWS7mh7Tm2qmLhgNvtCh8RjSH667rJxFrpiSzamhLJqBpHxGa7nA1QYwrKQU4Hfrgg8BTj7MmKx
 OkIdEPBHJPtnsdhwjp8CCGFUZ03J3RlPnhQXJjwsnfmj6INqtl83.ed7uoUJEV9OKfTO_1neUHcK
 Mdztke4.ue2EFlbo9U4Sr84iGONQXsJKevJHk7YKnfatIcMzrR4uX7jCyhhQTb9ooGf77O_kzMVu
 KOiehlrVX9JxCWzmdufNNKAZNvbWq.jexMAWz9OGYxucmT5asgVy3LZ9sogr.WZqa_6BAGRjWbY_
 aHsEPxQ15X4MJQamkdXxzeU9RMuEBQTJ71nl_3I7sxKe3YRydsd0QTj4830i0jmwPOOGdqzJZuDx
 WvJcrU1.QAV_oEyStwyT33JjQ_IE8N3u.1M6fXxqeX4emhA8tDDi0x19Y1CT14Cfp91nnKzDqikF
 s32AoMw2tZjH4DeF0sEQFbuizkc1XzM.Dn4nRXMWEitia_YulXmAZ_t85RCXWZJbAiXUvWlSk6aC
 LqKdkRwnr5K6.yIMX19.rs3.0zxwNmdVrc2tcDRcflEi00VIDMhQPB1H8sJQT8w4i4vI3HQfpH36
 mTpZiPV36hO2Rn_92BB92Nq8.3u.uCLHjxm3zdjNG7G0mHMcmI3f_v45fMk3TIXpMVSdiv_PDjFJ
 kwZxyPfBRSWPsouzzmwwZD4lo9a7IK_hnYTMN28e9DumU7BNeHwppf7nZmBczOJjA2hamLhkxO.T
 Z_t7l6L.A1gPzdyqcVtoUKVI3Vr3I3IGN4S3S1Q2rBvrTicJHavnmxw95KCI3qGL4Tc4iyKW39pb
 0kkRxcgcMfz2S0j3QBIFKa95jCKW3c4HAma8_VSwQgKH7uQzmoXhF3BWhuZCHa7HitWeW0Ct17o5
 8GkCcbuRBPdgcEuWp.49HrfC8rIcvdeQGZl7sViVALZN44ts_x8203xbzVq3glrUv.YIKXyE02fa
 ipWp1KkGIcZitgtl3Xw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6fa78a8f-fd8d-4543-b293-ae269e61f885
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:44:42 +0000
Received: by hermes--production-gq1-7d844d8954-psjqr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 839fbc661e28c041ce8f4c5628604c14;
          Wed, 02 Aug 2023 17:44:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v13 01/11] LSM: Identify modules by more than name
Date:   Wed,  2 Aug 2023 10:44:24 -0700
Message-ID: <20230802174435.11928-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a struct lsm_id to contain identifying information
about Linux Security Modules (LSMs). At inception this contains
the name of the module, an identifier associated with the security
module and an integer member "attrs" which identifies the API
related data associated with each security module. The initial set
of features maps to information that has traditionaly been available
in /proc/self/attr. They are documented in a new userspace-api file.
Change the security_add_hooks() interface to use this structure.
Change the individual modules to maintain their own struct lsm_id
and pass it to security_add_hooks().

The values are for LSM identifiers are defined in a new UAPI
header file linux/lsm.h. Each existing LSM has been updated to
include it's LSMID in the lsm_id.

The LSM ID values are sequential, with the oldest module
LSM_ID_CAPABILITY being the lowest value and the existing modules
numbered in the order they were included in the main line kernel.
This is an arbitrary convention for assigning the values, but
none better presents itself. The value 0 is defined as being invalid.
The values 1-99 are reserved for any special case uses which may
arise in the future. This may include attributes of the LSM
infrastructure itself, possibly related to namespacing or network
attribute management. A special range is identified for such attributes
to help reduce confusion for developers unfamiliar with LSMs.

LSM attribute values are defined for the attributes presented by
modules that are available today. As with the LSM IDs, The value 0
is defined as being invalid. The values 1-99 are reserved for any
special case uses which may arise in the future.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Mickael Salaun <mic@digikod.net>
---
 Documentation/userspace-api/index.rst |  1 +
 MAINTAINERS                           |  1 +
 include/linux/lsm_hooks.h             | 16 ++++++++++++++--
 security/apparmor/lsm.c               |  8 +++++++-
 security/bpf/hooks.c                  |  9 ++++++++-
 security/commoncap.c                  |  8 +++++++-
 security/landlock/cred.c              |  2 +-
 security/landlock/fs.c                |  2 +-
 security/landlock/ptrace.c            |  2 +-
 security/landlock/setup.c             |  6 ++++++
 security/landlock/setup.h             |  1 +
 security/loadpin/loadpin.c            |  9 ++++++++-
 security/lockdown/lockdown.c          |  8 +++++++-
 security/safesetid/lsm.c              |  9 ++++++++-
 security/security.c                   | 12 ++++++------
 security/selinux/hooks.c              |  9 ++++++++-
 security/smack/smack_lsm.c            |  8 +++++++-
 security/tomoyo/tomoyo.c              |  9 ++++++++-
 security/yama/yama_lsm.c              |  8 +++++++-
 19 files changed, 107 insertions(+), 21 deletions(-)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 72a65db0c498..b5fa29c077eb 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -32,6 +32,7 @@ place where this information is gathered.
    sysfs-platform_profile
    vduse
    futex2
+   lsm
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..aca4db11dd02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19156,6 +19156,7 @@ L:	linux-security-module@vger.kernel.org (suggested Cc:)
 S:	Supported
 W:	http://kernsec.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
+F:	include/uapi/linux/lsm.h
 F:	security/
 X:	security/selinux/
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ab2b2fafa4a4..5f7d8caacc00 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -41,6 +41,18 @@ struct security_hook_heads {
 	#undef LSM_HOOK
 } __randomize_layout;
 
+/**
+ * struct lsm_id - Identify a Linux Security Module.
+ * @lsm: name of the LSM, must be approved by the LSM maintainers
+ * @id: LSM ID number from uapi/linux/lsm.h
+ *
+ * Contains the information that identifies the LSM.
+ */
+struct lsm_id {
+	const char	*name;
+	u64		id;
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -49,7 +61,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	const char			*lsm;
+	const struct lsm_id		*lsmid;
 } __randomize_layout;
 
 /*
@@ -84,7 +96,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm);
+			       const struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c9463bd0307d..bfd049c3fd22 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -24,6 +24,7 @@
 #include <linux/zstd.h>
 #include <net/sock.h>
 #include <uapi/linux/mount.h>
+#include <uapi/linux/lsm.h>
 
 #include "include/apparmor.h"
 #include "include/apparmorfs.h"
@@ -1215,6 +1216,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
+static const struct lsm_id apparmor_lsmid = {
+	.name = "apparmor",
+	.id = LSM_ID_APPARMOR,
+};
+
 static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1904,7 +1910,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index cfaf1d0e6a5f..57b9ffd53c98 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -5,6 +5,7 @@
  */
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
+#include <uapi/linux/lsm.h>
 
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
@@ -15,9 +16,15 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
+static const struct lsm_id bpf_lsmid = {
+	.name = "bpf",
+	.id = LSM_ID_BPF,
+};
+
 static int __init bpf_lsm_init(void)
 {
-	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
+			   &bpf_lsmid);
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index ab5742ab4362..4e94075656e9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/personality.h>
 #include <linux/mnt_idmapping.h>
+#include <uapi/linux/lsm.h>
 
 /*
  * If a non-root user executes a setuid-root binary in
@@ -1440,6 +1441,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static const struct lsm_id capability_lsmid = {
+	.name = "capability",
+	.id = LSM_ID_CAPABILITY,
+};
+
 static struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1464,7 +1470,7 @@ static struct security_hook_list capability_hooks[] __ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 13dff2a31545..786af18c4a1c 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -42,5 +42,5 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 __init void landlock_add_cred_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 1c0c198f6fdb..db5ebecfbf02 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1307,5 +1307,5 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 __init void landlock_add_fs_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index 8a06d6c492bf..2bfc533d36e4 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -116,5 +116,5 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 __init void landlock_add_ptrace_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			   LANDLOCK_NAME);
+			   &landlock_lsmid);
 }
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 0f6113528fa4..aab13750edde 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 #include "common.h"
 #include "cred.h"
@@ -24,6 +25,11 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+const struct lsm_id landlock_lsmid = {
+	.name = LANDLOCK_NAME,
+	.id = LSM_ID_LANDLOCK,
+};
+
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..c4252d46d49d 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -14,5 +14,6 @@
 extern bool landlock_initialized;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
+extern const struct lsm_id landlock_lsmid;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ebae964f7cc9..9fbc90f0e65b 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -20,6 +20,7 @@
 #include <linux/string_helpers.h>
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
+#include <uapi/linux/lsm.h>
 
 #define VERITY_DIGEST_FILE_HEADER "# LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS"
 
@@ -208,6 +209,11 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_check(NULL, (enum kernel_read_file_id) id);
 }
 
+static const struct lsm_id loadpin_lsmid = {
+	.name = "loadpin",
+	.id = LSM_ID_LOADPIN,
+};
+
 static struct security_hook_list loadpin_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -259,7 +265,8 @@ static int __init loadpin_init(void)
 	if (!register_sysctl("kernel/loadpin", loadpin_sysctl_table))
 		pr_notice("sysctl registration failed!\n");
 #endif
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 
 	return 0;
 }
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 68d19632aeb7..f2bdbd55aa2b 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 
 static enum lockdown_reason kernel_locked_down;
 
@@ -75,6 +76,11 @@ static struct security_hook_list lockdown_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static const struct lsm_id lockdown_lsmid = {
+	.name = "lockdown",
+	.id = LSM_ID_LOCKDOWN,
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +89,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 5be5894aa0ea..1ba564f097f5 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched/task_stack.h>
 #include <linux/security.h>
+#include <uapi/linux/lsm.h>
 #include "lsm.h"
 
 /* Flag indicating whether initialization completed */
@@ -261,6 +262,11 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 	return 0;
 }
 
+static const struct lsm_id safesetid_lsmid = {
+	.name = "safesetid",
+	.id = LSM_ID_SAFESETID,
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
@@ -271,7 +277,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index b720424ca37d..feaae09581dc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -512,17 +512,17 @@ static int lsm_append(const char *new, char **result)
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-			       const char *lsm)
+			       const struct lsm_id *lsmid)
 {
 	int i;
 
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -531,7 +531,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->name, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -3778,7 +3778,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -3803,7 +3803,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..c900813fc8f7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6929,6 +6930,11 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
+static const struct lsm_id selinux_lsmid = {
+	.name = "selinux",
+	.id = LSM_ID_SELINUX,
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7250,7 +7256,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6e270cf3fd30..f3e4b26c8a87 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,7 @@
 #include <linux/fs_parser.h>
 #include <linux/watch_queue.h>
 #include <linux/io_uring.h>
+#include <uapi/linux/lsm.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -4871,6 +4872,11 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static const struct lsm_id smack_lsmid = {
+	.name = "smack",
+	.id = LSM_ID_SMACK,
+};
+
 static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -5077,7 +5083,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 25006fddc964..9dc8e64890bc 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
 #include "common.h"
 
 /**
@@ -542,6 +543,11 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static const struct lsm_id tomoyo_lsmid = {
+	.name = "tomoyo",
+	.id = LSM_ID_TOMOYO,
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -595,7 +601,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 2503cf153d4a..49dc52b454ef 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -18,6 +18,7 @@
 #include <linux/task_work.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <uapi/linux/lsm.h>
 
 #define YAMA_SCOPE_DISABLED	0
 #define YAMA_SCOPE_RELATIONAL	1
@@ -421,6 +422,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static const struct lsm_id yama_lsmid = {
+	.name = "yama",
+	.id = LSM_ID_YAMA,
+};
+
 static struct security_hook_list yama_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -471,7 +477,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.41.0

