Return-Path: <linux-kernel+bounces-39108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0A483CAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2270FB27360
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669513EFEF;
	Thu, 25 Jan 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PJNOljaJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wDK5TCeG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71313BE98;
	Thu, 25 Jan 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206900; cv=none; b=V15cyOYxzsADhpbezQ9x2W5qGVshQLeCCyVAaTrzlOpazrellJVv4Hgt/Fb8qVBhJCmu+a9KP7JCNi/rTB02pLl0lfytj4vvQfO9ZbEPOeWuISSbbbFBl5yTxiZCYsnR/yJiLWrT5RizWE+zL499wbjNH/qpeipdi9dqIaveORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206900; c=relaxed/simple;
	bh=V9cSUwT+VGk+A6Ux1blRgQ4N12B0F9vHolcuscPdx/I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KrrmQ8dHx5EU9Ois635td9UsjfFpTw/2Zk9JfyljjDXGpULKvVm5C37kitcNzLukwmy6QeeQGXUVwX8Bj4xJeXS5UWM9X9ZQEmi0jKtjfzsYCCOeBFrDCHZKsn0/V1eQtbh4IEEd/v9glSU1frPWyESPqochIHmPPiPkLMHnp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PJNOljaJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wDK5TCeG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHtsBYfUeADAj+UUq1y6wKXx5FxG+y3myG9XqCvyKoM=;
	b=PJNOljaJw9BZ9DiMslfnhmvUlS4xiM++Tj5IegDGLa7ggQKDLsWyH0PbW5JnQLg/R1ll78
	t5bh+i1WcYVijfqftLpHXezWzVUL/Yj6hD4WSlYOQF8zzycSM6FxNpUA5Vd/+clcWFSMXD
	w63mpBCNOeGld9b6ZE9RiKp5nh7oMiiAarHMNGcfGrTqpbtEAyfbO7rzUmvfSlRIgtLZ5C
	OxgVrGtHqCfYciF4F5rknp+p8fLkLc6vFkCrrT/e6Gj8nJCO2zVQuKt2nVZkE6+WRnbsWB
	M6RRqGLmfofjwtJMOlP3QpScYamzewlVKZdI0Yd/AoLCXupcfxRMk8+e5u4RHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHtsBYfUeADAj+UUq1y6wKXx5FxG+y3myG9XqCvyKoM=;
	b=wDK5TCeGFIeWlhiG1qlFs3JMMK6Jkrfk4QD5IKssIo2y29aPZud1OrydZSwgKf9mGtIQqB
	t8TVqoyHqTWDgwDg==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Disable FRED by default in its early stage
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-9-xin3.li@intel.com>
References: <20231205105030.8698-9-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689542.398.3437920556925908485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     7a1d75084df087dcae703d70a49274a3982e3681
Gitweb:        https://git.kernel.org/tip/7a1d75084df087dcae703d70a49274a3982e3681
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:57 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:30 +01:00

x86/fred: Disable FRED by default in its early stage

To enable FRED, a new kernel command line option "fred" needs to be added.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-9-xin3.li@intel.com

---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/x86/kernel/cpu/common.c                    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25..c6c1a2c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1539,6 +1539,9 @@
 			Warning: use of this parameter will taint the kernel
 			and may cause unknown problems.
 
+	fred		[X86-64]
+			Enable flexible return and event delivery
+
 	ftrace=[tracer]
 			[FTRACE] will set and start the specified tracer
 			as early as possible in order to facilitate early
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcd..2121ec6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1484,6 +1484,9 @@ static void __init cpu_parse_early_param(void)
 	char *argptr = arg, *opt;
 	int arglen, taint = 0;
 
+	if (!cmdline_find_option_bool(boot_command_line, "fred"))
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
 #ifdef CONFIG_MATH_EMULATION

