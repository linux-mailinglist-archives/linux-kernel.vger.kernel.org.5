Return-Path: <linux-kernel+bounces-71827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAC185AB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F081C21644
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C9D44C8C;
	Mon, 19 Feb 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nws6pBwP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmkWlG3F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7250278;
	Mon, 19 Feb 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367858; cv=none; b=B0CvSuUs/k0kCDVotMg0T0MBPdwXCNkrFgpkN4ge7PCWL+QaRha2eHS4ZZSVX3bjU9nKR7Ud1jk4y6B/ntScTWPRifsh4s0dWCFQ2KRSDye2nbpHLTDs9Ft3j9Kz/qPaXr7leGcHnAhcAT+K0ybPscW9ApbIx3OTp+u4SqvMZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367858; c=relaxed/simple;
	bh=VCcUjmWxYmFQHAAt7Z1tpW/3aeXFrz53ayAs/sfG3hU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kTaRwvS9J6z6QPYQPrgdd70//uiQY38E66cg79o8U/CLU7ieqZtN8YAtJ+mOmJq2F0ShDqrkxxpBhQvUYdcK3crzAKP/mMgFD1Djk93Khs4z6yryZeFVjBSLVLbcN/6hWJ1BWZHwI32GLrGd/nK83uzTE8in3JPOKDIqhL0Cc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nws6pBwP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmkWlG3F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367855;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqt1BzLDOLT2qIOSaQyWM4Pf4xk5jdRIU3v5QNUeR8w=;
	b=Nws6pBwPBnAJGnaXq5Mhv4WnUZcbWcoUgNOWqfTi4ABLSfbvbKTzi8g513sIjwbjfxCPkp
	i2rcvuKeh8n4WG7S7oOwdMHhLiZerOyy0NK+5unU5+jSL72Xy0U8i7R59vKVC5/avDPqTn
	P9T+ESU0rAFBbzR7XkENtmRQPjoPOSXSLIgv0+ukkWPo0MSLDWL33Ec7gG/mhAUSK1IDP5
	SgnEbVez1lqgr5DtlVjc2Ov3zPtP9ezomkrFnlo27rkg0ScvAJvIpt8W3XVGliL/wiRqe2
	lTXVDHe2Y9FVk6+m3njcp8wrH6NN86vA0AMwVG56yxuY1zrimII69lJPRd1B9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367855;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqt1BzLDOLT2qIOSaQyWM4Pf4xk5jdRIU3v5QNUeR8w=;
	b=wmkWlG3FN8HRV0G5oH6sCrIAoX+9fjQSU5ZrCgJsnVEFL+9R1Kee0p9Vkr9ZWQOI1UMRP7
	ZC8l/J+fkVV8uCBQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Use __set_bit()/__clear_bit() instead
 of open coding
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-10-james.morse@arm.com>
References: <20240213184438.16675-10-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785480.398.10287268080200773656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     5d920b6881f2249be3a028ce0a7f31c5cc61b1ee
Gitweb:        https://git.kernel.org/tip/5d920b6881f2249be3a028ce0a7f31c5cc61b1ee
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:23 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:31 +01:00

x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding

The resctrl CLOSID allocator uses a single 32bit word to track which
CLOSID are free. The setting and clearing of bits is open coded.

Convert the existing open coded bit manipulations of closid_free_map
to use __set_bit() and friends. These don't need to be atomic as this
list is protected by the mutex.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-10-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index dcffd1c..bc6e0f8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -111,7 +111,7 @@ void rdt_staged_configs_clear(void)
  * - Our choices on how to configure each resource become progressively more
  *   limited as the number of resources grows.
  */
-static int closid_free_map;
+static unsigned long closid_free_map;
 static int closid_free_map_len;
 
 int closids_supported(void)
@@ -130,8 +130,8 @@ static void closid_init(void)
 
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
-	/* CLOSID 0 is always reserved for the default group */
-	closid_free_map &= ~1;
+	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
+	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
 	closid_free_map_len = rdt_min_closid;
 }
 
@@ -139,17 +139,21 @@ static int closid_alloc(void)
 {
 	u32 closid = ffs(closid_free_map);
 
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	if (closid == 0)
 		return -ENOSPC;
 	closid--;
-	closid_free_map &= ~(1 << closid);
+	__clear_bit(closid, &closid_free_map);
 
 	return closid;
 }
 
 void closid_free(int closid)
 {
-	closid_free_map |= 1 << closid;
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	__set_bit(closid, &closid_free_map);
 }
 
 /**
@@ -161,7 +165,9 @@ void closid_free(int closid)
  */
 static bool closid_allocated(unsigned int closid)
 {
-	return (closid_free_map & (1 << closid)) == 0;
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	return !test_bit(closid, &closid_free_map);
 }
 
 /**

