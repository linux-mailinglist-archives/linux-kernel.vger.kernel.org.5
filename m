Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3249774D21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjHHVhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHHVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:37:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19232E0;
        Tue,  8 Aug 2023 14:37:23 -0700 (PDT)
Date:   Tue, 08 Aug 2023 21:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691530641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDkO5o+VYKafXt0UwqB1zta1+/jE80vGFNHWvcTQRJc=;
        b=ISC+yFDJob9FQbdVKs6ZOLY6p/81fKqvBu/A8G1EW2fqdcD+L2+cMBHe2AC+GnIL0o3SEx
        U2wM8pUWDq/Coq6mDIKBwLFlszhLIg+TB1O7iCH4x2T+2RpZbFInzUWE5GfyrihX+vOkR8
        n5PMmFoYzIXJA/zyJwanQCwv8cUkPRcv4jXDsLNeklnwRiGDpf+6dR8dAbn5D+9A+y+g+c
        S0waETU7+f9o9l+hdq3k5saVoMwtKKvk/xcbeEwj71qMBEvPYJ7r0vv1ieGWClnrx/xX8F
        uRCT1IdNcv2v/FjTAATkM01Os05mYsr0knuXfvjHP7n9LmqCC0wgBeCDbqtJ8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691530641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDkO5o+VYKafXt0UwqB1zta1+/jE80vGFNHWvcTQRJc=;
        b=F9L1p5UJXsZ08eUfBLWiTvcPY+syiMCsT7uKiyLpS+9p7Lbo4GWe/lVHLb+4tDKU8J7jNd
        rjc2YGywYSpjF5AQ==
From:   "tip-bot2 for Jinghao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h
Cc:     Jinghao Jia <jinghao@linux.ibm.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230808182353.76218-1-jinghao@linux.ibm.com>
References: <20230808182353.76218-1-jinghao@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <169153064106.27769.9957898091293450936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7324f74d39531262b8e362f228b46512e6bee632
Gitweb:        https://git.kernel.org/tip/7324f74d39531262b8e362f228b46512e6bee632
Author:        Jinghao Jia <jinghao@linux.ibm.com>
AuthorDate:    Tue, 08 Aug 2023 14:23:53 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 08 Aug 2023 23:13:17 +02:00

x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h

The BUILD_VDSO macro was incorrectly spelled as BULID_VDSO in
asm/linkage.h. This causes the !defined(BULID_VDSO) directive to always
evaluate to true.

Correct the spelling to BUILD_VDSO.

Fixes: bea75b33895f ("x86/Kconfig: Introduce function padding")
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230808182353.76218-1-jinghao@linux.ibm.com
---
 arch/x86/include/asm/linkage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 0953aa3..97a3de7 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -21,7 +21,7 @@
 #define FUNCTION_PADDING
 #endif
 
-#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BULID_VDSO)
+#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 # define __FUNC_ALIGN		__ALIGN; FUNCTION_PADDING
 #else
 # define __FUNC_ALIGN		__ALIGN
