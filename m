Return-Path: <linux-kernel+bounces-68816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDDA8580AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7351C21A91
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23412FB20;
	Fri, 16 Feb 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CBeUt+Ic";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zv4u1ACl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371F136988;
	Fri, 16 Feb 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096632; cv=none; b=dAfs/TXEKft2L2qZaksH1ALYMlqwqDUbRw5UDHjHwyI0APfhBoZ87yVC/oD7TiThDMMrpb+QsGDUARyZog5hrZDkdUU7i4crj4az8RUDvWpM24eTMoIIJzhjt7sAoBGMcuhD4yXym482gL95f9V7NEENr/UM113rMedJH/Zxonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096632; c=relaxed/simple;
	bh=fMSrKV24IISfeLkmj0p/LE9DV6MQTY/zoBgAmx3G1Gg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XH9mfyE8JFqL9KPj4QM/b2setDF15P4dW+WrmMUrU6nL08oQCUCtuukxPlnhFNjIfeG5RH0w9Z/MFSPRC0HWLUFWGh+i5FdA7f5s29WDSrWQlNJJAhvxwiM5lRF4glyf/JIocm/BN0/kanaEE3iAR7PCw97ToWuZERlrk/awrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CBeUt+Ic; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zv4u1ACl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+WP56T35oaG9qtPO/O/xxIOlhFHajSoEmFhKDDE3Gk=;
	b=CBeUt+Icf0iMxgO8R0CdNRaXI0kOYjqq7haMZSr2ndTR3qkZth0boaG/nuQeNJ4XJsoGWJ
	HB06jFLI0RxmlgqBKACIPMqatsG9LWyOUhxSxm4BPAKPzEIlryCDyi6mI0rgeJB4OKV2yT
	af7tG6+UFtoUNf3f+SALVveg6NDIwVscxZH7u1NkPClU8kDBpvYUxlncPccxcQ/Z0iqnhg
	hH1qumeuxHsTtAm3c3IwfMxa9UJAv3Yz9a85WYaEj5dqlSW2zYFwTqVytADJisYIDgSAWd
	tVX9MFGimBz51sURQJyrar/rdNn58Sd8L2R7VMp0OVdZSmvaSsPPF9pmuu1Zfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+WP56T35oaG9qtPO/O/xxIOlhFHajSoEmFhKDDE3Gk=;
	b=zv4u1ACl944Bibb7EYLSbO1WUm3zVCipyK/0Az740sbPKB+5YUQ4kyqvhjUSgBPJEvkuZ5
	2tA719UqQu1f3jCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/jailhouse: Use new APIC registration function
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.720970412@linutronix.de>
References: <20240213210251.720970412@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662719.398.8016500441467651334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     8cd01c8a68b083e2a0af601c5464e2dfa64f1421
Gitweb:        https://git.kernel.org/tip/8cd01c8a68b083e2a0af601c5464e2dfa64f1421
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:42 +01:00

x86/jailhouse: Use new APIC registration function

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.720970412@linutronix.de



---
 arch/x86/kernel/jailhouse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 5128ac8..df33786 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -102,7 +102,7 @@ static void __init jailhouse_parse_smp_config(void)
 	register_lapic_address(0xfee00000);
 
 	for (cpu = 0; cpu < setup_data.v1.num_cpus; cpu++)
-		generic_processor_info(setup_data.v1.cpu_ids[cpu]);
+		topology_register_apic(setup_data.v1.cpu_ids[cpu], CPU_ACPIID_INVALID, true);
 
 	smp_found_config = 1;
 

