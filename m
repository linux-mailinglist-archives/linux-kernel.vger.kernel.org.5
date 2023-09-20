Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA077A87EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjITPIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjITPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:08:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B3AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:08:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c46b30a1ceso34613485ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695222519; x=1695827319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1hTqSXJfm7wcfrItcK5JrSlQOXjCv7HTCeKCGqvymQ=;
        b=fCLx4kJnxRnvn2RBWIlJp2xgrtfnSQrRXiPLB6hWl09ua9FnqQEnts2Slj+yPV7BJL
         qFTne1skdJE2P4UCMjVODMRwLc/zXesV8i6pYKRaDa/jleDOBjTrHnJqNEJszw7Cow92
         w/fCEPPX4mjYH6I9tfTeiuSFbgSP0O8pZB0SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222519; x=1695827319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1hTqSXJfm7wcfrItcK5JrSlQOXjCv7HTCeKCGqvymQ=;
        b=WWoCZ4wNsrciMgjPOGYApXDZxHPEBLFpVOXW731GC2+eAdqo2MoxkeXGJltH7WEoNG
         n/V0R5Jzdynkh2ZILMdOJtTrqzk+ixI37OrqUFT1bu6+PK8U5dpPAgbom/LWEAq9A9uZ
         dIhj4HGxTV9hJ1/l9oPgQwCOf3crOQJ9kXVO7LGwNOIqi3FM/TD7IhT8YmajZ+niKQR/
         SgFoKXKXIp1HN7YZ+rk78ioE7erT7UlL7Rua3TsRyGHMVNenQphsuyev/wlJEYUdDhrL
         m2IMH1LbdDIfDMZQviakVxSz0kuyhiNgjzb7EydHrI7vjzKR6F4Ouyeydmv3/ygTGJ1u
         /vxw==
X-Gm-Message-State: AOJu0YzUu8xNO/PHQvwhhrDHGGOZYSCqhhoYBksczceCLT83ei1GTOBo
        L4o8RSBF4j4ckGRrY7zZquzxUw==
X-Google-Smtp-Source: AGHT+IEYvSSgs4VfBdmet/Ntoo1ukThK7r/ZFBYCpjSeCZ3+S9ZUzjkeWklpd+2K8Ou/noxLiQj4Rg==
X-Received: by 2002:a17:902:c404:b0:1be:e7ba:3a97 with SMTP id k4-20020a170902c40400b001bee7ba3a97mr3205943plk.15.1695222519016;
        Wed, 20 Sep 2023 08:08:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902b78300b001c56157f062sm6096848pls.227.2023.09.20.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:08:38 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:08:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Message-ID: <202309200803.1911A584@keescook>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp>
 <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
 <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp>
 <6df9f8b8-5653-09a5-ae0a-6526016abaff@schaufler-ca.com>
 <ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 07:20:35PM +0900, Tetsuo Handa wrote:
