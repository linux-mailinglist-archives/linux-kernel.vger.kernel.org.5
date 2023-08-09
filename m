Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC3776A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjHIUhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbjHIUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C109268D;
        Wed,  9 Aug 2023 13:36:16 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ncSA6kkBWYMdumbDHnemezwrrAD2YeFSIIbSb9P+7+s=;
        b=au3CpCmc11a30hQqvzi1Tik72ZAPLIn20JsCr8MWTAbxHxdirn5By5LmtLyXExa6ugNQcD
        A09rAA+whniIG9WOq+nY4N89unjAyJl9MWvmX3Ff7oGw/4CNL14badny5FQMJ0DpHLJDcE
        +cA/8EWci/0coFKkOZFuXCI48p6kNBKmtbRhp7cLeDSpO703kTPDEtCjDV2Y+xFNWB4GnN
        wyUeULdW22opzAujXRcY6qMPx3RtSA7MjGrrgWzVSIyoo3X0arGMYCzDB6o6H0PAu8cq8j
        x6ORjjvytzj3q8IRmo6Q2bO7KqcaR5AnLDSn7db1acJ6hM/vuEB5JCmtdsml/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ncSA6kkBWYMdumbDHnemezwrrAD2YeFSIIbSb9P+7+s=;
        b=goZudmqPIx5MjUk8xgpNuDK9Vbn9LuOuxcXdRZCk/3oGh48E0fEpvAsoxTPkRV3eOVGHJG
        sCIZuTlEHfxggUDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/uv: Get rid of wrapper callbacks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337409.27769.66872517118417432.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     194ac709819c1fe281397ce1b2894f2bb6413599
Gitweb:        https://git.kernel.org/tip/194ac709819c1fe281397ce1b2894f2bb6413599
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:29 -07:00

x86/apic/uv: Get rid of wrapper callbacks

Why on earth makes a wrapper around some common function sense? Just to be
able to slap some vendor name on it...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f532c58..f0580a6 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -783,11 +783,6 @@ static int uv_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-static u32 apic_uv_calc_apicid(unsigned int cpu)
-{
-	return apic_default_calc_apicid(cpu);
-}
-
 static unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
@@ -838,7 +833,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= set_apic_id,
 
-	.calc_dest_apicid		= apic_uv_calc_apicid,
+	.calc_dest_apicid		= apic_default_calc_apicid,
 
 	.send_IPI			= uv_send_IPI_one,
 	.send_IPI_mask			= uv_send_IPI_mask,
