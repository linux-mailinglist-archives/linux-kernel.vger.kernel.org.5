Return-Path: <linux-kernel+bounces-60660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 582E4850826
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E01F22A0F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136759153;
	Sun, 11 Feb 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PXizpP/C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OReLGchG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C90168B7;
	Sun, 11 Feb 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640892; cv=none; b=QpGseC52kz3j5b7X+kDzk+MJKzO+lkSg6YIUrFnR/cbgxmBB10J1xWCxRWFHAvA9pP1iRYLOO00FxEA/9rokyT6BDdsfNLwNrvTMViBAR6UkNSjdzIFywPriaaAzOQe7eLg+XK6F5aH3//q+eMogMT7RXmOXSEBSN6sio5iyNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640892; c=relaxed/simple;
	bh=Lyzhh2oxkizGTam2poJk3R3Y8L/Wct8UaT4vBV18mUQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sQoiD0doaQQcjYtY8fHa9Egw37lAPRCrbKCELkkidVpgBk5zyr08hyWpg1GQrn3OZNYMreUa1r4gr/XxK+1XrnDV8mOsTa/o1cJXM9nT1HvThULO6rjd0rTRT1S/WCnTjEc4n5rBAHqxiRCMRhnc05z+MHWbppQw6okOI7hs9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PXizpP/C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OReLGchG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 Feb 2024 08:41:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707640888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUWZEUmK7lS7OygzlZlsJ8mmpGogQ8b/szu/z1ltWlY=;
	b=PXizpP/CC9iN/HXzgabTxSG9psAc0Jgv/JkeFcdYJp0fYV67eV9zKTrE4EcvUYddKMbrlL
	MF1WsG81mAUmLGE0xsVoM3IBPpqkwkFdEAV7kDvQviTmJg/5ZeSSjRJgvIOsxOzGHNsl2r
	DJs6cay8ECnNUuKG+dDvi4e8K6+O+5KKZM9w2OuEbqWa3K2JYRFXoPVLd5b1QvM6eyhIIM
	XCxXv2DSSIFwwBzETnBF1aVzbbhv6My4+Xy2IYdxVUcyyTSH8+PwJ9rFYlZQwHYDiq7b8y
	gs3AQuHR17IGnHQo7tMKuSIA1mWoKaLj5ZQHmvdyvITsbS9jAA8t5rly/4vkVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707640888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUWZEUmK7lS7OygzlZlsJ8mmpGogQ8b/szu/z1ltWlY=;
	b=OReLGchGPgjjw9cSvuISbX1jPGm7z3ADwNMteElrmjQM07XbBEtBsupw6nj4KFlrLxK2JY
	IbuamNO9Z8CH2FBA==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] kvmclock: Unexport kvmclock clocksource
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201010453.2212371-9-peter.hilber@opensynergy.com>
References: <20240201010453.2212371-9-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170764088739.398.11245426040021766902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     27f6a9c87a97f5ea7459be08d5be231af6b32c20
Gitweb:        https://git.kernel.org/tip/27f6a9c87a97f5ea7459be08d5be231af6b32c20
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Thu, 01 Feb 2024 02:04:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 17:05:21 +01:00

kvmclock: Unexport kvmclock clocksource

The KVM PTP driver now refers to the clocksource ID CSID_X86_KVM_CLK, not
to the clocksource itself any more. There are no remaining users of the
clocksource export.

Therefore, make the clocksource static again.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240201010453.2212371-9-peter.hilber@opensynergy.com

---
 arch/x86/include/asm/kvmclock.h | 2 --
 arch/x86/kernel/kvmclock.c      | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvmclock.h b/arch/x86/include/asm/kvmclock.h
index 511b350..f163176 100644
--- a/arch/x86/include/asm/kvmclock.h
+++ b/arch/x86/include/asm/kvmclock.h
@@ -4,8 +4,6 @@
 
 #include <linux/percpu.h>
 
-extern struct clocksource kvm_clock;
-
 DECLARE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
 static __always_inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 2f1bbf7..5b2c152 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -154,7 +154,7 @@ static int kvm_cs_enable(struct clocksource *cs)
 	return 0;
 }
 
-struct clocksource kvm_clock = {
+static struct clocksource kvm_clock = {
 	.name	= "kvm-clock",
 	.read	= kvm_clock_get_cycles,
 	.rating	= 400,
@@ -163,7 +163,6 @@ struct clocksource kvm_clock = {
 	.id     = CSID_X86_KVM_CLK,
 	.enable	= kvm_cs_enable,
 };
-EXPORT_SYMBOL_GPL(kvm_clock);
 
 static void kvm_register_clock(char *txt)
 {

