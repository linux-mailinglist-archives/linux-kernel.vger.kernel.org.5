Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C9812A96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjLNIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjLNIpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:45:18 -0500
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E0E3;
        Thu, 14 Dec 2023 00:45:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECECCE1D60;
        Thu, 14 Dec 2023 09:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1702543520; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=sDSb1qqHtkUz2/XPauaz/NpVOMr1hYcEwXh+vxb5xOM=;
        b=qkEQ9YI3iIyEBnMTfq8Jtoj5HwaF8OuTT9xFUHbpEUAAcJWp5Vmr8h2SaS42JoelIFfuqz
        nVW0LJWPdh4dBMugTgl0EzhEOYOlBPnRI3XaBlZ1OYxvyS7o9FR4I+YUf5+m6CrhJ8g1mr
        QByI3MT7ZmTogTGOhgjYae0+ZCMYf7TclNGE8A7IEqZ/X3jjT4Aa6mJwFeHaZyZgViyFmN
        jKNBR6F22V9UtCk1FH7yboTfeDDZMIQqeGsqAa/D4yDNU7bX0iIEt91OrPB+CFyUKziK5z
        kzZfHGPOyRzkShFLlD8gxm5DQJF4u8MlsTgtOXZKjH5Ka4MzeIP2KK3QIBDq1g==
Date:   Thu, 14 Dec 2023 09:45:17 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.299-rt130
Message-ID: <170254303594.22090.13135204123422729997@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.299-rt130 stable release. This
is just updating the stable release 4.19.299. No RT specific changes.

There was a conflict due to the backport of 56e894982522 ("sched/rt:
Provide migrate_disable/enable() inlines") to stable. Thus I dropped the
backport because v4.19-rt already provides these two functions.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: a279ca52df99df429ac873bcd8cf7df8569758ae

Or to build 4.19.299-rt130 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.299.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.299-rt130.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.295-rt129:
---

Daniel Wagner (2):
      Revert "sched/rt: Provide migrate_disable/enable() inlines"
      Linux 4.19.299-rt130
---
include/linux/preempt.h | 30 ------------------------------
 localversion-rt         |  2 +-
 2 files changed, 1 insertion(+), 31 deletions(-)
---
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 29ecd13afdda..9c74a019bf57 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -422,34 +422,4 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
-/**
- * migrate_disable - Prevent migration of the current task
- *
- * Maps to preempt_disable() which also disables preemption. Use
- * migrate_disable() to annotate that the intent is to prevent migration,
- * but not necessarily preemption.
- *
- * Can be invoked nested like preempt_disable() and needs the corresponding
- * number of migrate_enable() invocations.
- */
-static __always_inline void migrate_disable(void)
-{
-	preempt_disable();
-}
-
-/**
- * migrate_enable - Allow migration of the current task
- *
- * Counterpart to migrate_disable().
- *
- * As migrate_disable() can be invoked nested, only the outermost invocation
- * reenables migration.
- *
- * Currently mapped to preempt_enable().
- */
-static __always_inline void migrate_enable(void)
-{
-	preempt_enable();
-}
-
 #endif /* __LINUX_PREEMPT_H */
diff --git a/localversion-rt b/localversion-rt
index 90303f5aabcf..6fa797e5b850 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt129
+-rt130
