Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495137F0F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjKTJ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjKTJ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:28:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39DC99;
        Mon, 20 Nov 2023 01:28:33 -0800 (PST)
Date:   Mon, 20 Nov 2023 09:28:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700472511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AL6a3mfrD+bM/yYnjRJE4SkN/bnHM3Nv1byO+diWrh4=;
        b=QvoF+6ycThwORS8pHiC2q2Rno8UACvNFfIYEJn3kpUIKHY8gA/Cis/7zWMrLR7yE2/JbU9
        S/KX2R/JLyiSyuqXr2rd5eMPIbEntWc8+LNnMr+BbHACjd4BZ4uJTwGK7iees4suWXqU/u
        IK2Sab6gljxnqEGs2/kdpns27+Lbk8GEjI+UDCDi84lEK5TMAvVI3PDWK8jnSSdmBkSW2H
        vzbaNM1eS+9aoALPVrY/gmPulBWxRWv6eCxrNHdefSpwtD7vWjAG7blPxqwd9+5U9dC6aL
        5zUlb7AoBWMs5AJWrb2BLMQQiDAakWZMv0l8ApWP0RGZAEKFL6LaAF+7TxMwLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700472511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AL6a3mfrD+bM/yYnjRJE4SkN/bnHM3Nv1byO+diWrh4=;
        b=J/FkAav5MVyHeobbA2Y4TFiA5DRUraDTUgDEK75vRQBvADq6TKeW8EvoKR0tND8qDNNTWh
        9p0KgSYeezj5rtDA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mtrr: Document missing function parameters in
 kernel-doc
Cc:     kernel test robot <lkp@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202311130104.9xKAKzke-lkp@intel.com>
References: <202311130104.9xKAKzke-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <170047250972.398.12119323318343960939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4e15b91c5b7919c530c27f39c7f2d392bf0a95e3
Gitweb:        https://git.kernel.org/tip/4e15b91c5b7919c530c27f39c7f2d392bf0a95e3
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 13 Nov 2023 14:52:52 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 20 Nov 2023 10:19:27 +01:00

x86/mtrr: Document missing function parameters in kernel-doc

Add text explaining what they do.

No functional changes.

Closes: https://lore.kernel.org/oe-kbuild-all/202311130104.9xKAKzke-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202311130104.9xKAKzke-lkp@intel.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 2d6aa5d..d352477 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -428,6 +428,10 @@ void __init mtrr_copy_map(void)
  * from the x86_init.hyper.init_platform() hook.  It can be called only once.
  * The MTRR state can't be changed afterwards.  To ensure that, X86_FEATURE_MTRR
  * is cleared.
+ *
+ * @var: MTRR variable range array to use
+ * @num_var: length of the @var array
+ * @def_type: default caching type
  */
 void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
 			  mtrr_type def_type)
@@ -492,13 +496,15 @@ static u8 type_merge(u8 type, u8 new_type, u8 *uniform)
 /**
  * mtrr_type_lookup - look up memory type in MTRR
  *
+ * @start: Begin of the physical address range
+ * @end: End of the physical address range
+ * @uniform: output argument:
+ *  - 1: the returned MTRR type is valid for the whole region
+ *  - 0: otherwise
+ *
  * Return Values:
  * MTRR_TYPE_(type)  - The effective MTRR type for the region
  * MTRR_TYPE_INVALID - MTRR is disabled
- *
- * Output Argument:
- * uniform - Set to 1 when the returned MTRR type is valid for the whole
- *	     region, set to 0 else.
  */
 u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 {
