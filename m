Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD07DA623
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjJ1JUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjJ1JUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 05:20:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CB7F2;
        Sat, 28 Oct 2023 02:20:15 -0700 (PDT)
Date:   Sat, 28 Oct 2023 09:20:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698484814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+88Ivlr4lTWiNShXR0+BLShmQwq2HwCdL0nyX8w/bI=;
        b=zVah+bNUiy8lW1Ug7Rw6XlZv2ionOA33nZffW0Ozd/uJbLzcBFNym1WiK+sRvEl+VW8MWk
        rCmhBM6WbMl2lb9V1knm1lqOEyeck4GV1jjsnBD6lvuQ3aYb5k/mqaV3vXAPorArwHpdCq
        g2mCqyz14meQ/xjeNPb0+7GRDPrHeW+72uGUirGiE45l6YMJOPDlGonL93f8+mHTaKgLXi
        iSZycvjsU63T0K+V1Iy8Xf27mK/jNrR1VBlmXgBeOKT1v2nWb/ynjrkdVmdNpP/alYqble
        sMXxlwtXE//5hKGlke1hghqGdlEj3cEN7rBrVW6+KA6skWt/sD2KFR3uT7DTwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698484814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+88Ivlr4lTWiNShXR0+BLShmQwq2HwCdL0nyX8w/bI=;
        b=SL+ulciOuCjQrQsOigMIEM7fwhtuBQxmtdGgkIxQoNVGrvGDBUEuEAfTZt6DAtxCTaOqyh
        GCERWJ0cJv92egCw==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/headers] x86/headers: Remove unnecessary #include <asm/export.h>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230806145958.380314-1-masahiroy@kernel.org>
References: <20230806145958.380314-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <169848481317.3135.12638031005168748918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/headers branch of tip:

Commit-ID:     b425232c676b264faa9edb0b6cece4bd08d8ee82
Gitweb:        https://git.kernel.org/tip/b425232c676b264faa9edb0b6cece4bd08d8ee82
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sun, 06 Aug 2023 23:59:55 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 10:38:07 +02:00

x86/headers: Remove unnecessary #include <asm/export.h>

There is no EXPORT_SYMBOL() line there, hence #include <asm/export.h>
is unnecessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230806145958.380314-1-masahiroy@kernel.org
---
 arch/x86/entry/vdso/vsgx.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index d77d278..37a3d4c 100644
--- a/arch/x86/entry/vdso/vsgx.S
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <linux/linkage.h>
-#include <asm/export.h>
 #include <asm/errno.h>
 #include <asm/enclu.h>
 