> On 2023/09/18 1:38, Casey Schaufler wrote:
> > On 9/15/2023 11:32 PM, Tetsuo Handa wrote:
> >> +/**
> >> + * struct lsm_id - Identify a Linux Security Module.
> >> + * @lsm: name of the LSM, must be approved by the LSM maintainers
> >>
> >> Why can't you understand that "approved by the LSM maintainers" is a horrible
> >> requirement for LSM modules which cannot become one of in-tree LSMs?
> >>
> >> One of reasons for not every proposed LSM module can become in-tree is out of
> >> the LSM community's resources for reviewing/maintaining (or failure to acquire
> >> attention from the LSM community enough to get reviewed).
> >>
> >> + * @id: LSM ID number from uapi/linux/lsm.h
> >>
> >> Since the LSM community cannot accept all of proposed LSMs due to limited resources,
> >> the LSM community is responsible for allowing whatever proposed LSMs (effectively any
> >> publicly available LSMs) to live as out-of-tree LSMs, by approving the LSM name and
> >> assigning a permanent LSM ID number.
> >>
> >> The only exception the LSM community can refuse to approve/assign would be that the name
> >> is not appropriate (e.g. a LSM module named "FuckYou") or the name is misleading (e.g.
> >> "selinux+", "smock", "tomato", "apparmour"). Otherwise, no matter how many times you repeat
> >> "we don't care out-of-tree LSMs" or "I do not intentionally plan to make life difficult for
> >> the out-of-tree LSMs", this patch is intended to lock out out-of-tree LSMs.
> > 
> > That is a false statement. There is a huge difference between apathy and malice. 
> 
> Dave Chinner wrote at https://lkml.kernel.org/r/ZQo94mCzV7hOrVkh@dread.disaster.area
> as a response to "We don't care about out of tree filesystems.":
> 
>   In this case, we most certainly do care. Downstream distros support
>   all sorts of out of tree filesystems loaded via kernel modules, so a
>   syscall that is used to uniquely identify a filesystem type to
>   userspace *must* have a mechanism for the filesystem to provide that
>   unique identifier to userspace.
> 
>   Fundamentally, the kernel does not and should not dictate what
>   filesystem types it supports; the user decides what filesystem they
>   need to use, and it is the kernel's job to provide infrastructure
>   that works with that user's choice.
> 
> Can you see? What you are trying to is NACKed by simple s/filesystem/LSM/g .
> 
> The kernel is ultimately there for users. The kernel is never there for doing patent
> acquisition competition. If the LSM community accepts only LSMs which won the patent
> acquisition competition as in-tree (as described in "ANN: new LSM guidelines"),
> the LSM community is responsible for allowing any publicly available LSMs to live as
> out of tree modules.
> 
> Unless the policy is updated to approve any publicly available LSMs and assign a unique
> identifier (which can be passed to the syscalls introduced by this series) to each
> publicly available LSM, this series is a regression.
> 
> The "[PATCH v15 01/11] LSM: Identify modules by more than name" is exactly doing
> "LSM: allow only in-tree LSM modules, lock out out-of-tree LSM modules".
> Nack, Nack, Nack, Nack, Nack!!!!!

I feel like you are willfully not listening to us when we say that this
doesn't block out of tree LSMs. Again, there is nothing here that stops
it. To prove this point, here is an out of tree LSM that works with this
series. So let's move from theoretical to practical: given this example,
why do you think out of tree LSMs are blocked?


From a6f50cb719aac2452506babda07657f9f6961a95 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Wed, 20 Sep 2023 08:00:31 -0700
Subject: [PATCH] security: Add GOAT LSM

This will never go upstream, but it still works with the new LSM
syscalls.

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/lsm.h |  2 ++
 security/Kconfig         |  1 +
 security/Makefile        |  1 +
 security/goat/Kconfig    |  9 +++++++
 security/goat/Makefile   |  2 ++
 security/goat/goat.c     | 51 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+)
 create mode 100644 security/goat/Kconfig
 create mode 100644 security/goat/Makefile
 create mode 100644 security/goat/goat.c

diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index eeda59a77c02..23b7a8f79cef 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -63,6 +63,8 @@ struct lsm_ctx {
 #define LSM_ID_BPF		110
 #define LSM_ID_LANDLOCK		111
 
+#define LSM_ID_GOAT		1138
+
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
  * which are used in the kernel's LSM userspace API. Support
diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..0c692913a1a6 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -194,6 +194,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/goat/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index 59f238490665..1d260f994fac 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_GOAT)		+= goat/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/goat/Kconfig b/security/goat/Kconfig
new file mode 100644
index 000000000000..dd25848e3204
--- /dev/null
+++ b/security/goat/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SECURITY_GOAT
+	bool "Greatest Of All Time security features"
+	depends on SECURITY
+	help
+	  This LSM provides the greatest security features of all
+	  time.
+
+	  If in doubt, choose "Heck yeah".
diff --git a/security/goat/Makefile b/security/goat/Makefile
new file mode 100644
index 000000000000..e673c913f66f
--- /dev/null
+++ b/security/goat/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SECURITY_GOAT) += goat.o
diff --git a/security/goat/goat.c b/security/goat/goat.c
new file mode 100644
index 000000000000..f1eee60c9217
--- /dev/null
+++ b/security/goat/goat.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Greatest Linux Security Module Of All Time
+ *
+ * Author: Kees Cook <keescook@chromium.org>
+ */
+
+#define pr_fmt(fmt) "GOAT: " fmt
+
+#include <linux/module.h>
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+
+const struct lsm_id goat_lsmid = {
+	.name = "goat",
+	.id = LSM_ID_GOAT,
+};
+
+static int goat_read_file(struct file *file, enum kernel_read_file_id id,
+			  bool contents)
+{
+	pr_info("universally allowing file read\n");
+	return 0;
+}
+
+static int goat_load_data(enum kernel_load_data_id id, bool contents)
+{
+	pr_info("No blobs allowed!\n");
+	return -EUCLEAN;
+}
+
+static struct security_hook_list goat_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(kernel_read_file, goat_read_file),
+	LSM_HOOK_INIT(kernel_load_data, goat_load_data),
+};
+
+static int __init goat_init(void)
+{
+	pr_info("GOAT loading: Bleeeaaaeeeeggh\n");
+
+	security_add_hooks(goat_hooks, ARRAY_SIZE(goat_hooks), &goat_lsmid);
+
+	return 0;
+}
+
+DEFINE_LSM(goat) = {
+	.name = "goat",
+	.init = goat_init,
+};
-- 
2.34.1


-- 
Kees Cook
