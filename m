Return-Path: <linux-kernel+bounces-137910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FB789E94E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EAF1F24135
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF740171CD;
	Wed, 10 Apr 2024 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XvMZH0y3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DF79d8tP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF061095C;
	Wed, 10 Apr 2024 04:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725070; cv=none; b=eLMBfpx6BKwduRYjBPl8oTjUcjJOYJCReTmxZwJvy0IJWqqql4EHTyxU7j2Uc9U9r+gHwnAbtgys8Kcd+IRMSTyEHUyWXN9lxZL5saK1mPRt7JUpSbJ/4srJtBd4gn13Qaz4vGcb1I8PoJjzP/kS4e2mhZrVB72nP0jyaw7Q/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725070; c=relaxed/simple;
	bh=S312C+gavUYz8h3A2GcgRimqY7cpLQKh9KZOsaixUAU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PFBMKaop06N1MQXd1fT4iMa0C6zDRjMVjTJeqjZQkk1grb/vTT9el3D+eCK83oYTsxLMW+uvYAizk/Gce86GkteSAvXsqKB2M66AqmdVNl7Y4Aih3yupvRJ0y2wVqwB1cwyrJq5HnSED2QaIUdcyxIDwNfNk0lwVIDJY5mp5jCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XvMZH0y3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DF79d8tP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 04:57:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712725067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDT1P1cWGh7lNYe8T33JKPfDBX0TWzCN2az5ox4/RaY=;
	b=XvMZH0y3cA5pod7CUg+EWQ8reIULmyMxyAKn8X3EFPokSjGsS8oQ9XvtUgx+0Uoe/kxqvy
	hvUNkjSBGOh7ysReM9scteBhpErEb7V9ADZEtHzjS0905sNiDvmZ2aHYR5b63Ts1r2EGOk
	NFYZl1HypebCPWnfwHPbWhveAyfhtFutlROC3YWFp3P/EHccGhRqMXWc/NT6vpa9J8Mbrn
	GubNHKCxTDie6i0LNua80LwpsdPo9DK/Ol7x/ZbLiOWWFcyZ1foQXCxYQzRE24Prj3XmAV
	OCiNPn/ZTP0Ic8w6qdiL4hPgNi9CTgq3+ZIrajNsgGP29CTVULGYqDrFE19aUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712725067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDT1P1cWGh7lNYe8T33JKPfDBX0TWzCN2az5ox4/RaY=;
	b=DF79d8tPg7AyZt9YNEEnf6uW3oQQCI6mM4W7lLYbm1FI2BeYJ18GQNGyhDYjbhKsOkXdJK
	f+y1rOnc4kOdKJAA==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Fix out of range data
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240306061003.1894224-1-namhyung@kernel.org>
References: <20240306061003.1894224-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171272506661.10875.17620123228073910318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     dec8ced871e17eea46f097542dd074d022be4bd1
Gitweb:        https://git.kernel.org/tip/dec8ced871e17eea46f097542dd074d022be4bd1
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 05 Mar 2024 22:10:03 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 06:12:01 +02:00

perf/x86: Fix out of range data

On x86 each struct cpu_hw_events maintains a table for counter assignment but
it missed to update one for the deleted event in x86_pmu_del().  This
can make perf_clear_dirty_counters() reset used counter if it's called
before event scheduling or enabling.  Then it would return out of range
data which doesn't make sense.

The following code can reproduce the problem.

  $ cat repro.c
  #include <pthread.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <linux/perf_event.h>
  #include <sys/ioctl.h>
  #include <sys/mman.h>
  #include <sys/syscall.h>

  struct perf_event_attr attr = {
  	.type = PERF_TYPE_HARDWARE,
  	.config = PERF_COUNT_HW_CPU_CYCLES,
  	.disabled = 1,
  };

  void *worker(void *arg)
  {
  	int cpu = (long)arg;
  	int fd1 = syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0);
  	int fd2 = syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0);
  	void *p;

  	do {
  		ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
  		p = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd1, 0);
  		ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);

  		ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0);
  		munmap(p, 4096);
  		ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0);
  	} while (1);

  	return NULL;
  }

  int main(void)
  {
  	int i;
  	int n = sysconf(_SC_NPROCESSORS_ONLN);
  	pthread_t *th = calloc(n, sizeof(*th));

  	for (i = 0; i < n; i++)
  		pthread_create(&th[i], NULL, worker, (void *)(long)i);
  	for (i = 0; i < n; i++)
  		pthread_join(th[i], NULL);

  	free(th);
  	return 0;
  }

And you can see the out of range data using perf stat like this.
Probably it'd be easier to see on a large machine.

  $ gcc -o repro repro.c -pthread
  $ ./repro &
  $ sudo perf stat -A -I 1000 2>&1 | awk '{ if (length($3) > 15) print }'
       1.001028462 CPU6   196,719,295,683,763      cycles                           # 194290.996 GHz                       (71.54%)
       1.001028462 CPU3   396,077,485,787,730      branch-misses                    # 15804359784.80% of all branches      (71.07%)
       1.001028462 CPU17  197,608,350,727,877      branch-misses                    # 14594186554.56% of all branches      (71.22%)
       2.020064073 CPU4   198,372,472,612,140      cycles                           # 194681.113 GHz                       (70.95%)
       2.020064073 CPU6   199,419,277,896,696      cycles                           # 195720.007 GHz                       (70.57%)
       2.020064073 CPU20  198,147,174,025,639      cycles                           # 194474.654 GHz                       (71.03%)
       2.020064073 CPU20  198,421,240,580,145      stalled-cycles-frontend          #  100.14% frontend cycles idle        (70.93%)
       3.037443155 CPU4   197,382,689,923,416      cycles                           # 194043.065 GHz                       (71.30%)
       3.037443155 CPU20  196,324,797,879,414      cycles                           # 193003.773 GHz                       (71.69%)
       3.037443155 CPU5   197,679,956,608,205      stalled-cycles-backend           # 1315606428.66% backend cycles idle   (71.19%)
       3.037443155 CPU5   198,571,860,474,851      instructions                     # 13215422.58  insn per cycle

It should move the contents in the cpuc->assign as well.

Fixes: 5471eea5d3bf ("perf/x86: Reset the dirty counter to prevent the leak for an RDPMC task")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240306061003.1894224-1-namhyung@kernel.org
---
 arch/x86/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0905064..5b0dd07 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1644,6 +1644,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	while (++i < cpuc->n_events) {
 		cpuc->event_list[i-1] = cpuc->event_list[i];
 		cpuc->event_constraint[i-1] = cpuc->event_constraint[i];
+		cpuc->assign[i-1] = cpuc->assign[i];
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;

