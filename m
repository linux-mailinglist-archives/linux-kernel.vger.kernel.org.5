Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFA7F5BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjKWKGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjKWKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:06:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A204D48;
        Thu, 23 Nov 2023 02:06:44 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:06:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700734003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWJLpr+e76xHxp+lFdVVcBgYCBwYbNunL9DUBWCjG4I=;
        b=T13cPWhMDqzIfBShxd1T5TJm5RjAWzDQQZuKysDvEoHZQyqjXa2Z/p5LkF/EirlR+70O6B
        qNagkG/khCuWiodNRRmK7f9n4ZJONg7/ttjXtJnAmEY4E/8rcK0/TSD5f4Fk2PHR3zDRB6
        Akpk2Hrg8iyiK+6x1d7bOiBigniCgRAhyQ+TsJ6nRARNrcOg2i4vdSDHsA8Natza9EnQWK
        0rUmMgPt2GeySOo8jsAGGvsmGlpYPzQlZiX7sX/0jkSnAUOH/F62pjKKwn9De8hnTCx5nT
        QLnyo9WYupq3ygZkGHUhHRkajKgea77kfsA2o9OWjF3+yC43a8UBICgQRyFimQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700734003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWJLpr+e76xHxp+lFdVVcBgYCBwYbNunL9DUBWCjG4I=;
        b=zW0XOz/HtriJYbP6G2nZ2ukJkZIqr/IGEADXLwhl2vSn7uEYxfiV2aB3mbv9zcHnZtQD/b
        uFd+qtu2MeWMU4DQ==
From:   "tip-bot2 for Yuntao Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/io: Remove the unused 'bw' parameter from the
 BUILDIO() macro
Cc:     Yuntao Wang <ytcoode@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231123034911.217791-1-ytcoode@gmail.com>
References: <20231123034911.217791-1-ytcoode@gmail.com>
MIME-Version: 1.0
Message-ID: <170073400251.398.4232441300253606258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     03f111710af9ea9cd5a08ecc98e456d1cc0c2284
Gitweb:        https://git.kernel.org/tip/03f111710af9ea9cd5a08ecc98e456d1cc0c2284
Author:        Yuntao Wang <ytcoode@gmail.com>
AuthorDate:    Thu, 23 Nov 2023 11:49:11 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Nov 2023 10:57:36 +01:00

x86/io: Remove the unused 'bw' parameter from the BUILDIO() macro

Commit 1e8f93e18379 ("x86: Consolidate port I/O helpers") moved some
port I/O helpers to <asm/shared/io.h>, which caused the 'bw' parameter
in the BUILDIO() macro to become unused. Remove it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231123034911.217791-1-ytcoode@gmail.com
---
 arch/x86/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 7623884..3814a92 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -242,7 +242,7 @@ static inline void slow_down_io(void)
 
 #endif
 
-#define BUILDIO(bwl, bw, type)						\
+#define BUILDIO(bwl, type)						\
 static inline void out##bwl##_p(type value, u16 port)			\
 {									\
 	out##bwl(value, port);						\
@@ -288,9 +288,9 @@ static inline void ins##bwl(u16 port, void *addr, unsigned long count)	\
 	}								\
 }
 
-BUILDIO(b, b, u8)
-BUILDIO(w, w, u16)
-BUILDIO(l,  , u32)
+BUILDIO(b, u8)
+BUILDIO(w, u16)
+BUILDIO(l, u32)
 #undef BUILDIO
 
 #define inb_p inb_p
