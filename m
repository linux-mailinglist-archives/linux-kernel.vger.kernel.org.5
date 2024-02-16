Return-Path: <linux-kernel+bounces-68836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1448580D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7181C23637
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B914AD21;
	Fri, 16 Feb 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fFiIN6Zg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="13EsRCsg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F914A09B;
	Fri, 16 Feb 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096644; cv=none; b=iHaFi4hmmDoKS7CkXd/fatpJy2ixCNVwUqhhm/O5f9sLz2PVs+GSUa5YfNyU/p26P8W20QSoogu7zCASDLXP953aCUuSMo4q+vw7KVCpJuYmLxKnNm4aIQ3tcmcXboDT7oamFtoS1q+iOTQktypFMPjkQFI6VcV9vrBitIkk0pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096644; c=relaxed/simple;
	bh=6PSspZFAHUFdNAdX6o3ML8ZyjGMbT4OOmr0/dvpt6m0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iusznNdHSqNJ1W3lpd0zHj4cSZu/0zg6GlVNCTnfROoAz+TGcqUZbLFjw6LXWoCK4gt2btToeYnsSeChaNgDyGWjrMchLs2pvoMTEunRUr+wBsL6L/t/+9PPn04e/f7Vb0OUgTSsowH0gVlCkRHgDJUCTnYOohiUcOwObbAVYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fFiIN6Zg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=13EsRCsg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZNGAVozQiLLoQUjSBFEIndtGk2i+W1n/nLa+kVKDhQ=;
	b=fFiIN6ZgjBknadJS8lsuldWWO3VHA98VZdjbFbK90EGRUX5WikXrxzfhOvg+dWm0bC1f4X
	oBa+doxA/Y8IulTuAj1FdiB7QLwqzy3i4SMSRlD6W+0H3VN9Sp5/+1KiTc2LkflN0mgs8r
	cIyJ+IrmcLhf3D/eoEbf64x+QqDfKpWetPOT9yh6LjNXFMmT4m9u1TaYBhjiHK2geXzAIY
	V+UW/TzQLrC1cqLQXTIN+YKWjeMMb638HlF1nyoVzBin/MkJw4h7t9bMvKfxXUu0kovxV/
	eSF/sTurAiKGIKEFI+Rcl6F0aCawvJNQqfFUK0MCVkVxE9HIuCxCezbpXyeeDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZNGAVozQiLLoQUjSBFEIndtGk2i+W1n/nLa+kVKDhQ=;
	b=13EsRCsgo3UuvR7c3Z50gM5E7W+Gmr3QSwoysotndXB3WfqAvp2xNNauPgrLxJIysDAJ9/
	dXKHyuObT5w1SOAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/ioapic: Simplify setup_ioapic_ids_from_mpc_nocheck()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.181901887@linutronix.de>
References: <20240212154639.181901887@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664103.398.14592865741278123465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     4b99e735a5c6cb3c8b23fba522cb1d24a1679f94
Gitweb:        https://git.kernel.org/tip/4b99e735a5c6cb3c8b23fba522cb1d24a1679f94
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:39 +01:00

x86/ioapic: Simplify setup_ioapic_ids_from_mpc_nocheck()

No need to go through APIC callbacks. It's already established that this is
an ancient APIC. So just copy the present mask and use the direct physid*
functions all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.181901887@linutronix.de



---
 arch/x86/kernel/apic/io_apic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 8dc91d0..6285d88 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1471,7 +1471,7 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
 	 */
-	apic->ioapic_phys_id_map(&phys_cpu_present_map, &phys_id_present_map);
+	phys_id_present_map = phys_cpu_present_map;
 
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1496,8 +1496,7 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (apic->check_apicid_used(&phys_id_present_map,
-					    mpc_ioapic_id(ioapic_idx))) {
+		if (physid_isset(mpc_ioapic_id(ioapic_idx), phys_id_present_map)) {
 			pr_err(FW_BUG "IO-APIC#%d ID %d is already used!...\n",
 			       ioapic_idx, mpc_ioapic_id(ioapic_idx));
 			for (i = 0; i < broadcast_id; i++)

