Return-Path: <linux-kernel+bounces-64276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968EE853CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99C71C22540
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF1F626DD;
	Tue, 13 Feb 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k2PkmRqo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SbyS0xgX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8B74E3A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858315; cv=none; b=Jqd76VsgT0zUQxWVLnEe4pe1miPmOBaxV76IAhHT9Vodj4KgbSd+5kmUMdfqF41oiq4aMHEZcI5NtwbONlZlbuEjcVq3o/aCi9m85IIHTh7zTphF2hkPWySlE4rWIsne5r+BMQ1SxvShZxa511jSuDqhBCIl5lWW052/tBkmFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858315; c=relaxed/simple;
	bh=SGXrE8Yw2ANix13HVyPL7ecmVibMK1HhvzhajBLDnlA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=A4GIthIynRs4/qoRQEYgVB5C5OwjTBbjVUYpBgYTuEEc5+TfotcDvoxK1q0x4yEi2IV3/hE41brhaMqXtC8YGT0gXam17eCsVKN9C7fpsrQ1/iQYZmzvUHZgWnryzxsK88mjF9ZnG8xMPGpvBAAXJwZau4xAdAKmKTgGE4dtWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k2PkmRqo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SbyS0xgX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.745028043@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wDzo3sDxLcX+PY8MPqJ3TBw1kK5S3plxLG9oPF/78Vw=;
	b=k2PkmRqoIrtlYtsAZz5T5V7QKInngLBGeQP5zHlRE2tefW+sISLfXbJeJSwN+TBYSHqHwK
	kPh+iZDBu7SZ/PTsHzW8B1wC4BWd3zwGIePsHEeNlM0Afb6PtMtTGD3A8rzFX/ApUTgST9
	QNHyg7mKnsZnFqAV9r3vroVhFfQBn7O36+kJjbKKo5ru3Dy8BqKGzjRpaLlfEOy2JqCkYF
	hgOZelzEIbFiP6zEGY+ydPUXHSlJwXKpccbUuyDbhSoMa7YTre5RzFoV0ia1rqV+MJBCWj
	Ly2NUB9FkekH3aQnl4a5GjRzfQ+7c/Td7rdb4Sjgf8W3ZJHSqMCH4ZfqWEXV1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wDzo3sDxLcX+PY8MPqJ3TBw1kK5S3plxLG9oPF/78Vw=;
	b=SbyS0xgXPBt0nhX7p9sPYt5BBY7qZhwQmHZL2+oh07LL+1Khvwm97Z1O0OE0wQ3AxFR6wk
	EMprhcefQNvB6WAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 15/22] x86/xen/smp_pv: Prepare for separate mpparse
 callbacks
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:12 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Provide a wrapper around the existing function and fill the new callbacks
in.

No functional change as the new callbacks are not yet operational.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/xen/smp_pv.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)
---

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -185,6 +185,11 @@ static void __init _get_smp_config(unsig
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




