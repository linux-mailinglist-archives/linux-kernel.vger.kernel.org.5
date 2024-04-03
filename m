Return-Path: <linux-kernel+bounces-129323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55487896896
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B46E1F23361
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4601272AE;
	Wed,  3 Apr 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3QccJmz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1z2QVo3T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154485C909;
	Wed,  3 Apr 2024 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132535; cv=none; b=tAKrZ9j+l60W6Usk5uLSWmCohSCiYGpnk9h1aHwT4WGQVc7ZYlUbyTAg9lmNMi0YOSHafxkoX7Eqjj02fP/ZeXv6St93O5MS0Y7sOI5DgSFlYE2GEyvKRusMNMT4w8iWboxh1aAYCENQCGQBciISTzWD8Wj1LegOClNhkDlOAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132535; c=relaxed/simple;
	bh=5lp7AlGrGY72eH77g2/OpWl6OBQLgzTGI692i8nt878=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gh8t3Nbu8pEhzfJrEQrcm1GXkJ/Nbr+D0cJX8jKbISLrWNPB+xDrugAgownK5qXoDhsqgkuykqPbLADOsd/OW8qwvjJsO1mb5A3S2OJKPNGmOCH5Ag/iLtPOjhyfaYHH7sflORGeU+FGimcbDG8eKC39tE3vCFBCr3fCT+CgmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3QccJmz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1z2QVo3T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 08:22:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712132532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaFmSIb4p+Gtq3fkhBTi42NY/14O9dMwtxLw7aG5c5Q=;
	b=P3QccJmzizra30UrznPr5/VfiP5CQkj0a8LjmbbXCIl2NtBruLQedMSDa6I7gbS2Xs2Yyw
	ftlV3tSIxDEFcu3gNS6F6zSq5+67ZIGiVPgcXQdVkhp0UjjF05auqYV/czN7CuKQpW1Jvu
	Jrpd/ZF4lilOgWfk7Q+mpdUl/bnM8EsiBed4gRGKXnT1zrOQ8vJlhWA5UG2O4gr6izuI2y
	OrWivX2iMa2WAJXVVU0XYJQ2wsWNp7irDWyJ1S2iJ5++LD85nl0OBF9dHYCm+0m9bjWpI1
	BgzB0igFDZBhmRN3/YXGBicK8YhOZmSE0DmrbFW8uqm1JDjeodMIdqJQKRVmGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712132532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaFmSIb4p+Gtq3fkhBTi42NY/14O9dMwtxLw7aG5c5Q=;
	b=1z2QVo3T4c8jDKPMW56mJxeXcoZrUVuW7lmE+EJRqfFo6RHsALNLHR6w0mCZVRRg5YPAhy
	JWf95OLv4NyU64Cw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/ds: Don't clear ->pebs_data_cfg for
 the last PEBS event
Cc: Stephane Eranian <eranian@google.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240401133320.703971-1-kan.liang@linux.intel.com>
References: <20240401133320.703971-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171213253103.10875.3060258964816599355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     312be9fc2234c8acfb8148a9f4c358b70d358dee
Gitweb:        https://git.kernel.org/tip/312be9fc2234c8acfb8148a9f4c358b70d358dee
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 01 Apr 2024 06:33:20 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 10:19:20 +02:00

perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS event

The MSR_PEBS_DATA_CFG MSR register is used to configure which data groups
should be generated into a PEBS record, and it's shared among all counters.

If there are different configurations among counters, perf combines all the
configurations.

The first perf command as below requires a complete PEBS record
(including memory info, GPRs, XMMs, and LBRs). The second perf command
only requires a basic group. However, after the second perf command is
running, the MSR_PEBS_DATA_CFG register is cleared. Only a basic group is
generated in a PEBS record, which is wrong. The required information
for the first perf command is missed.

 $ perf record --intr-regs=AX,SP,XMM0 -a -C 8 -b -W -d -c 100000003 -o /dev/null -e cpu/event=0xd0,umask=0x81/upp &
 $ sleep 5
 $ perf record  --per-thread  -c 1  -e cycles:pp --no-timestamp --no-tid taskset -c 8 ./noploop 1000

The first PEBS event is a system-wide PEBS event. The second PEBS event
is a per-thread event. When the thread is scheduled out, the
intel_pmu_pebs_del() function is invoked to update the PEBS state.
Since the system-wide event is still available, the cpuc->n_pebs is 1.
The cpuc->pebs_data_cfg is cleared. The data configuration for the
system-wide PEBS event is lost.

The (cpuc->n_pebs == 1) check was introduced in commit:

  b6a32f023fcc ("perf/x86: Fix PEBS threshold initialization")

At that time, it indeed didn't hurt whether the state was updated
during the removal, because only the threshold is updated.

The calculation of the threshold takes the last PEBS event into
account.

However, since commit:

  b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG")

we delay the threshold update, and clear the PEBS data config, which triggers
the bug.

The PEBS data config update scope should not be shrunk during removal.

[ mingo: Improved the changelog & comments. ]

Fixes: b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240401133320.703971-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2641ba6..e010bfe 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1237,11 +1237,11 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 	struct pmu *pmu = event->pmu;
 
 	/*
-	 * Make sure we get updated with the first PEBS
-	 * event. It will trigger also during removal, but
-	 * that does not hurt:
+	 * Make sure we get updated with the first PEBS event.
+	 * During removal, ->pebs_data_cfg is still valid for
+	 * the last PEBS event. Don't clear it.
 	 */
-	if (cpuc->n_pebs == 1)
+	if ((cpuc->n_pebs == 1) && add)
 		cpuc->pebs_data_cfg = PEBS_UPDATE_DS_SW;
 
 	if (needed_cb != pebs_needs_sched_cb(cpuc)) {

