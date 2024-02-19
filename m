Return-Path: <linux-kernel+bounces-71835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81E285AB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790F31F22BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDAB55E58;
	Mon, 19 Feb 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FakJgU4t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VB+NAyF9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A153E30;
	Mon, 19 Feb 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367865; cv=none; b=lIevKOWwIjDs5P6J8Brh8Qh71j9/2T9CUcZMVitdFyaK/H5/4mB/eN1UPiV8trETRBcdXBrB5a/lMJw+MBrkV1tjxDIdKIwGzJGAwImEBy2KzZIb0HnCfmyTbmSxHpj0Vspia5tV8HPameT9d/0peWAaFclQ7hUW/j27Gnx6CP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367865; c=relaxed/simple;
	bh=Ur7n6O6cc2GYgaHCjHv02QDl9qSnvKgLGRianf5W6rU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PrSig+xgGP3n0tYPZ6EF++f9abxEpiEiqOcvT4pOm8IsP/frVe6CeKbqB/AbO1qxmZCY+WiEEc2mL36gYp6WcBt80XFZ0+Weda8281WV/HulCN4uxDItBIrG2jsIf8kUyUxg79LASH5RMITZ55Bl472elgAo+mKk74jT12ywSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FakJgU4t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VB+NAyF9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNEh+ZS43l4fs1ygurS2HLPWAbO1/zVyUp6TyI3WOfY=;
	b=FakJgU4tFagn3dBTdqYkw3J3XGW5tEpZC77RX5PVlJ5RPCLSommfeFkydc+lC6y0snitCB
	yl0J4h2ZDfCATPHX55GNqI4fY2+YxR22pzbQKjFWSvAgfvO2c4ddOkO1lNenRaDG9/GUBZ
	xSa9J13i/DczDBg3kCopMmiE19zCGcs94SGRn7hDLpXCSeSdbVHN5latIOo2UYMUn/0lO2
	bVi7k44vXH7LSABJLRMA21FQBpBHwfVxgFyiPMqEHI0p+cArEiGCiZIA0w5+aoL/N+KuNX
	lP4+9FRhZnZqLEadHca3EtXA4w1UHDad6V6KIbwQ1Y0h4pnO+eZ12R9GJHRjQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNEh+ZS43l4fs1ygurS2HLPWAbO1/zVyUp6TyI3WOfY=;
	b=VB+NAyF95ShyXaialLQseb6IzKBmVldY6odcWjVK3ZnTnhKAPHoLi9xqgEPS+xqyw68UCj
	j1Q9pu/c2FaHniBA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] tick/nohz: Move tick_nohz_full_mask declaration
 outside the #ifdef
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-2-james.morse@arm.com>
References: <20240213184438.16675-2-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836786117.398.9035726276646423995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     31a5c0b7c674977889ce721d69101bc35f25e041
Gitweb:        https://git.kernel.org/tip/31a5c0b7c674977889ce721d69101bc35f25e041
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:15 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:31 +01:00

tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef

tick_nohz_full_mask lists the CPUs that are nohz_full. This is only needed when
CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows a specific CPU to be
tested against the mask, and evaluates to false when CONFIG_NO_HZ_FULL is not
defined.

The resctrl code needs to pick a CPU to run some work on, a new helper prefers
housekeeping CPUs by examining the tick_nohz_full_mask. Hiding the declaration
behind #ifdef CONFIG_NO_HZ_FULL forces all the users to be behind an #ifdef
too.

Move the tick_nohz_full_mask declaration, this lets callers drop the #ifdef,
and guard access to tick_nohz_full_mask with IS_ENABLED() or something like
tick_nohz_full_cpu().

The definition does not need to be moved as any callers should be removed at
compile time unless CONFIG_NO_HZ_FULL is defined.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com> # for resctrl dependency
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-2-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 include/linux/tick.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 716d17f..0fb9038 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -164,9 +164,16 @@ static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
+/*
+ * Mask of CPUs that are nohz_full.
+ *
+ * Users should be guarded by CONFIG_NO_HZ_FULL or a tick_nohz_full_cpu()
+ * check.
+ */
+extern cpumask_var_t tick_nohz_full_mask;
+
 #ifdef CONFIG_NO_HZ_FULL
 extern bool tick_nohz_full_running;
-extern cpumask_var_t tick_nohz_full_mask;
 
 static inline bool tick_nohz_full_enabled(void)
 {

