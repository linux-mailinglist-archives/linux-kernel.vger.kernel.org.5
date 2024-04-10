Return-Path: <linux-kernel+bounces-137908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C5889E94A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5252B1C230BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87410A3B;
	Wed, 10 Apr 2024 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QcDjJXYO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GYRC7ShE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C9D51A;
	Wed, 10 Apr 2024 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725069; cv=none; b=K0l/GbToE2SO3y6RDRCXapfW2IpyyC3OEo6iNFbDJzmhu1lz+gmpYhla7vmo375Y/fxmM74McOSPDwK1T1QaIcH+Yqt0nYs3T8fZ1gekMW0Zg0KR0Vl3m6nCy30tiXb+3ILj/ByoeYb1lDJhbrTtFbUywTnJ2lRVK4YEWVoJMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725069; c=relaxed/simple;
	bh=1bg2ed1fxDBgKsreFSBIR/3aeKLchbspFsok4PUJNzY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mzhCoeg1bRNRp27QUkCY3x+3DmDCluuCK5pG9GdRYKXMKv2oSD26LNXeCwYucSqtcDlyLTNYh6KI3ypwOCgLsSVr6s30NYUD0lTDjRYVdTIOHLuIfIpoFsuTxsmeDjTM3wAu90c+6D/AQ6JvrPyM6dqd/fFIwwvwCKtY+L1Ps5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QcDjJXYO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GYRC7ShE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 04:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712725066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aosX2fNfJOBQQfZWyqTitQc7wrM7/1Fev40KqiYoNVU=;
	b=QcDjJXYOo68zeSiGXAhobMi147ADKU7RLAWBffqhaF3rayda8uXevX483faoYd6oKIOk0t
	r+d/+W6r0YO376dgX9H+bg2dTND8jdmSp0toIMwn3OGD2poaYQmmcG3yeoMNKkOZ7ybpR2
	9ycWLEJ8FDS5fHfWDK59gDvkEy8sNJ92zzwXwWoLhMhAdHUxXgplzDN/0VUEw/IIOpTO5v
	7MEYg2DBZHkaOGXhbU1tpAfqVTPhQ4IrekuuuUm9L1pDFCaICjPAzOG9Hgs4dzCXRnXU5a
	7+91BHNiUsA4VjsdKRTZVpBkHrPdl+NDWyc3Dvvl46FcX+xFqRpmCP3oGTxLVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712725066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aosX2fNfJOBQQfZWyqTitQc7wrM7/1Fev40KqiYoNVU=;
	b=GYRC7ShE4q6r0QVhSGx2R1kM+ADY0IGcn504cce3Ldq6RrmntLVQHP17usbkkeT6WsbwDC
	250qw+dUUX1FKpBg==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Reduce PMU access to adjust sample freq
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240207050545.2727923-2-namhyung@kernel.org>
References: <20240207050545.2727923-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171272506512.10875.6886742044570226022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f38628b06c36222367e26820879789ae59e49f60
Gitweb:        https://git.kernel.org/tip/f38628b06c36222367e26820879789ae59e49f60
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 06 Feb 2024 21:05:45 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 06:13:57 +02:00

perf/core: Reduce PMU access to adjust sample freq

In perf_adjust_freq_unthr_context(), it first starts the event and then
stop unnecessarily to adjust the sampling frequency if the event is
throttled.

For a throttled non-frequency event, it doesn't have a freq so no need
to adjust.  Just starting the event would be ok.

For a frequency event, whether it's throttled or not, it needs to stop
before adjusting the frequency.  That means it should not start the
even if it was throttled.  I tried to skip calling the stop callback,
but it didn't work well since the event count might not be up to date.
It should call the stop callback with PERF_EF_UPDATE anyway.

However not calling start would prevent unnecessary MSR accesses (which
can be costly) for already stopped events as stop state is saved in the
hw config.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240207050545.2727923-2-namhyung@kernel.org
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9566cfb..fd94e45 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4146,7 +4146,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (hwc->interrupts == MAX_INTERRUPTS) {
 			hwc->interrupts = 0;
 			perf_log_throttle(event, 1);
-			event->pmu->start(event, 0);
+			if (!event->attr.freq || !event->attr.sample_freq)
+				event->pmu->start(event, 0);
 		}
 
 		if (!event->attr.freq || !event->attr.sample_freq)

