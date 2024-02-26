Return-Path: <linux-kernel+bounces-82385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC897868392
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F8428944E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EE132C03;
	Mon, 26 Feb 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/zKEXIK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WH9DlPoT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A3132486;
	Mon, 26 Feb 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986271; cv=none; b=KyFMbHhRQ7OMzu18nxL5k9ex+k+8XKK7odtCuXH4oTRiqgNls7BCR8njUiVCL4YVFM/lnKGEQJcyO20A3Fb+fvNrU1usriQCkqqDUhmfFXZYyTG/XqA5vboWW3sC6U0rMSEa1/EjlxI/JPONVgOVlgQvZdGhqw7cp6AtXHlBn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986271; c=relaxed/simple;
	bh=TTrlwk/E8iegOt2UjKcQXtlNzMYojq0/n1Iyl0jVdCA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZhmKjEZpM5CrXXwvJryx4obiZwBEv4pL6rsAjxP3MOVjrthgqNdaHlzJWGV94oO8eKBD4lG1tuUX9kFNO0tA1rIWBcLv8HOCD5XlHYoHcrBFkRHWlhO8eolQ1IT528RiZGkDZt5Zc4sxzuPrDcJQH0HNgRni4PnRU61SIIZ/Z24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/zKEXIK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WH9DlPoT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVzKVsJhf5e6bXf2ZcV/iev7ofEWrTQXAf+4O63SiZI=;
	b=Y/zKEXIKagayaKzokOU4zQBlM52gZJ5Y2RXG0HqQ6N70NfgRy6Nfq3wwCpMwWgFj+pY85a
	AWi29vbZpskrMCN2HNLOBPDCgpePTEKuQjDZx0ef7MSRSwhWco2RDA0mrqHsxp3iJhRlj4
	kbKf18NcvO/qZkCnAXx0umqUqzJSN2FF+PgpCP5Re3ULDQsjm7fuTPDsbzdbE7E7Vnrb1R
	fF29KefOb62gDyc+JiRXibAi+Adbk9MNdeNUQLoEVAv59w2su8/NN8ykRwz2p4bN7S/uBw
	TMM7vUeqPTfO0+WfaqSaiO0prd7fucCm1D/Lz6otGYuGwJHtMfQboELWg1KRNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVzKVsJhf5e6bXf2ZcV/iev7ofEWrTQXAf+4O63SiZI=;
	b=WH9DlPoT+ufFKFGbncdWJSzJabGFVZ84DZGz0MqxZUafPbvZr2Mah5h1/prR6mY3r2p2tr
	LP5TpFkWSkll5HAA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Assert no next dyntick timer look-up while
 CPU is offline
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-17-frederic@kernel.org>
References: <20240225225508.11587-17-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898626753.398.4108841734022309650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     19b344a91ff79f65be377825635bcf5f5bb8df67
Gitweb:        https://git.kernel.org/tip/19b344a91ff79f65be377825635bcf5f5bb=
8df67
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:55:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:32 +01:00

timers: Assert no next dyntick timer look-up while CPU is offline

The next timer (re-)evaluation, with the purpose of entering/updating
the dyntick mode, can happen from 3 sites and none of them are relevant
while the CPU is offline:

1) The idle loop:
	a) From the quick check helping the cpuidle governor to heuristically
	   predict the best C-state.
	b) While stopping the tick.

   But if the CPU is offline, the tick has been cancelled and there is
   consequently no need to further stop the tick.

2) Remote expiry: when a CPU remotely expires global timers on behalf of
   another CPU, the latter target's next timer is re-evaluated
   afterwards. However remote exp=C3=AEry doesn't happen on offline CPUs.

3) IRQ exit: on nohz_full mode, the tick is (re-)evaluated on IRQ exit.
   But full dynticks is disabled on offline CPUs.

Therefore it is safe to assume that no next dyntick timer lookup can
be performed on offline CPUs.

Assert this expectation to report any surprise.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-17-frederic@kernel.org

---
 kernel/time/timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4f4930d..e69e75d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2233,10 +2233,10 @@ static inline u64 __get_next_timer_interrupt(unsigned=
 long basej, u64 basem,
 	bool idle_is_possible;
=20
 	/*
-	 * Pretend that there is no timer pending if the cpu is offline.
-	 * Possible pending timers will be migrated later to an active cpu.
+	 * When the CPU is offline, the tick is cancelled and nothing is supposed
+	 * to try to stop it.
 	 */
-	if (cpu_is_offline(smp_processor_id())) {
+	if (WARN_ON_ONCE(cpu_is_offline(smp_processor_id()))) {
 		if (idle)
 			*idle =3D true;
 		return tevt.local;

