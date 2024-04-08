Return-Path: <linux-kernel+bounces-135400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B60389C0D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFE12829C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5596C77F11;
	Mon,  8 Apr 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sSo1BHW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vdg93hU8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57427F466;
	Mon,  8 Apr 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581844; cv=none; b=g5j7RJGlmGhW4vDHQwnYSesjZylID05ut8Oq6bfBAO6Xtsq2YWfDnfF6O54LpSVhLCXizDm8DlO+R/wiLfnPL88IBxI0aubjR67okeGHag0yhVmalDEsBUaC5mAFoMs0hyfzFB2dnt5jeASEvw3GvUDSuWVKW500K+JZmNuZ0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581844; c=relaxed/simple;
	bh=93xazvMvcvDjb1ynzZlO5q4vfY+sl98A7uYQAWn7G5s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SVNoawF0vZUr9jJjgM6ZFuHh7mWxrxkBWCriL3rQf57TAub1U9Egmf9BtQabmp0JzjZAylrJQ6niBdluIUaBmRjNRpzRTZ9+9x4IS6cY2swjqqiR22O3iY3hfPwFNUSguL1FnTRjgoo/tm9Gn6+0dsu9172WeYxMa/J41morteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sSo1BHW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vdg93hU8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjyX2yHQeZs8zwNtRJE49NPE7UtmWOE94hdhqmv8RbA=;
	b=0sSo1BHWlnSQ5Ms0TSCy/26vDL13iinlLLv6OfESbW+y5PB+/pE6Zv/hOT/AOEsM12uf0a
	DBuTQNoKfPeokAuqPcTxddV1CyVk+QE+d0l6h5oHiFQw5MgAE9DTSiPNp/v6oOe6Mbp1dj
	FqGQjj9YCI6zGJAv5hrgwckCmU4QhqdLoF1YTIeddQiXdVCH937vJ/W64PhZX8gJ28e2TW
	p/0GvESUFKX6cneJGWOQAk3v0hTn3LoZdDYkSSMxnLAMqYxJyL88zqR3PjI5HkKMTj6DVw
	4CcNtij4iJ/epFe+6ZP5wLpngoI6aqYuHPlLtv6mhDsDwsOpihozDZ3igHS+2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjyX2yHQeZs8zwNtRJE49NPE7UtmWOE94hdhqmv8RbA=;
	b=vdg93hU8CpOdYlEjqSQNtry5qcFg8aDQdhD7BUosbr7DrbOdNRv4dWoOpxfOBBwMoURNim
	d+EvRBdAvjVZDFCQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Make delta calculation overflow safe
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-8-adrian.hunter@intel.com>
References: <20240325064023.2997-8-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258184044.10875.9117228310710193606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     456e3788bc7164c1c8298045e04068b8e3d8e413
Gitweb:        https://git.kernel.org/tip/456e3788bc7164c1c8298045e04068b8e3d8e413
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:07 +02:00

vdso: Make delta calculation overflow safe

Kernel timekeeping is designed to keep the change in cycles (since the last
timer interrupt) below max_cycles, which prevents multiplication overflow
when converting cycles to nanoseconds. However, if timer interrupts stop,
the calculation will eventually overflow.

Add protection against that, enabled by config option
CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT. Check against max_cycles, falling
back to a slower higher precision calculation.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-8-adrian.hunter@intel.com

---
 lib/vdso/gettimeofday.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9fa90e0..9c3a8d2 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -13,6 +13,18 @@
 # define VDSO_DELTA_MASK(vd)	(vd->mask)
 #endif
 
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 delta)
+{
+	return delta < vd->max_cycles;
+}
+#else
+static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 delta)
+{
+	return true;
+}
+#endif
+
 #ifndef vdso_shift_ns
 static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
 {
@@ -28,7 +40,10 @@ static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, 
 {
 	u64 delta = (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
 
-	return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+	if (likely(vdso_delta_ok(vd, delta)))
+		return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+
+	return mul_u64_u32_add_u64_shr(delta, vd->mult, base, vd->shift);
 }
 #endif /* vdso_calc_ns */
 

