Return-Path: <linux-kernel+bounces-135397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8F789C0CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313C81C20846
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922137EF0F;
	Mon,  8 Apr 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2suEfzCQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jpH1KJxE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E077E0E4;
	Mon,  8 Apr 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581841; cv=none; b=TFfqCuumTfwom0pP12EtIGkhK4dn2PMqoLy0YRIvkmjQsfIzTjS3byWcKjZnFrV4D7k4ZEhuf2iOFSBDtRM7b6ZZbfrg6VpNrLzkMzNu3eFb8emx8JZQWCH1y0vcUzfyVcLDKLQU6gmxRXtayjzEzRU31t3rIHIWBjRhaoM11rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581841; c=relaxed/simple;
	bh=tltP1uCdPOugjN6M8Qo9rTw2JecOQMSMfnmAwN0uChk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tk75H+vQHd3IN5J1V+zK7+3yjLwGEAnTEowMvDDg+B0SbG6iml7Zyh1TmRl9Hb9/WPDq6o3qJafQg5iNf/MKN4BfJW6wxfRKBM8mAI+0QZ7sAf/kj0pje6Li33fFlppg3u1ghSbKJG2SgLpJb+0zvY0XGE4Zr6v5zEE7mn1cLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2suEfzCQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jpH1KJxE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1x0tlFyxQ8Z6qbHTFiwYSz6qyeTZpJxwo7ZO26tYE1o=;
	b=2suEfzCQPmskIcWBNvIy9fpw7m/hZIG8hCVDlkl89FswyLJrAoYCRWMQwbIaESj3oPApXa
	yGdeOeBN54GJLwSNx9jINzBXLRrU86clTLFvlfIb2OzI1lJkQN/xBl6jhu9AOTfPZ9v6Xm
	2jxUR7i1iM8RZSCIxmVPD4NJGymgIjOKL/RoaN8hDTURV6aHeL8rto2nbswcVBlGNlKgxm
	gMkeTi4H74XEWobEbafmvslQ45JIlDDQ0R6BKOXwSmsy00cyF8l1ZwfuBTi+Zy/3VmfX8Z
	X7c/qAEuTGSylZrP+K/X64J2lxutazAj9Vu4D0hPuA2QMgVELLKtRPI+lqHPqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1x0tlFyxQ8Z6qbHTFiwYSz6qyeTZpJxwo7ZO26tYE1o=;
	b=jpH1KJxE/LeteTV61+/hmIzzQPtdwyIf85X8bJs51P6QlehHUh5cauQOsFO5KXEPun4i3q
	V6lc6YM5aqI66rAw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Rename fast_tk_get_delta_ns() to
 __timekeeping_get_ns()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-11-adrian.hunter@intel.com>
References: <20240325064023.2997-11-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183799.10875.775118297225382255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a729a63c6b2ebd8bc37646519d404f005ea8f1b2
Gitweb:        https://git.kernel.org/tip/a729a63c6b2ebd8bc37646519d404f005ea8f1b2
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:07 +02:00

timekeeping: Rename fast_tk_get_delta_ns() to __timekeeping_get_ns()

Rename fast_tk_get_delta_ns() to __timekeeping_get_ns() to prepare for its
reuse as a general timekeeping helper function.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-11-adrian.hunter@intel.com

---
 kernel/time/timekeeping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3375f0a..6306133 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -390,7 +390,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
-static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
+static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	u64 delta, cycles = tk_clock_read(tkr);
 
@@ -449,7 +449,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
 		now = ktime_to_ns(tkr->base);
-		now += fast_tk_get_delta_ns(tkr);
+		now += __timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
@@ -565,7 +565,7 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 		tkr = tkf->base + (seq & 0x01);
 		basem = ktime_to_ns(tkr->base);
 		baser = ktime_to_ns(tkr->base_real);
-		delta = fast_tk_get_delta_ns(tkr);
+		delta = __timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	if (mono)

