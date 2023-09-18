Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AB47A46C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbjIRKPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbjIRKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:15:01 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5201ACD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:14:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:9622:9b2f:73fd:43ad])
        by baptiste.telenet-ops.be with bizsmtp
        id nNEr2A00d4u9dj801NEr9R; Mon, 18 Sep 2023 12:14:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qiBGw-003wYZ-LZ;
        Mon, 18 Sep 2023 12:14:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qiBHH-006GjX-FP;
        Mon, 18 Sep 2023 12:14:51 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/2] powerpc: Replace GPL 2.0+ README.legal boilerplate with SPDX
Date:   Mon, 18 Sep 2023 12:14:44 +0200
Message-Id: <d91725ff1ed5d4b6ba42474e2ebfeebe711cba23.1695031668.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695031668.git.geert@linux-m68k.org>
References: <cover.1695031668.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream Linux never had a "README.legal" file, but it was present
in early source releases of Linux/m68k.  It contained a simple copyright
notice and a link to a version of the "COPYING" file that predated the
addition of the "only valid GPL version is v2" clause.

Get rid of the references to non-existent files by replacing the
boilerplate with SPDX license identifiers.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - s/existant/existent/.
---
 arch/powerpc/kernel/ptrace/ptrace.c | 5 +----
 arch/powerpc/kernel/signal.c        | 5 +----
 arch/powerpc/kernel/signal.h        | 7 ++-----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 5d7a72b41ae71158..727ed4a145451356 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  PowerPC version
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -9,10 +10,6 @@
  *
  * Modified by Cort Dougan (cort@hq.fsmlabs.com)
  * and Paul Mackerras (paulus@samba.org).
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file README.legal in the main directory of
- * this archive for more details.
  */
 
 #include <linux/regset.h>
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 68a91e553e14cea2..aa17e62f37547a79 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Common signal handling code for both 32 and 64 bits
  *
  *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Corporation
  *    Extracted from signal_32.c and signal_64.c
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file README.legal in the main directory of
- * this archive for more details.
  */
 
 #include <linux/resume_user_mode.h>
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index a429c57ed4331805..58ecea1cdc27ae80 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -1,10 +1,7 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
  *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Corporation
  *    Extracted from signal_32.c and signal_64.c
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file README.legal in the main directory of
- * this archive for more details.
  */
 
 #ifndef _POWERPC_ARCH_SIGNAL_H
-- 
2.34.1

