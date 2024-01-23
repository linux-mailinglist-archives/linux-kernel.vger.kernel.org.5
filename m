Return-Path: <linux-kernel+bounces-35700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036083957E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59276B22213
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC55823B1;
	Tue, 23 Jan 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BjTq9gpE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cee1Fhzz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C081AD0;
	Tue, 23 Jan 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028439; cv=none; b=S/Rl3TLqRSOPd/rVOnHlL30iueYEbmvZOEcizCW6LvQaBbrcPwqDF3xcNlJBgnQ7GNrr/wK2APKX/AC5e6esxvbFEiZ/kvX41s0CcB9hrxe2qwuX/GAAudUfwB2t0NBgU2biOkVaqQkg9yxhonKArXoS/q5MHBrPLgYEDzh5Vq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028439; c=relaxed/simple;
	bh=ABB1vlQxv/0V2+G9TW5mFcBYo1D2QEKJLsH+lva718Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnZqM4wQTN8iJinmPtXMODqzjr7fBcy3uJH7q5yjXGthixax3W1Ctrxq1hEkSgxUdZ/8jpCuAr5tTuzKApgwpeOWk5j5gjUjj2JDd/hSIwjDTmE5z2sxcU3VUs25NMfmlySLwcgKpTUGUcPWG4CGkj9eqITBXZOTCzEDKE8sggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BjTq9gpE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cee1Fhzz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=92l9Ny1uPwtTpjOT9VYGZX+1CebFF3Ee9CkJCelMiYk=;
	b=BjTq9gpE6K+bqH9UgYcdfG0zBNSnLk7U8rkNPaZX0hdhFrsb+bNBxv0j6I+1dAtMCUKIkz
	6e59WIhJJdqV3H1KYBDyp85spM9LbPJuHIQz89uP9TQAgn0yls2a7Aqcbm7PAa2/CN3Tb/
	/AJbkRrK2YURWpWq/wxcB7K84J1Vb4ifam8srBIHK0VDNxUs8UOGZ2kkz57vc4vFdtPIrA
	Cyu+jnSReTVSdNdZc0YoXO0FUlw5f5tGunPP4IzSamucW1FvTwll0l8Fto/PukM3ig1xpJ
	A4e9v34GkDjuLmqYesVpjauB1Gu+iFZT9dbfZXz9Af3xlEVK4BOS52JoKJLyqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=92l9Ny1uPwtTpjOT9VYGZX+1CebFF3Ee9CkJCelMiYk=;
	b=Cee1FhzzonzVFWpipJGa1On/BqCneWof1t6vle79sTWaUbhLIRxSd1+VwvYmmY/Df1/3lw
	VsX+NGM9Zr0yM9DA==
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 0/8] timers and Documentation: Cleanup
Date: Tue, 23 Jan 2024 17:46:54 +0100
Message-Id: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

initially the plan was to simply transform already existing comments in
timer code into kernel-doc DOC blocks, and reference them inside a *.rst
file. After trying to get familiar with the kernel documentation by reading
Documentation/doc-guide/* and have a look at the existing timer related
kernel documentation (which is below Documentation/timers and also below
Documentation/driver-api), the list what should/could be improved started
to grow.

So the aim of the queue is to do the first step for moving the timer
related stuff into the 'core-api book'. It contains the following changes:

- Do not expose internal hrtimer documentation (to prevent people of
  thinking they should use it somehow directly)

- Add missing documentation and update existing ones to be compatible with
  kernel-doc/rst

- Create a subfolder in core-api to make this the final destination of
  up-to-date timer documentation. Add banner to already existing timer
  related documentation to make sure they are really up to date before they
  are moved to the final destination.

- Move timer API from driver-api to core-api

- Add two files which make (in code hidden) timer documentation accessible
  via kernel documentation

Thanks,

	Anna-Maria


Anna-Maria Behnsen (8):
  include/hrtimers: Move hrtimer base related definitions into
    hrtimer_defs
  hrtimers: Update formatting of documentation
  tick/sched: Add function description for tick_nohz_next_event()
  timers: Add struct member description for timer_base
  jiffies: Transform comment about time_* functions into DOC block
  Documentation: Create a new folder for all timer internals
  Documentation: Move "core core" api into a separate file
  timers: Add timer wheel documentation

 Documentation/core-api/core-api.rst           |  14 ++
 Documentation/core-api/index.rst              |   5 +-
 Documentation/core-api/kernel-api.rst         |  12 +-
 Documentation/core-api/timers/api.rst         |  63 ++++++
 Documentation/core-api/timers/index.rst       |  32 +++
 .../core-api/timers/timer-list-timers.rst     |  13 ++
 Documentation/core-api/timers/timer-wheel.rst |  38 ++++
 Documentation/driver-api/basics.rst           |  24 ---
 Documentation/timers/highres.rst              |   5 +
 Documentation/timers/hpet.rst                 |   5 +
 Documentation/timers/hrtimers.rst             |   5 +
 Documentation/timers/index.rst                |   5 +
 Documentation/timers/no_hz.rst                |   4 +
 Documentation/timers/timekeeping.rst          |   5 +
 Documentation/timers/timers-howto.rst         |   5 +
 include/linux/hrtimer.h                       | 117 +----------
 include/linux/hrtimer_defs.h                  | 102 ++++++++++
 include/linux/jiffies.h                       |  15 +-
 include/linux/timer.h                         |  15 +-
 kernel/time/hrtimer.c                         |  18 +-
 kernel/time/tick-sched.c                      |  10 +
 kernel/time/timer.c                           | 184 ++++++++++++------
 22 files changed, 471 insertions(+), 225 deletions(-)
 create mode 100644 Documentation/core-api/core-api.rst
 create mode 100644 Documentation/core-api/timers/api.rst
 create mode 100644 Documentation/core-api/timers/index.rst
 create mode 100644 Documentation/core-api/timers/timer-list-timers.rst
 create mode 100644 Documentation/core-api/timers/timer-wheel.rst

-- 
2.39.2


