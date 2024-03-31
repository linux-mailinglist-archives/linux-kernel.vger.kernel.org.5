Return-Path: <linux-kernel+bounces-126324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F366893538
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3959A2885EF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720BA14534D;
	Sun, 31 Mar 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RO34ytlo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692922F3A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711906015; cv=none; b=ZLJKba5uIvmVp6AkOZHie+Ajp4aOclutfqWyegR7TNtXIF+RYAV/sQe26tqPeul0iAGe0qH2qrE1O1cEkeEUS2FJ1cJim/D41KaM/DvTdSoiTYJrjvrR7iUk+fwnmsvDXFC2rKSoE2xktkGCf3QjYX3+gOJmbHB40DOaGa8uCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711906015; c=relaxed/simple;
	bh=qpnx22l6MwoNp+6V7jUV+OM640BvQ3nHftSLi2Xu6bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjxFecVSnTzwC86mx+ySKsgZ0qnoXqlBgwPGv9GYc3ofziessG9if8QoDRjAGgcrjZOft8rDYczunMVn9IRndkt4hBNAFKd9oVUfFeDnfFgCXtm9T0vWIjY3BI+sbQ4YbE4lslU0xXlvUCC8OHaXG+4SfLChd5Kx46iUjFlj68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RO34ytlo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XaNe5C6qcgnnnbCW8bI/8rsdUIrRjOK7WtsVkxh/mfg=; b=RO34ytloGhP6y2/ISv+eh/MpK9
	sVvJ/KjlQ+44x/MXYLQny9q+GDXktfyZRfITdbh+smDJ4EuVAQhISOI0/Qn0QafDjMj+jR4oSyuAE
	Pgsx3iE143C4PwhAFnnJUB1657h4buT6eu9xvcsxGjz2obJakkmFPz6ah7i3Niez+zSBT7vzdvcrf
	TbA9jsgS7sZxgLjUSfwIP6OJbHOfFktYmBHwgCurgxD0MAcTf/sYCBFA14u5BnNPwyUkred/EG/aR
	6ozPhCvEgv+DBvglS8Xsi0uWNgqCA0rq/5JpHFyQ0VwTeA0PanF16twbqbYx/SPKm84uDYYXVxEBL
	az4gm66Q==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqyxJ-00000005z30-1puH;
	Sun, 31 Mar 2024 17:26:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] time: clean up text and kernel-doc issues
Date: Sun, 31 Mar 2024 10:26:46 -0700
Message-ID: <20240331172652.14086-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings and format, some punctuation, spelling, & typos
in time/timer source files.

 [PATCH 1/6] time/timecounter: fix inline documentation
 [PATCH 2/6] time/timekeeping: fix kernel-doc warnings and typos
 [PATCH 3/6] time/timer: fix kernel-doc format and add Return values
 [PATCH 4/6] tick/sched: fix various kernel-doc warnings
 [PATCH 5/6] tick/sched: fix struct tick_sched doc warnings
 [PATCH 6/6] timers: fix text inconsistencies and spelling

 include/linux/timecounter.h |   11 ++++++-
 include/linux/timekeeping.h |   49 +++++++++++++++++++++++++++++-----
 include/linux/timer.h       |   12 ++++++--
 kernel/time/tick-sched.c    |   18 ++++++++++--
 kernel/time/tick-sched.h    |    2 -
 kernel/time/timer.c         |   22 +++++++--------
 6 files changed, 88 insertions(+), 26 deletions(-)


Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

