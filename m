Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C567FFD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376857AbjK3VQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376841AbjK3VQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:16:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E0910E5;
        Thu, 30 Nov 2023 13:16:32 -0800 (PST)
Date:   Thu, 30 Nov 2023 21:16:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701378991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vavI3RxrLtloE3LjQEUBpt9Crabz1GqFixWES3vlEKk=;
        b=aVl4TBu1rzjQtgN1aiSMeuM5vbF9jPKmRH6nCb2HdvGPlcbeKQCu9XBgwxeUJIUjPp+I0j
        WcB+NV3w017sT0TMIjBvpc3z3HWcFobD0ftQT3/j689jZO/FSQ6QfVRRCIclWm8xgESTWS
        AwokAP74+E3Wc7b/60Wwc8T4i2UDNy2Yhn0atv6wGFVtJbW/DcDW4iSCdRS5/AmkuBXeNL
        qosoNJPvYVU/eYlIRDWP3lFMdz8/9ToeUcMgbKbrhHvLPHoeXpPXn+5A+rZUIAU7KACR/+
        MdClDYbKUdxLsLg78jBOFEVlxWApPwKGvHoZXpUUJ4VtmZJrC09SkurKwSEOHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701378991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vavI3RxrLtloE3LjQEUBpt9Crabz1GqFixWES3vlEKk=;
        b=+oP2G7fyRT8waiZaoPuWiUTAGQ3kR68HD9o6om0xRgr30jlaLuOVFjfICBw6l/UDmd8MyP
        s6MFnPWLJECOXvAQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Declare const_pcpu_hot as extern const variable
Cc:     kernel test robot <lkp@intel.com>, Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231130162949.83518-1-ubizjak@gmail.com>
References: <20231130162949.83518-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170137899052.398.2740335306554226817.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     4604c052b84d66407f5e68045a1939685eac401e
Gitweb:        https://git.kernel.org/tip/4604c052b84d66407f5e68045a1939685eac401e
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 30 Nov 2023 17:27:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 20:19:33 +01:00

x86/percpu: Declare const_pcpu_hot as extern const variable

const_pcpu_hot is aliased by linker to pcpu_hot, so there is no need
to use the DECLARE_PER_CPU_ALIGNED() macro. Also, declare const_pcpu_hot
as extern to avoid allocating storage space for the aliased structure.

Fixes: ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231130162949.83518-1-ubizjak@gmail.com
Closes: https://lore.kernel.org/oe-kbuild-all/202311302257.tSFtZnly-lkp@intel.com/
---
 arch/x86/include/asm/current.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 0538d24..9fbd7cb 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -37,8 +37,7 @@ static_assert(sizeof(struct pcpu_hot) == 64);
 DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 
 /* const-qualified alias to pcpu_hot, aliased by linker. */
-DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
-			const_pcpu_hot);
+extern const struct pcpu_hot __percpu_seg_override const_pcpu_hot;
 
 static __always_inline struct task_struct *get_current(void)
 {
