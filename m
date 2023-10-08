Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EBF7BCDA0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbjJHJwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbjJHJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:52:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CB7B6;
        Sun,  8 Oct 2023 02:52:31 -0700 (PDT)
Date:   Sun, 08 Oct 2023 09:52:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696758749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6MlXoe96JWyM6gHh38vzeZaUjP/cVbpZxqfXw9dQ/o=;
        b=T51m2NxbfbfbRt+/B0+xu2v9fAKiAPr3MZ7axCkMCrpw3XqISP0A0YPhWGGiDLYcYMrInk
        QohgUPywpYv6owA2pYj9XzeomYKx/vKrlZHfkGAsjBEP5EqCGrswsbVu0txrQLEbctsuYz
        A/8Ic+tIw6PPadRkSkLlCxqh+OHWo4dXULTJJGbd3mHAU4PDcRuHxJHlS655hP758IaoOQ
        LA99if7J6wqiwnguSvUxkGD9iOhhcIOEkp9X08ss2IXh64QmuYeZYFdCV/i34d/QgwMOEP
        fVh2f7hxxSFIy8iLU26Mp+0XhDO3V174O4SwebS9L2l0XMzSm3p61Qs1xJ8u1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696758749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6MlXoe96JWyM6gHh38vzeZaUjP/cVbpZxqfXw9dQ/o=;
        b=eMh2OmzzjJxmZ+Kbn7ZkcFr7MC/DMASPVshvFEoap/Zh7XwrKcY3FGAbhc/e+GF2DtjanE
        HHkTfGM1SK2p4xDg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix kernel-doc warnings
Cc:     kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231006235132.16227-1-rdunlap@infradead.org>
References: <20231006235132.16227-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <169675874835.3135.5688248795172710200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     025d5ac978cc3b47874cc1c03ab096a78b49f278
Gitweb:        https://git.kernel.org/tip/025d5ac978cc3b47874cc1c03ab096a78b49f278
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 06 Oct 2023 16:51:32 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Oct 2023 11:45:16 +02:00

x86/resctrl: Fix kernel-doc warnings

The kernel test robot reported kernel-doc warnings here:

  monitor.c:34: warning: Cannot understand  * @rmid_free_lru    A least recently used list of free RMIDs on line 34 - I thought it was a doc line
  monitor.c:41: warning: Cannot understand  * @rmid_limbo_count     count of currently unused but (potentially) on line 41 - I thought it was a doc line
  monitor.c:50: warning: Cannot understand  * @rmid_entry - The entry in the limbo and free lists.  on line 50 - I thought it was a doc line

We don't have a syntax for documenting individual data items via
kernel-doc, so remove the "/**" kernel-doc markers and add a hyphen
for consistency.

Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
Fixes: 24247aeeabe9 ("x86/intel_rdt/cqm: Improve limbo list processing")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231006235132.16227-1-rdunlap@infradead.org
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ded1fc7..f136ac0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -30,15 +30,15 @@ struct rmid_entry {
 	struct list_head		list;
 };
 
-/**
- * @rmid_free_lru    A least recently used list of free RMIDs
+/*
+ * @rmid_free_lru - A least recently used list of free RMIDs
  *     These RMIDs are guaranteed to have an occupancy less than the
  *     threshold occupancy
  */
 static LIST_HEAD(rmid_free_lru);
 
-/**
- * @rmid_limbo_count     count of currently unused but (potentially)
+/*
+ * @rmid_limbo_count - count of currently unused but (potentially)
  *     dirty RMIDs.
  *     This counts RMIDs that no one is currently using but that
  *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
@@ -46,7 +46,7 @@ static LIST_HEAD(rmid_free_lru);
  */
 static unsigned int rmid_limbo_count;
 
-/**
+/*
  * @rmid_entry - The entry in the limbo and free lists.
  */
 static struct rmid_entry	*rmid_ptrs;
