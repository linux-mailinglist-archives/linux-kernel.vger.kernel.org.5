Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C1577DB72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbjHPHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbjHPHzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:55:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61051FE6;
        Wed, 16 Aug 2023 00:55:17 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:55:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692172515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JYeRS+nqU6eqmbKsjqsxxJG6zKJs1J9aAx8uLuZ3U4=;
        b=zNs8TO6HWF4ca+/6vIQrk7BdGw6Wgzj26y6aDXPyE5k5Qd9Rt8Zu+2fFaWp/i2FY1DZUvq
        +pMuaMantNrm8ciX/BYceJbHylAHsF4WR3Tw/tSRB7Ksdfhr+Lq+EhZ1BS3m2+aE/ZqFTW
        ivVBR1YbKUUi9jm1xhv3ejNYBbZv2Arc28jkKe25jxrQM1mIytV6b+r2fyTR7mAB8xNUO+
        rIA8BRcoizegQuzGxco1RJRJ9OuIfMQJ0r9kt8nJMaFc3izwpfZSpA8ZDtiXl7VK82BtDn
        eu8J0eRNeoYaNIuHzxqJpe/ur37KELibyWXSkDMbqKPI338gNs+hjT2HzBuwaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692172515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JYeRS+nqU6eqmbKsjqsxxJG6zKJs1J9aAx8uLuZ3U4=;
        b=ChjGslee3TzunlM2TPRFxP5RXwM11TYMcVXkX3fnMiKUqHi1KoCUsUkssRzrQHhMuw8ymu
        f7bNpkG+4pERKiBQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/srso: Explain the untraining sequences a bit more
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <64H4lENIe94@fat_crate.local>
References: <64H4lENIe94@fat_crate.local>
MIME-Version: 1.0
Message-ID: <169217251418.27769.2623579948793879056.tip-bot2@tip-bot2>
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

Commit-ID:     d80c3c9de067e08498d9bbfef7ab0b716fe4cc05
Gitweb:        https://git.kernel.org/tip/d80c3c9de067e08498d9bbfef7ab0b716fe4cc05
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 14 Aug 2023 21:29:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 09:39:17 +02:00

x86/srso: Explain the untraining sequences a bit more

The goal is to eventually have a proper documentation about all this.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814164447.GFZNpZ/64H4lENIe94@fat_crate.local
---
 arch/x86/lib/retpoline.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 5e85da1..cd86aeb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -187,6 +187,25 @@ SYM_CODE_START(srso_alias_return_thunk)
 SYM_CODE_END(srso_alias_return_thunk)
 
 /*
+ * Some generic notes on the untraining sequences:
+ *
+ * They are interchangeable when it comes to flushing potentially wrong
+ * RET predictions from the BTB.
+ *
+ * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
+ * Retbleed sequence because the return sequence done there
+ * (srso_safe_ret()) is longer and the return sequence must fully nest
+ * (end before) the untraining sequence. Therefore, the untraining
+ * sequence must fully overlap the return sequence.
+ *
+ * Regarding alignment - the instructions which need to be untrained,
+ * must all start at a cacheline boundary for Zen1/2 generations. That
+ * is, instruction sequences starting at srso_safe_ret() and
+ * the respective instruction sequences at retbleed_return_thunk()
+ * must start at a cacheline boundary.
+ */
+
+/*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
  * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
