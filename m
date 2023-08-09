Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18531776859
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjHITOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjHITNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9BB30F0;
        Wed,  9 Aug 2023 12:12:54 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nZ1fz7afZbS9ZifqQ0DfNP5YpS9PvP+lGgUyibxBptk=;
        b=ra9kBmT0eRtIKiJ1dswIbS0ZnFl9n6nrGJcjezaa6upsDTu5SmlncDc90s+03g6+9P7+lA
        G6ekMJ0snPJMFQamP71fdB527wGud7j0fEmLyp+Xi2Zj+Zso2D1tUCICoSwIhKXtw4LsK9
        x9EICIfPbI+/35az9shdgG66ikHUNaW6z1MmxxhQQUCPUHLRH87XKg/ovcciq5LrnGCIO5
        2iYW5Qaj4Kpb3E6Rf+su9kwCNa32+0EsQUy5p1r8GbxXuKPZQubkrHXGcHwakaG5KUxiCm
        LhUZt3QMm/WvD5jfEprPg/5rbO85rK9gPjBGd1UB61KIL6gMYYYSrd2hGP7svA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nZ1fz7afZbS9ZifqQ0DfNP5YpS9PvP+lGgUyibxBptk=;
        b=iDjXstr9cVxbGiJPk8oTTXuJSD5ui16Y3InniYxqb86X/9p4eBWLxSe+aFhO56mQ2brPuG
        k4ggdLCJz90AuACg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove unused max_physical_apicid
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834775.27769.8839904065386107662.tip-bot2@tip-bot2>
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

Commit-ID:     b3bc5dd99462218602145581a1907c4143e9d015
Gitweb:        https://git.kernel.org/tip/b3bc5dd99462218602145581a1907c4143e9d015
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:43 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:17 -07:00

x86/apic: Remove unused max_physical_apicid

max_physical_apicid is assigned but never read.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/apic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ee64f8f..d6b5059 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -74,11 +74,6 @@ EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 u8 boot_cpu_apic_version __ro_after_init;
 
 /*
- * The highest APIC ID seen during enumeration.
- */
-static unsigned int max_physical_apicid;
-
-/*
  * Bitmask of physically existing CPUs:
  */
 physid_mask_t phys_cpu_present_map;
@@ -2541,9 +2536,6 @@ int generic_processor_info(int apicid, int version)
 			boot_cpu_apic_version, cpu, version);
 	}
 
-	if (apicid > max_physical_apicid)
-		max_physical_apicid = apicid;
-
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
