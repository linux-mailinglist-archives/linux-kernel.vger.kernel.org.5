Return-Path: <linux-kernel+bounces-95241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06FE874B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC1281750
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB083CCA;
	Thu,  7 Mar 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yPPXjblG"
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A6839EF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804391; cv=none; b=bS9vlXppgTEriZbnD0j4VklzL4SP4Oenlk9S737uvMqAsbCSF30yY0hiFQdFp7ibxJ8j/0Rkd6J0VYswJfhnPKxRcBn9jODj6dPAq1wmV6nPTX4eZ4DXVtVocbaIywooOBJV4jN2XFNQ6WoOICXn3cT52mxea6PczschE44z+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804391; c=relaxed/simple;
	bh=KluVRBv/19f0IRGPeyv1rPXZYsvrNfNV39euLt5Oi7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz7xUvm9bKTtxoIL+Q2lPmzMM0rXRruGKmPFfX+x7oDwVnJt2UEdHVzXoelzmMWn7YN5o7OUepqErwl9crLgORcbNHeq1I5IgT/CzruZGGsUIcqBGPHwQl4Nlrav25pH0ZN6/TZnyDitpdlBjirchzzlHecDWt2zfsZn+VSzCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yPPXjblG; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tr45R2qsDz15fF;
	Thu,  7 Mar 2024 10:39:39 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tr45Q6rtjzr1;
	Thu,  7 Mar 2024 10:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709804379;
	bh=KluVRBv/19f0IRGPeyv1rPXZYsvrNfNV39euLt5Oi7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yPPXjblGjDxz+Oi9NbOFj1XxmtiPFkvsO6TI0jgs/97zDRSLz+CczRcToBOo1JdMq
	 kJHMAk3wS+LTMfIm8D2RjTZLnmHW6ksU+DXJWcE8AvqZCwZI8GTUtFpOgVe1pHkmpS
	 CNM3g4RkWdADHe/K0HQwGBHrdPyMbKBUivzqkoVY=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] landlock: Rename "ptrace" files to "task"
Date: Thu,  7 Mar 2024 10:39:23 +0100
Message-ID: <20240307093923.1466071-2-mic@digikod.net>
In-Reply-To: <20240307093923.1466071-1-mic@digikod.net>
References: <20240307093923.1466071-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

ptrace.[ch] are currently only used for the ptrace LSM hooks but their
scope will expand with IPCs and audit support.  Rename ptrace.[ch] to
task.[ch], which better reflect their content.  Similarly, rename
landlock_add_ptrace_hooks() to landlock_add_task_hooks().  Keep header
files for now.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/Makefile             | 2 +-
 security/landlock/setup.c              | 4 ++--
 security/landlock/{ptrace.c => task.c} | 4 ++--
 security/landlock/{ptrace.h => task.h} | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)
 rename security/landlock/{ptrace.c => task.c} (98%)
 rename security/landlock/{ptrace.h => task.h} (52%)

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index c2e116f2a299..b4538b7cf7d2 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
 landlock-y := setup.o syscalls.o object.o ruleset.o \
-	cred.o ptrace.o fs.o
+	cred.o task.o fs.o
 
 landlock-$(CONFIG_INET) += net.o
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f6dd33143b7f..28519a45b11f 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -14,8 +14,8 @@
 #include "cred.h"
 #include "fs.h"
 #include "net.h"
-#include "ptrace.h"
 #include "setup.h"
+#include "task.h"
 
 bool landlock_initialized __ro_after_init = false;
 
@@ -34,7 +34,7 @@ const struct lsm_id landlock_lsmid = {
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
-	landlock_add_ptrace_hooks();
+	landlock_add_task_hooks();
 	landlock_add_fs_hooks();
 	landlock_add_net_hooks();
 	landlock_initialized = true;
diff --git a/security/landlock/ptrace.c b/security/landlock/task.c
similarity index 98%
rename from security/landlock/ptrace.c
rename to security/landlock/task.c
index 2bfc533d36e4..849f5123610b 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/task.c
@@ -16,9 +16,9 @@
 
 #include "common.h"
 #include "cred.h"
-#include "ptrace.h"
 #include "ruleset.h"
 #include "setup.h"
+#include "task.h"
 
 /**
  * domain_scope_le - Checks domain ordering for scoped ptrace
@@ -113,7 +113,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
 };
 
-__init void landlock_add_ptrace_hooks(void)
+__init void landlock_add_task_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
 			   &landlock_lsmid);
diff --git a/security/landlock/ptrace.h b/security/landlock/task.h
similarity index 52%
rename from security/landlock/ptrace.h
rename to security/landlock/task.h
index 265b220ae3bf..7c00360219a2 100644
--- a/security/landlock/ptrace.h
+++ b/security/landlock/task.h
@@ -6,9 +6,9 @@
  * Copyright © 2019 ANSSI
  */
 
-#ifndef _SECURITY_LANDLOCK_PTRACE_H
-#define _SECURITY_LANDLOCK_PTRACE_H
+#ifndef _SECURITY_LANDLOCK_TASK_H
+#define _SECURITY_LANDLOCK_TASK_H
 
-__init void landlock_add_ptrace_hooks(void);
+__init void landlock_add_task_hooks(void);
 
-#endif /* _SECURITY_LANDLOCK_PTRACE_H */
+#endif /* _SECURITY_LANDLOCK_TASK_H */
-- 
2.44.0


