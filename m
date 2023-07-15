Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16A75469D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGODsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGODsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:48:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0589530FB;
        Fri, 14 Jul 2023 20:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8aCWMj77QZ8ONW03YRtoGFYKcph9Q/SLzHgp+bEd3EY=; b=J3CzbnJ5LuguUHhMs7M3kxNxmE
        qHha+Wga7hF6k//BYHTBnvdKTTFV+SXANERUEA31UAcWIUyVzjXI6u4zDR9WIIKpkwqLHYKC9ZF0M
        2QCFNv7qVrp/1UrZ8XtVO7ntplNj5r7kWz3nnXWoqNbRG5dwcuizS2PavkdNDwaHLjuOVvX2vfCuT
        tFh45e26UUVv4JD5vkaXtAZp0ko6xOVnydjIj8EVSlqHdQRUfgPyeabbtbZ+qzIsSV0Wi+bEmS/mq
        ICCSjnDVR4O4Z+Bui39d9NEk9k5AjezfcicrVFhDNp4fJKiMY/ELbjxQJNoTr0f073XLt16FCHDFB
        r/+8ejOQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKWGT-007pkC-1Z;
        Sat, 15 Jul 2023 03:48:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2] docs: panic: cleanups for panic params
Date:   Fri, 14 Jul 2023 20:48:11 -0700
Message-ID: <20230715034811.9665-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move 'panic_print' to its correct place in alphabetical order.
Add parameter format for 'pause_on_oops'.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v2: rebase/resend since v1 did not apply cleanly;

 Documentation/admin-guide/kernel-parameters.txt |   30 +++++++-------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff -- a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4037,20 +4037,6 @@
 			timeout < 0: reboot immediately
 			Format: <timeout>
 
-	panic_print=	Bitmask for printing system info when panic happens.
-			User can chose combination of the following bits:
-			bit 0: print all tasks info
-			bit 1: print system memory info
-			bit 2: print timer info
-			bit 3: print locks info if CONFIG_LOCKDEP is on
-			bit 4: print ftrace buffer
-			bit 5: print all printk messages in buffer
-			bit 6: print all CPUs backtrace (if available in the arch)
-			*Be aware* that this option may print a _lot_ of lines,
-			so there are risks of losing older messages in the log.
-			Use this option carefully, maybe worth to setup a
-			bigger log buffer with "log_buf_len" along with this.
-
 	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
 			Format: <hex>[,nousertaint]
 			Hexadecimal bitmask representing the set of TAINT flags
@@ -4067,6 +4053,20 @@
 	panic_on_warn=1	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
+	panic_print=	Bitmask for printing system info when panic happens.
+			User can chose combination of the following bits:
+			bit 0: print all tasks info
+			bit 1: print system memory info
+			bit 2: print timer info
+			bit 3: print locks info if CONFIG_LOCKDEP is on
+			bit 4: print ftrace buffer
+			bit 5: print all printk messages in buffer
+			bit 6: print all CPUs backtrace (if available in the arch)
+			*Be aware* that this option may print a _lot_ of lines,
+			so there are risks of losing older messages in the log.
+			Use this option carefully, maybe worth to setup a
+			bigger log buffer with "log_buf_len" along with this.
+
 	parkbd.port=	[HW] Parallel port number the keyboard adapter is
 			connected to, default is 0.
 			Format: <parport#>
@@ -4186,7 +4186,7 @@
 			mode 0, bit 1 is for mode 1, and so on.  Mode 0 only
 			allowed by default.
 
-	pause_on_oops=
+	pause_on_oops=<int>
 			Halt all CPUs after the first oops has been printed for
 			the specified number of seconds.  This is to be used if
 			your oopses keep scrolling off the screen.
