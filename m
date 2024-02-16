Return-Path: <linux-kernel+bounces-68856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F2858102
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B341F21718
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A017153BD8;
	Fri, 16 Feb 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MkBsRAT3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Km57MBZZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4906152DFC;
	Fri, 16 Feb 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096659; cv=none; b=akT0Nk1js++Ct74IlO46bjWejyJnBNX9I6KWZQLp/X8AJMkdGRzOT7ZLlXb8wZEzDHxFhZpkW4X0EDr6DHIDe3TkrshQzC6nLJa4lCtBtzhCCt0b8GvYEhqXC5DJSZRtIgM4ENKAjh22eRLXaYBNCxR3+venez7iMeQEYQYJFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096659; c=relaxed/simple;
	bh=Kdy/3ACi5kIfj5bulc4AeoSffzVKJ0eH2LWQUggffCg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SBNO2X+rmL7TOap53J7WU0buyvtCAiWVJX6AvcuYW5mr6nONO4Iw/jCvmf1979QqWwyPPMTRyCcGLsy3nNHcMSaY4LhNjZNJaSs02vC3fxVODZMOEgIPwInEWYb552Td8yAE6zOZxpgICW7ZI32+46SqhKZ488lHTL1et4TmHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MkBsRAT3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Km57MBZZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qV3XftI8hzq2CaDVBoRiUthistZuO3PbPWNbpjHBME=;
	b=MkBsRAT3UK9l6q5wA8GNM5fQLDYlWc/WO/WobW0Mx6hSA5Q1E3o3Zj9Rz8vMZ9sOZfseVA
	8AO7tJSxCtkxB5vLMXKAfk3dwCNZppThQyFMFg7XzlH7tFiBpNEX9OO1vo97RqE/Of/gLG
	2tLzkvllhTtsucsi1CmXBwyVHvy7CyWysdtVhJcVnnlGQEwUDoWEprY9sG7iLQqg04H9tL
	ws4bwxTz6UN/Q+VKicoQzwQ3hAeqZud8liqn7PgqQNwZSJy3zqfYxlze3F2m8eko2rax0O
	dihWqgUg1ekNz9Abv/zDykVLsZvQGKvr7K/VqTqMSswREd9dle9D0Ueh/BxVGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qV3XftI8hzq2CaDVBoRiUthistZuO3PbPWNbpjHBME=;
	b=Km57MBZZBXe4og9+tYiSOC63X1n+a0Jvyo4qkBS7KA0MiOMNATD1FIpSihriI3IkgCHHkJ
	SIP+19+6+18i6ECg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Move __max_die_per_package to common.c
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153624.768188958@linutronix.de>
References: <20240212153624.768188958@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809665374.398.4261415306130047095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     92853a7774f942e3692dbd83bace82333a2b47bd
Gitweb:        https://git.kernel.org/tip/92853a7774f942e3692dbd83bace82333a2b47bd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:37 +01:00

x86/cpu: Move __max_die_per_package to common.c

In preparation of a complete replacement for the topology leaf 0xb/0x1f
evaluation, move __max_die_per_package into the common code.

Will be removed once everything is converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153624.768188958@linutronix.de




---
 arch/x86/kernel/cpu/common.c   | 3 +++
 arch/x86/kernel/cpu/topology.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 004ae9c..5d7911f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -76,6 +76,9 @@ u32 elf_hwcap2 __read_mostly;
 int smp_num_siblings = 1;
 EXPORT_SYMBOL(smp_num_siblings);
 
+unsigned int __max_die_per_package __read_mostly = 1;
+EXPORT_SYMBOL(__max_die_per_package);
+
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index dc13670..208e17a 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -25,9 +25,6 @@
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
-unsigned int __max_die_per_package __read_mostly = 1;
-EXPORT_SYMBOL(__max_die_per_package);
-
 #ifdef CONFIG_SMP
 /*
  * Check if given CPUID extended topology "leaf" is implemented

