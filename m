Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D205280EE59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376462AbjLLOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376435AbjLLOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:05:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CA0AD;
        Tue, 12 Dec 2023 06:05:54 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:05:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702389952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcMokWq25uAys5K3zaZ/+MW+ia8KqiqZhTtnTFZPKas=;
        b=h+eOd3J2g2Iyqj5Eg0ooxHw6XCGxHg4gvtqhaOe60A/Q3U+CHD/9yTaL8EWrsUuwEUAD8a
        H4ti4m8WIPSdIRFeWrM8ZDsUTdvMnTfk1ckQjydATknUkjO6JY7WJaPsI/WAxBi+IwUWLK
        MMF++VomQG7dr7D5XWUKBRcG6p/WmXPtaCRiPJ75edW30PzZfIwcMZsQ2OyA9D7ACU7+0T
        YKjuDGeqMtr6byemJazGY5G6fVUepJQchULJ7r9laoVeWK2cdMrf5pAk8DCfCfpFFpC7lo
        zwntlr8N9yob1WqLoV4f8xYEHSt06C5UiN4GhatC8EehqONEs55OZ3vhF2hUBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702389952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcMokWq25uAys5K3zaZ/+MW+ia8KqiqZhTtnTFZPKas=;
        b=vJ2cDEMliaJe9AtMpEZrJRw5/yBFpnHSXG23r8BCDBOu4sKkWssnPvKmwkcwfSNddwxf6E
        02AIrP/6dBc/pfCA==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/docs: Remove reference to syscall trampoline in PTI
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231102130204.41043-1-nik.borisov@suse.com>
References: <20231102130204.41043-1-nik.borisov@suse.com>
MIME-Version: 1.0
Message-ID: <170238995160.398.1051285467012003027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7a0a6d55ed93fe064039c4e014d5cf3a97391bbb
Gitweb:        https://git.kernel.org/tip/7a0a6d55ed93fe064039c4e014d5cf3a97391bbb
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Thu, 02 Nov 2023 15:02:04 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 12 Dec 2023 14:43:59 +01:00

x86/docs: Remove reference to syscall trampoline in PTI

Commit

  bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")

removed the syscall trampoline and instead opted to enable using the
default SYSCALL64 entry point by mapping the percpu TSS. Unfortunately,
the PTI documentation wasn't updated when the respective changes were
made, so bring the doc up to speed.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231102130204.41043-1-nik.borisov@suse.com
---
 Documentation/arch/x86/pti.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/x86/pti.rst b/Documentation/arch/x86/pti.rst
index 4b858a9..e08d351 100644
--- a/Documentation/arch/x86/pti.rst
+++ b/Documentation/arch/x86/pti.rst
@@ -81,11 +81,9 @@ this protection comes at a cost:
      and exit (it can be skipped when the kernel is interrupted,
      though.)  Moves to CR3 are on the order of a hundred
      cycles, and are required at every entry and exit.
-  b. A "trampoline" must be used for SYSCALL entry.  This
-     trampoline depends on a smaller set of resources than the
-     non-PTI SYSCALL entry code, so requires mapping fewer
-     things into the userspace page tables.  The downside is
-     that stacks must be switched at entry time.
+  b. Percpu TSS is mapped into the user page tables to allow SYSCALL64 path
+     to work under PTI. This doesn't have a direct runtime cost but it can
+     be argued it opens certain timing attack scenarios.
   c. Global pages are disabled for all kernel structures not
      mapped into both kernel and userspace page tables.  This
      feature of the MMU allows different processes to share TLB
@@ -167,7 +165,7 @@ that are worth noting here.
  * Failures of the selftests/x86 code.  Usually a bug in one of the
    more obscure corners of entry_64.S
  * Crashes in early boot, especially around CPU bringup.  Bugs
-   in the trampoline code or mappings cause these.
+   in the mappings cause these.
  * Crashes at the first interrupt.  Caused by bugs in entry_64.S,
    like screwing up a page table switch.  Also caused by
    incorrectly mapping the IRQ handler entry code.
