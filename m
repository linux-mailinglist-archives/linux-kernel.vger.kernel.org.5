Return-Path: <linux-kernel+bounces-111029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E786886723
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1B11C23904
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC39125C4;
	Fri, 22 Mar 2024 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wdef2tgP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOCqU6e6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1F12E51;
	Fri, 22 Mar 2024 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090337; cv=none; b=DDj3Tqn1Crnl9WE6NClddG4rx0qJNIcCT9S48nLL8W9juwZkwjyl+T0ODWNfrtdLTEy2gX8WFXh6bdAeQNc0X0svWVtDrGjJqtjsg6t9qXm/Azq8ISmjP4eWxQ6fyYKMCQbDs3vgfpnShUogA1epqDKA4E7TJB7SB7x+2cYYBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090337; c=relaxed/simple;
	bh=taVimAut1RqnRtaMWo43maVz+nQQ2R8r7EJzpVStgOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l+yRqyP4MoPGqYXoru+T0tqqQmP+KbaZIAem11GO/wK9kgV/K04pXVnC4AndPcrmgGVB/Ke/4hHL78fRax9xET2Rx3zlenhZ6W/sZlCWnxFYcNvu8GRnK1YLoT5gT9gI1dmLBovwWjtCAAKdDPxlTNgIzJ2qDcpB3yX0Bs8ZsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wdef2tgP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOCqU6e6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711090332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EEFbnnAVHmdwzZCxVsdsp8BUSsMIXx8yGOcnfHYn3Fk=;
	b=Wdef2tgPLCOqGGtkx2ZVDVOVKFAxDIW4y5+c5fiioQP90MBCr2SWHLHdcOaqOhyRQX2YoZ
	BRBbWfA5r8VRFNbtxWV03P2ekUwchmuRqAtOx6e5taGV5aARozjR0CbelLYo15pNvuMhq5
	qAzRXuys0P1Mgg7YX8v2V3YsNQ1pPCUayokC+6f+6azAs0bYP3vYZnrLigmvNyl/iRrJSc
	81onx5w+SLk8VYXhiuCZNsW1pWkd8hjetlvumCPCujvxXH7QSFLaZh9Y8zSPob11NRXvR1
	VoGMJb0SY0ZpRxSe2eEQwo7x1GP6nMbkzyMV18dP3wahQLYo+WL0MonKy/qKkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711090332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EEFbnnAVHmdwzZCxVsdsp8BUSsMIXx8yGOcnfHYn3Fk=;
	b=qOCqU6e6MVm6EFs4oYmDEkX7krgqeTDtAWgumfWSPCHnc8yANEGsrgaHG1al3bGMi2Ud4m
	9kGX4eo04W6FatCg==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on RT.
Date: Fri, 22 Mar 2024 07:48:20 +0100
Message-ID: <20240322065208.60456-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
the signal gets delayed until event_sched_out() which then uses
task_work_add() for its delivery. This breaks on PREEMPT_RT because the
signal is delivered with disabled preemption.

While looking at this, I also stumbled upon __perf_pending_irq() which
requires disabled interrupts but this is not the case on PREEMPT_RT.

This series aim to address both issues while not introducing a new issue
at the same time ;)
Any testing is appreciated.

v2=E2=80=A6v3: https://lore.kernel.org/all/20240312180814.3373778-1-bigeasy=
@linutronix.de/
    - Marco suggested to add a few comments
      - Added a comment to __perf_event_overflow() to explain why irq_work
        is raised in the in_nmi() case.
      - Added a comment to perf_event_exit_event() to explain why the
        pending event is deleted.

v1=E2=80=A6v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigeasy=
@linutronix.de/
    - Marco pointed me to the testsuite that showed two problems:
      - Delayed task_work from NMI / missing events.
        Fixed by triggering dummy irq_work to enforce an interrupt for
	the exit-to-userland path which checks task_work
      - Increased ref-count on clean up/ during exec.
        Mostly addressed by the former change. There is still a window
	if the NMI occurs during execve(). This is addressed by removing
	the task_work before free_event().
      The testsuite (remove_on_exec) fails sometimes if the event/
      SIGTRAP is sent before the sighandler is installed.

Sebastian


