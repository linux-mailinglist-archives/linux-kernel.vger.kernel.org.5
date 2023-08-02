Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9841276DA81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHBWTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjHBWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:19:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82D12701;
        Wed,  2 Aug 2023 15:19:26 -0700 (PDT)
Date:   Wed, 02 Aug 2023 22:19:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691014764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9G34ZQWMpm0TD6FcpnDf5Y/8FNaD5q28hdqaqeEKrHE=;
        b=KvlK9FCM9/0+BA+yZs7F4u56akT8vIGkzpBwzf7BXI6WuAqy1V7JUUIjw3AWCzT6tpcF57
        ZGA4MyuDACqGqUgZROsclDMpopqvTDSkdwGn8eZAvS67gE9lAMT95SW0WHLy75jDYvO6Mb
        FxmCDRuE1EFVLPJnxc4j8iaRufBMyiVAoJRVRnw8qI8HoKBMGoK739+2dGXugKCMpBB/Dv
        0fwp3azRve5PcZGSOdM6WQx/KIk12NXuKfFRrPdM8Te5CwGn9G8ELb1TOp66lVsUiPfwU6
        yCneBOCyQjX0VOVHaMZUgIlrZlyqBLXXhml1XIioYBmibSe8slhSqMdT1DBKvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691014764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9G34ZQWMpm0TD6FcpnDf5Y/8FNaD5q28hdqaqeEKrHE=;
        b=jM21cmH5B4svxCCKB8U0wG8KRjq8dOeQpiQRw1SeY229Sj5dnbZSllACGEdYs9Ol4UzAEd
        +KvDQ16x8LSSWIAQ==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/kbuild: Fix Documentation/ reference
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        kernel test robot <lkp@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169101476361.28540.6727126063960366385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     54acee601b87cfe43e17f6812449e5eb3eab39f9
Gitweb:        https://git.kernel.org/tip/54acee601b87cfe43e17f6812449e5eb3eab39f9
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 02 Aug 2023 13:37:22 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 02 Aug 2023 15:01:51 -07:00

x86/kbuild: Fix Documentation/ reference

x86 documentation moved.  Fix the reference.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202307271956.IxoG9X0c-lkp@intel.com/
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e860f80..99e7552 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1969,7 +1969,7 @@ config X86_USER_SHADOW_STACK
 
 	  CPUs supporting shadow stacks were first released in 2020.
 
-	  See Documentation/x86/shstk.rst for more information.
+	  See Documentation/arch/x86/shstk.rst for more information.
 
 	  If unsure, say N.
 
