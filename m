Return-Path: <linux-kernel+bounces-100628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39C879AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D8B1F226E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770013957F;
	Tue, 12 Mar 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hoyig5Pu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Si0jMMkz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1C53BE;
	Tue, 12 Mar 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266902; cv=none; b=mUA6KcxjU6DZL9SxAVi9yKqn4T/1O4QdBjZKzMwPb+aRl/AGHMHN3kZFZbHBVP72LNWhqNbYGArEDXnKhWmXpG+QD0/8oHRK0xQZptTvS9JpX6FGbFwJTnYin3fbgcOoipD+2EMRKq2C/SfO2Y/A3mLlnKoEY3qbZgrUh0E8MAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266902; c=relaxed/simple;
	bh=qu9QpLpLoG/MHsULZWTP1NiBsuIff8uU7mCQ+STPC0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpPkS33DMRMXjV08aU1T+NXVdJ4GIsS1BUKnT6lpnidAC3c0tw6zJig5z8wizDlNDQd0H2CK0ajI6rebTVjBG4mBFaMXTLorTGdyJnczh+wZKCpLQ+ibSwdMoKCcBzLFeAQ9eNuovmbQII86fm9510m9Wpq1t6eY3GXhL44XvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hoyig5Pu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Si0jMMkz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710266899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ofnsWQdHNBIT62/BSireKZzq3CrT3bJvHhWQMH0KupI=;
	b=hoyig5PumWxLJxS4wRJgHvhyDr+IdO35rVR88jUh88WwmI64KgPMDcJP4xHpZH7/CTA1JY
	WvAESxfy3Mo5WScS036ocwuIu5vKd7yMLLtVB5fGkTr3/v2elIzIvQkY1x6jAP6sPl3Z99
	2FCe4684yhf2Qy4+XYhtsjsg7ODl6u9DshH3vxg9RlvHSZwHJP37QP2GMc2wgEpoYB9/UK
	69Thzd5K3ZnxXvuMNntIuhajJtnkiCLjN9BpOyxAE0EQCgHTeQdshdcOQnNEBVL2yfdJsr
	x7TKRcc0sjpP/NwF6/qaS9dt26/epQwMBcICObdCRnsgAA8oPLqlYhIFzJyxHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710266899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ofnsWQdHNBIT62/BSireKZzq3CrT3bJvHhWQMH0KupI=;
	b=Si0jMMkzVidrY8XUvrm2WmRSi1hnBPBp3wTSrYGrwsRtvy90OXHvpCLRZLUYgSaOCXkF+Z
	Q8qTozs4h0KJbQBg==
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
Subject: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on RT.
Date: Tue, 12 Mar 2024 19:01:48 +0100
Message-ID: <20240312180814.3373778-1-bigeasy@linutronix.de>
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


