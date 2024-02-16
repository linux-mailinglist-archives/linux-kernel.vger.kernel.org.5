Return-Path: <linux-kernel+bounces-68827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C98580BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AA51C216BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E382C1482F7;
	Fri, 16 Feb 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0mtXXJkh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uETAoRib"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBC1468F2;
	Fri, 16 Feb 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096638; cv=none; b=phAv+YmJ2T3bME10GBMuSwQCK2BExMLWRqsihJRUMyundkjbU4pp7Zyt0XvItjveO3uOwiNU61kCXYpA5t3kdeRPuQc/TBPeAsQpOhkh10458BXYL9R1Ei6o3xFozw7TTmeYStRrD0EgJY/FsJUxdMEaNTpykf/hjq5bu2X3oA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096638; c=relaxed/simple;
	bh=bm094Bz6HIOAWPHeJ67KkWS/OApUVuhCem2IJ/VejIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YgjP3XjrvBo1PpYZ6muF8Lo3q+pwu+lql/dAcV2yrP7svZRQr+Gi7xpqDOqI9BS3c0kefksKl1tN20+8CpJTTZXqrs8fM67UTSBkIH4K9cRF9zACNZRw+dcRMTT4itiESCVsEfCS8p5Sm5BRLJIDIJb7Si9R0JOC3CdAmEccrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0mtXXJkh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uETAoRib; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjV3z4YqWSBRBkCWBZ2EDbTuT93qzoQZZbVXZejq/BQ=;
	b=0mtXXJkhc1r8EG2/WJYWROlQPxiKEGAmU8p4Z1r8EaylSa6Ars2VvqECKPoVydRNh0YCn3
	SJdLdQKr2jI3N2r33ZemYekbn5T5ktVu9M1q0vTrEuy58oz4TxZh13jaPDc3rHftqbbzZT
	UvCYh5IhT6sYwZZMpd6NvAjTcWNDMKempUA1jQlD2UwtTNV5MrLXslNuLZEo9kjoLoA56q
	vMz0xI0YxNXhIpkXKwwy/8YsOnoahcn9koGr2K5i79Y/1FuSs9yiQz9h2R32poYDgYkeLS
	5qrWAsf+JNKTkJ887YgljCyshQuKlogmUbvjIsFz4GqcRswVJjaNY4To3Hwz1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjV3z4YqWSBRBkCWBZ2EDbTuT93qzoQZZbVXZejq/BQ=;
	b=uETAoRibvFqP4IB9E5HkwqKx6EQaOocDjB0zkw/yGgc8dpXY6X8zJgREUV8dIhKt2GkvUE
	rk4gNYIGylsn7MBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/xen/smp_pv: Prepare for separate mpparse callbacks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.745028043@linutronix.de>
References: <20240212154639.745028043@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663483.398.11626035231102662383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     0baf4d485cbe5c1b94433f3f5aed2e6e6cd91b02
Gitweb:        https://git.kernel.org/tip/0baf4d485cbe5c1b94433f3f5aed2e6e6cd91b02
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:40 +01:00

x86/xen/smp_pv: Prepare for separate mpparse callbacks

Provide a wrapper around the existing function and fill the new callbacks
in.

No functional change as the new callbacks are not yet operational.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.745028043@linutronix.de



---
 arch/x86/xen/smp_pv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 44c35b1..bd939b8 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -185,6 +185,11 @@ static void __init _get_smp_config(unsigned int early)
 	smp_found_config = 1;
 }
 
+static void __init xen_pv_smp_config(void)
+{
+	_get_smp_config(false);
+}
+
 static void __init xen_pv_smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
@@ -455,6 +460,8 @@ void __init xen_smp_init(void)
 	smp_ops = xen_smp_ops;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.mpparse.get_smp_config = _get_smp_config;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= xen_pv_smp_config;
+	x86_init.mpparse.get_smp_config		= _get_smp_config;
 }

