Return-Path: <linux-kernel+bounces-68797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB52858081
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFC72838ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8C130AF5;
	Fri, 16 Feb 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsJ/eEh/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjih0QiM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AED12FB32;
	Fri, 16 Feb 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096614; cv=none; b=ggF5Q1Jndm24p+HXp5ne+3WWx/EnQa+uHna2f31nDlUylZTcz6jGN4b2B9hB5kLqLJ/MMKZZS4jshTHlxUKIP0nYCPwfEjjNtwXAR9eByJ97LPnEbx2PfVYaiw2v6tfPY6CDVB1iqwwDY6m8/5sDMWzA4Jn2VzwvD1p7ZJBFq+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096614; c=relaxed/simple;
	bh=UnQ6UWZ1b78WNk1udN307W3ub9CZWBVF30hIC4t4uj8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BNlEIkjPxGTMZXa4lBr/6/ig6eb2VLHjrM2jjVpXU1tUr6/CPsXksPvYRJsK5WJdaIrly04ca0Ro7IXLCqkBZulnbBkhrqaLujE/VC0ioHWK7O2DYf6RciQb1ZXLdSqd9RMOfm5VdeLi2rW7pe8mn/+TkPNedGymYxPOgP/lzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hsJ/eEh/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjih0QiM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096611;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvpcHu2e3O6rmpf62lLnlHs1KftwGXwpCIWQDAfShOE=;
	b=hsJ/eEh/1vHWuUHacMNKCfDHclqbmsPRxaRCru6mXCjKd2Ag0zOL9nCvhaFdZ3D4swXhuL
	c6yuAq+UrtAFF4gAbgohgXeMlQkYCSoiHWiFqexmkHcqzY6wMTPsEzCltQP+d7twujMvgr
	D92F9cmY6ALuP/9Swc+VV9p/hzRTaNPwW4LbX1VLRQRNYN6h+FrbCqEzS+XSqqGv5fcayW
	wKR9UiJpvSCpBiQ8sSJxqzuP8NGqzyRu60gLIT/LD5vs8inCq0GwJBqd5zPdCp2zYZ9SZM
	Kr/uZdeqbxt6G+x71teGa9UXBO8HA7+BKjrULDcoWwv+HwmuFbpWdQPmAp8Hlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096611;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvpcHu2e3O6rmpf62lLnlHs1KftwGXwpCIWQDAfShOE=;
	b=sjih0QiMYbRt07h0GG9nFDZDfDSlQ9yzHo2wNmLAE2C0PfT4s2EEvZ7nJrf9gldtfYuThc
	fHmkoW4o/GvnucAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Simplify cpu_mark_primary_thread()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.791176581@linutronix.de>
References: <20240213210252.791176581@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661071.398.6594587752889764685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5e40fb2d4a4c7503cab4f923b7d985dbcf583581
Gitweb:        https://git.kernel.org/tip/5e40fb2d4a4c7503cab4f923b7d985dbcf583581
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:44 +01:00

x86/cpu/topology: Simplify cpu_mark_primary_thread()

No point in creating a mask via fls(). smp_num_siblings is guaranteed to be
a power of 2. So just using (smp_num_siblings - 1) has the same effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.791176581@linutronix.de





---
 arch/x86/kernel/cpu/topology.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index f3397e2..aea408d 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -76,10 +76,7 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 #ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
-	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
-
-	if (smp_num_siblings == 1 || !(apicid & mask))
+	if (!(apicid & (smp_num_siblings - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
 #else

