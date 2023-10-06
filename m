Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15517BB549
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjJFKc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjJFKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:32:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51CC9F;
        Fri,  6 Oct 2023 03:32:22 -0700 (PDT)
Date:   Fri, 06 Oct 2023 10:32:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696588341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVisgtQNVzDiyDauoPwFi6xuBYYibbumtylUKxIkQlQ=;
        b=Xc6RXRYORtjK8XNwF2CR1+c/UYrzJxy3BVA0BcX0D7vdfdFD3YXN7RyMCqRHgg2CBv6BDZ
        uPmiTxcDZYr/0gor8mNium3OfoEg2KphHjTuZMuet8p5bF64T+loRPj6KhFKHDqCCzJklK
        afi8oIJjLEEszRaEWJmncvVpBTD+GKnD/i5NKu770o6rEM3qXiq8u1v2u2ccp0OJeliGwM
        F+WlsbS+5JPoyRCW9kFGz+ArHW2S0e9Yma2LHDdZYT2kWyv7yDuYVFrK3E+u6fBKcvHLAS
        c77kJrn55/xQNGBuNxB0KUuYbB77EfqI54I9KQe49e4H7FRHTCk8RvnkYG50mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696588341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVisgtQNVzDiyDauoPwFi6xuBYYibbumtylUKxIkQlQ=;
        b=8np5eGw1eehkSGHQZ1XoP/ea5knFSWqF6KuqnfYZOFKmVnuUDXfSixZnAPIMvYggYO7sl8
        jJTcbnwPAZVRatBg==
From:   "tip-bot2 for Muhammad Usama Anjum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/futex/selftests: Remove duplicate ABI defines
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231006095539.1601385-1-usama.anjum@collabora.com>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Message-ID: <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d351a9e56cc90a9ff694550e4b3bcaf51a391525
Gitweb:        https://git.kernel.org/tip/d351a9e56cc90a9ff694550e4b3bcaf51a391525
Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
AuthorDate:    Fri, 06 Oct 2023 14:55:37 +05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Oct 2023 12:29:45 +02:00

locking/futex/selftests: Remove duplicate ABI defines

Kselftests are kernel tests that are built with kernel headers
from the same source version. The kernel headers, which includes
current ABI definitions, are already being included correctly
in the futex selftest Makefile with the help of KHDR_INCLUDE,
no need to define them again.

Remove duplicate ABI definitions, which is effectively dead code.

No functional changes intended.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231006095539.1601385-1-usama.anjum@collabora.com
---
 tools/testing/selftests/futex/include/futextest.h | 22 +--------------
 1 file changed, 22 deletions(-)

diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9..59f66af 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -25,28 +25,6 @@
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
 
-/* Define the newer op codes if the system header file is not up to date. */
-#ifndef FUTEX_WAIT_BITSET
-#define FUTEX_WAIT_BITSET		9
-#endif
-#ifndef FUTEX_WAKE_BITSET
-#define FUTEX_WAKE_BITSET		10
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI
-#define FUTEX_WAIT_REQUEUE_PI		11
-#endif
-#ifndef FUTEX_CMP_REQUEUE_PI
-#define FUTEX_CMP_REQUEUE_PI		12
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
-#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
-					 FUTEX_PRIVATE_FLAG)
-#endif
-#ifndef FUTEX_REQUEUE_PI_PRIVATE
-#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
-					 FUTEX_PRIVATE_FLAG)
-#endif
-
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
