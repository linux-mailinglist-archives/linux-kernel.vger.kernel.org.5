Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5E7666F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjG1IXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjG1IW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:22:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE13582;
        Fri, 28 Jul 2023 01:21:23 -0700 (PDT)
Date:   Fri, 28 Jul 2023 08:21:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690532481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5Y/oYGIsg/lEQP/IWXfklA5/PBU/PmzxbYkTrrMcfc=;
        b=kDCYkdPe/c3M+RE/IZiuzilR5BfhksRDPlv5jpv9/l91fwBz+QRZezRHYRD2Dl4A18dNtO
        /eePhrj2L7NkHdHk0e+W3Drgrro0bvl+q9x5JQ+mEX+p3RtEyqAHX4VhC1M2BfhOhPpKbJ
        En6nRlSo6RNoM9mRnQ9O9izNhIiyUWP7QBPii+gOrd272sbTtLUP2c0cuKT4AWy17t2Fyx
        adQYyagNTEtuJkMk+aD9zLwxLONNf296st+5uxVcVALGp1REVys1CnLUmGtu1VWU4huWid
        Q3vTwyROKAys+FRHIBsg0IX7FQPw9KIKeIX9gPogFIzZZwpPe4THYxsISVaSHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690532481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5Y/oYGIsg/lEQP/IWXfklA5/PBU/PmzxbYkTrrMcfc=;
        b=powh/1HNqZC7x1ZJmmBVEziNAMXmj3sfHPOxEz9ogh+2t5TvXw3TCofkBfD03niWCZUkms
        1AqRXqUB9fFUD8CA==
From:   "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Remove a non-existent function declaration
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727180533.3119660-3-sohil.mehta@intel.com>
References: <20230727180533.3119660-3-sohil.mehta@intel.com>
MIME-Version: 1.0
Message-ID: <169053248123.28540.16359111840279202443.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     54bfd02bbfcd0582bc4ebf6fd57fba323b141b5b
Gitweb:        https://git.kernel.org/tip/54bfd02bbfcd0582bc4ebf6fd57fba323b141b5b
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Jul 2023 18:05:32 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 10:17:53 +02:00

x86/smp: Remove a non-existent function declaration

x86_idle_thread_init() does not exist anywhere. Remove its declaration
from the header.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230727180533.3119660-3-sohil.mehta@intel.com

---
 arch/x86/include/asm/smp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 600cf25..094f31d 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,7 +132,6 @@ void smp_kick_mwait_play_dead(void);
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
-void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
 
 bool smp_park_other_cpus_in_init(void);
 
