Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF7B780CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377247AbjHRNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377248AbjHRNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5854B30F5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692366187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=e934zJ4Y+NrdVCj0YwCdAAjU2Txt7SiE8zuv/ETVT0Y=;
        b=DUTIjUw5ejtSaf8YdOS1TQbgTbrTCJbUXIIdpKUPqk5xWqRMne7Xe7Ig5IUQwbyuR9zY/f
        XgBJBbItujrNVn/8Epljip7Mg0Xhl5CPj+MeJd6A5Q2JIuK3ixX6N52wgyaQnZrO09JWR4
        B6Zd1fca0TkVwhHbaS6+6ciufpkK7cQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-Nf-6TaWjNvmF6Y5NseGhxA-1; Fri, 18 Aug 2023 09:43:04 -0400
X-MC-Unique: Nf-6TaWjNvmF6Y5NseGhxA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4179E8011AD;
        Fri, 18 Aug 2023 13:43:04 +0000 (UTC)
Received: from localhost (unknown [10.22.8.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7E57492C13;
        Fri, 18 Aug 2023 13:43:03 +0000 (UTC)
Date:   Fri, 18 Aug 2023 10:43:02 -0300
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.320-rt152
Message-ID: <ZN91PvQbpc3jE/zd@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

I'm pleased to announce the 4.14.320-rt152 stable release.

This release is an RT-only update. All the changes here are specific to RT.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 3b05adff8894f6d2f56f54faf7876b15e9442dad

Or to build 4.14.320-rt152 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.320.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.320-rt152.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v4.14.320-rt151:
---

Clark Williams (1):
      rt: PREEMPT_RT safety net for backported patches

Luis Claudio R. Goncalves (1):
      Linux 4.14.320-rt152
---
kernel/Kconfig.preempt | 4 ++++
 localversion-rt        | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)
---
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 11dbe26a8279..97875b4eb569 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -6,6 +6,9 @@ config PREEMPT_RT_BASE
 	bool
 	select PREEMPT
 
+config PREEMPT_RT
+       bool
+
 config HAVE_PREEMPT_LAZY
 	bool
 
@@ -78,6 +81,7 @@ config PREEMPT_RT_FULL
 	depends on IRQ_FORCED_THREADING
 	select PREEMPT_RT_BASE
 	select PREEMPT_RCU
+	select PREEMPT_RT
 	help
 	  All and everything
 
diff --git a/localversion-rt b/localversion-rt
index 7c59c4689f8b..2fd0f636104d 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt151
+-rt152

