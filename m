Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EBE7B3B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjI2Uko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Ukm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC521AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696019991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=aTxHeJJZooLm0LnqykCD+3TI4+Q/DSXoZTkzlwvMAIE=;
        b=Dox+kLslcU7jrHZX9zMdDtbjurmugBPNDQH9DhClECJ8/vHWAqTZRGoy0Lpkua0kO+ZJ+U
        Vlx6pDQDV1pWl6tROBQQ5PTNdaZIihirP5tNsW7uS551qnAmr0w3dox02WIeQRqWW35zll
        d+vAXcOqleEFKRGvvlmevVQUwMSy9u4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-vrCNtTJtPxik9U9WrzXkkQ-1; Fri, 29 Sep 2023 16:39:47 -0400
X-MC-Unique: vrCNtTJtPxik9U9WrzXkkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68FFF185A797;
        Fri, 29 Sep 2023 20:39:45 +0000 (UTC)
Received: from localhost (unknown [10.22.10.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94421170E9;
        Fri, 29 Sep 2023 20:39:43 +0000 (UTC)
Date:   Fri, 29 Sep 2023 17:39:42 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Wang Yong <wang.yong12@zte.com.cn>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.194-rt95
Message-ID: <ZRc2DtDvnsK7wVwR@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.194-rt95 stable release.

This release is an RT-only update. All the changes here are specific to RT.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: e9e1d0b892ed4e46c4d83b53f0f39880e37f8d92

Or to build 5.10.194-rt95 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.194.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.194-rt95.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.194-rt94:
---

Luis Claudio R. Goncalves (1):
      Linux 5.10.194-rt95

Wang Yong (1):
      arm64: signal: Use ARCH_RT_DELAYS_SIGNAL_SEND
---
arch/arm64/include/asm/signal.h | 12 ++++++++++++
 arch/arm64/kernel/signal.c      |  9 +++++++++
 localversion-rt                 |  2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)
---
diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
new file mode 100644
index 0000000000000..0fb418cf4c17a
--- /dev/null
+++ b/arch/arm64/include/asm/signal.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_ASM_SIGNAL_H
+#define __ARM64_ASM_SIGNAL_H
+
+#include <uapi/asm/signal.h>
+#include <uapi/asm/siginfo.h>
+
+#if defined(CONFIG_PREEMPT_RT)
+#define ARCH_RT_DELAYS_SIGNAL_SEND
+#endif
+
+#endif
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 94eed0dc3afcd..5b08f55ec85d9 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -929,6 +929,15 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		} else {
 			local_daif_restore(DAIF_PROCCTX);
 
+#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
+			if (unlikely(current->forced_info.si_signo)) {
+				struct task_struct *t = current;
+
+				force_sig_info(&t->forced_info);
+				t->forced_info.si_signo = 0;
+			}
+#endif
+
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
diff --git a/localversion-rt b/localversion-rt
index 8d02a9bac5002..5a28f0a65d160 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt94
+-rt95

